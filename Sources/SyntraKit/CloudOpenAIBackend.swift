import Foundation

// MARK: - Cloud OpenAI-Compatible Backend
public struct CloudOpenAIBackend: LLMBackend {
    private let baseURL: URL
    private let apiKey: String
    private let model: String
    private let timeoutSeconds: TimeInterval
    private let streamIdleTimeoutSeconds: TimeInterval
    private let debug: Bool

    public init(
        baseURL: URL = URL(string: (ProcessInfo.processInfo.environment["LLM_BASE_URL"] ?? "https://api.openai.com"))!,
        apiKey: String = (ProcessInfo.processInfo.environment["LLM_API_KEY"] ?? ""),
        model: String = (ProcessInfo.processInfo.environment["LLM_MODEL"] ?? "gpt-4.1"),
        timeoutSeconds: TimeInterval = TimeInterval(ProcessInfo.processInfo.environment["LLM_TIMEOUT_S"] ?? "60") ?? 60,
        streamIdleTimeoutSeconds: TimeInterval = TimeInterval(ProcessInfo.processInfo.environment["LLM_STREAM_IDLE_TIMEOUT_S"] ?? "120") ?? 120,
        debug: Bool = ((ProcessInfo.processInfo.environment["SYNTRA_DEBUG"] ?? "false").lowercased() == "true")
    ) {
        self.baseURL = baseURL
        self.apiKey = apiKey
        self.model = model
        self.timeoutSeconds = timeoutSeconds
        self.streamIdleTimeoutSeconds = streamIdleTimeoutSeconds
        self.debug = debug
    }

    public func healthCheck() async throws -> String { "ok" }

    public func complete(messages: [ChatMessage], stream: Bool) async throws -> AsyncThrowingStream<String, Error> {
        if apiKey.isEmpty { throw LLMBackendError.unavailable("LLM_API_KEY not set") }

        // Preflight: privacy redaction + token budgeting
        let preflighted = preprocess(messages: messages)

        let url = baseURL.appendingPathComponent("/v1/chat/completions")
        if debug { print("[DEBUG] CloudOpenAIBackend baseURL: \(baseURL), full URL: \(url)") }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        let payload = try makePayload(messages: preflighted, stream: stream)
        request.httpBody = try JSONSerialization.data(withJSONObject: payload)

        if debug { logRequest(messages: preflighted, stream: stream) }

        let config = URLSessionConfiguration.ephemeral
        config.timeoutIntervalForRequest = timeoutSeconds
        config.timeoutIntervalForResource = max(timeoutSeconds, streamIdleTimeoutSeconds)
        let session = URLSession(configuration: config)

        // Circuit breaker + retries wrapper
        return try await Breaker.shared.run(operation: {
            if stream {
                return try await streamSSEWithRetries(session: session, request: request)
            } else {
                return try await oneShotWithRetries(session: session, request: request)
            }
        })
    }

    // MARK: - Helpers

    private func makePayload(messages: [ChatMessage], stream: Bool) throws -> [String: Any] {
        let mapped: [[String: String]] = messages.map { [
            "role": $0.role.rawValue,
            "content": $0.content
        ] }

        var body: [String: Any] = [
            "model": model,
            "messages": mapped,
            "stream": stream,
            "temperature": 0.3
        ]

        if let seed = ProcessInfo.processInfo.environment["LLM_SEED"].flatMap(Int.init) {
            body["seed"] = seed
        }
        return body
    }

    // MARK: - Privacy + Budgeting

    private func preprocess(messages: [ChatMessage]) -> [ChatMessage] {
        var msgs = messages
        // Privacy redaction
        let privacyOn = (ProcessInfo.processInfo.environment["SYNTRA_PRIVACY"] ?? "off").lowercased() == "on"
        if privacyOn {
            msgs = msgs.map { ChatMessage(role: $0.role, content: redact($0.content)) }
        }

        // Token budget
        let maxTokens = Int(ProcessInfo.processInfo.environment["LLM_MAX_PROMPT_TOKENS"] ?? "8192") ?? 8192
        let total = estimateTokens(messages: msgs)
        if total > maxTokens {
            if debug { print("[SYNTRA] Budget: prompt ~\(total) > cap \(maxTokens); compressing") }
            msgs = budget(messages: msgs, to: maxTokens)
        }
        return msgs
    }

    private func estimateTokens(messages: [ChatMessage]) -> Int {
        messages.reduce(0) { $0 + estimateTokens(text: $1.content) }
    }

    private func estimateTokens(text: String) -> Int {
        // Simple heuristic: ~4 chars per token
        max(1, text.count / 4)
    }

    private func budget(messages: [ChatMessage], to maxTokens: Int) -> [ChatMessage] {
        // Strategy: keep first system message, then include messages from the end backward until cap.
        let system: ChatMessage? = messages.first(where: { $0.role == .system })
        var others = messages.filter { $0.role != .system }
        var acc: [ChatMessage] = []
        var used = system.map { estimateTokens(text: $0.content) } ?? 0
        while let last = others.popLast() {
            let cost = estimateTokens(text: last.content)
            if used + cost > maxTokens {
                // Truncate this last message to fit
                let remaining = maxTokens - used
                let truncated = truncateToTokens(text: last.content, tokenBudget: max(remaining, 16))
                acc.insert(ChatMessage(role: last.role, content: truncated), at: 0)
                used = maxTokens
                break
            } else {
                acc.insert(last, at: 0)
                used += cost
            }
            if used >= maxTokens { break }
        }
        if let s = system { return [s] + acc }
        return acc
    }

    private func truncateToTokens(text: String, tokenBudget: Int) -> String {
        // Keep head and tail slices with an elision marker
        let approxChars = tokenBudget * 4
        if text.count <= approxChars { return text }
        let head = text.prefix(approxChars / 2)
        let tail = text.suffix(approxChars / 2)
        return String(head) + "\n[... REDACTED/TRUNCATED FOR BUDGET ...]\n" + String(tail)
    }

    private func redact(_ text: String) -> String {
        var out = text
        // Emails
        out = out.replacingOccurrences(of: #"[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}"#, with: "[REDACTED_EMAIL]", options: [.regularExpression, .caseInsensitive])
        // Phone numbers (simple): sequences with 7+ digits possibly with separators
        out = out.replacingOccurrences(of: #"(?:(?:\+?\d{1,3}[\s-]?)?(?:\(?\d{2,4}\)?[\s-]?)?\d[\d\s-]{5,}\d)"#, with: "[REDACTED_PHONE]", options: .regularExpression)
        // SSN-like
        out = out.replacingOccurrences(of: #"\b\d{3}-\d{2}-\d{4}\b"#, with: "[REDACTED_SSN]", options: .regularExpression)
        // Credit card 13-19 digits
        out = out.replacingOccurrences(of: #"\b(?:\d[ -]*?){13,19}\b"#, with: "[REDACTED_CARD]", options: .regularExpression)
        // IPv4
        out = out.replacingOccurrences(of: #"\b(?:(?:2[0-5]{2}|1?\d?\d)\.){3}(?:2[0-5]{2}|1?\d?\d)\b"#, with: "[REDACTED_IP]", options: .regularExpression)
        // URLs
        out = out.replacingOccurrences(of: #"https?://[^\s]+"#, with: "[REDACTED_URL]", options: .regularExpression)
        return out
    }

    private func oneShot(session: URLSession, request: URLRequest) async throws -> AsyncThrowingStream<String, Error> {
        let (data, response) = try await session.data(for: request)
        guard let http = response as? HTTPURLResponse else {
            throw LLMBackendError.protocolError("No HTTPURLResponse")
        }
        guard (200..<300).contains(http.statusCode) else {
            let body = String(data: data, encoding: .utf8) ?? ""
            throw LLMBackendError.httpError(http.statusCode, body)
        }
        // Parse OpenAI response
        struct Choice: Decodable { let message: Msg }
        struct Msg: Decodable { let content: String }
        struct Resp: Decodable { let choices: [Choice] }
        let decoded = try JSONDecoder().decode(Resp.self, from: data)
        let text = decoded.choices.first?.message.content ?? ""

        return AsyncThrowingStream<String, Error> { continuation in
            continuation.yield(text)
            continuation.finish()
        }
    }

    private func streamSSE(session: URLSession, request: URLRequest) async throws -> AsyncThrowingStream<String, Error> {
        // Use bytes(for:) to consume the response as an AsyncSequence of bytes/lines.
        let (bytes, response) = try await session.bytes(for: request)
        guard let http = response as? HTTPURLResponse else {
            throw LLMBackendError.protocolError("No HTTPURLResponse")
        }
        guard (200..<300).contains(http.statusCode) else {
            // Try to read a small error body
            let err = try? await String.decoding(bytes, maximumLength: 2048)
            throw LLMBackendError.httpError(http.statusCode, err ?? "")
        }

        let startTime = Date()

        return AsyncThrowingStream<String, Error> { continuation in
            Task {
                var lastYield = Date()
                do {
                    for try await line in bytes.lines {
                        if Task.isCancelled { continuation.finish(); break }
                        if line.hasPrefix(":") || line.isEmpty { continue } // comment/keepalive
                        guard line.hasPrefix("data:") else { continue }
                        let dataPart = line.dropFirst(5).trimmingCharacters(in: .whitespaces)
                        if dataPart == "[DONE]" {
                            continuation.finish()
                            break
                        }
                        if let chunk = parseDelta(jsonLine: String(dataPart)) {
                            if !chunk.isEmpty {
                                continuation.yield(chunk)
                                lastYield = Date()
                            }
                        }
                        // Idle timeout guard (best-effort)
                        if Date().timeIntervalSince(lastYield) > streamIdleTimeoutSeconds {
                            continuation.finish()
                            break
                        }
                        // Hard cap guard to avoid runaway streams
                        if Date().timeIntervalSince(startTime) > max(timeoutSeconds, streamIdleTimeoutSeconds) {
                            continuation.finish()
                            break
                        }
                    }
                    continuation.finish()
                } catch {
                    continuation.finish(throwing: error)
                }
            }
        }
    }

    // MARK: - Retries + Circuit Breaker

    private func oneShotWithRetries(session: URLSession, request: URLRequest) async throws -> AsyncThrowingStream<String, Error> {
        let maxRetries = Int(ProcessInfo.processInfo.environment["LLM_MAX_RETRIES"] ?? "5") ?? 5
        var attempt = 0
        while true {
            do {
                return try await oneShot(session: session, request: request)
            } catch {
                attempt += 1
                if !isRetriable(error), attempt > maxRetries {
                    throw error
                }
                if attempt > maxRetries { throw error }
                try await backoff(attempt: attempt)
                continue
            }
        }
    }

    private func streamSSEWithRetries(session: URLSession, request: URLRequest) async throws -> AsyncThrowingStream<String, Error> {
        let maxRetries = Int(ProcessInfo.processInfo.environment["LLM_MAX_RETRIES"] ?? "5") ?? 5
        var attempt = 0
        while true {
            do {
                return try await streamSSE(session: session, request: request)
            } catch {
                attempt += 1
                if !isRetriable(error), attempt > maxRetries {
                    throw error
                }
                if attempt > maxRetries { throw error }
                try await backoff(attempt: attempt)
                continue
            }
        }
    }

    private func isRetriable(_ error: Error) -> Bool {
        if let e = error as? LLMBackendError {
            switch e {
            case .httpError(let code, _): return code == 429 || (500...599).contains(code)
            default: break
            }
        }
        let nserr = error as NSError
        // URL error codes for network issues/timeouts
        if nserr.domain == NSURLErrorDomain {
            let retriable: Set<Int> = [NSURLErrorTimedOut, NSURLErrorCannotFindHost, NSURLErrorCannotConnectToHost, NSURLErrorNetworkConnectionLost, NSURLErrorDNSLookupFailed, NSURLErrorNotConnectedToInternet]
            return retriable.contains(nserr.code)
        }
        return false
    }

    private func backoff(attempt: Int) async throws {
        // Exponential backoff with jitter: base 0.5s * 2^(attempt-1)
        let base: Double = 0.5
        let delay = min(pow(2.0, Double(attempt - 1)) * base, 8.0)
        let jitter = Double.random(in: 0...0.2)
        let total = delay + jitter
        try await Task.sleep(nanoseconds: UInt64(total * 1_000_000_000))
    }

    private func logRequest(messages: [ChatMessage], stream: Bool) {
        print("[SYNTRA] Backend: CloudOpenAIBackend")
        print("[SYNTRA] Model: \(model)")
        print("[SYNTRA] Messages: \(messages.count)")
        print("[SYNTRA] Stream: \(stream)")
    }

    // Simple circuit breaker shared across instances
    actor Breaker {
        static let shared = Breaker()

        private var consecutiveFailures: Int = 0
        private var openUntil: Date? = nil

        private var maxFailures: Int {
            Int(ProcessInfo.processInfo.environment["LLM_BREAKER_MAX_FAILS"] ?? "5") ?? 5
        }
        private var openSeconds: TimeInterval {
            TimeInterval(ProcessInfo.processInfo.environment["LLM_BREAKER_OPEN_S"] ?? "60") ?? 60
        }

        func run<T>(operation: () async throws -> T) async throws -> T {
            if let until = openUntil, until > Date() {
                throw LLMBackendError.unavailable("circuit_open")
            }
            do {
                let result = try await operation()
                consecutiveFailures = 0
                openUntil = nil
                return result
            } catch {
                consecutiveFailures += 1
                if consecutiveFailures >= maxFailures {
                    openUntil = Date().addingTimeInterval(openSeconds)
                }
                throw error
            }
        }
    }
    private func parseDelta(jsonLine: String) -> String? {
        // Minimal decoder for OpenAI delta payloads
        struct Delta: Decodable { let content: String? }
        struct Choice: Decodable { let delta: Delta? }
        struct Resp: Decodable { let choices: [Choice] }
        guard let data = jsonLine.data(using: .utf8) else { return nil }
        do {
            let decoded = try JSONDecoder().decode(Resp.self, from: data)
            return decoded.choices.first?.delta?.content
        } catch {
            return nil
        }
    }
}

// MARK: - Tiny helpers
private extension StringProtocol {
    var isEmptyOrWhitespace: Bool { trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
}

private extension String {
    static func decoding<S: AsyncSequence>(_ bytes: S, maximumLength: Int) async throws -> String where S.Element == UInt8 {
        var buffer = [UInt8]()
        buffer.reserveCapacity(maximumLength)
        var iterator = bytes.makeAsyncIterator()
        while let byte = try await iterator.next() {
            buffer.append(byte)
            if buffer.count >= maximumLength { break }
        }
        return String(decoding: buffer, as: UTF8.self)
    }
}

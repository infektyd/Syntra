import Vapor

// MARK: - Public engine protocol your runtime should implement
// Implement `chatStream` for true token streaming. If not available, `chat` is required.

public protocol SyntraChatRuntime {
    func chat(messages: [ChatMessage]) async throws -> String
    func chatStream(messages: [ChatMessage]) async throws -> AsyncStream<String>?
}

// MARK: - Default adapter: replace with your concrete engine
// Wire this to VALON/MODI/your brain. For now, it throws to force implementation.

public final class SyntraEngine: SyntraChatRuntime, @unchecked Sendable {
    public static let shared = SyntraEngine()
    private init() {}

    public func chat(messages: [ChatMessage]) async throws -> String {
        // TODO: Map ChatMessage -> your internal types and return a full assistant string.
        // throw until wired:
        throw Abort(.notImplemented, reason: "SyntraEngine.chat(messages:) not implemented")
    }

    public func chatStream(messages: [ChatMessage]) async throws -> AsyncStream<String>? {
        // TODO: Return AsyncStream<String> for true incremental output, or nil if unavailable.
        return nil
    }
}

// MARK: - Helpers

extension String {
    /// Pseudo-stream splitter for fallback streaming.
    func chunked(_ n: Int) -> [String] {
        guard n > 0 else { return [self] }
        var out: [String] = []
        var i = startIndex
        while i < endIndex {
            let j = index(i, offsetBy: n, limitedBy: endIndex) ?? endIndex
            out.append(String(self[i..<j]))
            i = j
        }
        return out
    }
}

// Escape for JSON string content.
func jsonEscape(_ s: String) -> String {
    s.replacingOccurrences(of: "\\", with: "\\\\")
     .replacingOccurrences(of: "\"", with: "\\\"")
     .replacingOccurrences(of: "\n", with: "\\n")
     .replacingOccurrences(of: "\r", with: "\\r")
}

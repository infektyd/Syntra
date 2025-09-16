import Vapor

struct RequestBodyLoggerMiddleware: AsyncMiddleware {
    func respond(to request: Request, chainingTo next: any AsyncResponder) async throws -> Response {
        guard Environment.get("LOG_REQUEST_BODIES") == "1",
              request.headers.contentType == .json else {
            return try await next.respond(to: request)
        }
        let maxBytes = Int(Environment.get("LOG_BODY_MAX") ?? "65536") ?? 65536
        let redactKeys = Set((Environment.get("REDACT_KEYS") ?? "api_key,authorization")
            .split(separator: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() })

        if let buf = request.body.data {
            var raw = String(buffer: buf)
            if raw.utf8.count > maxBytes {
                let idx = raw.index(raw.startIndex, offsetBy: maxBytes, limitedBy: raw.endIndex) ?? raw.endIndex
                raw = String(raw[..<idx]) + "…(\(raw.utf8.count) bytes)"
            }
            // lightweight redaction (best-effort)
            for key in redactKeys {
                raw = raw.replacingOccurrences(of: "\"\(key)\":", with: "\"\(key)\": ••REDACTED••")
            }
            request.logger.info("🔎 RAW BODY: \(raw)")
            // request.body = .init(buffer: buf) // re-inject
        }
        return try await next.respond(to: request)
    }
}

private struct RawKey: StorageKey { typealias Value = String }
extension Request {
    var rawJSONBodyPreview: String? { storage[RawKey.self] }
}

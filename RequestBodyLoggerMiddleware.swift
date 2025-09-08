import Vapor

/// Captures and logs raw JSON bodies for debugging (non-destructive).
struct RequestBodyLoggerMiddleware: AsyncMiddleware {
    func respond(to request: Request, chainingTo next: AsyncResponder) async throws -> Response {
        if let contentType = request.headers.contentType, contentType == .json {
            // Collect the body data non-destructively
            let buffer = try await request.body.collect(upTo: request.application.routes.defaultMaxBodySize.value)
            let raw = String(buffer: buffer)
            request.logger.info("🔎 RAW BODY: \(raw)")
            
            // Re-inject the body so downstream decoding still works
            request.body = .init(buffer: buffer)
        }
        return try await next.respond(to: request)
    }
}
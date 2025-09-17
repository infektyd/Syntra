import Vapor
import NIO

struct TimeoutMiddleware: AsyncMiddleware {
    let timeout: TimeAmount
    
    init(timeout: TimeAmount = .seconds(600)) { // 10 minutes default
        self.timeout = timeout
    }
    
    func respond(to request: Request, chainingTo next: any AsyncResponder) async throws -> Response {
        // Apply extended timeout for AI/chat endpoints
        if request.url.path.contains("/chat/completions") {
            return try await withTimeout(timeout) {
                try await next.respond(to: request)
            }
        }
        
        // Standard timeout for other endpoints
        return try await next.respond(to: request)
    }
    
    private func withTimeout<T>(_ timeout: TimeAmount, _ operation: @escaping () async throws -> T) async throws -> T {
        return try await withThrowingTaskGroup(of: T.self) { group in
            group.addTask {
                try await operation()
            }
            
            group.addTask {
                try await Task.sleep(nanoseconds: UInt64(timeout.nanoseconds))
                throw TimeoutError()
            }
            
            let result = try await group.next()!
            group.cancelAll()
            return result
        }
    }
}

struct TimeoutError: Error {
    let message = "Request timed out"
}
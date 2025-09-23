import Foundation

// MARK: - Chat Message Model
public struct ChatMessage: Codable, Sendable {
    public enum Role: String, Codable, Sendable {
        case system
        case user
        case assistant
        case tool
    }

    public let role: Role
    public let content: String

    public init(role: Role, content: String) {
        self.role = role
        self.content = content
    }
}

// MARK: - LLM Backend Protocol
public protocol LLMBackend: Sendable {
    /// Complete a chat with optional streaming. When `stream` is false, the stream yields exactly once.
    func complete(
        messages: [ChatMessage],
        stream: Bool
    ) async throws -> AsyncThrowingStream<String, Error>

    /// Lightweight health check string; "ok" indicates healthy by convention.
    func healthCheck() async throws -> String
}

public enum LLMBackendError: Error, LocalizedError {
    case unavailable(String)
    case protocolError(String)
    case httpError(Int, String)
    case decodingError(String)

    public var errorDescription: String? {
        switch self {
        case .unavailable(let msg):
            return "Backend unavailable: \(msg)"
        case .protocolError(let msg):
            return "Backend protocol error: \(msg)"
        case .httpError(let code, let body):
            return "HTTP error \(code): \(body)"
        case .decodingError(let msg):
            return "Decoding error: \(msg)"
        }
    }
}


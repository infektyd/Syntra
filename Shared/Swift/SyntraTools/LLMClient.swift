import Foundation
import SyntraKit

public protocol LLMClient: Sendable {
    func complete(_ messages: [ChatMessage], stream: Bool) async throws -> AsyncThrowingStream<String, Error>
    func healthCheck() async -> String
}

public struct DefaultLLMClient: LLMClient {
    private let backend: LLMBackend?

    public init(backend: LLMBackend? = SyntraEngine.selectBackend()) {
        self.backend = backend
    }

    public func complete(_ messages: [ChatMessage], stream: Bool) async throws -> AsyncThrowingStream<String, Error> {
        if let backend {
            return try await backend.complete(messages: messages, stream: stream)
        }
        // Fallback to AFM backend if available in this build
        let afm = AppleFMBackend()
        return try await afm.complete(messages: messages, stream: stream)
    }

    public func healthCheck() async -> String {
        do {
            if let backend {
                return try await backend.healthCheck()
            }
            // Probe AFM fallback
            return try await AppleFMBackend().healthCheck()
        } catch { return "unavailable" }
    }
}

public enum LLMClients {
    public static let shared: LLMClient = DefaultLLMClient()
}

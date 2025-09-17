import Vapor
import ConversationalInterface // Assumed to contain clearSyntraConversation()
import SyntraKit // Make sure your SyntraCore is in a module imported here
import SyntraCore

// MARK: - Public engine protocol your runtime should implement
public protocol SyntraChatRuntime {
    func chat(messages: [ChatMessage]) async throws -> String
    func chatStream(messages: [ChatMessage]) async throws -> AsyncStream<String>?
}

// MARK: - Adapter to the Core Syntra Consciousness
public final class SyntraEngine: SyntraChatRuntime, @unchecked Sendable {
    public static let shared = SyntraEngine()
    private init() {}

    /// Handles non-streaming chat requests.
    public func chat(messages: [ChatMessage]) async throws -> String {
        guard let lastUserMessage = messages.last(where: { $0.role == .user }),
              case .text(let text) = lastUserMessage.content else {
            return "Syntra is ready. Please provide a prompt."
        }
        
        // NOTE: Stateless server mode — prevent context bleed between requests.
        // If you want to hard-clear any legacy BrainEngine state, you can call
        // BrainEngine.clearConversationHistory() here, but we avoid importing BrainEngine
        // in the server target to keep dependencies minimal.
        // Route through ConversationalInterface's stateless entrypoint.
        return await chatWithSyntraStateless(text)
    }

    /// Handles streaming chat requests.
    public func chatStream(messages: [ChatMessage]) async throws -> AsyncStream<String>? {
        guard let lastUserMessage = messages.last(where: { $0.role == .user }),
              case .text(let text) = lastUserMessage.content else {
            
            let responseText = "Syntra is ready. Please provide a prompt."
            return AsyncStream { continuation in
                continuation.yield(responseText)
                continuation.finish()
            }
        }
        
        // NOTE: Stateless server mode — prevent context bleed between requests (streaming path).
        // See note above about optional BrainEngine.clearConversationHistory()
        let responseText = await chatWithSyntraStateless(text)
        
        // This simulates streaming for the response.
        return AsyncStream { continuation in
            Task {
                let words = responseText.split { $0.isWhitespace || $0.isPunctuation }.map(String.init)
                for (index, word) in words.enumerated() {
                    let separator = (index == words.count - 1) ? "" : " "
                    continuation.yield(word + separator)
                    try? await Task.sleep(nanoseconds: 50_000_000) // 50ms delay
                }
                continuation.finish()
            }
        }
    }
}

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
        
        // Clear the conversation history in the BrainEngine before processing the request.
        await BrainEngine.clearConversationHistory()
        
        // ✅ INTEGRATION: Call the shared SyntraCore instance you provided.
        return await SyntraCore.shared.processWithValonModi(text)
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
        
        // Clear the conversation history in the BrainEngine before processing the request.
        await BrainEngine.clearConversationHistory()
        
        // ✅ INTEGRATION: Call the shared SyntraCore instance you provided.
        let responseText = await SyntraCore.shared.processWithValonModi(text)
        
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

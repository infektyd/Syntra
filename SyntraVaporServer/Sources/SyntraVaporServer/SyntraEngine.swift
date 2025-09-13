import Vapor
import ConversationalInterface

// MARK: - Public engine protocol your runtime should implement
// Implement `chatStream` for true token streaming. If not available, `chat` is required.

public protocol SyntraChatRuntime {
    func chat(messages: [ChatMessage]) async throws -> String
    func chatStream(messages: [ChatMessage]) async throws -> AsyncStream<String>?
}

// MARK: - Adapter to the Core Syntra Consciousness
// This engine acts as a bridge between the Vapor server and the
// internal, stateful SyntraConversationEngine.

public final class SyntraEngine: SyntraChatRuntime, @unchecked Sendable {
    public static let shared = SyntraEngine()
    private init() {}

    public func chat(messages: [ChatMessage]) async throws -> String {
        guard let lastUserMessage = messages.last(where: { $0.role == .user }),
              case .text(let text) = lastUserMessage.content else {
            return "Syntra is ready. Please provide a prompt."
        }
        
        return await chatWithSyntra(text)
    }

    public func chatStream(messages: [ChatMessage]) async throws -> AsyncStream<String>? {
        guard let lastUserMessage = messages.last(where: { $0.role == .user }),
              case .text(let text) = lastUserMessage.content else {
            
            let responseText = "Syntra is ready. Please provide a prompt."
            return AsyncStream { continuation in
                continuation.yield(responseText)
                continuation.finish()
            }
        }

        let responseText = await chatWithSyntra(text)
        
        return AsyncStream { continuation in
            Task {
                let words = responseText.split { $0.isWhitespace || $0.isPunctuation }.map(String.init)
                for (index, word) in words.enumerated() {
                    var separator = " "
                    if index == words.count - 1 {
                        separator = ""
                    } else if let nextChar = responseText.first(where: { $0.isPunctuation }) {
                        if word.last == nextChar {
                           separator = ""
                        }
                    }
                    
                    continuation.yield(word + separator)
                    // Simulate generative speed
                    try? await Task.sleep(nanoseconds: 250_000_000)
                }
                continuation.finish()
            }
        }
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

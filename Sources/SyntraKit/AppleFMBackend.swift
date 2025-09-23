import Foundation

#if canImport(FoundationModels)
import FoundationModels
#endif

public struct AppleFMBackend: LLMBackend {
    public init() {}

    public func healthCheck() async throws -> String { "ok" }

    public func complete(messages: [ChatMessage], stream: Bool) async throws -> AsyncThrowingStream<String, Error> {
        #if canImport(FoundationModels)
        let model = SystemLanguageModel.default
        guard model.availability == .available else {
            throw LLMBackendError.unavailable("FoundationModels unavailable")
        }
        // Use first system message as instructions, rest concatenate as a single prompt for now
        let systemInstr = messages.first(where: { $0.role == .system })?.content
        let userPrompt = messages.filter { $0.role != .system }.map { $0.content }.joined(separator: "\n")

        let session = LanguageModelSession(model: model, instructions: systemInstr ?? "You are Syntra.")

        if stream {
            // Native streaming if available on this platform
            return AsyncThrowingStream<String, Error> { continuation in
                Task {
                    do {
                        let s = session.streamResponse(to: userPrompt)
                        for try await chunk in s {
                            continuation.yield(chunk.content)
                        }
                        continuation.finish()
                    } catch {
                        continuation.finish(throwing: error)
                    }
                }
            }
        } else {
            let resp = try await session.respond(to: userPrompt)
            return AsyncThrowingStream<String, Error> { c in
                c.yield(resp.content)
                c.finish()
            }
        }
        #else
        throw LLMBackendError.unavailable("FoundationModels not present in this build")
        #endif
    }
}


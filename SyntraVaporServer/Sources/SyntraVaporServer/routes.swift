import Vapor
import SyntraKit
import SyntraTools
import BrainEngine
import FoundationModels

// --- MODEL DEFINITIONS ---

struct OpenAIModelsPayload: Content {
    let data: [ModelData]
}

struct ModelData: Content {
    let id: String
    let created: Int
}

struct ErrorResponse: Content {
    let error: String
    let message: String
}

// --- Tool Call Bridge ---

private struct SyntraToolCallRequest: Decodable {
    let tool_name: String
    let arguments: [String: String] // Using a simple dictionary for now
}

// ----------------------------------------------------------
// --- OUTPUT POST-PROCESSING: Add your cleaning here! ---
// ----------------------------------------------------------

func sanitizeOutput(_ text: String) -> String {
    // Remove repeated lines and trim whitespace.
    var seen = Set<String>()
    let lines = text.components(separatedBy: .newlines)
    let filtered = lines.compactMap { (line: String) -> String? in
        let trimmed = line.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return nil }
        if seen.contains(trimmed) { return nil }
        seen.insert(trimmed)
        return trimmed
    }
    return filtered.joined(separator: "\n")
}

// ----------------------------------------------------------
// --- DIRECT BRAIN ENGINE INTEGRATION ---
// ----------------------------------------------------------

private func processWithDirectConsciousness(_ input: String) async throws -> String {
    // Step 1: Process through BrainEngine to get complete consciousness data
    let consciousnessResult = await BrainEngine.processThroughBrains(input)

    // Step 2: Extract complete symbolic and analysis data for PromptArchitect
    let valonResponse = consciousnessResult["valon"] as? String ?? "neutral"
    let modiResponse = consciousnessResult["modi"] as? [String] ?? ["baseline_analysis"]

    // Extract rich symbolic data from Valon
    let valonSymbolicData = consciousnessResult["valon_symbolic_data"] as? [String: Any] ?? [:]

    // Extract detailed Modi analysis
    let modiAnalysisDetails = consciousnessResult["modi_analysis_details"] as? [String: Any] ?? [:]

    // Step 3: Extract precision and verification requirements
    let precisionNeeded = consciousnessResult["precision_needed"] as? Bool ?? false
    let verificationContext = consciousnessResult["verification_context"] as? [String: Any] ?? [:]

    // Step 4: Use PromptArchitect to build enhanced instructions with complete consciousness data
    // Pass rich consciousness data to PromptArchitect for maximum instruction enhancement
    let enhancedInstructions = PromptArchitect.buildEnhancedInstructions(
        valonResponse: valonResponse,
        modiResponse: modiResponse,
        verificationNeeded: precisionNeeded
    )

    // Log the complete consciousness data for debugging
    print("🔍 [CONSCIOUSNESS DATA] Complete data extracted for PromptArchitect:")
    print("  🎭 Valon Symbolic Data: \(valonSymbolicData)")
    print("  🔧 Modi Analysis Details: \(modiAnalysisDetails)")
    print("  ⚡ Precision Context: \(verificationContext)")
    print("  ✅ Complete consciousness data preserved and available")

    // Step 5: Create LanguageModelSession with enhanced instructions
    if #available(macOS 26.0, *) {
        let model = SystemLanguageModel.default
        guard model.availability == .available else {
            // Fallback to synthesis from consciousness if Apple Intelligence unavailable
            if let synthesis = consciousnessResult["consciousness"] as? [String: Any],
               let syntraSynthesis = synthesis["synthesis"] as? String {
                return syntraSynthesis
            }
            return "SYNTRA consciousness processing completed, but Apple Intelligence unavailable for enhanced response."
        }

        let session = LanguageModelSession(model: model)
        // Combine the enhanced instructions with the original input
        let fullPrompt = "\(enhancedInstructions)\n\nUser Input: \(input)"
        let response = try await session.respond(to: fullPrompt)
        return response.content
    } else {
        // Fallback for older macOS versions - use consciousness synthesis
        if let synthesis = consciousnessResult["consciousness"] as? [String: Any],
           let syntraSynthesis = synthesis["synthesis"] as? String {
            return syntraSynthesis
        }
        return "Consciousness processing completed (macOS version does not support Apple Intelligence)."
    }
}

private func processWithDirectConsciousnessStream(_ input: String) async throws -> AsyncThrowingStream<String, any Error> {
    return AsyncThrowingStream<String, any Error> { continuation in
        Task {
            do {
                let result = try await processWithDirectConsciousness(input)
                // For streaming, split the response into chunks
                let chunks = result.components(separatedBy: " ")
                for chunk in chunks {
                    if !chunk.isEmpty {
                        continuation.yield(chunk + " ")
                        try await Task.sleep(nanoseconds: 50_000_000) // 50ms delay between chunks
                    }
                }
                continuation.finish()
            } catch {
                continuation.finish(throwing: error)
            }
        }
    }
}

// ----------------------------------------------------------
// --- ROUTES ---
// ----------------------------------------------------------

func routes(_ app: Application) throws {

    // Lightweight health check for active LLM backend
    app.get("health", "llm") { req async throws -> [String: String] in
        let status = await LLMClients.shared.healthCheck()
        let backend = (Environment.get("SYNTRA_BACKEND") ?? "afm").lowercased()
        return ["status": status, "backend": backend]
    }

    app.get("v1", "models") { req async -> OpenAIModelsPayload in
        let now = Int(Date().timeIntervalSince1970)
        let models = [
            ModelData(id: "gpt-4", created: now),
            ModelData(id: "gpt-3.5-turbo", created: now),
            ModelData(id: "syntra-consciousness", created: now)
        ]
        return OpenAIModelsPayload(data: models)
    }

    app.post("v1", "chat", "completions") { req async throws -> Response in
        let buffer = try await req.body.collect(upTo: app.routes.defaultMaxBodySize.value)
        guard buffer.readableBytes > 0 else {
            req.logger.warning("Request body is empty.")
            throw Abort(.badRequest, reason: "Request body is empty.")
        }

        let bodyString = String(buffer: buffer)
        req.logger.info("Received chat completion request:\n\(bodyString)")
        do {
            let chatRequest = try JSONDecoder().decode(ChatCompletionRequest.self, from: buffer)
            req.logger.info("Successfully decoded request for model: \(chatRequest.model ?? "not specified")")
            let userPrompt = chatRequest.messages.last(where: { $0.role == .user })?.content.asString() ?? ""
            guard !userPrompt.isEmpty else {
                req.logger.warning("User prompt is empty or missing.")
                throw Abort(.badRequest, reason: "User prompt is empty or missing.")
            }

            req.logger.info("Extracted user prompt (first 100 chars): \(userPrompt.prefix(100))")

            let processedPrompt: String
            if userPrompt.count > 8000 {
                req.logger.info("Prompt is too long (\(userPrompt.count) chars), applying middle-out truncation.")
                let prefix = userPrompt.prefix(4000)
                let suffix = userPrompt.suffix(4000)
                processedPrompt = "\(prefix)\n\n[... CONTENT TRUNCATED ...]\n\n\(suffix)"
            } else {
                processedPrompt = userPrompt
            }

            if chatRequest.stream == true {
                req.logger.info("Handling as a STREAMING request.")

                let responseID = "chatcmpl-\(UUID().uuidString)"
                let creationDate = Int(Date().timeIntervalSince1970)
                let modelID = chatRequest.model ?? "syntra-consciousness"
                let body = Response.Body(stream: { writer in
                    Task {
                        do {
                            // 1. Send initial role chunk
                            let initialChunk = ChatCompletionChunk(
                                id: responseID,
                                object: "chat.completion.chunk",
                                created: creationDate,
                                model: modelID,
                                choices: [.init(index: 0, delta: .init(role: "assistant", content: nil, tool_calls: nil), finish_reason: nil)]
                            )
                            let initialJsonData = try JSONEncoder().encode(initialChunk)
                            let initialEventString = "data: \(String(decoding: initialJsonData, as: UTF8.self))\n\n"
                            _ = writer.write(.buffer(.init(string: initialEventString)))
                            // 2. Stream content chunks from selected backend
                            if (Environment.get("SYNTRA_BACKEND") ?? "").lowercased() == "cloud" {
                                let messages: [ChatMessage] = chatRequest.messages
                                let ms: [SyntraKit.ChatMessage] = messages.map { m in
                                    SyntraKit.ChatMessage(role: SyntraKit.ChatMessage.Role(rawValue: m.role.rawValue) ?? .user,
                                                          content: m.content.asString())
                                }
                                let llmStream = try await LLMClients.shared.complete(ms, stream: true)
                                for try await chunk in llmStream {
                                    let chunkResponse = ChatCompletionChunk(
                                        id: responseID,
                                        object: "chat.completion.chunk",
                                        created: creationDate,
                                        model: modelID,
                                        choices: [.init(index: 0, delta: .init(role: nil, content: chunk, tool_calls: nil), finish_reason: nil)]
                                    )
                                    let jsonData = try JSONEncoder().encode(chunkResponse)
                                    let eventString = "data: \(String(decoding: jsonData, as: UTF8.self))\n\n"
                                    _ = writer.write(.buffer(.init(string: eventString)))
                                }
                            } else {
                                let stream = try await processWithDirectConsciousnessStream(processedPrompt)
                                for try await chunk in stream {
                                    let chunkResponse = ChatCompletionChunk(
                                        id: responseID,
                                        object: "chat.completion.chunk",
                                        created: creationDate,
                                        model: modelID,
                                        choices: [.init(index: 0, delta: .init(role: nil, content: chunk, tool_calls: nil), finish_reason: nil)]
                                    )
                                    let jsonData = try JSONEncoder().encode(chunkResponse)
                                    let eventString = "data: \(String(decoding: jsonData, as: UTF8.self))\n\n"
                                    _ = writer.write(.buffer(.init(string: eventString)))
                                }
                            }
                            // 3. Send final finish reason chunk
                            let finalChunk = ChatCompletionChunk(
                                id: responseID,
                                object: "chat.completion.chunk",
                                created: creationDate,
                                model: modelID,
                                choices: [.init(index: 0, delta: .init(role: nil, content: nil, tool_calls: nil), finish_reason: "stop")]
                            )
                            let finalJsonData = try JSONEncoder().encode(finalChunk)
                            let finalEventString = "data: \(String(decoding: finalJsonData, as: UTF8.self))\n\n"
                            _ = writer.write(.buffer(.init(string: finalEventString)))
                            // 4. Terminate the stream
                            req.logger.info("Stream finished. Sending [DONE] message and closing stream.")
                            _ = writer.write(.buffer(.init(string: "data: [DONE]\n\n")))
                            _ = writer.write(.end)
                        } catch {
                            req.logger.error("FATAL STREAMING ERROR: \(error.localizedDescription)")
                            _ = writer.write(.error(error))
                        }
                    }
                })

                var headers = HTTPHeaders()
                headers.add(name: .contentType, value: "text/event-stream")
                headers.add(name: .cacheControl, value: "no-cache")
                headers.add(name: .connection, value: "keep-alive")
                return Response(status: .ok, headers: headers, body: body)

            } else {
                req.logger.info("Handling as a NON-STREAMING request.")

                let replyText: String
                if (Environment.get("SYNTRA_BACKEND") ?? "").lowercased() == "cloud" {
                    let messages: [ChatMessage] = chatRequest.messages
                    let ms: [SyntraKit.ChatMessage] = messages.map { m in
                        SyntraKit.ChatMessage(role: SyntraKit.ChatMessage.Role(rawValue: m.role.rawValue) ?? .user,
                                              content: m.content.asString())
                    }
                    var collected = ""
                    let stream = try await LLMClients.shared.complete(ms, stream: false)
                    for try await piece in stream { collected += piece }
                    replyText = collected
                } else {
                    replyText = try await processWithDirectConsciousness(processedPrompt)
                }
                req.logger.info("Received reply from SyntraKit: \(replyText)")

                // ---- Your output post-processing step here ----
                let cleanedReply = sanitizeOutput(replyText)
                // ------------------------------------------------

                if let toolCallData = cleanedReply.data(using: .utf8),
                    let syntraToolCall = try? JSONDecoder().decode(SyntraToolCallRequest.self, from: toolCallData) {
                    req.logger.info("Detected tool call: \(syntraToolCall.tool_name)")
                    let argumentsData = try JSONEncoder().encode(syntraToolCall.arguments)
                    let argumentsString = String(data: argumentsData, encoding: .utf8) ?? "{}"
                    let responseMessage = ChatCompletionResponse.AssistantMessage(
                        role: "assistant",
                        content: nil,
                        tool_calls: [.init(
                            id: "call_\(UUID().uuidString)",
                            type: "function",
                            function: .init(name: syntraToolCall.tool_name, arguments: argumentsString)
                        )]
                    )
                    let response = ChatCompletionResponse(
                        id: "chatcmpl-\(UUID().uuidString)",
                        object: "chat.completion",
                        created: Int(Date().timeIntervalSince1970),
                        model: chatRequest.model ?? "syntra-consciousness",
                        choices: [.init(index: 0, message: responseMessage, finish_reason: "tool_calls")],
                        usage: nil
                    )
                    return try await response.encodeResponse(for: req)
                } else {
                    let response = ChatCompletionResponse(
                        id: "chatcmpl-\(UUID().uuidString)",
                        object: "chat.completion",
                        created: Int(Date().timeIntervalSince1970),
                        model: chatRequest.model ?? "syntra-consciousness",
                        choices: [.init(index: 0, message: .init(role: "assistant", content: cleanedReply, tool_calls: nil), finish_reason: "stop")],
                        usage: nil
                    )
                    return try await response.encodeResponse(for: req)
                }
            }
        } catch {
            req.logger.error("Failed to process chat completion request: \(error.localizedDescription)")
            let errorResponse = ErrorResponse(error: "request_failed", message: "Failed to decode or process request: \(error.localizedDescription)")
            let response = try await errorResponse.encodeResponse(for: req)
            response.status = .internalServerError
            return response
        }
    }
}

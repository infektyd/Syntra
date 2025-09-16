import Vapor
import SyntraKit

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
// --- ROUTES ---
// ----------------------------------------------------------

func routes(_ app: Application) throws {

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
                            // 2. Stream content chunks
                            let stream = try await SyntraHandlers.handleProcessThroughBrainsStream(processedPrompt)
                            for try await chunk in stream {
                                // You may also process chunks here if you want (sanitizeOutput)
                                let chunkResponse = ChatCompletionChunk(
                                    id: responseID,
                                    object: "chat.completion.chunk",
                                    created: creationDate,
                                    model: modelID,
                                    choices: [.init(index: 0, delta: .init(role: nil, content: chunk, tool_calls: nil), finish_reason: nil)]
                                )
                                let jsonData = try JSONEncoder().encode(chunkResponse)
                                let eventString = "data: \(String(decoding: jsonData, as: UTF8.self))\n\n"
                                req.logger.debug("Writing stream chunk: \(eventString)")
                                _ = writer.write(.buffer(.init(string: eventString)))
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

                let replyText = try await SyntraHandlers.handleProcessThroughBrains(processedPrompt)
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

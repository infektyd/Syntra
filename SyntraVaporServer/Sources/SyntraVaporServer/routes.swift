import Vapor
import Foundation

public func routes(_ app: Application) throws {
    // --- Chat Completions ---
    app.post("v1", "chat", "completions") { req async throws -> Response in
        // decode leniently
        let body: ChatCompletionRequest
        do {
            body = try req.content.decode(ChatCompletionRequest.self)
            req.logger.info("Successfully decoded request for model: \(body.model)")
        } catch {
            req.logger.error("🛑 Decode error: \(error)")
            struct APIErr: Content { let error: Err
                struct Err: Content { let message: String; let type: String; let code: String? } }
            let payload = APIErr(error: .init(
                message: "Bad request: \(error)",
                type: "invalid_request_error",
                code: "invalid_json"
            ))
            return try await payload.encodeResponse(status: .badRequest, for: req)
        }

        RequestIntakeDebug.log(req, rawBody: req.body.data.map { String(buffer: $0) }, parsed: body)

        let wantsStream = body.stream ?? false
        let created = Int(Date().timeIntervalSince1970)
        let id = "chatcmpl_syntra_\(UUID().uuidString.prefix(8))"

        if wantsStream {
            // Streaming (SSE)
            var headers = HTTPHeaders()
            headers.replaceOrAdd(name: .contentType, value: "text/event-stream")
            headers.replaceOrAdd(name: .cacheControl, value: "no-cache")
            headers.replaceOrAdd(name: .connection, value: "keep-alive")

            let res = Response(status: .ok, headers: headers, body: .init(stream: { writer in
                func sse(_ json: String) { _ = writer.write(.buffer(ByteBuffer(string: "data: \(json)\n\n")))
                }
                // role preamble
                let pre = ChatCompletionChunk(
                    id: id, object: "chat.completion.chunk", created: created, model: body.model,
                    choices: [.init(index: 0, delta: .init(role: "assistant", content: nil), finish_reason: nil)]
                )
                if let preData = try? JSONEncoder().encode(pre), let preStr = String(data: preData, encoding: .utf8) {
                    sse(preStr)
                }

                Task {
                    do {
                        if let stream = try await SyntraEngine.shared.chatStream(messages: body.messages) {
                            // true streaming from runtime
                            for await piece in stream {
                                guard !piece.isEmpty else { continue }
                                let ch = ChatCompletionChunk(
                                    id: id, object: "chat.completion.chunk", created: created, model: body.model,
                                    choices: [.init(index: 0, delta: .init(role: nil, content: piece), finish_reason: nil)]
                                )
                                if let data = try? JSONEncoder().encode(ch),
                                   let str = String(data: data, encoding: .utf8) { sse(str) }
                            }
                        } else {
                            // fallback: pseudo-stream a full completion
                            let full = try await SyntraEngine.shared.chat(messages: body.messages)
                            for tok in full.chunked(24) {
                                let ch = ChatCompletionChunk(
                                    id: id, object: "chat.completion.chunk", created: created, model: body.model,
                                    choices: [.init(index: 0, delta: .init(role: nil, content: tok), finish_reason: nil)]
                                )
                                if let data = try? JSONEncoder().encode(ch),
                                   let str = String(data: data, encoding: .utf8) { sse(str) }
                            }
                        }
                        // stop + DONE
                        let stop = ChatCompletionChunk(
                            id: id, object: "chat.completion.chunk", created: created, model: body.model,
                            choices: [.init(index: 0, delta: .init(role: nil, content: nil), finish_reason: "stop")]
                        )
                        if let data = try? JSONEncoder().encode(stop),
                           let str = String(data: data, encoding: .utf8) { sse(str) }
                        _ = writer.write(.buffer(ByteBuffer(string: "data: [DONE]\n\n")))
                        req.logger.info("Stream finished. Sending [DONE] message and closing stream.")
                        _ = writer.write(.end)
                    } catch {
                        req.logger.error("🛑 Stream error: \(error)")
                        _ = writer.write(.end)
                    }
                }
            }))
            return res
        } else {
            // Non-streaming
            do {
                let text = try await SyntraEngine.shared.chat(messages: body.messages)
                let usage = ChatCompletionResponse.Usage(
                    prompt_tokens: 0, completion_tokens: 0, total_tokens: 0 // TODO: fill if you track
                )
                let resp = ChatCompletionResponse(
                    id: id,
                    object: "chat.completion",
                    created: created,
                    model: body.model,
                    choices: [.init(index: 0, message: .init(content: text), finish_reason: "stop")],
                    usage: usage
                )
                return try await resp.encodeResponse(status: .ok, for: req)
            } catch {
                req.logger.error("🛑 Generation error: \(error)")
                struct APIErr: Content { let error: Err
                    struct Err: Content { let message: String; let type: String; let code: String? } }
                let payload = APIErr(error: .init(
                    message: "Generation failed: \(error)",
                    type: "server_error",
                    code: "generation_failed"
                ))
                return try await payload.encodeResponse(status: .internalServerError, for: req)
            }
        }
    }

    // Optional: enable with ENABLE_MODELS / ENABLE_EMBEDDINGS env vars
    registerOpenAICompatRoutes(app)
}

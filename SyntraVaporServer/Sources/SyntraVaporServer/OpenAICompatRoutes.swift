import Vapor

public func registerOpenAICompatRoutes(_ app: Application) {
    if Environment.get("ENABLE_MODELS") == "1" {
        app.get("v1", "models") { req async throws -> Response in
            struct Model: Content { var id: String; var object: String = "model"; var owned_by: String = "local" }
            struct ModelList: Content { var object: String = "list"; var data: [Model] }
            let list = ModelList(data: [Model(id: "syntra-consciousness")])
            return try await list.encodeResponse(status: .ok, for: req)
        }
    }
    if Environment.get("ENABLE_EMBEDDINGS") == "1" {
        app.post("v1", "embeddings") { req async throws -> Response in
            struct EmbReq: Content {
                let model: String
                let input: Input
                enum Input: Codable {
                    case string(String), array([String])
                    init(from decoder: any Decoder) throws {
                        let c = try decoder.singleValueContainer()
                        if let s = try? c.decode(String.self) { self = .string(s); return }
                        if let a = try? c.decode([String].self) { self = .array(a); return }
                        throw Abort(.badRequest, reason: "input must be string or array of strings")
                    }
                }
            }
            struct Emb: Content { var object: String = "embedding"; var embedding: [Float]; var index: Int }
            struct EmbResp: Content { var object: String = "list"; var data: [Emb]; var model: String }

            let body = try req.content.decode(EmbReq.self)
            let dim = 1536
            let zero = [Float](repeating: 0.0, count: dim)
            let arr: [String]
            switch body.input {
            case .string(_): arr = [""]
            case .array(let a): arr = a
            }
            let data = arr.enumerated().map { Emb(embedding: zero, index: $0.offset) }
            let resp = EmbResp(data: data, model: body.model)
            return try await resp.encodeResponse(status: .ok, for: req)
        }
    }
}

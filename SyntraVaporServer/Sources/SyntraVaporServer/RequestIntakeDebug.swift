import Vapor

struct RequestIntakeDebug {
    static func log(_ req: Request, rawBody: String?, parsed: ChatCompletionRequest?) {
        let id = req.headers.first(name: "x-request-id") ?? "<none>"
        req.logger.info("🪵 DEBUG id=\(id) method=\(req.method.rawValue) path=\(req.url.path)")
        req.logger.info("🪵 HDR content-type=\(req.headers.contentType?.description ?? "<nil>") accept=\(req.headers.first(name: .accept) ?? "<nil>")")
        req.logger.info("🪵 QRY \(req.url.query ?? "<none>")")
        if let raw = rawBody {
            let preview = raw.count > 200 ? String(raw.prefix(200)) + "…(\(raw.count) bytes)" : raw
            req.logger.info("🪵 RAW \(preview)")
        }
        if let body = parsed {
            let parts = body.messages.map { "\($0.role):\($0.contentSummary())" }.joined(separator: " | ")
            req.logger.info("🪵 MSG \(parts)")
            if let tools = body.tools, !tools.isEmpty {
                let t = tools.map { $0.function?.name ?? $0.type }.joined(separator: ", ")
                req.logger.info("🪵 TOOLS [\(t)] tool_choice=\(String(describing: body.tool_choice))")
            }
            req.logger.info("🪵 FLAGS stream=\(String(describing: body.stream)) temp=\(String(describing: body.temperature)) max_tokens=\(String(describing: body.max_tokens))")
        }
    }
}
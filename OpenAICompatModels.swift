import Vapor

// MARK: - OpenAI-compatible Chat Completion Request (lenient)

struct ChatCompletionRequest: Content {
    let model: String
    let messages: [ChatMessage]

    // Common optional fields sent by various agents (accepted but not required)
    let tools: [ToolSpec]?
    let tool_choice: JSONValue?
    let temperature: Double?
    let max_tokens: Int?
    let stream: Bool?
    let n: Int?
    let user: String?
    let top_p: Double?
    let frequency_penalty: Double?
    let presence_penalty: Double?
    let stop: JSONValue?
    let response_format: JSONValue?

    enum CodingKeys: String, CodingKey {
        case model, messages, tools, tool_choice, temperature, max_tokens, stream, n, user, top_p, frequency_penalty, presence_penalty, stop, response_format
    }
}

struct ChatMessage: Content {
    enum Role: String, Content { 
        case system, user, assistant, tool, function 
    }

    let role: Role
    let content: MessageContent

    enum CodingKeys: String, CodingKey { 
        case role, content 
    }

    init(role: Role, content: MessageContent) {
        self.role = role
        self.content = content
    }

    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        role = try c.decode(Role.self, forKey: .role)

        // content may be a string or an array (multi-part content); accept both
        if let s = try? c.decode(String.self, forKey: .content) {
            content = .text(s)
        } else if let arr = try? c.decode([JSONValue].self, forKey: .content) {
            content = .parts(arr)
        } else {
            content = .text("")
        }
    }
}

enum MessageContent: Content {
    case text(String)
    case parts([JSONValue])

    init(from decoder: Decoder) throws {
        let c = try decoder.singleValueContainer()
        if let s = try? c.decode(String.self) { 
            self = .text(s)
            return 
        }
        if let a = try? c.decode([JSONValue].self) { 
            self = .parts(a)
            return 
        }
        self = .text("")
    }

    func encode(to encoder: Encoder) throws {
        switch self {
        case .text(let s):
            var c = encoder.singleValueContainer()
            try c.encode(s)
        case .parts(let a):
            var c = encoder.singleValueContainer()
            try c.encode(a)
        }
    }
    
    /// Extract text content from message content
    func asString() -> String {
        switch self {
        case .text(let s):
            return s
        case .parts(let parts):
            return parts.compactMap { part in
                switch part {
                case .string(let s):
                    return s
                case .object(let obj):
                    // Try to extract "text" field from content parts
                    if case .string(let text) = obj["text"] {
                        return text
                    }
                    return nil
                default:
                    return nil
                }
            }.joined(separator: " ")
        }
    }
}

struct ToolSpec: Content {
    let type: String
    let function: ToolFunctionSpec?
}

struct ToolFunctionSpec: Content {
    let name: String
    let description: String?
    let parameters: JSONValue?
}

// MARK: - Lossless JSON wrapper for unknown/heterogeneous fields

enum JSONValue: Content {
    case string(String)
    case number(Double)
    case bool(Bool)
    case object([String: JSONValue])
    case array([JSONValue])
    case null

    init(from decoder: Decoder) throws {
        let c = try decoder.singleValueContainer()
        if c.decodeNil() { 
            self = .null
            return 
        }
        if let s = try? c.decode(String.self) { 
            self = .string(s)
            return 
        }
        if let b = try? c.decode(Bool.self) { 
            self = .bool(b)
            return 
        }
        if let n = try? c.decode(Double.self) { 
            self = .number(n)
            return 
        }
        if let o = try? c.decode([String: JSONValue].self) { 
            self = .object(o)
            return 
        }
        if let a = try? c.decode([JSONValue].self) { 
            self = .array(a)
            return 
        }
        self = .null
    }

    func encode(to encoder: Encoder) throws {
        var c = encoder.singleValueContainer()
        switch self {
        case .string(let s): try c.encode(s)
        case .number(let d): try c.encode(d)
        case .bool(let b): try c.encode(b)
        case .object(let o): try c.encode(o)
        case .array(let a): try c.encode(a)
        case .null: try c.encodeNil()
        }
    }
}

// MARK: - Response Models

struct ChatCompletionResponse: Content {
    let object = "chat.completion"
    let id: String
    let created: Int
    let model: String
    let choices: [Choice]
    let usage: Usage?
    
    struct Choice: Content {
        let index: Int
        let message: ResponseMessage
        let finish_reason: String?
    }
    
    struct Usage: Content {
        let prompt_tokens: Int
        let completion_tokens: Int
        let total_tokens: Int
    }
}

struct ResponseMessage: Content {
    let role: String
    let content: String?
    let tool_calls: [ToolCall]?
    
    struct ToolCall: Content {
        let id: String
        let type: String
        let function: ToolFunction
        
        struct ToolFunction: Content {
            let name: String
            let arguments: String
        }
    }
}

// MARK: - Error Response

struct ChatCompletionError: Content {
    let error: ErrorDetail
    
    struct ErrorDetail: Content {
        let message: String
        let type: String
        let param: String?
        let code: String?
    }
}
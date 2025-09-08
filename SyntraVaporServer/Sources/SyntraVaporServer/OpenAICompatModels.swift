import Vapor
import Foundation

// MARK: - Lenient OpenAI Chat request

public struct ChatCompletionRequest: Content {
    public let model: String
    public let messages: [ChatMessage]
    // Common optional fields
    public let tools: [ToolSpec]?
    public let tool_choice: JSONValue?
    public let temperature: Double?
    public let max_tokens: Int?
    public let stream: Bool?
    public let n: Int?
    public let user: String?
    public let top_p: Double?
    public let frequency_penalty: Double?
    public let presence_penalty: Double?
    public let stop: JSONValue?
    public let response_format: JSONValue?
}

public struct ChatMessage: Content {
    public enum Role: String, Content { case system, user, assistant, tool, function }
    public let role: Role
    public let content: MessageContent

    public enum CodingKeys: String, CodingKey { case role, content }
    public init(role: Role, content: MessageContent) { self.role = role; self.content = content }
    public init(from decoder: any Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        role = try c.decode(Role.self, forKey: .role)
        if let s = try? c.decode(String.self, forKey: .content) {
            content = .text(s)
        } else if let a = try? c.decode([JSONValue].self, forKey: .content) {
            content = .parts(a)
        } else {
            content = .text("")
        }
    }
}

public enum MessageContent: Content {
    case text(String)
    case parts([JSONValue])
    public init(from decoder: any Decoder) throws {
        let c = try decoder.singleValueContainer()
        if let s = try? c.decode(String.self) { self = .text(s); return }
        if let a = try? c.decode([JSONValue].self) { self = .parts(a); return }
        self = .text("")
    }
    public func encode(to encoder: any Encoder) throws {
        switch self {
        case .text(let s): var c = encoder.singleValueContainer(); try c.encode(s)
        case .parts(let a): var c = encoder.singleValueContainer(); try c.encode(a)
        }
    }
}

public struct ToolSpec: Content {
    public let type: String
    public let function: ToolFunctionSpec?
}
public struct ToolFunctionSpec: Content {
    public let name: String
    public let description: String?
    public let parameters: JSONValue?
}

public enum JSONValue: Content {
    case string(String), number(Double), bool(Bool), object([String: JSONValue]), array([JSONValue]), null
    public init(from decoder: any Decoder) throws {
        let c = try decoder.singleValueContainer()
        if c.decodeNil() { self = .null; return }
        if let s = try? c.decode(String.self) { self = .string(s); return }
        if let b = try? c.decode(Bool.self) { self = .bool(b); return }
        if let d = try? c.decode(Double.self) { self = .number(d); return }
        if let o = try? c.decode([String: JSONValue].self) { self = .object(o); return }
        if let a = try? c.decode([JSONValue].self) { self = .array(a); return }
        self = .null
    }
    public func encode(to encoder: any Encoder) throws {
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

// MARK: - OpenAI-style Responses

// Non-streaming
public struct ChatCompletionResponse: Content {
    public var id: String
    public var object: String = "chat.completion"
    public var created: Int
    public var model: String
    public var choices: [Choice]
    public var usage: Usage?

    public struct Choice: Content {
        public var index: Int
        public var message: AssistantMessage
        public var finish_reason: String? // "stop" | "length" | "tool_calls" etc.
    }
    public struct AssistantMessage: Content {
        public var role: String = "assistant"
        public var content: String
    }
    public struct Usage: Content {
        public var prompt_tokens: Int
        public var completion_tokens: Int
        public var total_tokens: Int
    }
}

// Streaming chunks
public struct ChatCompletionChunk: Content {
    public var id: String
    public var object: String = "chat.completion.chunk"
    public var created: Int
    public var model: String
    public var choices: [DeltaChoice]

    public struct DeltaChoice: Content {
        public var index: Int
        public var delta: Delta
        public var finish_reason: String?
    }
    public struct Delta: Content {
        public var role: String?
        public var content: String?
    }
}

// Utility
extension ChatMessage {
    func contentSummary(max: Int = 120) -> String {
        switch content {
        case .text(let s): return s.count > max ? String(s.prefix(max)) + "…" : s
        case .parts(let a): return "[\(a.count) parts]"
        }
    }
}
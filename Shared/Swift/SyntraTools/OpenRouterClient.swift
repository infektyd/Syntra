import Foundation

/// Client for interacting with OpenRouter API to generate structured SYNTRA traces
public struct OpenRouterClient {
    private let apiKey: String
    private let baseURL: String
    private let session: URLSession

    public init(apiKey: String, baseURL: String = "https://openrouter.ai/api/v1") {
        self.apiKey = apiKey
        self.baseURL = OpenRouterClient.normalizeBaseURL(baseURL)
        self.session = URLSession(configuration: .default)
    }

    /// Ensure the configured base URL always includes the `/v1` segment once and only once.
    private static func normalizeBaseURL(_ rawBase: String) -> String {
        var normalized = rawBase.trimmingCharacters(in: .whitespacesAndNewlines)

        if normalized.hasSuffix("/") {
            normalized.removeLast()
        }

        if !normalized.hasSuffix("/v1") {
            normalized += "/v1"
        }

        return normalized
    }

    private func endpointURL(for path: String) throws -> URL {
        let fullPath = baseURL + (path.hasPrefix("/") ? path : "/" + path)
        guard let url = URL(string: fullPath) else {
            throw OpenRouterError.invalidBaseURL("Unable to form URL from base: \(baseURL) and path: \(path)")
        }
        return url
    }

    /// Response structure from OpenRouter API
    public struct OpenRouterResponse: Codable {
        public let id: String
        public let object: String
        public let created: Int
        public let model: String
        public let choices: [Choice]
        public let usage: Usage?

        public struct Choice: Codable {
            public let index: Int
            public let message: Message
            public let finish_reason: String?
        }

        public struct Message: Codable {
            public let role: String
            public let content: String
        }

        public struct Usage: Codable {
            public let prompt_tokens: Int
            public let completion_tokens: Int
            public let total_tokens: Int
        }
    }

    /// Request structure for OpenRouter API
    public struct OpenRouterRequest: Codable {
        public let model: String
        public let messages: [Message]
        public let temperature: Double
        public let max_tokens: Int?
        public let stream: Bool

        public struct Message: Codable {
            public let role: String
            public let content: String
        }

        public init(model: String, messages: [Message], temperature: Double = 0.3, max_tokens: Int? = 2000, stream: Bool = false) {
            self.model = model
            self.messages = messages
            self.temperature = temperature
            self.max_tokens = max_tokens
            self.stream = stream
        }
    }

    /// Send a chat completion request to OpenRouter
    public func sendChatCompletion(
        model: String,
        prompt: String,
        temperature: Double = 0.3,
        maxTokens: Int? = 2000
    ) async throws -> OpenRouterResponse {
        let url = try endpointURL(for: "/chat/completions")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        let message = OpenRouterRequest.Message(role: "user", content: prompt)
        let openRouterRequest = OpenRouterRequest(
            model: model,
            messages: [message],
            temperature: temperature,
            max_tokens: maxTokens,
            stream: false
        )

        request.httpBody = try JSONEncoder().encode(openRouterRequest)

        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            let responseText = String(data: data, encoding: .utf8) ?? "Unknown error"
            throw OpenRouterError.apiError("HTTP \(String(describing: (response as? HTTPURLResponse)?.statusCode)): \(responseText)")
        }

        do {
            let decodedResponse = try JSONDecoder().decode(OpenRouterResponse.self, from: data)
            return decodedResponse
        } catch {
            let responseText = String(data: data, encoding: .utf8) ?? "Unable to decode response"
            throw OpenRouterError.decodingError("Failed to decode response: \(error.localizedDescription). Response: \(responseText)")
        }
    }

    /// Extract the content from an OpenRouter response
    public func extractContent(from response: OpenRouterResponse) -> String? {
        return response.choices.first?.message.content
    }

    /// Send a chat completion request and return the raw content string
    /// This is the primary method for Step 3: capturing raw model response
    public func sendWrappedPromptAndGetRawResponse(
        wrappedPrompt: String,
        model: String = "openai/gpt-4o-mini",
        temperature: Double = 0.3,
        maxTokens: Int? = 2000
    ) async throws -> String {
        let response = try await sendChatCompletion(
            model: model,
            prompt: wrappedPrompt,
            temperature: temperature,
            maxTokens: maxTokens
        )

        guard let rawContent = extractContent(from: response) else {
            throw OpenRouterError.decodingError("No content found in response")
        }

        return rawContent
    }

    /// Get available models (basic implementation)
    public func getModels() async throws -> [String] {
        let url = try endpointURL(for: "/models")
        var request = URLRequest(url: url)
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        let (data, _) = try await session.data(for: request)

        // Parse models response - simplified implementation
        struct ModelsResponse: Codable {
            let data: [ModelInfo]
            struct ModelInfo: Codable {
                let id: String
            }
        }

        let modelsResponse = try JSONDecoder().decode(ModelsResponse.self, from: data)
        return modelsResponse.data.map { $0.id }
    }

    /// Error types for OpenRouter operations
    public enum OpenRouterError: Error {
        case apiError(String)
        case decodingError(String)
        case networkError(Error)
        case invalidAPIKey
        case rateLimited
        case invalidBaseURL(String)
    }
}

/// Environment-based configuration for OpenRouter
public extension OpenRouterClient {
    static func fromEnvironment() -> OpenRouterClient? {
        guard let apiKey = ProcessInfo.processInfo.environment["LLM_API_KEY"] else {
            print("Warning: LLM_API_KEY not found in environment for OpenRouterClient")
            return nil
        }

        let baseURL = ProcessInfo.processInfo.environment["LLM_BASE_URL"] ?? "https://openrouter.ai/api/v1"

        return OpenRouterClient(apiKey: apiKey, baseURL: baseURL)
    }
}

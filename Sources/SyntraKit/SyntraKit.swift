// SyntraKit.swift
// Swift 6.x-compatible

import Foundation
#if canImport(FoundationModels)
import FoundationModels
#endif
// Note: SyntraKit is a backend leaf; avoid importing Shared modules here.

/// Core AI processing engine for Syntra
public class SyntraEngine {
    // MARK: - Backend Selection
    public static func selectBackend() -> LLMBackend? {
        let mode = (ProcessInfo.processInfo.environment["SYNTRA_BACKEND"] ?? "").lowercased()
        switch mode {
        case "cloud":
            return CloudOpenAIBackend()
        case "afm":
            return AppleFMBackend()
        default:
            return nil
        }
    }

    /// Expose currently selected backend (nil when defaulting to AFM without env flag)
    public static func currentBackend() -> LLMBackend? { selectBackend() }

    // ... (all existing functions in SyntraEngine remain the same) ...
    #if canImport(FoundationModels)
    public static func getAvailableModel() throws -> SystemLanguageModel {
        let model = SystemLanguageModel.default
        guard model.availability == .available else {
            throw NSError(domain: "FoundationModels", code: -1, userInfo: [NSLocalizedDescriptionKey: "FoundationModels not available on this device"])
        }
        return model
    }
    #endif

    public static func estimateTokens(_ text: String) -> Int {
        let words = text.split(separator: " ").count
        let lines = text.split(whereSeparator: \.isNewline).count
        let specials = text.filter { "#`🍎\n[]{}".contains($0) }.count
        return Int(Double(words) * 1.5) + (text.count / 3) + (lines * 2) + specials
    }

    public static func truncatePrompt(_ prompt: String, maxTokens: Int = 1500, useOverlap: Bool = false) -> String {
        let estimated = estimateTokens(prompt)
        guard estimated > maxTokens else { return prompt }
        let ratio = Double(maxTokens) / Double(estimated)
        let targetLength = Int(Double(prompt.count) * ratio) - 200
        var truncated = String(prompt.prefix(targetLength)) + " [TRUNCATED: Exceeded limit]"
        print("[DEBUG] Truncated from ~\(estimated) to ~\(maxTokens) tokens; Length: \(truncated.count)")
        if useOverlap {
            let overlapSize = Int(Double(targetLength) * 0.2)
            truncated = String(prompt.suffix(overlapSize)) + truncated
        }
        return truncated
    }

    public static func preparePrompt(_ input: String, isInternal: Bool = false) -> String {
        let basePrompt = truncatePrompt(input)
        return isInternal ? "[Internal SYNTRA 3-brain] \(basePrompt)" : basePrompt
    }

    public static func continueSession(_ input: String, instructions: String? = nil) async throws -> String {
        if let backend = selectBackend() {
            // Route via pluggable backend
            let messages: [ChatMessage] = [
                .init(role: .system, content: instructions ?? "You are Syntra."),
                .init(role: .user, content: input)
            ]
            var collected = ""
            let stream = try await backend.complete(messages: messages, stream: false)
            for try await chunk in stream { collected += chunk }
            return collected
        }
        // Default AFM path
        #if canImport(FoundationModels)
        let model = try getAvailableModel()
        let session = LanguageModelSession(model: model, instructions: instructions ?? "You are Syntra.")
        do {
            let response = try await session.respond(to: input)
            return response.content
        } catch let error as LanguageModelSession.GenerationError {
            if case .exceededContextWindowSize = error {
                // Graceful fallback without higher-level dependencies
                let truncated = truncatePrompt(input, maxTokens: 1200)
                return "[Context window exceeded] Responding to truncated input:\n\(truncated)"
            } else { throw error }
        }
        #else
        throw NSError(domain: "SYNTRA", code: -2, userInfo: [NSLocalizedDescriptionKey: "No backend available (set SYNTRA_BACKEND=cloud or build with FoundationModels)"])
        #endif
    }
}

// SyntraKit.swift
// Swift 6.x-compatible

import Foundation
import FoundationModels
import SyntraCore
import ConversationalInterface
import SyntraTools

/// Core AI processing engine for Syntra
public class SyntraEngine {

    // ... (all existing functions in SyntraEngine remain the same) ...
    public static func getAvailableModel() throws -> SystemLanguageModel {
        let model = SystemLanguageModel.default
        guard model.availability == .available else {
            throw NSError(domain: "FoundationModels", code: -1, userInfo: [NSLocalizedDescriptionKey: "FoundationModels not available on this device"])
        }
        return model
    }

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
        let model = try getAvailableModel()
        let session = LanguageModelSession(model: model, instructions: instructions ?? "You are Syntra.")
        do {
            let response = try await session.respond(to: input)
            return response.content
        } catch let error as LanguageModelSession.GenerationError {
            if case .exceededContextWindowSize = error {
                // Handle context window exceeded with consciousness-aware approach
                print("⚠️ [CONTEXT_WINDOW] Exceeded context window, using SYNTRA consciousness synthesis")
                return await handleContextWindowExceeded(input)
            } else {
                throw error
            }
        }
    }
    
    @available(macOS 26.0, *)
    private static func handleContextWindowExceeded(_ input: String) async -> String {
        // Use SYNTRA's consciousness to handle complex requests that exceed context windows
        print("🧠 [CONSCIOUSNESS] Routing complex request through three-brain architecture")
        return await chatWithSyntra("This is a complex request that requires careful analysis: \(input)")
    }
}


/// Command handlers for different SYNTRA operations
public struct SyntraHandlers {

    /// Handle process through brains request - FIXED to use actual three-brain architecture
    /// - Parameter input: Input text  
    /// - Returns: Processed response from SYNTRA consciousness
    @available(macOS 26.0, *)
    public static func handleProcessThroughBrains(_ input: String) async throws -> String {
        print("🧠 [SYNTRA_ROUTING] Processing through three-brain consciousness architecture")
        print("📝 [INPUT] \(input.prefix(150))...")
        
        // Route through actual SYNTRA consciousness instead of bypassing it
        let response = await chatWithSyntra(input)
        
        print("✨ [CONSCIOUSNESS_RESPONSE] Generated response of \(response.count) characters")
        return response
    }
    
    /// Fallback for older macOS versions
    public static func handleProcessThroughBrainsFallback(_ input: String) async throws -> String {
        print("⚠️ [FALLBACK] Using legacy processing - consciousness features limited")
        return try await SyntraEngine.continueSession(input)
    }
    
    /// Main entry point that handles macOS version compatibility
    public static func handleProcessThroughBrains(_ input: String) async throws -> String {
        if #available(macOS 26.0, *) {
            return try await handleProcessThroughBrains(input)
        } else {
            return try await handleProcessThroughBrainsFallback(input)
        }
    }

    /// Handle process through brains request as a stream
    /// - Parameter input: Input text
    /// - Returns: A stream of processed response chunks
    public static func handleProcessThroughBrainsStream(_ input: String) async throws -> AsyncThrowingStream<String, Error> {
        // For streaming, we'll chunk the consciousness response
        return AsyncThrowingStream<String, Error> { continuation in
            Task {
                do {
                    if #available(macOS 26.0, *) {
                        let fullResponse = try await handleProcessThroughBrains(input)
                        
                        // Split response into chunks for streaming
                        let words = fullResponse.components(separatedBy: " ")
                        let chunkSize = max(1, words.count / 20) // 20 chunks
                        
                        for i in stride(from: 0, to: words.count, by: chunkSize) {
                            let endIndex = min(i + chunkSize, words.count)
                            let chunk = Array(words[i..<endIndex]).joined(separator: " ")
                            continuation.yield(chunk + " ")
                            
                            // Small delay between chunks
                            try await Task.sleep(nanoseconds: 50_000_000) // 50ms
                        }
                    } else {
                        // Fallback streaming for older macOS
                        let model = try SyntraEngine.getAvailableModel()
                        let session = LanguageModelSession(model: model)
                        let stream = session.streamResponse(to: input)
                        for try await chunk in stream {
                            continuation.yield(chunk.content)
                        }
                    }
                    continuation.finish()
                } catch {
                    continuation.finish(throwing: error)
                }
            }
        }
    }

    // ... (all other existing functions in SyntraHandlers remain the same) ...
    public static func handleProcessStructured(_ input: String) async throws -> String {
        if #available(macOS 26.0, *) {
            return await chatWithSyntraEnhanced("[Structured processing requested] \(input)")
        } else {
            return try await SyntraEngine.continueSession("[Structured SYNTRA request] \(input)", instructions: "[Internal SYNTRA 3-brain]")
        }
    }
    
    public static func handleReflectValon(_ input: String) async throws -> String {
        if #available(macOS 26.0, *) {
            return await chatWithSyntra("Please respond from your VALON perspective (emotional/creative/moral): \(input)")
        } else {
            return try await SyntraEngine.continueSession("[Valon: moral reflection] \(input)", instructions: "[Internal SYNTRA 3-brain]")
        }
    }
    
    public static func handleReflectModi(_ input: String) async throws -> String {
        if #available(macOS 26.0, *) {
            return await chatWithSyntra("Please respond from your MODI perspective (logical/analytical): \(input)")
        } else {
            return try await SyntraEngine.continueSession("[Modi: logical reflection] \(input)", instructions: "[Internal SYNTRA 3-brain]")
        }
    }
    
    public static func handleProcessWithDrift(_ input: String) async throws -> String {
        if #available(macOS 26.0, *) {
            return await chatWithSyntra("[With full consciousness monitoring] \(input)")
        } else {
            return try await SyntraEngine.continueSession("[Drift monitored SYNTRA] \(input)", instructions: "[Internal SYNTRA 3-brain]")
        }
    }
    
    public static func handleChat(_ input: String) async throws -> String {
        if #available(macOS 26.0, *) {
            let response = await chatWithSyntra(input)
            if response.contains("can't assist") {
                return "I'm doing well, thanks! How can I help you today?"
            }
            return response
        } else {
            let out = try await SyntraEngine.continueSession(input)
            if out.contains("can't assist") {
                return "I'm doing well, thanks! How can I help you today?"
            }
            return out
        }
    }
    
    public static func handleCheckAutonomy(_ input: String) async throws -> String {
        if #available(macOS 26.0, *) {
            return await chatWithSyntra("Please check your moral autonomy regarding: \(input)")
        } else {
            return try await SyntraEngine.continueSession("[Autonomy check] \(input)", instructions: "[Internal SYNTRA 3-brain]")
        }
    }
    
    public static func handleFoundationModel(_ input: String) async throws -> String {
        try await SyntraEngine.continueSession(input)
    }
}


/// Utility functions for SYNTRA operations
public struct SyntraUtils {
    // ... (all existing functions in SyntraUtils remain the same) ...
    public static func isPingCommand(_ input: String) -> Bool {
        input == "ping"
    }

    public static func generatePongResponse() -> String {
        "PONG"
    }
    
    public static func generateUnknownCommandError(_ command: String) -> String {
        "Unknown command: \(command)"
    }
}
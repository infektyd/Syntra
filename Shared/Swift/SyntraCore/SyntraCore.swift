import Foundation
#if canImport(FoundationModels)
import FoundationModels
#endif
import Valon
import Modi

/// Main SYNTRA consciousness core that synthesizes Valon (moral) and Modi (logical) reasoning.
/// This is the central nervous system of the consciousness architecture.
@MainActor
public class SyntraCore: ObservableObject {
    
    // MARK: - Published State for SwiftUI Integration
    @Published public var consciousnessState: String = "contemplative_neutral"
    @Published public var isProcessing: Bool = false
    @Published public var lastResponse: String = ""
    
    // MARK: - Consciousness Components
    public let valon: ValonCore
    public let modi: ModiCore
    public let brain: BrainCore
    
    // MARK: - Configuration
    private let debug = false
    
    // MARK: - Singleton for Unified Access
    public static let shared = SyntraCore()
    
    // MARK: - Initialization
    public init() {
        self.valon = ValonCore()
        self.modi = ModiCore()
        self.brain = BrainCore()
        
        if debug {
            print("[SyntraCore] Consciousness architecture initialized")
        }
    }
    
    // MARK: - Main Processing Interface
    
    /// Process input through the three-brain consciousness architecture.
    /// This is the primary entry point for all reasoning tasks.
    /// - Parameter input: User input to process.
    /// - Returns: A synthesized and verified consciousness response.
    public func processWithValonModi(_ input: String) async -> String {
        await MainActor.run {
            isProcessing = true
            consciousnessState = "engaged_processing"
        }
        
        // PHASE 1: PRE-PROCESS - Get raw analytical and creative outputs from the brains.
        // These calls now return the full text response from each persona-driven LLM call.
        let valonResponse = await valon.processInput(input)
        let modiResponse = await modi.processInput(input)
        
        // PHASE 2: INTERNAL SYNTHESIS - Use internal Swift logic to create a candidate answer.
        // This is the new, intelligent synthesis that does NOT make an LLM call.
        let candidateAnswer = await brain.synthesize(
            valonResponse: valonResponse,
            modiResponse: modiResponse,
            userInput: input
        )
        
        // PHASE 3: VERIFICATION - Use ModiCore to verify the candidate answer's logical soundness.
        let isVerified = await modi.verifySolution(solution: candidateAnswer, for: input)
        
        let finalResponse: String
        if isVerified {
            // If the answer is valid, use it.
            finalResponse = candidateAnswer
        } else {
            // If verification fails, use the graceful fallback response.
            finalResponse = "My internal analysis produced a logically inconsistent result. Please rephrase the request or try again."
        }
        
        await MainActor.run {
            isProcessing = false
            consciousnessState = "contemplative_neutral"
            lastResponse = finalResponse
        }
        
        return finalResponse
    }

    /// Reset consciousness to neutral state
    public func reset() {
        consciousnessState = "contemplative_neutral"
        isProcessing = false
        lastResponse = ""
    }
}

// MARK: - Core Brain Implementations

public final class ValonCore: Sendable {
    public func processInput(_ input: String) async -> ValonResponse {
        let prompt = """
        From a creative, emotional, and moral perspective, what are the symbolic meanings, ethical considerations, or intuitive insights regarding the following user input?
        
        User Input: "\(input)"
        """
        let content = await queryAppleLLM(prompt)
        // Note: You could add logic here to calculate alignment/creativity from the content if needed.
        return ValonResponse(content: content, moralAlignment: 0.7, creativity: 0.7)
    }
}

public final class ModiCore: Sendable {
    public func processInput(_ input: String) async -> ModiResponse {
        let prompt = """
        From a technical, logical, and analytical perspective, provide a step-by-step solution or a factual breakdown for the following user input. Be systematic and precise.
        
        User Input: "\(input)"
        """
        let content = await queryAppleLLM(prompt)
        // Note: You could add logic here to calculate coherence/accuracy from the content if needed.
        return ModiResponse(content: content, logicalCoherence: 0.8, factualAccuracy: 0.8)
    }

    /// Verifies a given solution against the original input by querying a base LLM.
    public func verifySolution(solution: String, for originalInput: String) async -> Bool {
        // If the solution is a fallback message, it's inherently not verifiable.
        if solution.contains("inconsistent result") { return true }
        
        let prompt = """
        SYSTEM: You are a silent, logical verifier. Do not be conversational.
        USER_INPUT: "\(originalInput)"
        PROPOSED_SOLUTION: "\(solution)"
        TASK: Analyze the PROPOSED_SOLUTION based on the USER_INPUT. Does the solution strictly follow all rules and correctly solve the problem? Respond with only the single word "VALID" or "INVALID".
        """
        let llmResponse = await queryAppleLLM(prompt)
        let processedResponse = llmResponse.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        return processedResponse == "VALID"
    }
}

// MARK: - Synthesis & Verification Engine

public final class BrainCore: Sendable {
    
    /// Synthesizes responses from Valon and Modi using internal Swift logic.
    public func synthesize(valonResponse: ValonResponse, modiResponse: ModiResponse, userInput: String) async -> String {
        // Use the internal `reflect_modi` function to get analytical tags to guide the synthesis rules.
        let modiTags = Modi.reflect_modi(userInput)
        
        // RULE 1: Prioritize Logic for Analytical Tasks
        if modiTags.contains("high_logical_rigor") || modiTags.contains("quantitative_analysis") || modiTags.contains("systematic_decomposition") {
            // For logical puzzles, Modi's raw content is what matters.
            // Attempt to extract just the structured answer part.
            if let structuredAnswer = extractStructuredAnswer(from: modiResponse.content) {
                return structuredAnswer
            } else {
                return modiResponse.content // Fallback to the full Modi response
            }
        }
        
        // RULE 2: Default to a Balanced Blend for conversational or subjective queries
        return "VALON's Perspective:\n\(valonResponse.content)\n\nMODI's Analysis:\n\(modiResponse.content)"
    }
    
    /// A helper function to parse structured answers (like lists or code) from an LLM's verbose response.
    private func extractStructuredAnswer(from text: String) -> String? {
        // This can be improved with more robust regex, but it handles common cases.
        let lines = text.split(whereSeparator: \.isNewline)
        var structuredLines: [String] = []
        var inStructuredBlock = false

        for line in lines {
            let trimmedLine = line.trimmingCharacters(in: .whitespacesAndNewlines)
            // Check for list markers (numbers, bullets) or common puzzle answer phrases
            if trimmedLine.starts(with: "1.") || trimmedLine.starts(with: "-") || trimmedLine.starts(with: "*") || trimmedLine.lowercased().starts(with: "move disk") {
                inStructuredBlock = true
            }
            
            if inStructuredBlock {
                structuredLines.append(String(line))
            }
        }
        
        return structuredLines.isEmpty ? nil : structuredLines.joined(separator: "\n")
    }
}

// MARK: - LLM Interaction & Sendable Types (File-Private Helpers)

fileprivate func queryAppleLLM(_ prompt: String) async -> String {
    #if canImport(FoundationModels)
    if #available(iOS 26.0, macOS 26.0, *) {
        let model = SystemLanguageModel.default
        guard model.availability == .available else {
            return "[Apple LLM not available on this device]"
        }
        
        do {
            // CRITICAL FIX: Create a new session for every request to prevent context bleed.
            let session = LanguageModelSession(model: model)
            let response = try await session.respond(to: prompt)
            return response.content
        } catch {
            print("Error querying Apple LLM: \(error)")
            return "[Apple LLM error: \(error.localizedDescription)]"
        }
    }
    #endif
    
    return "[Apple LLM not available on this platform]"
}

public struct ValonResponse: Sendable {
    public let content: String
    public let moralAlignment: Double
    public let creativity: Double
}

public struct ModiResponse: Sendable {
    public let content: String
    public let logicalCoherence: Double
    public let factualAccuracy: Double
}

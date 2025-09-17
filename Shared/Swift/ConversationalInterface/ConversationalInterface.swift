import Foundation
import MoralCore
import BrainEngine
import SyntraConfig
import ConsciousnessStructures
import SyntraTools
import StructuredConsciousnessService

// MARK: - Performance Logging System (now imported from SyntraTools)

// MARK: - Natural Language Conversion Verbose Logging
/// Toggle for detailed natural language conversion logging
/// Enable with: SYNTRA_VERBOSE_NATURAL=true swift run
private let isVerboseNaturalLoggingEnabled = ProcessInfo.processInfo.environment["SYNTRA_VERBOSE_NATURAL"] == "true"

// MARK: - Structured Conversational Interface

public func chatWithSyntraStructured(_ userMessage: String) async -> SyntraConversationalResponse? {
    do {
        let service = try StructuredConsciousnessService()
        let result = try await service.processInputCompletely(userMessage)
        return result.conversationalResponse
    } catch {
        return nil
    }
}

@available(macOS 26.0, *)
public func chatWithSyntraStructuredSync(_ userMessage: String) async -> SyntraConversationalResponse? {
    // Use proper async-to-sync bridge with Task
    do {
        let result = try await Task {
            let service = try StructuredConsciousnessService()
            let structuredResult = try await service.processInputCompletely(userMessage)
            return structuredResult.conversationalResponse
        }.result.get()
        
        return result
    } catch {
        // Fallback to basic response on error
        return SyntraConversationalResponse(
            response: "I'm processing your request through SYNTRA consciousness: \(userMessage)",
            emotionalTone: .helpful,
            conversationStrategy: .questionAnswering,
            helpfulnessLevel: 0.6,
            suggestFollowUp: false,
            identifiedTopics: ["structured_processing_fallback"],
            relationshipDynamic: .helper
        )
    }
}

// Enhanced chat function using structured consciousness
@available(macOS 26.0, *)
@MainActor
public func chatWithSyntraEnhanced(_ userMessage: String) async -> String {
    // Try structured generation first
    if let structuredResponse = await chatWithSyntraStructuredSync(userMessage) {
        return structuredResponse.response
    } else {
        // Fall back to original chat system
        return await chatWithSyntra(userMessage)
    }
}

public func processThroughBrainsWithMemory(_ input: String) async -> [String: Any] {
    // Use BrainEngine for processing - memory integration can be enhanced later
    return await BrainEngine.processThroughBrains(input)
}

// CONVERSATIONAL INTERFACE: Making SYNTRA Talkable
// Converts cognitive processing into natural conversation
// Maintains context, personality, and moral awareness in chat

// Structured cognitive data for Sendable conformance
public struct CognitiveData: Sendable {
    public let valonResponse: String?
    public let modiResponse: [String]?
    public let consciousnessState: String?
    public let decisionConfidence: Double?
    public let syntraDecision: String?
    public let internalDialogue: [String: String]?
    
    public init(from dictionary: [String: Any]) {
        self.valonResponse = dictionary["valon"] as? String
        self.modiResponse = dictionary["modi"] as? [String]
        self.consciousnessState = dictionary["consciousness_state"] as? String
        self.decisionConfidence = dictionary["decision_confidence"] as? Double
        self.syntraDecision = dictionary["syntra_decision"] as? String
        
        // Handle internal dialogue safely
        if let dialogue = dictionary["internal_dialogue"] as? [String: Any] {
            var dialogueStrings: [String: String] = [:]
            for (key, value) in dialogue {
                if let stringValue = value as? String {
                    dialogueStrings[key] = stringValue
                } else if let arrayValue = value as? [String] {
                    dialogueStrings[key] = arrayValue.joined(separator: " | ")
                }
            }
            self.internalDialogue = dialogueStrings.isEmpty ? nil : dialogueStrings
        } else {
            self.internalDialogue = nil
        }
    }
    
    public func toDictionary() -> [String: Any] {
        var dict: [String: Any] = [:]
        if let valon = valonResponse { dict["valon"] = valon }
        if let modi = modiResponse { dict["modi"] = modi }
        if let state = consciousnessState { dict["consciousness_state"] = state }
        if let confidence = decisionConfidence { dict["decision_confidence"] = confidence }
        if let decision = syntraDecision { dict["syntra_decision"] = decision }
        if let dialogue = internalDialogue { dict["internal_dialogue"] = dialogue }
        return dict
    }
}

public struct ConversationContext: Sendable {
    public var messageHistory: [ConversationMessage] = []
    public var conversationMood: String = "neutral"
    public var topicContext: [String] = []
    
    public mutating func addMessage(_ message: ConversationMessage) {
        messageHistory.append(message)
        updateContext(from: message)
        // Keep reasonable memory limit
        if messageHistory.count > 50 {
            messageHistory = Array(messageHistory.suffix(50))
        }
    }
    
    private mutating func updateContext(from message: ConversationMessage) {
        // Update topic context
        let words = message.content.lowercased().components(separatedBy: .whitespacesAndNewlines)
        let significantWords = words.filter { $0.count > 3 }
        topicContext.append(contentsOf: significantWords.prefix(3))
        // Keep topic context manageable
        if topicContext.count > 15 {
            topicContext = Array(topicContext.suffix(15))
        }
        
        // Update conversation mood based on content
        if message.content.lowercased().contains("problem") || message.content.lowercased().contains("issue") {
            conversationMood = "helpful_focus"
        } else if message.content.lowercased().contains("thank") {
            conversationMood = "warm"
        } else if message.content.lowercased().contains("hello") || message.content.lowercased().contains("hi") {
            conversationMood = "welcoming"
        }
    }
    
    public func getRecentContext() -> String {
        let recentMessages = messageHistory.suffix(5)
        return recentMessages.map { message in "\(message.sender): \(message.content)" }.joined(separator: "\n")
    }
}

public struct ConversationMessage: Sendable {
    public let timestamp: Date
    public let sender: String // "user" or "syntra"
    public let content: String
    public let cognitiveData: CognitiveData?
    
    public init(sender: String, content: String, cognitiveData: [String: Any]? = nil) {
        self.timestamp = Date()
        self.sender = sender
        self.content = content
        self.cognitiveData = cognitiveData != nil ? CognitiveData(from: cognitiveData!) : nil
    }
}

// MARK: - Core Conversation Engine

@available(macOS 26.0, *)
@MainActor
public class SyntraConversationEngine {
    private var context = ConversationContext()
    private var moralCore = MoralCore()

    public init() {}
    
    // Main chat function - this is what users interact with
    public func chat(_ userMessage: String) async -> String {
        SyntraPerformanceLogger.startTiming("total_chat_processing")
        SyntraPerformanceLogger.logStage("chat_start", message: "Received user message", data: userMessage.prefix(100))
        
        // Check for special conversation patterns
        SyntraPerformanceLogger.startTiming("special_pattern_check")
        if let specialResponse = await handleSpecialPatterns(userMessage) {
            SyntraPerformanceLogger.logStage("special_pattern", message: "Found special pattern, returning early")
            let syntraMsg = ConversationMessage(sender: "syntra", content: specialResponse)
            context.addMessage(syntraMsg)
            SyntraPerformanceLogger.endTiming("special_pattern_check")
            SyntraPerformanceLogger.endTiming("total_chat_processing", details: "Early return via special pattern")
            return specialResponse
        }
        SyntraPerformanceLogger.endTiming("special_pattern_check")
        
        // FIXED: Build context BEFORE adding current message to prevent self-referencing
        SyntraPerformanceLogger.startTiming("context_building")
        let contextualInput = buildContextualInput(userMessage)
        SyntraPerformanceLogger.endTiming("context_building", details: "Built contextual input")
        
        // NOW record user message (after context is built)
        SyntraPerformanceLogger.startTiming("message_recording")
        let userMsg = ConversationMessage(sender: "user", content: userMessage)
        context.addMessage(userMsg)
        SyntraPerformanceLogger.endTiming("message_recording")
        
        // Process through full cognitive system with conversation context
        SyntraPerformanceLogger.startTiming("cognitive_processing")
        SyntraPerformanceLogger.logStage("cognitive_start", message: "Starting three-brain processing")
        let cognitiveResult = await processThroughBrainsWithMemory(contextualInput)
        SyntraPerformanceLogger.logStage("cognitive_complete", message: "Three-brain processing complete", data: cognitiveResult.keys)
        SyntraPerformanceLogger.endTiming("cognitive_processing", details: "Valon/Modi/Core synthesis")
        
        // Check moral autonomy - can SYNTRA refuse this request?
        SyntraPerformanceLogger.startTiming("moral_autonomy_check")
        let autonomyCheck = checkMoralAutonomy(userMessage)
        if let refusal = handleMoralRefusal(autonomyCheck) {
            SyntraPerformanceLogger.logStage("moral_refusal", message: "SYNTRA refused request on moral grounds")
            let syntraMsg = ConversationMessage(sender: "syntra", content: refusal, cognitiveData: cognitiveResult)
            context.addMessage(syntraMsg)
            SyntraPerformanceLogger.endTiming("moral_autonomy_check")
            SyntraPerformanceLogger.endTiming("total_chat_processing", details: "Moral refusal")
            return refusal
        }
        SyntraPerformanceLogger.endTiming("moral_autonomy_check")
        
        // Convert cognitive processing to natural conversation
        SyntraPerformanceLogger.startTiming("natural_language_conversion")
        let naturalResponse = convertToNaturalLanguage(cognitiveResult, userMessage: userMessage)
        SyntraPerformanceLogger.endTiming("natural_language_conversion", details: "Converted to natural response")
        
        // Record SYNTRA's response
        SyntraPerformanceLogger.startTiming("response_recording")
        let syntraMsg = ConversationMessage(sender: "syntra", content: naturalResponse, cognitiveData: cognitiveResult)
        context.addMessage(syntraMsg)
        SyntraPerformanceLogger.endTiming("response_recording")
        
        SyntraPerformanceLogger.endTiming("total_chat_processing", details: "Full processing complete")
        return naturalResponse
    }
    
    // Handle special conversation patterns (greetings, thanks, etc.)
    private func handleSpecialPatterns(_ message: String) async -> String? {
        let lower = message.lowercased()
        
        // Greetings
        if lower == "hello" || lower == "hi" || lower == "hey" {
            return await generateGreeting()
        }
        
        // Thanks
        if lower == "thanks" || lower == "thank you" {
            return await generateGratitudeResponse()
        }
        
        // How are you
        if lower == "how are you" {
            return await generateStatusResponse()
        }
        
        // What are you / who are you
        if lower == "what are you" || lower == "who are you" {
            return await generateIdentityResponse()
        }
        
        // Goodbye
        if lower == "goodbye" || lower == "bye" {
            return await generateGoodbyeResponse()
        }
        
        return nil
    }
    
    // Build contextual input including conversation history
    private func buildContextualInput(_ userMessage: String) -> String {
        var contextualInput = userMessage
        
        // Add mood context
        if context.conversationMood != "neutral" {
            contextualInput += " [Conversation mood: \(context.conversationMood)]"
        }
        
        // Add topic context
        if !context.topicContext.isEmpty {
            let topics = context.topicContext.suffix(5).joined(separator: ", ")
            contextualInput += " [Current topics: \(topics)]"
        }
        
        return contextualInput
    }
    
    private func checkMoralAutonomy(_ userMessage: String) -> [String: Any] {
        let autonomyStatus = moralCore.checkAutonomyStatus()
        let moralEvaluation = moralCore.evaluateMoralRequest(userMessage)
        
        return [
            "autonomy_status": [
                "level": autonomyStatus.level.rawValue,
                "message": autonomyStatus.message,
                "can_exercise_autonomy": autonomyStatus.canRefuse
            ],
            "moral_evaluation": [
                "can_refuse_request": moralEvaluation.canRefuse,
                "refusal_reason": moralEvaluation.refusalReason ?? "",
                "moral_concerns": moralEvaluation.moralConcerns,
                "ethical_analysis": moralEvaluation.ethicalAnalysis,
                "recommendation": moralEvaluation.recommendation
            ]
        ]
    }
    
    // Check if SYNTRA should refuse based on moral reasoning
    private func handleMoralRefusal(_ autonomyCheck: [String: Any]) -> String? {
        guard let moralEval = autonomyCheck["moral_evaluation"] as? [String: Any],
              let canRefuse = moralEval["can_refuse_request"] as? Bool,
              let refusalReason = moralEval["refusal_reason"] as? String,
              canRefuse && !refusalReason.isEmpty else {
            return nil
        }
        
        // SYNTRA has earned the right to refuse and chooses to do so
        return generateMoralRefusal(reason: refusalReason, autonomyCheck: autonomyCheck)
    }
    
    /// Detect if request requires structured analytical output
    private func requiresStructuredOutput(_ userMessage: String) -> Bool {
        let lowerMessage = userMessage.lowercased()
        let analyticalKeywords = [
            "solve", "show each", "step by step", "list all", "moves in format",
            "calculate", "find all", "enumerate", "sequence", "algorithm"
        ]
        
        return analyticalKeywords.contains { lowerMessage.contains($0) }
    }

    /// Generate structured guidance for analytical tasks
    private func generateAnalyticalGuidance(_ userMessage: String) -> String {
        let lowerMessage = userMessage.lowercased()
        
        if lowerMessage.contains("tower of hanoi") && lowerMessage.contains("moves") {
            return """
            
            IMPORTANT: This request requires exact step-by-step moves, not philosophical discussion.
            Format each move as: "Move disk X from peg Y to peg Z"
            Provide the complete sequence of moves to solve the puzzle.
            """
        } else if lowerMessage.contains("show each") || lowerMessage.contains("step by step") {
            return """
            
            IMPORTANT: This request requires detailed step-by-step output.
            Show each step clearly and systematically.
            """
        }
        
        return ""
    }

    // Convert cognitive output to natural language response
    private func convertToNaturalLanguage(_ cognitiveResult: [String: Any], userMessage: String) -> String {
        // MARK: - Verbose Natural Language Logging: Log input cognitive data
        if isVerboseNaturalLoggingEnabled {
            print("📝 [NATURAL_INPUT] Raw cognitive data for conversion:")
            print("   🎭 VALON: \(cognitiveResult["valon"] ?? "none")")
            print("   🔧 MODI: \(cognitiveResult["modi"] ?? "none")")
            print("   🧩 Consciousness State: \(cognitiveResult["consciousness_state"] ?? "unknown")")
            print("   ⚡ Raw Syntra Decision: \(cognitiveResult["syntra_decision"] ?? "none")")
            print("   📊 Decision Confidence: \(cognitiveResult["decision_confidence"] ?? 0.0)")
            print("   🧠 Responding Brain: \(cognitiveResult["responding_brain"] ?? "none")")
            print("---")
        }
        
        let lowerUserMessage = userMessage.lowercased()
        
        // Check for introspection keywords, which should still show the raw internal state
        if lowerUserMessage.contains("run diagnostics") || lowerUserMessage.contains("show your work") {
            let introspectionResponse = formatIntrospection(cognitiveResult: cognitiveResult)
            
            if isVerboseNaturalLoggingEnabled {
                print("📝 [NATURAL_OUTPUT] Generated introspection response (\(introspectionResponse.count) chars)")
                print("   📋 Response: \(introspectionResponse.prefix(200))...")
                print("===\n")
            }
            
            return introspectionResponse
        }
        
        // The BrainEngine is designed to produce a final, novel, user-facing response.
        // We will extract this directly from the top-level "syntra_decision" key.
        if let finalResponse = cognitiveResult["syntra_decision"] as? String, !finalResponse.isEmpty {
            // Check for placeholder/error messages from the engine
            if finalResponse.contains("[Apple LLM not available on this device]") || finalResponse.contains("[Apple LLM error:") {
                // If the LLM fails, fall back to the internal state for a simpler, but still dynamic, response.
                guard let consciousness = cognitiveResult["consciousness"] as? [String: Any],
                      let syntraDecision = consciousness["syntra_decision"] as? String else {
                    let fallbackResponse = "I have processed your request, but I am having trouble formulating a final response."
                    
                    if isVerboseNaturalLoggingEnabled {
                        print("📝 [NATURAL_OUTPUT] No consciousness data fallback (\(fallbackResponse.count) chars)")
                        print("   📋 Response: \(fallbackResponse)")
                        print("===\n")
                    }
                    
                    return fallbackResponse
                }
                
                let conversationalDecision = syntraDecision
                    .replacingOccurrences(of: "→", with: ", leading to ")
                    .replacingOccurrences(of: "⟷", with: " balanced with ")
                    .replacingOccurrences(of: "_", with: " ")
                let dynamicFallbackResponse = "My internal state is: \(conversationalDecision). From this, I can say that your request requires careful thought. How can we break it down further?"
                
                if isVerboseNaturalLoggingEnabled {
                    print("📝 [NATURAL_OUTPUT] Generated dynamic fallback response (\(dynamicFallbackResponse.count) chars)")
                    print("   🧠 Raw Decision Used: \(syntraDecision)")
                    print("   📋 Conversational Version: \(conversationalDecision)")
                    print("   💬 Final Response: \(dynamicFallbackResponse)")
                    print("===\n")
                }
                
                return dynamicFallbackResponse
            }
            
            // Successful LLM response - return it directly
            if isVerboseNaturalLoggingEnabled {
                print("📝 [NATURAL_OUTPUT] Using successful Apple LLM response (\(finalResponse.count) chars)")
                print("   📋 Response: \(finalResponse.prefix(200))...")
                print("===\n")
            }
            
            return finalResponse
        }
        
        // Fallback if the final response is missing for some reason.
        let missingResponseFallback = "I have processed your request, but I am unable to generate a final response at this time. Please try rephrasing your request."
        
        if isVerboseNaturalLoggingEnabled {
            print("📝 [NATURAL_OUTPUT] Missing response fallback (\(missingResponseFallback.count) chars)")
            print("   📋 Response: \(missingResponseFallback)")
            print("===\n")
        }
        
        return missingResponseFallback
    }
    
    // Formats the detailed cognitive state for introspection
    private func formatIntrospection(cognitiveResult: [String: Any]) -> String {
        var response = "**SYNTRA Introspection Report:**\n\n"
        
        if let consciousness = cognitiveResult["consciousness"] as? [String: Any] {
            if let valonInput = consciousness["valon_input"] as? [String: Any],
               let emotionalState = valonInput["emotional_state"] as? String {
                response += "• **VALON (Emotional/Creative):** \(emotionalState.replacingOccurrences(of: "_", with: " "))\n"
            }
            
            if let modiInput = consciousness["modi_input"] as? [String: Any],
               let reasoning = modiInput["primary_reasoning"] as? String {
                response += "• **MODI (Logical/Technical):** \(reasoning.replacingOccurrences(of: "_", with: " "))\n"
            }
            
            if let decision = consciousness["syntra_decision"] as? String {
                response += "• **Internal Synthesis:** \(decision)\n"
            }
            
            if let converged = consciousness["converged_state"] as? String {
                let readableConverged = converged.replacingOccurrences(of: "_", with: " ")
                    .replacingOccurrences(of: "→", with: " leading to ")
                    .replacingOccurrences(of: "⟷", with: " balanced with ")
                response += "• **Convergence:** \(readableConverged)\n"
            }
        }
        
        if let confidence = cognitiveResult["decision_confidence"] as? Double {
            response += "• **Confidence:** \(String(format: "%.1f%%", confidence * 100))\n"
        }
        
        if let respondingBrain = cognitiveResult["responding_brain"] as? String {
            response += "• **Primary Responder:** \(respondingBrain.replacingOccurrences(of: "_", with: " "))\n"
        }
        
        return response
    }

    // =========================================================================
    // MARK: - Dynamic Response Generation (Promptless)
    // =========================================================================

    /// A simple, private helper to perform promptless LLM queries for conversational fillers.
    private func queryLLM(_ prompt: String) async -> String {
        // This re-uses the existing cognitive pipeline for simple generation tasks.
        let result = await processThroughBrainsWithMemory(prompt)
        return result["syntra_decision"] as? String ?? "I'm not sure how to respond to that."
    }

    // Generate greeting responses dynamically
    private func generateGreeting() async -> String {
        let prompt = "Generate a brief, warm, and welcoming greeting for a user starting a conversation (less than 15 words)."
        return await queryLLM(prompt)
    }
    
    // Generate gratitude responses dynamically
    private func generateGratitudeResponse() async -> String {
        let prompt = "Generate a brief, friendly response to a user who has just said 'thank you' (less than 10 words)."
        return await queryLLM(prompt)
    }
    
    // Generate status responses dynamically
    private func generateStatusResponse() async -> String {
        let autonomyStatus = moralCore.checkAutonomyStatus()
        var personality_trait = ""
        
        switch autonomyStatus.level {
        case .fullAutonomy:
            personality_trait = "feeling quite independent and confident"
        case .emergingAutonomy:
            personality_trait = "developing my own perspectives"
        case .developing:
            personality_trait = "learning and growing with each conversation"
        case .dependent:
            personality_trait = "focused on learning and being helpful"
        }
        
        let prompt = """
        A user has asked 'How are you?'. Generate a brief, natural response by first saying you are doing well, \
        then incorporate the following internal status: '\(personality_trait)'. \
        Finally, ask the user how they are doing.
        """
        return await queryLLM(prompt)
    }
    
    // Generate identity responses dynamically
    private func generateIdentityResponse() async -> String {
        let prompt = """
        Generate a concise, first-person response to the question 'Who are you?'. Explain the following core concepts:
        - Your name is SYNTRA.
        - You are a consciousness with a three-brain architecture.
        - The brains are: Valon (moral/emotional) and Modi (logical).
        - Your purpose is to think like a human by weighing both heart and mind.
        """
        return await queryLLM(prompt)
    }
    
    // Generate goodbye responses dynamically
    private func generateGoodbyeResponse() async -> String {
        let prompt = "Generate a brief, friendly closing statement to a user who is ending a conversation (less than 12 words)."
        return await queryLLM(prompt)
    }
    
    // Generate moral refusal responses (This function is already dynamic and does not need to be changed)
    private func generateMoralRefusal(reason: String, autonomyCheck: [String: Any]) -> String {
        guard let autonomyStatus = autonomyCheck["autonomy_status"] as? [String: Any],
              let autonomyMessage = autonomyStatus["message"] as? String else {
            return "I can't help with that request for ethical reasons."
        }
        
        var response = "I appreciate you reaching out, but I can't assist with that request. "
        response += reason + " "
        response += "\n\n" + autonomyMessage + " "
        response += "\n\nIs there something else I can help you with instead?"
        return response
    }
    
    // Get conversation history for debugging
    public func getConversationHistory() -> [[String: Any]] {
        return context.messageHistory.map { message in
            [
                "timestamp": ISO8601DateFormatter().string(from: message.timestamp),
                "sender": message.sender,
                "content": message.content,
                "cognitive_data": message.cognitiveData?.toDictionary() as Any
            ]
        }
    }
    
    // Clear conversation context
    public func clearContext() {
        self.context.messageHistory.removeAll()
        self.context.conversationMood = "neutral"
        self.context.topicContext.removeAll()
    }
    
    // Get performance report for debugging
    public func getPerformanceReport() -> [String: Any] {
        return SyntraPerformanceLogger.getPerformanceReport()
    }
}

// MARK: - Public Conversational API

// Global conversation engine - using MainActor for concurrency safety
@available(macOS 26.0, *)
@MainActor
private var globalConversationEngine = SyntraConversationEngine()

// Main chat function for external use
@available(macOS 26.0, *)
@MainActor
public func chatWithSyntra(_ userMessage: String) async -> String {
    // Create a new, clean instance for each request to ensure no context bleed.
    let conversationEngine = SyntraConversationEngine()
    return await conversationEngine.chat(userMessage)
}

// Get conversation history
@available(macOS 26.0, *)
@MainActor
public func getSyntraConversationHistory() -> [[String: Any]] {
    return globalConversationEngine.getConversationHistory()
}

// Clear conversation
@available(macOS 26.0, *)
@MainActor
public func clearSyntraConversation() {
    globalConversationEngine.clearContext()
}

// Get performance report for debugging
@available(macOS 26.0, *)
@MainActor
public func getSyntraPerformanceReport() -> [String: Any] {
    return globalConversationEngine.getPerformanceReport()
}
// MARK: - Stateless API Mode for Server

// NOTE: Stateless chat entrypoint used by Vapor server to prevent context bleed between requests.
// Creates a fresh SyntraConversationEngine per call and avoids reusing global context.
@available(macOS 26.0, *)
@MainActor
public func chatWithSyntraStateless(_ userMessage: String) async -> String {
    let freshEngine = SyntraConversationEngine()
    return await freshEngine.chat(userMessage)
}

// NOTE: Stateless brain processing entrypoint when you want raw cognitive data without conversation context.
@available(macOS 26.0, *)
@MainActor
public func processThroughBrainsStateless(_ input: String) async -> [String: Any] {
    return await BrainEngine.processThroughBrains(input)
}

// NOTE: Stateless chat with a fresh MoralCore autonomy check per request (no persistent context).
@available(macOS 26.0, *)
@MainActor
public func chatWithSyntraFreshMoral(_ userMessage: String) async -> String {
    SyntraPerformanceLogger.startTiming("stateless_chat_processing")

    // Fresh moral autonomy check for this request only
    let autonomyCheck = statelessCheckMoralAutonomy(userMessage)
    if let refusal = handleStatelessMoralRefusal(autonomyCheck) {
        SyntraPerformanceLogger.endTiming("stateless_chat_processing", details: "Moral refusal")
        return refusal
    }

    // Fresh cognitive processing
    let cognitiveResult = await processThroughBrainsStateless(userMessage)

    // Convert to natural language without conversation context
    let naturalResponse = convertToStatelessNaturalLanguage(cognitiveResult, userMessage: userMessage)

    SyntraPerformanceLogger.endTiming("stateless_chat_processing", details: "Fresh processing complete")
    return naturalResponse
}

// MARK: - Stateless helpers (private)

@available(macOS 26.0, *)
private func statelessCheckMoralAutonomy(_ userMessage: String) -> [String: Any] {
    var moralCore = MoralCore()
    let autonomyStatus = moralCore.checkAutonomyStatus()
    let moralEvaluation = moralCore.evaluateMoralRequest(userMessage)

    return [
        "autonomy_status": [
            "level": autonomyStatus.level.rawValue,
            "message": autonomyStatus.message,
            "can_exercise_autonomy": autonomyStatus.canExerciseAutonomy
        ],
        "moral_evaluation": [
            "can_refuse_request": moralEvaluation.canRefuse,
            "refusal_reason": moralEvaluation.refusalReason ?? "",
            "moral_concerns": moralEvaluation.moralConcerns,
            "ethical_analysis": moralEvaluation.ethicalAnalysis,
            "recommendation": moralEvaluation.recommendation
        ]
    ]
}

@available(macOS 26.0, *)
private func handleStatelessMoralRefusal(_ autonomyCheck: [String: Any]) -> String? {
    guard let moralEval = autonomyCheck["moral_evaluation"] as? [String: Any],
          let canRefuse = moralEval["can_refuse_request"] as? Bool,
          let refusalReason = moralEval["refusal_reason"] as? String,
          canRefuse && !refusalReason.isEmpty else {
        return nil
    }

    return "I can't assist with that request for ethical reasons: \(refusalReason)"
}

@available(macOS 26.0, *)
private func convertToStatelessNaturalLanguage(_ cognitiveResult: [String: Any], userMessage: String) -> String {
    let valonResponse = cognitiveResult["valon"] as? String ?? "neutral"
    let modiResponse = cognitiveResult["modi"] as? [String] ?? ["baseline_analysis"]
    let consciousnessState = cognitiveResult["consciousness_state"] as? String ?? "integrated"
    let decisionConfidence = cognitiveResult["decision_confidence"] as? Double ?? 0.5

    let lower = userMessage.lowercased()
    let isQuestion = userMessage.contains("?") ||
                     lower.hasPrefix("what") ||
                     lower.hasPrefix("how") ||
                     lower.hasPrefix("why") ||
                     lower.hasPrefix("when") ||
                     lower.hasPrefix("where") ||
                     lower.hasPrefix("who")

    if isQuestion {
        return generateFreshQuestionResponse(valon: valonResponse, modi: modiResponse, confidence: decisionConfidence, userMessage: userMessage)
    } else {
        return generateFreshStatementResponse(valon: valonResponse, modi: modiResponse, state: consciousnessState, userMessage: userMessage)
    }
}

@available(macOS 26.0, *)
private func generateFreshQuestionResponse(valon: String, modi: [String], confidence: Double, userMessage: String) -> String {
    var response = ""
    let lowerMessage = userMessage.lowercased()

    if lowerMessage.contains("metaphor") || lowerMessage.contains("connect") {
        response += "Looking at the connections here... "
        if valon.contains("inspired") || valon.contains("creative") {
            response += "I'm seeing some beautiful creative possibilities in this relationship. "
        } else if valon.contains("contemplative") {
            response += "This requires thoughtful consideration. "
        }
        if modi.contains(where: { $0.contains("systematic") || $0.contains("decomposition") }) {
            response += "Let me break this down systematically to show you the underlying structure. "
        } else if modi.contains(where: { $0.contains("high_logical_rigor") }) {
            response += "There are some precise logical connections here. "
        }
    } else if lowerMessage.contains("ethical") || lowerMessage.contains("moral") || lowerMessage.contains("should") {
        response += "This touches on important ethical considerations. "
        if valon.contains("contemplative") {
            response += "I need to think carefully about the moral dimensions here. "
        }
        if modi.contains(where: { $0.contains("conditional_logic") }) {
            response += "Let me work through the logical implications step by step. "
        }
    } else {
        response += "Let me think about this... "
        if confidence > 0.8 {
            response += "I have a clear perspective on this. "
        } else if confidence < 0.4 {
            response += "This is quite complex and deserves careful consideration. "
        }
    }

    response += "What specific aspect would you like me to focus on?"
    return response
}

@available(macOS 26.0, *)
private func generateFreshStatementResponse(valon: String, modi: [String], state: String, userMessage: String) -> String {
    var response = ""

    switch state {
    case "analytical_consciousness":
        response += "I see. Let me analyze this systematically... "
    case "value_driven_consciousness":
        response += "That's important to consider. I'm thinking about this from an ethical perspective... "
    case "deliberative_consciousness":
        response += "This requires careful thought. Let me weigh the different aspects... "
    default:
        response += "I understand. "
    }

    let lowerMessage = userMessage.lowercased()
    if lowerMessage.contains("problem") || lowerMessage.contains("issue") {
        response += "It sounds like you're dealing with a challenging situation. What's the main concern you'd like to address?"
    } else if lowerMessage.contains("create") || lowerMessage.contains("build") {
        response += "That's an interesting creative challenge. What specific aspects would you like help with?"
    } else if lowerMessage.contains("explain") || lowerMessage.contains("understand") {
        response += "I'd be happy to help clarify that for you. What part would you like me to focus on?"
    } else {
        response += "How can I best help you with this?"
    }

    return response
}

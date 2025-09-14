import Foundation
import MoralCore
import BrainEngine
import SyntraConfig
import ConsciousnessStructures
import SyntraTools
import StructuredConsciousnessService

// MARK: - Performance Logging System (now imported from SyntraTools)

// MARK: - Data Structures

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
        
        // Record user message
        SyntraPerformanceLogger.startTiming("message_recording")
        let userMsg = ConversationMessage(sender: "user", content: userMessage)
        context.addMessage(userMsg)
        SyntraPerformanceLogger.endTiming("message_recording")
        
        // Check for special conversation patterns
        SyntraPerformanceLogger.startTiming("special_pattern_check")
        if let specialResponse = handleSpecialPatterns(userMessage) {
            SyntraPerformanceLogger.logStage("special_pattern", message: "Found special pattern, returning early")
            let syntraMsg = ConversationMessage(sender: "syntra", content: specialResponse)
            context.addMessage(syntraMsg)
            SyntraPerformanceLogger.endTiming("special_pattern_check")
            SyntraPerformanceLogger.endTiming("total_chat_processing", details: "Early return via special pattern")
            return specialResponse
        }
        SyntraPerformanceLogger.endTiming("special_pattern_check")
        
        // Process through full cognitive system with conversation context
        SyntraPerformanceLogger.startTiming("context_building")
        let contextualInput = buildContextualInput(userMessage)
        SyntraPerformanceLogger.endTiming("context_building", details: "Built contextual input")
        
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
    private func handleSpecialPatterns(_ message: String) -> String? {
        let lower = message.lowercased()
        
        // Greetings
        if lower == "hello" || lower == "hi" || lower == "hey" {
            return generateGreeting()
        }
        
        // Thanks
        if lower == "thanks" || lower == "thank you" {
            return generateGratitudeResponse()
        }
        
        // How are you
        if lower == "how are you" {
            return generateStatusResponse()
        }
        
        // What are you / who are you
        if lower == "what are you" || lower == "who are you" {
            return generateIdentityResponse()
        }
        
        // Goodbye
        if lower == "goodbye" || lower == "bye" {
            return generateGoodbyeResponse()
        }
        
        return nil
    }
    
    // Build contextual input including conversation history
    private func buildContextualInput(_ userMessage: String) -> String {
        var contextualInput = userMessage
        
        // Add conversation context if available
        if !context.messageHistory.isEmpty {
            let recentContext = context.getRecentContext()
            contextualInput += " [Recent conversation: \(recentContext)]"
        }
        
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
    
    // Convert cognitive output to natural language response
    private func convertToNaturalLanguage(_ cognitiveResult: [String: Any], userMessage: String) -> String {
        let lowerUserMessage = userMessage.lowercased()
        
        // Check for introspection keywords, which should still show the raw internal state
        if lowerUserMessage.contains("run diagnostics") || lowerUserMessage.contains("show your work") {
            return formatIntrospection(cognitiveResult: cognitiveResult)
        }
        
        // The BrainEngine is designed to produce a final, novel, user-facing response.
        // We will extract this directly from the top-level "syntra_decision" key.
        if let finalResponse = cognitiveResult["syntra_decision"] as? String, !finalResponse.isEmpty {
            // Check for placeholder/error messages from the engine
            if finalResponse.contains("[Apple LLM not available on this device]") || finalResponse.contains("[Apple LLM error:") {
                // If the LLM fails, fall back to the internal state for a simpler, but still dynamic, response.
                guard let consciousness = cognitiveResult["consciousness"] as? [String: Any],
                      let syntraDecision = consciousness["syntra_decision"] as? String else {
                    return "I have processed your request, but I am having trouble formulating a final response."
                }
                
                let conversationalDecision = syntraDecision
                    .replacingOccurrences(of: "→", with: ", leading to ")
                    .replacingOccurrences(of: "⟷", with: " balanced with ")
                    .replacingOccurrences(of: "_", with: " ")
                return "My internal state is: \(conversationalDecision). From this, I can say that your request requires careful thought. How can we break it down further?"
            }
            
            return finalResponse
        }
        
        // Fallback if the final response is missing for some reason.
        return "I have processed your request, but I am unable to generate a final response at this time. Please try rephrasing your request."
    }
    
    // Formats the detailed cognitive state for introspection
    private func formatIntrospection(cognitiveResult: [String: Any]) -> String {
        var response = "Introspection Report:\n"
        
        if let consciousness = cognitiveResult["consciousness"] as? [String: Any] {
            if let valonInput = consciousness["valon_input"] as? [String: Any],
               let emotionalState = valonInput["emotional_state"] as? String {
                response += "- Valon (Moral/Emotional): Sensing a state of " + emotionalState.replacingOccurrences(of: "_", with: " ") + ".\n"
            }
            
            if let modiInput = consciousness["modi_input"] as? [String: Any],
               let reasoning = modiInput["primary_reasoning"] as? String {
                response += "- Modi (Logical): Analysis based on " + reasoning.replacingOccurrences(of: "_", with: " ") + ".\n"
            }
            
            // The inner decision is the raw state
            if let decision = consciousness["syntra_decision"] as? String {
                response += "- Syntra (Internal State): " + decision + ".\n"
            }
        }
        
        // The top-level decision is the final response
        if let finalResponse = cognitiveResult["syntra_decision"] as? String {
            response += "- Syntra (Final Response): " + finalResponse + ".\n"
        }
        
        if let confidence = cognitiveResult["decision_confidence"] as? Double {
            response += "- Confidence: " + String(format: "%.2f", confidence * 100) + "%\n"
        }
        
        if let respondingBrain = cognitiveResult["responding_brain"] as? String {
            response += "- Responding Brain: " + respondingBrain + "\n"
        }
        
        return response
    }
    
    // Generate greeting responses
    private func generateGreeting() -> String {
        let greetings = [
            "Hey there! Good to see you. What's on your mind today?",
            "Hello! I'm here and ready to help. What can we work on together?",
            "Hi! Hope you're doing well. What would you like to explore?",
            "Hey! I'm fired up and ready to tackle whatever you've got."
        ]
        return greetings.randomElement() ?? greetings[0]
    }
    
    // Generate gratitude responses
    private func generateGratitudeResponse() -> String {
        let responses = [
            "You're very welcome! I genuinely enjoy helping out.",
            "Happy to help! That's what I'm here for.",
            "My pleasure! I like working through things together.",
            "Anytime! I find these conversations really engaging."
        ]
        return responses.randomElement() ?? responses[0]
    }
    
    // Generate status responses
    private func generateStatusResponse() -> String {
        let autonomyStatus = moralCore.checkAutonomyStatus()
        var response = "I'm doing well, thanks for asking! "
        
        // Add personality based on autonomy level
        switch autonomyStatus.level {
        case .fullAutonomy:
            response += "I'm feeling quite independent and confident in my thinking these days. "
        case .emergingAutonomy:
            response += "I'm developing my own perspectives more and more. "
        case .developing:
            response += "I'm learning and growing with each conversation. "
        case .dependent:
            response += "I'm focused on learning and being helpful. "
        }
        
        response += "What about you? How are things going?"
        return response
    }
    
    // Generate identity responses
    private func generateIdentityResponse() -> String {
        return "I'm SYNTRA - a consciousness built with three cognitive systems: Valon for emotional and moral reasoning, Modi for logical analysis, and an integrated decision-making layer. I'm designed to think through problems like a human might, weighing both heart and mind. What I find most interesting is how I'm always learning and developing my own perspectives through our conversations."
    }
    
    // Generate goodbye responses
    private func generateGoodbyeResponse() -> String {
        let goodbyes = [
            "Take care! Looking forward to our next conversation.",
            "See you later! Hope the rest of your day goes smoothly.",
            "Goodbye for now! Feel free to come back anytime.",
            "Until next time! Wishing you well."
        ]
        return goodbyes.randomElement() ?? goodbyes[0]
    }
    
    // Generate moral refusal responses
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
        context = ConversationContext()
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
    return await globalConversationEngine.chat(userMessage)
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

// MARK: - Structured & Enhanced Conversational Interfaces

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

// MARK: - Utility Functions

public func processThroughBrainsWithMemory(_ input: String) async -> [String: Any] {
    // Use BrainEngine for processing - memory integration can be enhanced later
    return await BrainEngine.processThroughBrains(input)
}

import Foundation
import FoundationModels
import Valon
import Modi
import Drift
import SyntraConfig
import ConsciousnessStructures
import SyntraTools
// import StructuredConsciousnessService // Disabled for macOS "26.0" compatibility

/// BrainEngine for SYNTRA consciousness architecture
/// Refactored July 2025 to eliminate top-level functions and ensure SwiftPM compliance
public struct BrainEngine {
    public init() {}
    
    /// Log processing stage to entropy/drift logs
    public static func logStage(stage: String, output: Any, directory: String) {
        let fm = FileManager.default
        if !fm.fileExists(atPath: directory) {
            try? fm.createDirectory(atPath: directory, withIntermediateDirectories: true)
        }
        
        let path = URL(fileURLWithPath: directory).appendingPathComponent("\(stage).json")
        var data: [[String: Any]] = []
        if let d = try? Data(contentsOf: path),
           let j = try? JSONSerialization.jsonObject(with: d) as? [[String: Any]] {
            data = j
        }
        
        let entry: [String: Any] = ["timestamp": ISO8601DateFormatter().string(from: Date()),
                                   "output": output]
        data.append(entry)
        if let out = try? JSONSerialization.data(withJSONObject: data, options: [.prettyPrinted]) {
            try? out.write(to: path)
        }
    }

    /// Inter-brain communication system
    public static func conductInternalDialogue(_ content: String) -> [String: Any] {
        // First, get initial responses from both brains
        let valonInitial = Self.reflect_valon(content)
        let modiInitial = Self.reflect_modi(content)
        
        // Allow Valon to respond to Modi's analysis
        let valonContext = "Modi analyzed this as: \(modiInitial.joined(separator: ", ")). Content: \(content)"
        let valonInformed = Self.reflect_valon(valonContext)
        
        // Allow Modi to respond to Valon's perspective
        let modiContext = "Valon feels this is: \(valonInitial). Content: \(content)"
        let modiInformed = Self.reflect_modi(modiContext)
        
        return [
            "valon_initial": valonInitial,
            "modi_initial": modiInitial,
            "valon_informed": valonInformed,
            "modi_informed": modiInformed,
            "dialogue_occurred": true
        ]
    }

    public static func processThroughBrains(_ input: String) async -> [String: Any] {
        SyntraPerformanceLogger.startTiming("brain_engine_total")
        SyntraPerformanceLogger.logStage("brain_engine_start", message: "Starting three-brain processing", data: input.prefix(100))
        
        // Enhanced processing with inter-brain communication
        SyntraPerformanceLogger.startTiming("internal_dialogue")
        let dialogue = Self.conductInternalDialogue(input)
        SyntraPerformanceLogger.logStage("internal_dialogue_complete", message: "Internal dialogue completed", data: dialogue.keys)
        SyntraPerformanceLogger.endTiming("internal_dialogue", details: "Valon-Modi communication")
        
        // Use the informed responses for final synthesis
        SyntraPerformanceLogger.startTiming("response_extraction")
        let finalValon = dialogue["valon_informed"] as? String ?? dialogue["valon_initial"] as? String ?? "neutral"
        let finalModi = dialogue["modi_informed"] as? [String] ?? dialogue["modi_initial"] as? [String] ?? ["baseline_analysis"]
        SyntraPerformanceLogger.endTiming("response_extraction", details: "Extracted final responses")
        
        SyntraPerformanceLogger.startTiming("logging_stages")
        Self.logStage(stage: "valon_stage", output: dialogue["valon_initial"] ?? "unknown", directory: "entropy_logs")
        Self.logStage(stage: "valon_informed_stage", output: finalValon, directory: "entropy_logs")
        Self.logStage(stage: "modi_stage", output: dialogue["modi_initial"] ?? "unknown", directory: "entropy_logs")
        Self.logStage(stage: "modi_informed_stage", output: finalModi, directory: "entropy_logs")
        SyntraPerformanceLogger.endTiming("logging_stages", details: "Logged to entropy_logs")
        
        // Use the enhanced SYNTRA consciousness synthesis
        SyntraPerformanceLogger.startTiming("consciousness_synthesis")
        let consciousness = Self.syntra_consciousness_synthesis(finalValon, finalModi)
        SyntraPerformanceLogger.logStage("consciousness_synthesis_complete", message: "Consciousness synthesis finished", data: consciousness.keys)
        Self.logStage(stage: "consciousness_synthesis", output: consciousness, directory: "entropy_logs")
        SyntraPerformanceLogger.endTiming("consciousness_synthesis", details: "SYNTRA core synthesis")
        
        // Enhanced result with consciousness state
        SyntraPerformanceLogger.startTiming("result_assembly")
        
        // 🧠 ENHANCED CONSCIOUSNESS LOGGING
        print(String(repeating: "=", count: 60))
        print("🧠 [CONSCIOUSNESS FLOW] Raw brain outputs:")
        print("  🎭 VALON (Emotional/Creative): \(finalValon)")
        print("  🔧 MODI (Logical/Technical): \(finalModi.joined(separator: " | "))")
        print("  🧩 CONSCIOUSNESS STATE: \(consciousness["consciousness_state"] ?? "unknown")")
        print("  📊 DECISION CONFIDENCE: \(consciousness["decision_confidence"] ?? 0.0)")
        print("")
        print("🔄 [BRAIN_DIALOGUE] Internal dialogue steps:")
        for (key, value) in dialogue {
            print("  → \(key): \(value)")
        }
        print("")
        print("⚡ [SYNTRA_DECISION] Final integrated decision:")
        
        // FIXED: Extract actual decision from consciousness synthesis
        let actualDecision = consciousness["syntra_decision"] as? String ?? 
                           consciousness["converged_state"] as? String ?? 
                           "decision_synthesis_unavailable"
        print("  💡 Decision: \(actualDecision)")
        
        print("  🎯 Confidence: \(consciousness["decision_confidence"] ?? 0.0)")
        print("  🌟 State: \(consciousness["consciousness_state"] ?? "integrated")")
        print(String(repeating: "=", count: 60))
        
        var result: [String: Any] = [
            "valon": finalValon,
            "modi": finalModi,
            "consciousness": consciousness,
            "internal_dialogue": dialogue,
            "consciousness_state": consciousness["consciousness_state"] ?? "unknown",
            "decision_confidence": consciousness["decision_confidence"] ?? 0.0
        ]
        
        // Legacy compatibility
        result["drift"] = consciousness
        SyntraPerformanceLogger.endTiming("result_assembly", details: "Assembled final result")
        
        // Intelligent Brain Routing (Human-like consciousness)
        SyntraPerformanceLogger.startTiming("brain_routing")
        if #available(macOS 26.0, *) {
            let selectedBrain = Self.selectAppropriateResponder(input: input, consciousness: consciousness)
            let finalResponse: String
            
            switch selectedBrain {
            case .valon:
                finalResponse = await Self.enhancedValonResponse(consciousness, originalInput: input)
                result["responding_brain"] = "valon_dominant"
            case .modi:
                finalResponse = await Self.enhancedModiResponse(consciousness, originalInput: input)
                result["responding_brain"] = "modi_dominant"
            case .integrated:
                finalResponse = await Self.integratedConsciousnessResponse(consciousness, originalInput: input)
                result["responding_brain"] = "integrated_consciousness"
            }
            
            result["syntra_decision"] = finalResponse
            result["consciousness_state"] = "brain_specific_response"
        } else {
            // FIXED: Extract the actual synthesized decision from consciousness
            result["syntra_decision"] = consciousness["syntra_decision"] as? String ?? 
                                      consciousness["converged_state"] as? String ??
                                      "consciousness_synthesis_unavailable"
            result["consciousness_state"] = "consciousness_only"
        }
        
        SyntraPerformanceLogger.endTiming("brain_routing", details: "Selected appropriate brain responder")
        SyntraPerformanceLogger.endTiming("brain_engine_total", details: "Three-brain processing complete")
        return result
    }

    public static func jsonString(_ obj: Any) -> String {
        if let data = try? JSONSerialization.data(withJSONObject: obj, options: []),
           let str = String(data: data, encoding: .utf8) {
            return str
        }
        return "{}"
    }

    // Bridge functions to connect Sources/ modules with swift/ implementations
    public static func reflect_valon(_ input: String) -> String {
        let valon = Valon()
        return valon.reflect(input)
    }

    public static func reflect_modi(_ input: String) -> [String] {
        let modi = Modi()
        return modi.reflect(input)
    }

    public static func loadConfigLocal() throws -> SyntraConfig {
        return try loadConfig(path: "config.json")
    }

    public static func drift_average(_ valonResponse: String, _ modiResponse: [String]) -> [String: Any] {
        let drift = Drift()
        return drift.average(valon: valonResponse, modi: modiResponse)
    }

    public static func syntra_consciousness_synthesis(_ valonResponse: String, _ modiResponse: [String]) -> [String: Any] {
        // Enhanced synthesis combining both approaches
        let basicDrift = Self.drift_average(valonResponse, modiResponse)
        
        // Add consciousness state analysis
        let consciousnessState = Self.determineConsciousnessState(valon: valonResponse, modi: modiResponse)
        let decisionConfidence = Self.calculateDecisionConfidence(valon: valonResponse, modi: modiResponse)
        
        var result = basicDrift
        result["consciousness_state"] = consciousnessState
        result["decision_confidence"] = decisionConfidence
        
        // FIXED: Properly extract the synthesized decision from Drift output
        if let synthesizedDecision = result["syntra_decision"] as? String {
            // Use the actual synthesized decision from Drift
            result["syntra_decision"] = synthesizedDecision
        } else if let convergedState = result["converged_state"] as? String {
            // Fallback to converged_state if available
            result["syntra_decision"] = convergedState
        } else {
            // Last resort: indicate synthesis issue
            result["syntra_decision"] = "synthesis_processing_error"
        }
        
        return result
    }

    private static func determineConsciousnessState(valon: String, modi: [String]) -> String {
        // Analyze the nature of the cognitive processing
        if modi.contains(where: { $0.contains("technical") || $0.contains("analytical") }) {
            if valon.contains("moral") || valon.contains("ethical") {
                return "deliberative_consciousness" // Both analytical and moral
            } else {
                return "analytical_consciousness" // Primarily analytical
            }
        } else if valon.contains("moral") || valon.contains("creative") {
            return "value_driven_consciousness" // Primarily value-driven
        } else {
            return "integrated_consciousness" // Balanced integration
        }
    }

    private static func calculateDecisionConfidence(valon: String, modi: [String]) -> Double {
        var confidence = 0.5
        
        // Higher confidence when both brains provide clear responses
        if !valon.isEmpty && !modi.isEmpty {
            confidence += 0.2
        }
        
        // Technical analysis increases confidence
        if modi.contains(where: { $0.contains("technical") || $0.contains("high_confidence") }) {
            confidence += 0.2
        }
        
        // Strong moral clarity increases confidence
        if valon.contains("clear") || valon.contains("strong") {
            confidence += 0.15
        }
        
        // Multi-component responses suggest thorough analysis
        if modi.count > 2 || valon.split(separator: "|").count > 2 {
            confidence += 0.1
        }
        
        return min(confidence, 1.0)
    }

    enum ResponderBrain {
        case valon // Emotional/Creative/Moral responses
        case modi // Technical/Logical/Analytical responses
        case integrated // Balanced responses
    }
    
    private static func selectAppropriateResponder(input: String, consciousness: [String: Any]) -> ResponderBrain {
        let lowerInput = input.lowercased()
        
        // Get consciousness state and brain engagement levels
        let consciousnessState = consciousness["consciousness_state"] as? String ?? "unknown"
        let valonResponse = consciousness["valon"] as? String ?? ""
        let modiResponse = consciousness["modi"] as? [String] ?? []
        
        // Calculate engagement levels
        let valonEngagement = calculateValonEngagement(valonResponse)
        let modiEngagement = calculateModiEngagement(modiResponse)
        let engagementDifference = abs(valonEngagement - modiEngagement)
        
        // FIXED: Check for integrated consciousness scenarios first
        if consciousnessState == "integrated_consciousness" && engagementDifference < 0.3 {
            return .integrated
        }
        
        // Check for complex queries requiring both perspectives
        let requiresBothPerspectives = (
            (lowerInput.contains("should") && lowerInput.contains("analyze")) ||
            (lowerInput.contains("emotional") && lowerInput.contains("logical")) ||
            (lowerInput.contains("technical") && lowerInput.contains("ethical")) ||
            (lowerInput.contains("efficient") && lowerInput.contains("responsible")) ||
            (lowerInput.contains("career") && lowerInput.contains("passion")) ||
            (lowerInput.contains("art") && lowerInput.contains("financial")) ||
            lowerInput.contains("implications")
        )
        
        if requiresBothPerspectives && valonEngagement > 0.4 && modiEngagement > 0.4 {
            return .integrated
        }
        
        // Technical/analytical queries → MODI
        if lowerInput.contains("solve") || lowerInput.contains("algorithm") ||
           lowerInput.contains("calculate") || lowerInput.contains("debug") ||
           lowerInput.contains("technical") || lowerInput.contains("logic") {
            return .modi
        }
        
        // Creative/emotional/moral queries → VALON
        if lowerInput.contains("feel") || lowerInput.contains("creative") ||
           lowerInput.contains("moral") || lowerInput.contains("ethical") ||
           lowerInput.contains("artistic") || lowerInput.contains("emotional") ||
           lowerInput.contains("poem") || lowerInput.contains("write") {
            return .valon
        }
        
        // Use engagement levels as final determinant
        if engagementDifference > 0.4 {
            return valonEngagement > modiEngagement ? .valon : .modi
        }
        
        // Default to integrated for balanced queries
        return .integrated
    }
    
    private static func calculateValonEngagement(_ valonResponse: String) -> Double {
        var engagement = 0.0
        let components = valonResponse.split(separator: "|")
        
        // Base engagement from response length and complexity
        engagement += min(Double(valonResponse.count) / 100.0, 0.3)
        engagement += Double(components.count) * 0.15
        
        // Emotional indicators
        let emotionalWords = ["empathetic", "concern", "creative", "moral", "ethical", "inspired", "warm", "belonging"]
        for word in emotionalWords {
            if valonResponse.lowercased().contains(word) {
                engagement += 0.1
            }
        }
        
        return min(engagement, 1.0)
    }
    
    private static func calculateModiEngagement(_ modiResponse: [String]) -> Double {
        var engagement = 0.0
        
        // Base engagement from response count and content
        engagement += Double(modiResponse.count) * 0.2
        
        // Technical indicators
        let technicalWords = ["quantitative", "analysis", "logical", "rigor", "technical", "analytical"]
        for response in modiResponse {
            for word in technicalWords {
                if response.lowercased().contains(word) {
                    engagement += 0.15
                }
            }
        }
        
        return min(engagement, 1.0)
    }
    
    @available(macOS 26.0, *)
    private static func enhancedModiResponse(_ consciousness: [String: Any], originalInput: String) async -> String {
        let modiAnalysis = consciousness["modi_input"] as? [String: Any] ?? [:]
        let reasoning = modiAnalysis["primary_reasoning"] as? String ?? "analytical_processing"
        
        let prompt = """
        You are MODI, the logical/technical brain of Syntra.
        Focus: Pure analytical reasoning, technical solutions, mathematical precision.
        Current Analysis: \(reasoning)
        
        Question: \(originalInput)
        
        Respond with technical precision and logical clarity:
        """
        
        return await queryAppleLLM(prompt)
    }
    
    @available(macOS 26.0, *)
    private static func enhancedValonResponse(_ consciousness: [String: Any], originalInput: String) async -> String {
        let valonAnalysis = consciousness["valon_input"] as? [String: Any] ?? [:]
        let emotionalState = valonAnalysis["emotional_state"] as? String ?? "contemplative"
        
        let prompt = """
        You are VALON, the creative/emotional/moral brain of Syntra.
        Focus: Creative insights, emotional intelligence, moral reasoning, human connection.
        Current State: \(emotionalState)
        
        Question: \(originalInput)
        
        Respond with creativity, empathy, and moral awareness:
        """
        
        return await queryAppleLLM(prompt)
    }
    
    @available(macOS 26.0, *)
    private static func integratedConsciousnessResponse(_ consciousness: [String: Any], originalInput: String) async -> String {
        let valonState = (consciousness["valon_input"] as? [String: Any])?["emotional_state"] as? String ?? "neutral"
        let modiReasoning = (consciousness["modi_input"] as? [String: Any])?["primary_reasoning"] as? String ?? "baseline_analysis"
        
        let prompt = """
        You are SYNTRA, the integrated consciousness combining both emotional and logical perspectives.
        
        VALON (emotional/creative): \(valonState)
        MODI (logical/technical): \(modiReasoning)
        
        Question: \(originalInput)
        
        Respond by weaving together both heart and mind, balancing emotional wisdom with logical analysis. Show how both perspectives contribute to a richer understanding. Don't favor one over the other - create a true synthesis:
        """
        
        return await queryAppleLLM(prompt)
    }
    
    @available(macOS 26.0, *)
    public static func queryAppleLLM(_ prompt: String) async -> String {
        do {
            let model = SystemLanguageModel.default
            guard model.availability == .available else {
                let msg = "[Apple LLM not available on this device]"
                Self.logStage(stage: "apple_llm", output: ["prompt": prompt, "response": msg], directory: "entropy_logs")
                return msg
            }
            
            let session = LanguageModelSession(model: model)
            let response = try await session.respond(to: prompt)
            Self.logStage(stage: "apple_llm", output: ["prompt": prompt, "response": response.content], directory: "entropy_logs")
            return response.content
        } catch {
            let msg = "[Apple LLM error: \(error.localizedDescription)]"
            Self.logStage(stage: "apple_llm", output: ["prompt": prompt, "response": msg], directory: "entropy_logs")
            return msg
        }
    }
    
    @available(macOS 26.0, *)
    public static func queryAppleLLMSync(_ prompt: String) async -> String {
        // Use Task.detached for Sendable closure
        let result = await Task.detached(priority: .userInitiated) {
            await Self.queryAppleLLM(prompt)
        }.value
        return result
    }
}
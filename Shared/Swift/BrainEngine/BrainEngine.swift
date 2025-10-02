import Foundation
import FoundationModels
import Valon
import Modi
import Drift
import SyntraConfig
import ConsciousnessStructures
import SyntraTools
// import StructuredConsciousnessService // Disabled for macOS "26.0" compatibility

// Global conversation history (THIS IS THE SOURCE OF THE CONTEXT BLEED)
@MainActor
private var conversationHistory: [String] = []

/// BrainEngine for SYNTRA consciousness architecture
/// Refactored July 2025 to eliminate top-level functions and ensure SwiftPM compliance
public struct BrainEngine {
    public init() {}
    
    // MARK: - Verbose LLM Logging Configuration
    /// Toggle for detailed Apple LLM conversation logging
    /// Enable with: SYNTRA_VERBOSE_LLM=true swift run
    private static let isVerboseLLMLoggingEnabled = ProcessInfo.processInfo.environment["SYNTRA_VERBOSE_LLM"] == "true"
    
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

    /// Enhanced inter-brain communication system with precision awareness
    public static func conductInternalDialogue(_ content: String) -> [String: Any] {
        // PHASE 1: Initial Assessment
        let valonInitial = Self.reflect_valon(content)
        let modiInitial = Self.reflect_modi(content)
        
        // PHASE 2: Precision Assessment
        let needsVerification = Valon.assessVerificationNeed(content)
        var verificationResults: [String: Any] = [:]
        
        if needsVerification {
            // TODO: Extract solution from content for verification
            // For now, we'll simulate verification for demonstration
            let mockSolution = extractPotentialSolution(from: content)
            verificationResults = Modi.verifySolution(content, solution: mockSolution)
        }
        
        // PHASE 3: Verification-Informed Responses
        let valonContext = needsVerification ?
            "Modi analyzed this as: \(modiInitial.joined(separator: ", ")). Verification needed: \(needsVerification). Content: \(content)" :
            "Modi analyzed this as: \(modiInitial.joined(separator: ", ")). Content: \(content)"
        
        let valonInformed = Self.reflect_valon(valonContext)
        
        let modiContext = "Valon feels this is: \(valonInitial). Content: \(content)"
        let modiInformed = Self.reflect_modi(modiContext)
        
        // PHASE 4: Final Verification Adjustment (if verification occurred)
        var finalValon = valonInformed
        if needsVerification && !verificationResults.isEmpty {
            let adjustedResponse = Valon.interpretVerificationResults(content, verificationResults: verificationResults)
            finalValon = adjustedResponse["adjusted_response"] as? String ?? valonInformed
        }
        
        return [
            "valon_initial": valonInitial,
            "modi_initial": modiInitial,
            "valon_informed": finalValon,
            "modi_informed": modiInformed,
            "verification_needed": needsVerification,
            "verification_results": verificationResults,
            "dialogue_occurred": true
        ]
    }
    
    /// Extract potential solution from content for verification
    private static func extractPotentialSolution(from content: String) -> String {
        // Simple heuristic: look for patterns that might be solutions
        let lines = content.components(separatedBy: .newlines)
        
        // Look for lines with numbers (potential algorithmic answers)
        for line in lines {
            if line.range(of: #"\d+"#, options: .regularExpression) != nil {
                return line
            }
        }
        
        // Look for structured solution patterns
        for line in lines {
            let lower = line.lowercased()
            if lower.contains("step") || lower.contains("move") || lower.contains("solution") {
                return line
            }
        }
        
        // Fallback: return the content itself
        return content
    }

    public static func processThroughBrains(_ input: String) async -> [String: Any] {
        SyntraPerformanceLogger.startTiming("brain_engine_total")
        SyntraPerformanceLogger.logStage("brain_engine_start", message: "Starting three-brain processing", data: input.prefix(100))
        
        // Enhanced processing with inter-brain communication
        SyntraPerformanceLogger.startTiming("internal_dialogue")
        let dialogue = Self.conductInternalDialogue(input)
        SyntraPerformanceLogger.logStage("internal_dialogue_complete", message: "Internal dialogue completed", data: dialogue.keys)
        SyntraPerformanceLogger.endTiming("internal_dialogue", details: "Valon-Modi communication")

        // Extract complete consciousness data including rich symbolic structures
        SyntraPerformanceLogger.startTiming("consciousness_data_extraction")
        let finalValon = dialogue["valon_informed"] as? String ?? dialogue["valon_initial"] as? String ?? "neutral"
        let finalModi = dialogue["modi_informed"] as? [String] ?? dialogue["modi_initial"] as? [String] ?? ["baseline_analysis"]

        // Get full symbolic data from Valon for PromptArchitect
        let valon = Valon()
        let valonSymbolicData = valon.extractSymbolicData(finalValon)
        let precisionRequirements = dialogue["precision_context"] as? [String: Any] ?? [:]

        // Get detailed Modi analysis
        let modi = Modi()
        let modiAnalysisDetails = modi.extractAnalysisDetails(finalModi)

        SyntraPerformanceLogger.endTiming("consciousness_data_extraction", details: "Extracted complete consciousness data")
        
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
            "decision_confidence": consciousness["decision_confidence"] ?? 0.0,

            // Enhanced consciousness data for PromptArchitect
            "valon_symbolic_data": valonSymbolicData,
            "modi_analysis_details": modiAnalysisDetails,
            "precision_requirements": precisionRequirements,

            // Verification indicators
            "precision_needed": precisionRequirements["needs_verification"] as? Bool ?? false,
            "verification_context": [
                "type": precisionRequirements["type"] ?? "creative_approximation_acceptable",
                "intensity": precisionRequirements["intensity"] ?? "moderate_stakes",
                "reasoning": precisionRequirements["reasoning"] ?? ""
            ]
        ]

        // Legacy compatibility
        result["drift"] = consciousness
        SyntraPerformanceLogger.endTiming("result_assembly", details: "Assembled final result")
        
        // Intelligent Brain Routing (Human-like consciousness)
        SyntraPerformanceLogger.startTiming("brain_routing")
        if #available(macOS 26.0, *) {
            let selectedBrain = Self.selectAppropriateResponder(input: input, consciousness: consciousness)

            // Generate trace-enabled response
            let traceResponse = await Self.generateTraceEnabledResponse(
                brain: selectedBrain,
                consciousness: consciousness,
                originalInput: input
            )

            result["responding_brain"] = selectedBrain.rawValue
            result["syntra_decision"] = traceResponse.answer
            result["trace_validation"] = traceResponse.validationResult
            result["trace_data"] = traceResponse.validatedTrace
            result["consciousness_state"] = "trace_enabled_response"
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

    enum ResponderBrain: String {
        case valon // Emotional/Creative/Moral responses
        case modi // Technical/Logical/Analytical responses
        case integrated // Balanced responses
    }

    struct TraceResponse {
        let answer: String
        let validationResult: TraceValidationSchema.ValidationResult
        let validatedTrace: [String: Any]?
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
    
    // MARK: - Generic Prompt Optimization for Context Window Management
    
    /// Optimize prompts for Apple LLM to prevent context window overflow without bias
    private static func optimizePromptForAppleLLM(_ originalPrompt: String) -> String {
        let maxContextTokens = 4096  // Estimated Apple LLM context window
        let avgCharsPerToken = 4     // Conservative estimate
        let maxChars = maxContextTokens * avgCharsPerToken
        
        // If prompt is reasonable size, return as-is
        if originalPrompt.count <= Int(Double(maxChars) * 0.7) { // Use 70% as safety margin
            return originalPrompt
        }
        
        // Parse prompt components
        let lines = originalPrompt.components(separatedBy: "\n")
        var preservedLines: [String] = []
        var questionContent = ""
        
        // Always preserve critical components
        for line in lines {
            let trimmed = line.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Preserve SYNTRA identity and brain states
            if trimmed.contains("You are SYNTRA") || 
               trimmed.contains("You are VALON") ||
               trimmed.contains("You are MODI") ||
               trimmed.contains("VALON (") ||
               trimmed.contains("MODI (") ||
               trimmed.contains("Respond by weaving") {
                preservedLines.append(line)
            }
            // Extract and clean question content
            else if trimmed.hasPrefix("Question:") {
                // Remove duplication and clean
                var cleaned = trimmed.replacingOccurrences(of: "Question: Question:", with: "Question:")
                cleaned = cleaned.replacingOccurrences(of: "Question: ", with: "", options: [])
                questionContent = cleaned.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
        
        // Calculate available space for question
        let basePrompt = preservedLines.joined(separator: "\n")
        let availableForQuestion = maxChars - basePrompt.count - 200 // Buffer
        
        // Intelligently truncate question if needed
        if questionContent.count > availableForQuestion && availableForQuestion > 100 {
            // Try to preserve the core request
            let coreRequest = String(questionContent.prefix(availableForQuestion - 50))
            questionContent = coreRequest + " [Request truncated - core preserved]"
        }
        
        // Reconstruct optimized prompt
        var optimizedPrompt = basePrompt
        if !questionContent.isEmpty {
            optimizedPrompt += "\n\nQuestion: " + questionContent
        }
        
        return optimizedPrompt
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
        
        let optimizedPrompt = optimizePromptForAppleLLM(prompt)
        return await queryLLM(optimizedPrompt)
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
        
        let optimizedPrompt = optimizePromptForAppleLLM(prompt)
        return await queryLLM(optimizedPrompt)
    }
    
    @available(macOS 26.0, *)
    private static func integratedConsciousnessResponse(_ consciousness: [String: Any], originalInput: String) async -> String {
        let valonState = (consciousness["valon_input"] as? [String: Any])?["emotional_state"] as? String ?? "neutral"
        let modiReasoning = (consciousness["modi_input"] as? [String: Any])?["primary_reasoning"] as? String ?? "baseline_analysis"
        
        // Detect if structured output is needed
        let needsStructuredOutput = originalInput.lowercased().contains("show each") ||
                                   originalInput.lowercased().contains("moves in format") ||
                                   originalInput.lowercased().contains("step by step")
        
        var prompt = """
        You are SYNTRA, the integrated consciousness combining both emotional and logical perspectives.
        
        VALON (emotional/creative): \(valonState)
        MODI (logical/technical): \(modiReasoning)
        
        Question: \(originalInput)
        """
        
        if needsStructuredOutput {
            prompt += "\n\nCRITICAL: This request requires precise, structured output - not philosophical discussion.\nProvide the exact format requested. Be systematic and complete.\nBalance heart and mind, but prioritize delivering the specific solution requested."
        } else {
            prompt += "\n\nRespond by weaving together both heart and mind, balancing emotional wisdom with logical analysis. \nShow how both perspectives contribute to a richer understanding. Don't favor one over the other - create a true synthesis:"
        }
        
        let optimizedPrompt = optimizePromptForAppleLLM(prompt)
        return await queryLLM(optimizedPrompt)
    }

    @available(macOS 26.0, *)
    private static func generateTraceEnabledResponse(
        brain: ResponderBrain,
        consciousness: [String: Any],
        originalInput: String
    ) async -> TraceResponse {
        // Validate user prompt
        guard WrappedPromptTemplate.validateUserPrompt(originalInput) else {
            return TraceResponse(
                answer: "I'm sorry, but I need a more detailed question to provide a meaningful response.",
                validationResult: TraceValidationSchema.ValidationResult(
                    isValid: false,
                    errors: ["Invalid or empty user prompt"],
                    validatedData: nil
                ),
                validatedTrace: nil
            )
        }

        // Construct wrapped prompt using template
        let wrappedPrompt = WrappedPromptTemplate.constructWrappedPrompt(userPrompt: originalInput)

        // Try OpenRouter first, fallback to Apple FM
        var rawResponse: String?
        var usedOpenRouter = false

        if let openRouterClient = OpenRouterClient.fromEnvironment() {
            do {
                // Use a good model for structured output (GPT-4 or similar)
                let model = ProcessInfo.processInfo.environment["OPENROUTER_MODEL"] ?? "openai/gpt-4o-mini"
                let response = try await openRouterClient.sendChatCompletion(
                    model: model,
                    prompt: wrappedPrompt,
                    temperature: 0.3,
                    maxTokens: 2000
                )

                if let content = openRouterClient.extractContent(from: response) {
                    rawResponse = content
                    usedOpenRouter = true

                    // Log OpenRouter usage
                    Self.logStage(stage: "openrouter_request", output: [
                        "model": model,
                        "success": true,
                        "usage": response.usage.map { [
                            "prompt_tokens": $0.prompt_tokens,
                            "completion_tokens": $0.completion_tokens,
                            "total_tokens": $0.total_tokens
                        ] } as Any
                    ], directory: "entropy_logs")
                }
            } catch {
                // Log OpenRouter failure and fallback
                Self.logStage(stage: "openrouter_request", output: [
                    "error": error.localizedDescription,
                    "fallback_to_apple_fm": true
                ], directory: "entropy_logs")
            }
        }

        // Fallback to Apple FM if OpenRouter failed or unavailable
        if rawResponse == nil {
            let optimizedPrompt = optimizePromptForAppleLLM(wrappedPrompt)
            rawResponse = await queryLLM(optimizedPrompt)
            usedOpenRouter = false
        }

        guard let response = rawResponse else {
            return TraceResponse(
                answer: "I apologize, but I'm unable to generate a response at this time.",
                validationResult: TraceValidationSchema.ValidationResult(
                    isValid: false,
                    errors: ["No response generated from any LLM"],
                    validatedData: nil
                ),
                validatedTrace: nil
            )
        }

        // Attempt to parse and validate JSON response
        if let jsonData = response.data(using: .utf8),
           let json = try? JSONSerialization.jsonObject(with: jsonData) as? [String: Any] {

            let validationResult = TraceValidationSchema.validate(json: json)

            if validationResult.isValid, let answer = json["answer"] as? String {
                // Log successful validation
                Self.logStage(stage: "trace_validation", output: [
                    "validation_success": true,
                    "used_openrouter": usedOpenRouter,
                    "trace": json["trace"] as Any
                ], directory: "entropy_logs")

                return TraceResponse(
                    answer: answer,
                    validationResult: validationResult,
                    validatedTrace: json["trace"] as? [String: Any]
                )
            } else {
                // Validation failed - log errors
                Self.logStage(stage: "trace_validation", output: [
                    "validation_success": false,
                    "used_openrouter": usedOpenRouter,
                    "errors": validationResult.errors,
                    "raw_response_preview": String(response.prefix(500))
                ], directory: "entropy_logs")
            }
        } else {
            // JSON parsing failed
            Self.logStage(stage: "trace_validation", output: [
                "validation_success": false,
                "json_parsing_failed": true,
                "used_openrouter": usedOpenRouter,
                "raw_response_preview": String(response.prefix(500))
            ], directory: "entropy_logs")
        }

        // Fallback: return raw response as answer
        return TraceResponse(
            answer: response,
            validationResult: TraceValidationSchema.ValidationResult(
                isValid: false,
                errors: ["Failed to parse JSON response"],
                validatedData: nil
            ),
            validatedTrace: nil
        )
    }



    @available(macOS 26.0, *)
    public static func queryAppleLLM(_ prompt: String) async -> String {
        // MARK: - Verbose LLM Logging: Log prompt before sending
        if isVerboseLLMLoggingEnabled {
            print("🔍 [LLM_PROMPT] Sent to Apple LLM:")
            print("📤 Prompt: \(prompt)")
            print("---")
        }
        
        do {
            let model = SystemLanguageModel.default
            guard model.availability == .available else {
                let msg = "[Apple LLM not available on this device]"
                if isVerboseLLMLoggingEnabled {
                    print("🔍 [LLM_RESPONSE] Apple LLM unavailable: \(msg)")
                }
                Self.logStage(stage: "apple_llm", output: ["prompt": prompt, "response": msg], directory: "entropy_logs")
                return msg
            }
            
            let session = LanguageModelSession(model: model)
            let response = try await session.respond(to: prompt)
            
            // MARK: - Verbose LLM Logging: Log response after receiving
            if isVerboseLLMLoggingEnabled {
                print("🔍 [LLM_RESPONSE] Received from Apple LLM:")
                print("📥 Response: \(response.content)")
                print("===\n")
            }
            
            Self.logStage(stage: "apple_llm", output: ["prompt": prompt, "response": response.content], directory: "entropy_logs")
            return response.content
        } catch {
            let msg = "[Apple LLM error: \(error.localizedDescription)]"
            if isVerboseLLMLoggingEnabled {
                print("🔍 [LLM_RESPONSE] Apple LLM error: \(msg)")
            }
            Self.logStage(stage: "apple_llm", output: ["prompt": prompt, "response": msg], directory: "entropy_logs")
            return msg
        }
    }

    // MARK: - Backend-agnostic query (Cloud or AFM)
    @available(macOS 26.0, *)
    public static func queryLLM(_ prompt: String) async -> String {
        let mode = (ProcessInfo.processInfo.environment["SYNTRA_BACKEND"] ?? "").lowercased()
        if mode == "cloud" {
            // Minimal OpenAI-compatible non-stream call
            let base = ProcessInfo.processInfo.environment["LLM_BASE_URL"] ?? "https://api.openai.com"
            let model = ProcessInfo.processInfo.environment["LLM_MODEL"] ?? "gpt-4.1"
            guard let apiKey = ProcessInfo.processInfo.environment["LLM_API_KEY"], !apiKey.isEmpty else {
                return "[Cloud backend missing LLM_API_KEY]"
            }
            guard let url = URL(string: base + "/v1/chat/completions") else {
                return "[Invalid LLM_BASE_URL]"
            }
            var req = URLRequest(url: url)
            req.httpMethod = "POST"
            req.setValue("application/json", forHTTPHeaderField: "Content-Type")
            req.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
            let body: [String: Any] = [
                "model": model,
                "messages": [["role": "user", "content": prompt]],
                "stream": false,
                "temperature": 0.3
            ]
            req.httpBody = try? JSONSerialization.data(withJSONObject: body)
            let config = URLSessionConfiguration.ephemeral
            config.timeoutIntervalForRequest = 60
            let session = URLSession(configuration: config)
            do {
                let (data, response) = try await session.data(for: req)
                guard let http = response as? HTTPURLResponse, (200..<300).contains(http.statusCode) else {
                    let text = String(data: data, encoding: .utf8) ?? ""
                    return "[Cloud LLM HTTP error] \(text)"
                }
                struct Choice: Decodable { let message: Msg }
                struct Msg: Decodable { let content: String }
                struct Resp: Decodable { let choices: [Choice] }
                if let decoded = try? JSONDecoder().decode(Resp.self, from: data) {
                    return decoded.choices.first?.message.content ?? ""
                }
                return String(data: data, encoding: .utf8) ?? ""
            } catch {
                return "[Cloud LLM error: \(error.localizedDescription)]"
            }
        } else {
            // Default to Apple FM path
            return await queryAppleLLM(prompt)
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
    
    // Function to clear the conversation history
    @MainActor
    public static func clearConversationHistory() {
        conversationHistory.removeAll()
    }
}

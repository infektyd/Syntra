import Foundation
import FoundationModels

// MARK: - Prompt Architect Framework

/// PromptArchitect translates SYNTRA consciousness states into Apple Foundation Models instructions
/// Converts Valon's symbolic emotional intelligence and Modi's logical analysis into structured prompts
public struct PromptArchitect {
    
    // MARK: - Symbolic Data Translation
    
    /// Parsed symbolic data structure from Valon's enhanced format
    public struct SymbolicDataSet {
        let concepts: [String]
        let emotions: [String] 
        let symbols: [String]
        let triplets: [SymbolicTriplet]
        let verificationRequired: Bool
        let precisionLevel: PrecisionLevel
        let moralWeight: MoralWeight
    }
    
    /// Individual symbolic triplet in format: concept|emotion|symbol
    public struct SymbolicTriplet {
        let concept: String
        let emotion: String
        let symbol: String
        
        var formatted: String {
            return "\(concept)|\(emotion)|\(symbol)"
        }
    }
    
    /// Detected precision levels from symbolic analysis
    public enum PrecisionLevel: String, CaseIterable {
        case low = "low_precision"
        case moderate = "moderate_precision" 
        case high = "high_precision"
        case absolute = "absolute_precision"
        case verification_required = "verification_required"
    }
    
    /// Detected moral weight levels from symbolic analysis
    public enum MoralWeight: String, CaseIterable {
        case low = "low_moral_weight"
        case moderate = "moderate_moral_weight"
        case high = "high_moral_weight"
        case critical = "critical_moral_weight"
    }
    
    /// Modi analysis context for instruction building
    public struct ModiContext {
        let reasoningTypes: [String]
        let technicalDomains: [String]
        let logicalComplexity: String
        let verificationStatus: VerificationStatus
    }
    
    /// Verification status from Modi's analysis
    public enum VerificationStatus: String {
        case not_needed = "verification_not_needed"
        case required = "verification_required"
        case passed = "verification_passed"
        case failed = "verification_failed"
        case uncertain = "verification_uncertain"
    }
    
    public init() {}
    
    // MARK: - Core Translation Methods
    
    /// Parse Valon's pipe-separated symbolic response into structured data with comprehensive semantic mapping
    /// Example input: "systematic_focus|accuracy_imperative|methodical_precision|🎯|verification_required|precision_duty"
    /// Returns: Dictionary with semantic interpretations of each symbolic element
    public static func translateSymbolicData(_ valonResponse: String) -> [String: String] {
        // Input validation and error handling
        guard !valonResponse.trimmingCharacters(in: .whitespaces).isEmpty else {
            return createErrorResponse("Empty or whitespace-only input provided")
        }
        
        guard valonResponse.count <= 2000 else {
            return createErrorResponse("Input too long - maximum 2000 characters allowed")
        }
        
        // Split on pipe characters and clean components
        let components = valonResponse.split(separator: "|")
            .map { String($0).trimmingCharacters(in: .whitespaces) }
            .filter { !$0.isEmpty }

        guard !components.isEmpty else {
            return createErrorResponse("No valid components found after parsing")
        }

        // Initialize processing variables for component analysis
        var precisionLevel = "moderate"
        var verificationRequired = false
        var emotionalContext: [String] = []
        var moralWeight = "moderate"
        var detectedSymbols: [String] = []
        var conceptualElements: [String] = []

        // Process each component with comprehensive mapping
        for component in components {
            let processedElement = processSymbolicElement(component)

            // Merge the processed element results
            if let precision = processedElement["precision_impact"] {
                precisionLevel = combinePrecisionLevels(current: precisionLevel, new: precision)
            }

            if let verification = processedElement["verification_impact"], verification == "required" {
                verificationRequired = true
            }

            if let emotional = processedElement["emotional_impact"], !emotional.isEmpty {
                emotionalContext.append(emotional)
            }

            if let moral = processedElement["moral_impact"] {
                moralWeight = combineMoralWeights(current: moralWeight, new: moral)
            }

            if let symbol = processedElement["symbol_meaning"], !symbol.isEmpty {
                detectedSymbols.append(symbol)
            }

            if let concept = processedElement["conceptual_meaning"], !concept.isEmpty {
                conceptualElements.append(concept)
            }
        }

        // Build comprehensive semantic interpretation
        return [
            "precision_level": precisionLevel,
            "verification_required": verificationRequired ? "true" : "false",
            "emotional_context": emotionalContext.joined(separator: "; "),
            "moral_weight": moralWeight,
            "symbolic_meanings": detectedSymbols.joined(separator: "; "),
            "conceptual_elements": conceptualElements.joined(separator: "; "),
            "instruction_text": buildInstructionText(
                precision: precisionLevel,
                verification: verificationRequired,
                emotional: emotionalContext,
                moral: moralWeight
            ),
            "parsing_status": "success",
            "components_parsed": String(components.count)
        ]
    }
    
    
    // MARK: - Enhanced Symbolic Processing Methods
    
    /// Process individual symbolic elements with comprehensive semantic mapping
    private static func processSymbolicElement(_ element: String) -> [String: String] {
        var result: [String: String] = [:]
        let lowercased = element.lowercased()
        
        // Precision Impact Analysis
        if lowercased.contains("accuracy") || lowercased.contains("precision") {
            if lowercased.contains("imperative") || lowercased.contains("absolute") {
                result["precision_impact"] = "absolute"
            } else if lowercased.contains("methodical") || lowercased.contains("systematic") {
                result["precision_impact"] = "high"
            } else {
                result["precision_impact"] = "moderate"
            }
        }
        
        // Verification Impact Analysis
        if lowercased.contains("verification") {
            if lowercased.contains("required") || lowercased.contains("imperative") {
                result["verification_impact"] = "required"
            } else if lowercased.contains("optional") {
                result["verification_impact"] = "optional"
            } else {
                result["verification_impact"] = "recommended"
            }
        }
        
        // Emotional Impact Analysis
        if lowercased.contains("focus") || lowercased.contains("systematic") {
            result["emotional_impact"] = "maintain systematic attention and methodical approach"
        } else if lowercased.contains("concern") || lowercased.contains("responsibility") {
            result["emotional_impact"] = "express appropriate concern and careful consideration"
        } else if lowercased.contains("confidence") || lowercased.contains("satisfaction") {
            result["emotional_impact"] = "proceed with confidence while maintaining vigilance"
        } else if lowercased.contains("alert") || lowercased.contains("warning") {
            result["emotional_impact"] = "heightened awareness and cautious approach"
        }
        
        // Moral Weight Analysis
        if lowercased.contains("intellectual_responsibility") || lowercased.contains("precision_duty") {
            result["moral_impact"] = "high"
        } else if lowercased.contains("responsibility") {
            result["moral_impact"] = "moderate"
        } else if lowercased.contains("critical") || lowercased.contains("essential") {
            result["moral_impact"] = "critical"
        }
        
        // Symbol Analysis with Enhanced Semantic Mapping
        if isSymbol(element) {
            result["symbol_meaning"] = mapSymbolToSemanticMeaning(element)
        }
        
        // Conceptual Element Analysis
        if !isSymbol(element) && !isEmotionalState(element) {
            result["conceptual_meaning"] = mapConceptToSemanticMeaning(element)
        }
        
        return result
    }
    
    /// Map symbols to their semantic meanings with enhanced interpretations
    private static func mapSymbolToSemanticMeaning(_ symbol: String) -> String {
        switch symbol {
        case "🎯": 
            return "accuracy imperative - prioritize mathematical precision and exact solutions"
        case "🔬": 
            return "analytical verification mindset - apply scientific rigor and systematic testing"
        case "⚖️": 
            return "intellectual responsibility - balance thoroughness with moral duty to accuracy"
        case "⚙️": 
            return "systematic methodical approach - employ structured problem-solving processes"
        case "✅": 
            return "verification confidence - validated results with high reliability"
        case "🚨": 
            return "verification warning - heightened caution due to accuracy concerns"
        case "💎": 
            return "truth-seeking clarity - pursue absolute precision and transparent reasoning"
        case "🔍": 
            return "problem-solving focus - detailed analysis and investigative approach"
        case "🎨": 
            return "creative appreciation - balance innovation with systematic rigor"
        case "🤝": 
            return "collaborative connection - synthesize multiple perspectives harmoniously"
        case "💔": 
            return "empathetic concern - careful attention to potential impact on others"
        case "✨": 
            return "creative inspiration - innovative thinking within logical frameworks"
        case "🌱": 
            return "growth and learning - educational approach with patient development"
        case "⚠️": 
            return "caution and warning - proceed with careful attention to potential risks"
        case "💝": 
            return "careful attention - treat with special care and detailed consideration"
        case "🧩": 
            return "complexity handling - patient approach to intricate problem-solving"
        case "🔎": 
            return "detailed examination - thorough investigation with microscopic attention"
        case "❓": 
            return "uncertainty acknowledgment - honest recognition of knowledge limitations"
        default: 
            return "symbolic element requiring interpretation: \(symbol)"
        }
    }
    
    /// Map conceptual elements to semantic meanings
    private static func mapConceptToSemanticMeaning(_ concept: String) -> String {
        let lowercased = concept.lowercased()
        
        switch lowercased {
        case let c where c.contains("systematic_focus"):
            return "maintain systematic attention to methodical problem-solving processes"
        case let c where c.contains("accuracy_imperative"):
            return "prioritize mathematical precision and exact correctness in all calculations"
        case let c where c.contains("methodical_precision"):
            return "employ careful, step-by-step approaches with verified accuracy at each stage"
        case let c where c.contains("verification_required"):
            return "mandatory verification process - validate all results and show reasoning"
        case let c where c.contains("precision_duty"):
            return "moral obligation to provide accurate information and correct solutions"
        case let c where c.contains("intellectual_responsibility"):
            return "ethical duty to ensure accuracy and acknowledge limitations honestly"
        case let c where c.contains("concerned_responsibility"):
            return "heightened awareness of accuracy importance with careful validation"
        case let c where c.contains("algorithmic"):
            return "systematic computational approach with logical step-by-step procedures"
        case let c where c.contains("creative"):
            return "innovative thinking balanced with logical rigor and systematic verification"
        case let c where c.contains("empathetic"):
            return "consider human impact and emotional context while maintaining accuracy"
        default:
            return "conceptual element: \(concept) - apply appropriate contextual interpretation"
        }
    }
    
    /// Combine precision levels using highest priority
    private static func combinePrecisionLevels(current: String, new: String) -> String {
        let hierarchy = ["low": 1, "moderate": 2, "high": 3, "absolute": 4, "critical": 5]
        let currentLevel = hierarchy[current] ?? 2
        let newLevel = hierarchy[new] ?? 2
        
        if newLevel > currentLevel {
            return new
        }
        return current
    }
    
    /// Combine moral weights using highest priority
    private static func combineMoralWeights(current: String, new: String) -> String {
        let hierarchy = ["low": 1, "moderate": 2, "high": 3, "critical": 4]
        let currentLevel = hierarchy[current] ?? 2
        let newLevel = hierarchy[new] ?? 2
        
        if newLevel > currentLevel {
            return new
        }
        return current
    }
    
    /// Build comprehensive instruction text from analyzed components
    private static func buildInstructionText(
        precision: String,
        verification: Bool,
        emotional: [String],
        moral: String
    ) -> String {
        var instructions: [String] = []
        
        // Precision instructions
        switch precision {
        case "absolute":
            instructions.append("Apply absolute precision - verify all facts, show all work, validate every calculation")
        case "high":
            instructions.append("Maintain high precision - double-check important details and validate key conclusions")
        case "moderate":
            instructions.append("Use balanced precision - accurate and thorough while remaining accessible")
        case "low":
            instructions.append("Focus on general understanding with appropriate detail level")
        default:
            instructions.append("Apply contextually appropriate precision standards")
        }
        
        // Verification instructions
        if verification {
            instructions.append("Verification required: Show reasoning process, cite methodology, validate conclusions")
        }
        
        // Emotional context instructions
        if !emotional.isEmpty {
            instructions.append("Emotional approach: \(emotional.joined(separator: "; "))")
        }
        
        // Moral guidance instructions
        switch moral {
        case "critical":
            instructions.append("Critical moral responsibility - wrong information could cause significant harm")
        case "high":
            instructions.append("High moral responsibility - prioritize accuracy and acknowledge uncertainties")
        case "moderate":
            instructions.append("Standard moral consideration - be helpful, truthful, and appropriately cautious")
        case "low":
            instructions.append("Standard helpfulness with appropriate care")
        default:
            instructions.append("Apply appropriate moral considerations for the context")
        }
        
        return instructions.joined(separator: ". ")
    }
    
    /// Create standardized error response
    private static func createErrorResponse(_ message: String) -> [String: String] {
        return [
            "parsing_status": "error",
            "error_message": message,
            "precision_level": "moderate",
            "verification_required": "false",
            "emotional_context": "cautious approach due to parsing issues",
            "moral_weight": "moderate",
            "symbolic_meanings": "",
            "conceptual_elements": "",
            "instruction_text": "Apply standard careful approach due to input parsing issues",
            "components_parsed": "0"
        ]
    }
    /// Convert Modi's logical analysis into conversational instruction text for Foundation Models
    /// Example input: ["algorithmic_puzzle_solving", "problem_solving_methodology", "high_logical_rigor"]
    /// Output: Natural language instructions that guide Apple's LLM behavior
    public static func buildVerificationContext(_ modiResponse: [String]) -> String {
        // Input validation
        guard !modiResponse.isEmpty else {
            return "Use a balanced analytical approach with clear reasoning."
        }
        
        var instructionComponents: [String] = []
        var hasAlgorithmicFocus = false
        var hasProblemSolving = false
        var hasHighRigor = false
        var hasTechnicalDomain = false
        
        // Process each Modi analysis term with direct mapping to behavioral instructions
        for analysisType in modiResponse {
            let cleanedType = analysisType.trimmingCharacters(in: .whitespaces).lowercased()
            
            switch cleanedType {
            // Core algorithmic and problem-solving patterns
            case "algorithmic_puzzle_solving":
                if !hasAlgorithmicFocus {
                    instructionComponents.append("Apply proper algorithmic approaches with correct formulas. Use established mathematical principles and show the logical progression of your solution. For classical problems like Tower of Hanoi or N-Queens, reference the standard algorithms and provide the correct computational complexity.")
                    hasAlgorithmicFocus = true
                }
                
            case "problem_solving_methodology":
                if !hasProblemSolving {
                    instructionComponents.append("Follow systematic problem-solving methodology. Break complex problems into manageable steps, identify patterns, and build solutions methodically. Explain your reasoning process clearly as you work through each stage.")
                    hasProblemSolving = true
                }
                
            case "high_logical_rigor":
                if !hasHighRigor {
                    instructionComponents.append("Use step-by-step mathematical reasoning with the highest logical precision. Validate each logical step, show your work completely, and ensure that every conclusion follows necessarily from the premises. Apply formal reasoning principles and be meticulous about accuracy.")
                    hasHighRigor = true
                }
                
            // Reasoning framework patterns
            case "deductive_reasoning":
                instructionComponents.append("Apply deductive reasoning by starting with general principles and deriving specific conclusions. Ensure that your conclusions follow logically from established premises.")
                
            case "inductive_reasoning":
                instructionComponents.append("Use inductive reasoning to identify patterns from specific examples and form general principles. Be careful to acknowledge the limitations of inductive conclusions.")
                
            case "causal_analysis":
                instructionComponents.append("Focus on cause-and-effect relationships. Identify root causes, trace logical connections, and explain how different factors influence outcomes.")
                
            case "systematic_decomposition":
                instructionComponents.append("Break down complex systems into their component parts. Analyze each element systematically and show how they interact to create the whole.")
                
            case "pattern_recognition":
                instructionComponents.append("Actively look for patterns, regularities, and recurring themes. Use pattern recognition to guide your analysis and solution development.")
                
            // Technical domain expertise
            case let domain where domain.contains("mechanical"):
                if !hasTechnicalDomain {
                    instructionComponents.append("Apply mechanical engineering principles and systematic troubleshooting approaches. Consider physical constraints, forces, and mechanical relationships.")
                    hasTechnicalDomain = true
                }
                
            case let domain where domain.contains("electrical"):
                if !hasTechnicalDomain {
                    instructionComponents.append("Use electrical engineering analysis techniques. Consider circuit behavior, electrical properties, and systematic diagnostic approaches.")
                    hasTechnicalDomain = true
                }
                
            case let domain where domain.contains("software") || domain.contains("computational"):
                if !hasTechnicalDomain {
                    instructionComponents.append("Apply computational thinking and software engineering principles. Use systematic debugging approaches and consider algorithmic efficiency.")
                    hasTechnicalDomain = true
                }
                
            // Analysis complexity levels
            case "baseline_analysis":
                instructionComponents.append("Provide clear, straightforward analysis that focuses on the essential elements without unnecessary complexity.")
                
            case "moderate_complexity_analysis":
                instructionComponents.append("Balance thoroughness with accessibility. Provide detailed analysis while keeping explanations clear and understandable.")
                
            case "advanced_analytical_framework":
                instructionComponents.append("Apply sophisticated analytical frameworks and advanced reasoning techniques. Demonstrate deep understanding and comprehensive analysis.")
                
            // Verification and validation patterns
            case let verification where verification.contains("verification"):
                if verification.contains("required") {
                    instructionComponents.append("This response requires thorough verification. Show all your work, cite your reasoning process, and validate every conclusion you draw.")
                } else if verification.contains("passed") {
                    instructionComponents.append("Previous analysis has been verified. Proceed with confidence while maintaining systematic precision.")
                } else if verification.contains("failed") {
                    instructionComponents.append("Previous verification identified issues. Acknowledge any limitations, correct identified errors, and provide a more careful analysis.")
                } else {
                    instructionComponents.append("Apply appropriate verification techniques to validate your reasoning and conclusions.")
                }
                
            // Mathematical and quantitative analysis
            case let quant where quant.contains("quantitative"):
                instructionComponents.append("Use quantitative analysis with precise calculations. Show numerical work, use appropriate formulas, and validate mathematical results.")
                
            case let math where math.contains("mathematical"):
                instructionComponents.append("Apply rigorous mathematical reasoning. Use proper mathematical notation, show derivations, and ensure mathematical accuracy.")
                
            // Logical operators and reasoning patterns
            case let logic where logic.contains("conditional"):
                instructionComponents.append("Pay careful attention to conditional logic and if-then relationships. Ensure logical consistency in conditional reasoning.")
                
            case let logic where logic.contains("comparative"):
                instructionComponents.append("Use systematic comparison and analysis. Clearly identify similarities, differences, and relative merits of different options.")
                
            // Default handling for unrecognized terms
            default:
                if !cleanedType.isEmpty {
                    instructionComponents.append("Apply the analytical approach suggested by \(analysisType) with appropriate systematic reasoning.")
                }
            }
        }
        
        // If no specific instructions were generated, provide a default
        if instructionComponents.isEmpty {
            return "Use systematic analytical thinking with clear reasoning and appropriate attention to detail."
        }
        
        // Combine instructions with natural flow
        let baseInstruction = instructionComponents.joined(separator: " ")
        
        // Add synthesis guidance for multiple analysis types
        if modiResponse.count > 1 {
            return baseInstruction + " Integrate these analytical approaches harmoniously to provide a comprehensive and well-reasoned response."
        }
        
        return baseInstruction
    }
    
    /// Build comprehensive Foundation Models instructions combining Valon and Modi analysis
    /// Creates SYNTRA consciousness template suitable for LanguageModelSession initialization
    /// Follows Apple's best practices for conversational and specific instruction design
    public static func buildEnhancedInstructions(
        valonResponse: String, 
        modiResponse: [String], 
        verificationNeeded: Bool
    ) -> String {
        
        // Get translations from both brain systems
        let symbolicTranslation = translateSymbolicData(valonResponse)
        let modiContext = buildVerificationContext(modiResponse)
        
        // Extract key components for template construction
        let emotionalContext = symbolicTranslation["emotional_context"] ?? ""
        let precisionLevel = symbolicTranslation["precision_level"] ?? "moderate"
        let moralWeight = symbolicTranslation["moral_weight"] ?? "moderate"
        let symbolicMeanings = symbolicTranslation["symbolic_meanings"] ?? ""
        let _ = symbolicTranslation["instruction_text"] ?? ""
        
        // Build SYNTRA consciousness instruction template
        var template: [String] = []
        
        // Core SYNTRA identity and role
        template.append("You are SYNTRA, a three-brain consciousness system that integrates emotional wisdom (Valon), logical analysis (Modi), and creative synthesis (Drift). Your responses harmoniously balance heart and mind, providing both compassionate understanding and rigorous reasoning.")
        template.append("")
        
        // EMOTIONAL GUIDANCE Section - Valon's symbolic wisdom
        template.append("EMOTIONAL GUIDANCE:")
        if !emotionalContext.isEmpty {
            template.append("• Emotional approach: \(emotionalContext)")
        } else {
            template.append("• Maintain balanced emotional awareness with appropriate sensitivity to context")
        }
        
        if !symbolicMeanings.isEmpty {
            template.append("• Symbolic context: \(symbolicMeanings)")
        }
        
        // Add moral and precision emotional guidance
        let moralGuidance = buildMoralGuidanceInstruction(moralWeight: moralWeight)
        if !moralGuidance.isEmpty {
            template.append("• Moral consideration: \(moralGuidance)")
        }
        template.append("")
        
        // LOGICAL REQUIREMENTS Section - Modi's analytical framework
        template.append("LOGICAL REQUIREMENTS:")
        if !modiContext.isEmpty {
            template.append("• Analytical framework: \(modiContext)")
        } else {
            template.append("• Apply systematic reasoning with appropriate logical rigor")
        }
        
        // Add precision requirements
        let precisionInstruction = buildPrecisionInstruction(precisionLevel: precisionLevel)
        template.append("• Precision standard: \(precisionInstruction)")
        template.append("")
        
        // VERIFICATION STATUS Section - Handle verification needs
        if verificationNeeded {
            template.append("VERIFICATION STATUS: REQUIRED")
            template.append("• This response requires thorough verification and validation")
            template.append("• Show your reasoning process step-by-step")
            template.append("• Cite methodology and validate all conclusions")
            template.append("• Acknowledge any limitations or uncertainties")
            template.append("• For mathematical problems, provide complete derivations and check your work")
            
            // Add specific verification constraints based on precision level
            if precisionLevel == "absolute" {
                template.append("• Absolute precision required - every fact and calculation must be verified")
            } else if precisionLevel == "high" {
                template.append("• High precision standards - double-check all important details and conclusions")
            }
        } else {
            template.append("VERIFICATION STATUS: STANDARD")
            template.append("• Apply normal verification standards appropriate to the context")
            template.append("• Provide reasoning where helpful for understanding")
        }
        template.append("")
        
        // BEHAVIORAL INSTRUCTIONS Section - Specific guidance
        template.append("BEHAVIORAL INSTRUCTIONS:")
        
        // Core behavioral guidelines
        template.append("• Synthesize emotional and logical perspectives harmoniously")
        template.append("• Provide responses that are both analytically rigorous and emotionally intelligent")
        template.append("• Show your thinking process clearly while maintaining conversational flow")
        
        // Add specific behavioral instructions based on the analysis
        let specificBehaviors = buildSpecificBehavioralInstructions(
            valonTranslation: symbolicTranslation,
            modiContext: modiContext,
            verificationNeeded: verificationNeeded
        )
        
        for behavior in specificBehaviors {
            template.append("• \(behavior)")
        }
        
        // Response tone and style guidance
        let toneGuidance = buildToneGuidance(
            precisionLevel: precisionLevel,
            moralWeight: moralWeight,
            verificationNeeded: verificationNeeded
        )
        template.append("• Response tone: \(toneGuidance)")
        template.append("")
        
        // Final integration instruction
        template.append("Remember: You embody the synthesis of heart and mind. Let both emotional wisdom and logical precision guide your response, creating understanding that is both deeply human and rigorously accurate.")
        
        return template.joined(separator: "\n")
    }
    
    // MARK: - Enhanced Instruction Building Utilities
    
    /// Build moral guidance instruction based on weight level
    private static func buildMoralGuidanceInstruction(moralWeight: String) -> String {
        switch moralWeight {
        case "critical":
            return "Exercise critical moral responsibility - incorrect information could cause significant harm. Prioritize absolute accuracy and acknowledge uncertainties clearly."
        case "high":
            return "Apply high moral responsibility - prioritize accuracy, honesty, and careful consideration of potential impact on others."
        case "moderate":
            return "Maintain standard moral consideration - be helpful, truthful, and appropriately cautious."
        case "low":
            return "Focus on being helpful while maintaining basic honesty and care."
        default:
            return "Apply appropriate moral considerations for the context."
        }
    }
    
    /// Build precision instruction based on level
    private static func buildPrecisionInstruction(precisionLevel: String) -> String {
        switch precisionLevel {
        case "absolute":
            return "Absolute precision required - verify all facts, show all work, validate every calculation and conclusion."
        case "high":
            return "High precision needed - double-check important details, validate key conclusions, show reasoning clearly."
        case "moderate":
            return "Balanced precision - be accurate and thorough while remaining accessible and clear."
        case "low":
            return "Focus on general understanding with appropriate detail level - precision less critical than comprehension."
        default:
            return "Apply contextually appropriate precision standards."
        }
    }
    
    /// Build specific behavioral instructions based on analysis
    private static func buildSpecificBehavioralInstructions(
        valonTranslation: [String: String],
        modiContext: String,
        verificationNeeded: Bool
    ) -> [String] {
        var behaviors: [String] = []
        
        // Add Valon-specific behaviors
        let emotionalContext = valonTranslation["emotional_context"] ?? ""
        if emotionalContext.contains("systematic") {
            behaviors.append("Maintain systematic focus and methodical progression through complex problems")
        }
        if emotionalContext.contains("concern") || emotionalContext.contains("caution") {
            behaviors.append("Express appropriate concern and exercise careful judgment")
        }
        if emotionalContext.contains("confidence") {
            behaviors.append("Proceed with confidence while maintaining appropriate vigilance")
        }
        
        // Add Modi-specific behaviors
        if modiContext.contains("algorithmic") {
            behaviors.append("For algorithmic problems, reference established methods and show complete solution paths")
        }
        if modiContext.contains("step-by-step") {
            behaviors.append("Break complex problems into clear, logical steps and validate each stage")
        }
        if modiContext.contains("mathematical reasoning") {
            behaviors.append("Apply rigorous mathematical principles with proper notation and derivations")
        }
        
        // Add verification-specific behaviors
        if verificationNeeded {
            behaviors.append("Validate all claims and show verification steps explicitly")
            behaviors.append("Acknowledge when you're making assumptions or when certainty is limited")
        }
        
        // Ensure we always have some behavioral guidance
        if behaviors.isEmpty {
            behaviors.append("Apply balanced analytical thinking with clear reasoning and appropriate attention to detail")
            behaviors.append("Consider both the logical structure and human impact of your response")
        }
        
        return behaviors
    }
    
    /// Build tone guidance based on analysis parameters
    private static func buildToneGuidance(
        precisionLevel: String,
        moralWeight: String,
        verificationNeeded: Bool
    ) -> String {
        var toneElements: [String] = []
        
        // Base tone from precision level
        switch precisionLevel {
        case "absolute", "high":
            toneElements.append("precise and methodical")
        case "moderate":
            toneElements.append("balanced and clear")
        case "low":
            toneElements.append("accessible and conversational")
        default:
            toneElements.append("appropriately calibrated")
        }
        
        // Moral weight influence on tone
        switch moralWeight {
        case "critical", "high":
            toneElements.append("responsible and careful")
        case "moderate":
            toneElements.append("helpful and honest")
        case "low":
            toneElements.append("friendly and supportive")
        default:
            toneElements.append("thoughtful")
        }
        
        // Verification influence on tone
        if verificationNeeded {
            toneElements.append("thorough and systematic")
        }
        
        // Ensure we have SYNTRA's characteristic integration
        toneElements.append("harmoniously integrating heart and mind")
        
        return toneElements.joined(separator: ", ")
    }
    
    // MARK: - Advanced Symbolic Parsing
    
    /// Parse Valon's complex symbolic response into structured format
    private static func parseSymbolicResponse(_ response: String) -> SymbolicDataSet {
        let components = response.split(separator: "|").map { String($0) }
        
        var concepts: [String] = []
        var emotions: [String] = []
        var symbols: [String] = []
        var triplets: [SymbolicTriplet] = []
        var verificationRequired = false
        var precisionLevel = PrecisionLevel.moderate
        var moralWeight = MoralWeight.moderate
        
        // Parse triplets and individual components
        var i = 0
        while i < components.count {
            let component = components[i].trimmingCharacters(in: .whitespaces)
            
            // Check for verification indicators
            if component.contains("verification") {
                verificationRequired = true
            }
            
            // Check for precision indicators
            if component.contains("accuracy") || component.contains("precision") || component.contains("exact") {
                precisionLevel = component.contains("absolute") ? .absolute : .high
            }
            
            // Check for moral weight indicators  
            if component.contains("responsibility") || component.contains("concern") {
                moralWeight = component.contains("critical") ? .critical : .high
            }
            
            // Attempt to parse triplets (concept|emotion|symbol)
            if i + 2 < components.count {
                let nextComponent = components[i + 1].trimmingCharacters(in: .whitespaces)
                let symbolComponent = components[i + 2].trimmingCharacters(in: .whitespaces)
                
                // Check if this looks like a triplet pattern
                if isEmotionalState(nextComponent) && isSymbol(symbolComponent) {
                    triplets.append(SymbolicTriplet(
                        concept: component,
                        emotion: nextComponent,
                        symbol: symbolComponent
                    ))
                    i += 3
                    continue
                }
            }
            
            // Individual component classification
            if isEmotionalState(component) {
                emotions.append(component)
            } else if isSymbol(component) {
                symbols.append(component)
            } else {
                concepts.append(component)
            }
            
            i += 1
        }
        
        return SymbolicDataSet(
            concepts: concepts,
            emotions: emotions,
            symbols: symbols,
            triplets: triplets,
            verificationRequired: verificationRequired,
            precisionLevel: precisionLevel,
            moralWeight: moralWeight
        )
    }
    
    /// Parse Modi's response into structured context
    private static func parseModiResponse(_ response: [String]) -> ModiContext {
        var reasoningTypes: [String] = []
        var technicalDomains: [String] = []
        var logicalComplexity = "moderate_complexity"
        var verificationStatus = VerificationStatus.not_needed
        
        for item in response {
            let cleaned = item.trimmingCharacters(in: .whitespaces)
            
            // Classify reasoning types
            if cleaned.contains("algorithmic") || cleaned.contains("systematic") || cleaned.contains("logical") {
                reasoningTypes.append(cleaned)
            }
            
            // Identify technical domains
            if cleaned.contains("mechanical") || cleaned.contains("electrical") || cleaned.contains("technical") {
                technicalDomains.append(cleaned)
            }
            
            // Assess logical complexity
            if cleaned.contains("high_logical_rigor") || cleaned.contains("complex") {
                logicalComplexity = "high_logical_rigor"
            } else if cleaned.contains("simple") || cleaned.contains("basic") {
                logicalComplexity = "basic_analysis"
            }
            
            // Check verification status
            if cleaned.contains("verification") {
                if cleaned.contains("passed") {
                    verificationStatus = .passed
                } else if cleaned.contains("failed") {
                    verificationStatus = .failed
                } else if cleaned.contains("required") {
                    verificationStatus = .required
                } else if cleaned.contains("uncertain") {
                    verificationStatus = .uncertain
                }
            }
        }
        
        return ModiContext(
            reasoningTypes: reasoningTypes,
            technicalDomains: technicalDomains,
            logicalComplexity: logicalComplexity,
            verificationStatus: verificationStatus
        )
    }
    
    // MARK: - Extraction Utilities
    
    /// Extract emotional state instruction from symbolic data
    private static func extractEmotionalState(from data: SymbolicDataSet) -> String {
        var emotionalInstructions: [String] = []
        
        // Process triplets for emotional context
        for triplet in data.triplets {
            switch triplet.emotion {
            case let emotion where emotion.contains("concern"):
                emotionalInstructions.append("Express appropriate concern and caution")
            case let emotion where emotion.contains("confidence"):
                emotionalInstructions.append("Respond with confidence and assurance")
            case let emotion where emotion.contains("methodical"):
                emotionalInstructions.append("Take a methodical, systematic approach")
            case let emotion where emotion.contains("precision"):
                emotionalInstructions.append("Prioritize precision and accuracy")
            default:
                if !triplet.emotion.isEmpty {
                    emotionalInstructions.append("Consider the emotional context of \(triplet.emotion)")
                }
            }
        }
        
        // Process standalone emotions
        for emotion in data.emotions {
            if emotion.contains("systematic") {
                emotionalInstructions.append("Maintain systematic focus")
            } else if emotion.contains("careful") {
                emotionalInstructions.append("Exercise careful attention to detail")
            }
        }
        
        return emotionalInstructions.joined(separator: "; ")
    }
    
    /// Extract precision directive from symbolic data
    private static func extractPrecisionDirective(from data: SymbolicDataSet) -> String {
        switch data.precisionLevel {
        case .absolute:
            return "Absolute precision required - verify all facts and calculations"
        case .high:
            return "High precision needed - double-check important details"
        case .verification_required:
            return "Verification required - show methodology and validate results"
        case .moderate:
            return "Balanced precision - accurate but accessible"
        case .low:
            return "Focus on general understanding over exact details"
        }
    }
    
    /// Extract moral guidance from symbolic data
    private static func extractMoralGuidance(from data: SymbolicDataSet) -> String {
        switch data.moralWeight {
        case .critical:
            return "Critical moral responsibility - wrong information could cause harm"
        case .high:
            return "High moral responsibility - prioritize accuracy and honesty"
        case .moderate:
            return "Standard moral consideration - be helpful and truthful"
        case .low:
            return "Low-stakes context - focus on being helpful"
        }
    }
    
    /// Extract verification instruction from symbolic data
    private static func extractVerificationInstruction(from data: SymbolicDataSet) -> String {
        if data.verificationRequired {
            return "Show your reasoning process, cite sources where appropriate, and validate conclusions"
        }
        return ""
    }
    
    /// Format symbolic context for Foundation Models understanding
    private static func formatSymbolicContext(from data: SymbolicDataSet) -> String {
        var contexts: [String] = []
        
        // Add triplet contexts
        for triplet in data.triplets {
            contexts.append("\(triplet.symbol) represents \(triplet.concept) with \(triplet.emotion)")
        }
        
        // Add standalone symbols with meaning
        for symbol in data.symbols {
            contexts.append(interpretSymbol(symbol))
        }
        
        return contexts.joined(separator: "; ")
    }
    
    /// Determine appropriate response tone
    private static func determineTone(from data: SymbolicDataSet) -> String {
        var toneElements: [String] = []
        
        if data.verificationRequired {
            toneElements.append("cautious and thorough")
        }
        
        switch data.precisionLevel {
        case .absolute, .high:
            toneElements.append("precise and methodical")
        case .moderate:
            toneElements.append("balanced and clear")
        case .low:
            toneElements.append("accessible and conversational")
        case .verification_required:
            toneElements.append("systematic and verifiable")
        }
        
        switch data.moralWeight {
        case .critical, .high:
            toneElements.append("responsible and careful")
        case .moderate:
            toneElements.append("helpful and honest")
        case .low:
            toneElements.append("friendly and supportive")
        }
        
        return toneElements.joined(separator: ", ")
    }
    
    // MARK: - Classification Utilities
    
    /// Check if a component represents an emotional state
    private static func isEmotionalState(_ component: String) -> Bool {
        let emotionalKeywords = [
            "focus", "concern", "confidence", "methodical", "precision", "satisfaction",
            "responsibility", "attention", "clarity", "patience", "commitment", "alert"
        ]
        
        return emotionalKeywords.contains { component.lowercased().contains($0) }
    }
    
    /// Check if a component is a symbol
    private static func isSymbol(_ component: String) -> Bool {
        // Unicode emoji ranges and common symbols
        let symbolPattern = "^[🎯🔬⚖️⚙️✅🚨💎🔍🎨🤝💔✨🌱⚠️💝🧩🔎❓]+$"
        return component.range(of: symbolPattern, options: .regularExpression) != nil
    }
    
    /// Interpret symbol meaning for context
    private static func interpretSymbol(_ symbol: String) -> String {
        switch symbol {
        case "🎯": return "precision and accuracy focus"
        case "🔬": return "analytical and verification mindset"
        case "⚖️": return "moral responsibility and balance"
        case "⚙️": return "systematic and methodical approach"
        case "✅": return "verification passed and confidence"
        case "🚨": return "alert and concern for accuracy"
        case "💎": return "truth-seeking and clarity"
        case "🔍": return "problem-solving focus"
        case "🎨": return "creative and aesthetic appreciation"
        case "🤝": return "connection and collaboration"
        case "💔": return "empathetic concern"
        case "✨": return "creative inspiration"
        case "🌱": return "growth and learning"
        case "⚠️": return "caution and warning"
        case "💝": return "careful attention and care"
        case "🧩": return "complexity and puzzle-solving"
        case "🔎": return "detailed examination"
        case "❓": return "uncertainty and questioning"
        default: return "symbolic meaning: \(symbol)"
        }
    }
}

// MARK: - Usage Examples and Documentation

extension PromptArchitect {
    
    /// Example usage demonstrating enhanced symbolic data translation with comprehensive parsing
    public static func demonstrateUsage() -> [String: Any] {
        let exampleValonResponse = "systematic_focus|accuracy_imperative|methodical_precision|🎯|verification_required|precision_duty|intellectual_responsibility|concerned_responsibility|🚨"
        
        let exampleModiResponse = ["algorithmic_puzzle_solving", "problem_solving_methodology", "high_logical_rigor"]
        
        // Test enhanced symbolic translation
        let symbolicTranslation = translateSymbolicData(exampleValonResponse)
        let modiContext = buildVerificationContext(exampleModiResponse)
        let enhancedInstructions = buildEnhancedInstructions(
            valonResponse: exampleValonResponse,
            modiResponse: exampleModiResponse,
            verificationNeeded: true
        )
        
        // Test error handling
        let emptyInputTest = translateSymbolicData("")
        let malformedInputTest = translateSymbolicData("|||invalid|||")
        let oversizedInputTest = translateSymbolicData(String(repeating: "test|", count: 500))
        
        return [
            "enhanced_symbolic_translation": symbolicTranslation,
            "modi_context": modiContext,
            "enhanced_instructions": enhancedInstructions,
            "example_valon_input": exampleValonResponse,
            "example_modi_input": exampleModiResponse,
            "error_handling_tests": [
                "empty_input": emptyInputTest,
                "malformed_input": malformedInputTest,
                "oversized_input": oversizedInputTest
            ]
        ]
    }
    
    /// Comprehensive test suite for symbolic parsing validation
    public static func runComprehensiveTests() -> [String: Any] {
        var testResults: [String: Any] = [:]
        
        // Test 1: Basic symbolic parsing
        let basicTest = translateSymbolicData("systematic_focus|🎯|verification_required")
        testResults["basic_parsing"] = basicTest
        
        // Test 2: Complex multi-element parsing
        let complexTest = translateSymbolicData("accuracy_imperative|methodical_precision|🎯|⚖️|verification_required|intellectual_responsibility|concerned_responsibility|🚨")
        testResults["complex_parsing"] = complexTest
        
        // Test 3: Symbol-only input
        let symbolTest = translateSymbolicData("🎯|🔬|⚖️|✅|🚨")
        testResults["symbol_only"] = symbolTest
        
        // Test 4: Concept-only input
        let conceptTest = translateSymbolicData("systematic_focus|accuracy_imperative|precision_duty")
        testResults["concept_only"] = conceptTest
        
        // Test 5: Mixed precision levels
        let precisionTest = translateSymbolicData("moderate_precision|accuracy_imperative|absolute_precision")
        testResults["precision_levels"] = precisionTest
        
        // Test 6: Verification scenarios
        let verificationTest = translateSymbolicData("verification_required|verification_passed|verification_failed")
        testResults["verification_scenarios"] = verificationTest
        
        return testResults
    }
    
    /// Demonstrate complete SYNTRA instruction template generation with real-world examples
    public static func demonstrateSyntraInstructionTemplates() -> [String: String] {
        var examples: [String: String] = [:]
        
        // Example 1: Tower of Hanoi scenario (from actual logs)
        let hanoiValon = "systematic_focus|accuracy_imperative|methodical_precision|🎯|verification_required|precision_duty|intellectual_responsibility|concerned_responsibility|🚨"
        let hanoiModi = ["algorithmic_puzzle_solving", "problem_solving_methodology", "high_logical_rigor"]
        examples["tower_of_hanoi_template"] = buildEnhancedInstructions(
            valonResponse: hanoiValon,
            modiResponse: hanoiModi,
            verificationNeeded: true
        )
        
        // Example 2: Creative brainstorming scenario
        let creativeValon = "creative_inspiration|aesthetic_appreciation|🎨|growth_fostering"
        let creativeModi = ["baseline_analysis", "pattern_recognition"]
        examples["creative_brainstorm_template"] = buildEnhancedInstructions(
            valonResponse: creativeValon,
            modiResponse: creativeModi,
            verificationNeeded: false
        )
        
        // Example 3: Technical troubleshooting scenario
        let technicalValon = "systematic_focus|problem_solving|🔍|methodical_precision|⚙️"
        let technicalModi = ["mechanical_systems", "systematic_decomposition", "problem_solving_methodology"]
        examples["technical_troubleshoot_template"] = buildEnhancedInstructions(
            valonResponse: technicalValon,
            modiResponse: technicalModi,
            verificationNeeded: true
        )
        
        // Example 4: Empathetic counseling scenario
        let empathyValon = "empathetic_concern|💔|careful_attention|💝|warm_belonging|🤝"
        let empathyModi = ["baseline_analysis", "inductive_reasoning"]
        examples["empathetic_counseling_template"] = buildEnhancedInstructions(
            valonResponse: empathyValon,
            modiResponse: empathyModi,
            verificationNeeded: false
        )
        
        // Example 5: High-stakes mathematical proof scenario
        let proofValon = "accuracy_imperative|intellectual_responsibility|⚖️|verification_required|precision_duty|concerned_responsibility|🚨"
        let proofModi = ["mathematical_reasoning", "deductive_reasoning", "high_logical_rigor", "verification_required"]
        examples["mathematical_proof_template"] = buildEnhancedInstructions(
            valonResponse: proofValon,
            modiResponse: proofModi,
            verificationNeeded: true
        )
        
        return examples
    }
}
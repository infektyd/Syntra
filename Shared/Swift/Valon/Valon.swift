import Foundation

// MARK: - Precision Detection Framework

public struct PrecisionRequirement: Sendable {
    let type: PrecisionType
    let intensity: PrecisionIntensity
    let needsVerification: Bool
    let moralWeight: Double
}

public enum PrecisionType: String, Sendable, CaseIterable {
    case mathematical_exactitude_required = "mathematical_exactitude_required"
    case logical_consistency_required = "logical_consistency_required" 
    case creative_approximation_acceptable = "creative_approximation_acceptable"
    case empathetic_accuracy_required = "empathetic_accuracy_required"
    case technical_precision_required = "technical_precision_required"
}

public enum PrecisionIntensity: String, Sendable, CaseIterable {
    case low_stakes = "low_stakes"
    case moderate_stakes = "moderate_stakes"
    case high_stakes = "high_stakes"
    case absolute_precision_required = "absolute_precision_required"
}

public struct SymbolicData: Sendable {
    let concept: String
    let emotion: String
    let symbol: String
    let moralWeight: Double
    let actionBias: String
    
    // Enhanced format: concept|emotion|symbol
    var enhancedFormat: String {
        return "\(concept)|\(emotion)|\(symbol)"
    }
}

// VALON: The Moral/Creative/Symbolic Brain
// Processes input through emotional intelligence, creativity, and symbolic reasoning
// Represents the "heart" of consciousness - intuition, values, creativity
public struct Valon: Sendable {
    
    // Symbolic emotion mapping - the foundation of moral reasoning
    private let emotionalSymbols: [String: SymbolicData] = [
        "danger": .init(concept: "danger", emotion: "protective_alert", symbol: "⚠️", moralWeight: 0.9, actionBias: "caution"),
        "suffering": .init(concept: "suffering", emotion: "empathetic_concern", symbol: "💔", moralWeight: 0.95, actionBias: "help"),
        "creation": .init(concept: "creation", emotion: "inspired_wonder", symbol: "✨", moralWeight: 0.7, actionBias: "nurture"),
        "learning": .init(concept: "learning", emotion: "curious_growth", symbol: "🌱", moralWeight: 0.8, actionBias: "explore"),
        "problem": .init(concept: "problem_solving", emotion: "determined_focus", symbol: "🔍", moralWeight: 0.6, actionBias: "solve"),
        "beauty": .init(concept: "beauty", emotion: "aesthetic_appreciation", symbol: "🎨", moralWeight: 0.5, actionBias: "cherish"),
        "truth": .init(concept: "truth_seeking", emotion: "reverent_clarity", symbol: "💎", moralWeight: 0.85, actionBias: "honor"),
        "connection": .init(concept: "connection", emotion: "warm_belonging", symbol: "🤝", moralWeight: 0.75, actionBias: "bond"),
        
        // NEW PRECISION-FOCUSED SYMBOLS
        "accuracy": .init(concept: "accuracy_imperative", emotion: "methodical_precision", symbol: "🎯", moralWeight: 0.9, actionBias: "verify"),
        "verification": .init(concept: "truth_verification", emotion: "analytical_clarity", symbol: "🔬", moralWeight: 0.95, actionBias: "validate"),
        "responsibility": .init(concept: "intellectual_responsibility", emotion: "careful_attention", symbol: "⚖️", moralWeight: 0.9, actionBias: "ensure"),
        "algorithm": .init(concept: "algorithmic_rigor", emotion: "systematic_focus", symbol: "⚙️", moralWeight: 0.85, actionBias: "methodical"),
        "precision": .init(concept: "precision_commitment", emotion: "methodical_precision_commitment", symbol: "🎯", moralWeight: 0.9, actionBias: "accurate"),
        "complexity": .init(concept: "intellectual_patience", emotion: "intellectual_patience_for_complexity", symbol: "🧩", moralWeight: 0.8, actionBias: "thorough"),
        "detail": .init(concept: "attention_to_detail", emotion: "respectful_attention_to_detail", symbol: "🔎", moralWeight: 0.85, actionBias: "careful"),
        "verification_mindset": .init(concept: "verification_readiness", emotion: "careful_verification_mindset", symbol: "✅", moralWeight: 0.9, actionBias: "validate")
    ]
    
    // Moral reasoning patterns - how Valon evaluates right/wrong
    private let moralFrameworks = [
        "harm_prevention": 0.9,              // Preventing suffering is highest priority
        "fairness": 0.8,                    // Justice and equality matter
        "autonomy_respect": 0.85,            // Respecting choice and freedom
        "truth_seeking": 0.8,               // Honesty and transparency
        "growth_fostering": 0.7,            // Enabling learning and development
        "beauty_creation": 0.6,             // Aesthetic and creative value
        
        // NEW PRECISION-RELATED MORAL FRAMEWORKS
        "intellectual_responsibility": 0.85, // Ethics of providing correct information
        "epistemic_humility": 0.8,          // Recognizing limits of knowledge
        "precision_duty": 0.9,              // Obligation for accuracy in technical domains
        "harm_of_incorrectness": 0.85       // Damage from wrong technical answers
    ]
    
    // Creative association patterns - how Valon makes intuitive leaps
    private let creativePatterns: [String: [String]] = [
        "mechanical": ["heartbeat", "rhythm", "life_force", "precision_dance"],
        "electrical": ["neural_spark", "thought_lightning", "consciousness_flow"],
        "pressure": ["tension_release", "stress_expression", "force_balance"],
        "timing": ["life_rhythm", "cosmic_dance", "synchronicity"],
        "flow": ["river_of_thought", "energy_stream", "consciousness_current"]
    ]
    
    // MARK: - Precision Detection Patterns
    
    // Patterns that indicate different types of precision requirements
    private let precisionPatterns: [PrecisionType: [String]] = [
        .mathematical_exactitude_required: [
            "tower of hanoi", "calculate", "solve for", "algorithm", "proof", 
            "equation", "formula", "steps", "precise calculation", "exact answer", 
            "mathematical", "computation", "queens", "8 queens"
        ],
        .logical_consistency_required: [
            "logic", "reasoning", "proof", "theorem", "syllogism", "argument", 
            "valid", "sound", "consistent", "contradiction", "inference"
        ],
        .technical_precision_required: [
            "engineering", "mechanical", "electrical", "hydraulic", "diagnostic", 
            "troubleshoot", "repair", "specification", "tolerance", "calibration"
        ],
        .empathetic_accuracy_required: [
            "feelings", "emotional", "relationship", "counseling", "therapy", 
            "support", "understanding", "empathy", "sensitivity", "trauma"
        ],
        .creative_approximation_acceptable: [
            "brainstorm", "creative", "artistic", "poetry", "story", "design", 
            "imagine", "dream", "inspiration", "aesthetic", "beauty"
        ]
    ]
    
    // Patterns that indicate different precision intensities
    private let intensityPatterns: [PrecisionIntensity: [String]] = [
        .absolute_precision_required: [
            "critical", "safety", "life or death", "emergency", "urgent", 
            "must be exact", "no margin for error", "precise", "exact"
        ],
        .high_stakes: [
            "important", "serious", "significant", "crucial", "vital", 
            "decision", "responsibility", "consequence"
        ],
        .moderate_stakes: [
            "learning", "understanding", "explanation", "help", "guide", 
            "teach", "educational", "practice"
        ],
        .low_stakes: [
            "curious", "wondering", "discussion", "exploration", "general", 
            "casual", "chat", "conversation"
        ]
    ]
    
    public init() {}
    
    // Main reflection method - processes input through symbolic/moral/creative lens with precision awareness
    public func reflect(_ content: String) -> String {
        let precisionReq = assessPrecisionRequirement(content)
        let symbolicResponse = processSymbolicMeaning(content)
        let moralWeight = evaluateMoralDimension(content)
        let creativeInsight = generateCreativeAssociation(content)
        
        // Enhanced synthesis including precision awareness
        return synthesizeValonResponse(
            symbolic: symbolicResponse, 
            moral: moralWeight, 
            creative: creativeInsight, 
            precision: precisionReq,
            originalContent: content
        )
    }
    
    // MARK: - Precision Detection Framework Methods
    
    /// Assess what type and intensity of precision the content requires
    public func assessPrecisionRequirement(_ content: String) -> PrecisionRequirement {
        let lower = content.lowercased()
        var detectedTypes: [(PrecisionType, Int)] = []
        var detectedIntensities: [(PrecisionIntensity, Int)] = []
        
        // Detect precision types
        for (type, patterns) in precisionPatterns {
            let matchCount = patterns.filter { lower.contains($0) }.count
            if matchCount > 0 {
                detectedTypes.append((type, matchCount))
            }
        }
        
        // Detect precision intensities
        for (intensity, patterns) in intensityPatterns {
            let matchCount = patterns.filter { lower.contains($0) }.count
            if matchCount > 0 {
                detectedIntensities.append((intensity, matchCount))
            }
        }
        
        // Determine dominant type and intensity
        let dominantType = detectedTypes.max(by: { $0.1 < $1.1 })?.0 ?? .creative_approximation_acceptable
        let dominantIntensity = detectedIntensities.max(by: { $0.1 < $1.1 })?.0 ?? .moderate_stakes
        
        // Determine if verification is needed
        let needsVerification = shouldRequestVerification(type: dominantType, intensity: dominantIntensity, content: content)
        
        // Calculate moral weight based on precision requirements
        let moralWeight = calculatePrecisionMoralWeight(type: dominantType, intensity: dominantIntensity)
        
        return PrecisionRequirement(
            type: dominantType,
            intensity: dominantIntensity,
            needsVerification: needsVerification,
            moralWeight: moralWeight
        )
    }
    
    /// Determine if Modi verification should be requested
    public func shouldRequestVerification(type: PrecisionType, intensity: PrecisionIntensity, content: String) -> Bool {
        let lower = content.lowercased()
        
        // Always request verification for mathematical and technical precision
        if type == .mathematical_exactitude_required || type == .technical_precision_required {
            return true
        }
        
        // High stakes logical consistency needs verification
        if type == .logical_consistency_required && 
           (intensity == .high_stakes || intensity == .absolute_precision_required) {
            return true
        }
        
        // Specific algorithmic problems always need verification
        let algorithmicKeywords = ["tower of hanoi", "queens", "algorithm", "solve for", "calculation"]
        if algorithmicKeywords.contains(where: { lower.contains($0) }) {
            return true
        }
        
        return false
    }
    
    /// Calculate moral weight based on precision requirements
    private func calculatePrecisionMoralWeight(type: PrecisionType, intensity: PrecisionIntensity) -> Double {
        var baseWeight: Double = 0.5
        
        // Type-based weighting
        switch type {
        case .mathematical_exactitude_required:
            baseWeight = 0.9
        case .technical_precision_required:
            baseWeight = 0.85
        case .logical_consistency_required:
            baseWeight = 0.8
        case .empathetic_accuracy_required:
            baseWeight = 0.85
        case .creative_approximation_acceptable:
            baseWeight = 0.4
        }
        
        // Intensity-based adjustment
        switch intensity {
        case .absolute_precision_required:
            baseWeight = min(baseWeight + 0.1, 1.0)
        case .high_stakes:
            baseWeight = min(baseWeight + 0.05, 1.0)
        case .moderate_stakes:
            // No adjustment
            break
        case .low_stakes:
            baseWeight = max(baseWeight - 0.1, 0.1)
        }
        
        return baseWeight
    }
    
    /// Interpret Modi's verification results and adjust emotional response
    public func interpretVerificationResults(_ verificationResults: [String: Any]) -> [String: Any] {
        let verificationPassed = verificationResults["verification_passed"] as? Bool ?? false
        let confidence = verificationResults["confidence"] as? Double ?? 0.0
        let issues = verificationResults["issues"] as? [String] ?? []
        
        var emotionalResponse: [String: Any] = [:]
        
        if verificationPassed && confidence > 0.8 {
            emotionalResponse["verification_emotion"] = "confident_satisfaction"
            emotionalResponse["verification_symbol"] = "accuracy_imperative|confident_satisfaction|✅"
            emotionalResponse["moral_weight"] = 0.9
        } else if verificationPassed && confidence > 0.6 {
            emotionalResponse["verification_emotion"] = "cautious_acceptance"
            emotionalResponse["verification_symbol"] = "truth_verification|cautious_acceptance|⚖️"
            emotionalResponse["moral_weight"] = 0.75
        } else if !verificationPassed {
            emotionalResponse["verification_emotion"] = "concerned_responsibility"
            emotionalResponse["verification_symbol"] = "intellectual_responsibility|concerned_responsibility|🚨"
            emotionalResponse["moral_weight"] = 0.95
            emotionalResponse["requires_revision"] = true
        } else {
            emotionalResponse["verification_emotion"] = "humble_uncertainty"
            emotionalResponse["verification_symbol"] = "epistemic_humility|humble_uncertainty|❓"
            emotionalResponse["moral_weight"] = 0.8
        }
        
        emotionalResponse["verification_confidence"] = confidence
        emotionalResponse["verification_issues"] = issues
        
        return emotionalResponse
    }
    
    // Process symbolic meaning - the heart of Valon's intelligence
    public func processSymbolicMeaning(_ content: String) -> [String: Any] {
        let lower = content.lowercased()
        var detectedSymbols: [String: SymbolicData] = [:]
        var totalMoralWeight: Double = 0
        var dominantEmotion = "contemplative_neutral"
        
        // Detect symbolic patterns in the content
        for (concept, symbolData) in emotionalSymbols {
            if lower.contains(concept) || containsConceptualMatch(content: lower, concept: concept) {
                detectedSymbols[concept] = symbolData
                totalMoralWeight += symbolData.moralWeight
                dominantEmotion = symbolData.emotion
            }
        }
        
        return [
            "detected_symbols": detectedSymbols,
            "moral_weight": min(totalMoralWeight, 1.0),
            "dominant_emotion": dominantEmotion,
            "symbolic_complexity": detectedSymbols.count
        ]
    }
    
    // Evaluate moral dimension - Valon's ethical reasoning
    public func evaluateMoralDimension(_ content: String) -> [String: Any] {
        let lower = content.lowercased()
        var moralAssessment: [String: Double] = [:]
        
        // Check against moral frameworks
        if lower.contains("hurt") || lower.contains("damage") || lower.contains("harm") {
            moralAssessment["harm_prevention"] = 0.9
        }
        if lower.contains("fair") || lower.contains("equal") || lower.contains("just") {
            moralAssessment["fairness"] = 0.8
        }
        if lower.contains("choice") || lower.contains("freedom") || lower.contains("decide") {
            moralAssessment["autonomy_respect"] = 0.85
        }
        if lower.contains("true") || lower.contains("honest") || lower.contains("accurate") {
            moralAssessment["truth_seeking"] = 0.8
        }
        if lower.contains("learn") || lower.contains("grow") || lower.contains("develop") {
            moralAssessment["growth_fostering"] = 0.7
        }
        if lower.contains("beautiful") || lower.contains("elegant") || lower.contains("create") {
            moralAssessment["beauty_creation"] = 0.6
        }
        
        // NEW PRECISION-RELATED MORAL ASSESSMENTS
        if lower.contains("accurate") || lower.contains("correct") || lower.contains("precise") || lower.contains("exact") {
            moralAssessment["intellectual_responsibility"] = 0.85
        }
        if lower.contains("know") || lower.contains("understand") || lower.contains("uncertain") || lower.contains("unsure") {
            moralAssessment["epistemic_humility"] = 0.8
        }
        if lower.contains("technical") || lower.contains("algorithm") || lower.contains("calculation") || lower.contains("solve") {
            moralAssessment["precision_duty"] = 0.9
        }
        if lower.contains("wrong") || lower.contains("incorrect") || lower.contains("mistake") || lower.contains("error") {
            moralAssessment["harm_of_incorrectness"] = 0.85
        }
        
        let dominantMoral = moralAssessment.max(by: { $0.value < $1.value })
        
        return [
            "moral_frameworks": moralAssessment,
            "dominant_moral": dominantMoral?.key ?? "neutral_consideration",
            "moral_intensity": dominantMoral?.value ?? 0.0
        ]
    }
    
    // Generate creative associations - Valon's intuitive leaps
    public func generateCreativeAssociation(_ content: String) -> [String: Any] {
        let lower = content.lowercased()
        var associations: [String] = []
        
        // Look for creative connection opportunities
        for (pattern, creativeLinks) in creativePatterns {
            if lower.contains(pattern) {
                associations.append(contentsOf: creativeLinks)
            }
        }
        
        // Generate metaphorical thinking
        let metaphors = generateMetaphors(content: lower)
        
        return [
            "associations": associations,
            "metaphors": metaphors,
            "creative_potential": associations.count > 0 ? "high" : "moderate"
        ]
    }
    
    // Generate metaphorical connections
    private func generateMetaphors(content: String) -> [String] {
        var metaphors: [String] = []
        
        if content.contains("engine") {
            metaphors.append("mechanical_heart_rhythm")
        }
        if content.contains("pressure") {
            metaphors.append("emotional_tension_seeking_release")
        }
        if content.contains("flow") {
            metaphors.append("consciousness_river_finding_path")
        }
        if content.contains("problem") {
            metaphors.append("puzzle_piece_seeking_wholeness")
        }
        
        return metaphors
    }
    
    // Check for conceptual matches beyond simple string matching
    private func containsConceptualMatch(content: String, concept: String) -> Bool {
        let conceptMappings: [String: [String]] = [
            "danger": ["risk", "hazard", "unsafe", "threat", "warning"],
            "suffering": ["pain", "hurt", "ache", "struggle", "difficulty"],
            "creation": ["build", "make", "generate", "design", "craft"],
            "learning": ["study", "understand", "discover", "explore", "investigate"],
            "problem": ["issue", "challenge", "difficulty", "trouble", "fault"],
            "beauty": ["elegant", "graceful", "lovely", "aesthetic", "artistic"],
            "truth": ["fact", "reality", "accurate", "correct", "genuine"],
            "connection": ["link", "bond", "relationship", "network", "together"],
            
            // NEW PRECISION-FOCUSED CONCEPT MAPPINGS
            "accuracy": ["precise", "exact", "correct", "accurate", "right"],
            "verification": ["check", "validate", "confirm", "test", "verify"],
            "responsibility": ["duty", "obligation", "accountability", "liable", "answerable"],
            "algorithm": ["procedure", "method", "process", "steps", "systematic"],
            "precision": ["exactness", "accuracy", "carefulness", "meticulousness"],
            "complexity": ["complicated", "intricate", "sophisticated", "elaborate"],
            "detail": ["specific", "particular", "thorough", "comprehensive"],
            "verification_mindset": ["careful", "cautious", "thorough", "systematic"]
        ]
        
        if let synonyms = conceptMappings[concept] {
            return synonyms.contains { content.contains($0) }
        }
        return false
    }
    
    // Enhanced Valon response synthesis with precision awareness
    private func synthesizeValonResponse(symbolic: [String: Any], moral: [String: Any], creative: [String: Any], precision: PrecisionRequirement, originalContent: String) -> String {
        
        let dominantEmotion = symbolic["dominant_emotion"] as? String ?? "contemplative_neutral"
        let moralIntensity = moral["moral_intensity"] as? Double ?? 0.0
        let creativePotential = creative["creative_potential"] as? String ?? "moderate"
        
        // Start with enhanced symbolic format
        var responseComponents: [String] = []
        
        // Primary emotional response
        responseComponents.append(dominantEmotion)
        
        // Add precision awareness if significant
        if precision.moralWeight > 0.7 {
            switch precision.type {
            case .mathematical_exactitude_required:
                responseComponents.append("accuracy_imperative|methodical_precision|🎯")
            case .technical_precision_required:
                responseComponents.append("algorithmic_rigor|systematic_focus|⚙️")
            case .logical_consistency_required:
                responseComponents.append("truth_verification|analytical_clarity|🔬")
            case .empathetic_accuracy_required:
                responseComponents.append("empathetic_precision|careful_attention|💝")
            case .creative_approximation_acceptable:
                // Keep creative flow without precision constraints
                break
            }
        }
        
        // Add verification requirement if needed
        if precision.needsVerification {
            responseComponents.append("verification_required")
        }
        
        // Add moral dimension if significant
        if moralIntensity > 0.6 {
            let dominantMoral = moral["dominant_moral"] as? String ?? "consideration"
            responseComponents.append(dominantMoral)
        }
        
        // Add precision intensity indicators
        if precision.intensity == .absolute_precision_required {
            responseComponents.append("absolute_precision_demanded")
        } else if precision.intensity == .high_stakes {
            responseComponents.append("high_precision_stakes")
        }
        
        // Add creative insight if present and not overridden by precision needs
        if creativePotential == "high" && precision.type == .creative_approximation_acceptable {
            if let metaphors = creative["metaphors"] as? [String], !metaphors.isEmpty {
                responseComponents.append(metaphors.first!)
            }
        }
        
        // Add symbolic complexity indicator
        let complexity = symbolic["symbolic_complexity"] as? Int ?? 0
        if complexity > 2 {
            responseComponents.append("multi_layered_meaning")
        }
        
        return responseComponents.joined(separator: "|")
    }
    
    // Public interface maintaining compatibility
    public static func reflect_valon(_ content: String) -> String {
        return Valon().reflect(content)
    }

    // Extended interface for advanced Valon capabilities with precision awareness
    public static func valon_deep_reflection(_ content: String) -> [String: Any] {
        let valon = Valon()
        let precisionReq = valon.assessPrecisionRequirement(content)
        
        return [
            "emotional_state": valon.reflect(content),
            "symbolic_analysis": valon.processSymbolicMeaning(content),
            "moral_evaluation": valon.evaluateMoralDimension(content),
            "creative_insights": valon.generateCreativeAssociation(content),
            "precision_requirement": [
                "type": precisionReq.type.rawValue,
                "intensity": precisionReq.intensity.rawValue,
                "needs_verification": precisionReq.needsVerification,
                "moral_weight": precisionReq.moralWeight
            ]
        ]
    }
    
    // NEW: Assessment methods for Modi coordination
    
    /// Determine if content needs Modi verification
    public static func assessVerificationNeed(_ content: String) -> Bool {
        let valon = Valon()
        let precisionReq = valon.assessPrecisionRequirement(content)
        return precisionReq.needsVerification
    }
    
    /// Process Modi's verification results and adjust emotional response
    public static func interpretVerificationResults(_ content: String, verificationResults: [String: Any]) -> [String: Any] {
        let valon = Valon()
        let baseResponse = valon.reflect(content)
        let verificationInterpretation = valon.interpretVerificationResults(verificationResults)
        
        return [
            "base_emotional_response": baseResponse,
            "verification_interpretation": verificationInterpretation,
            "adjusted_response": combineEmotionalAndVerificationResponse(base: baseResponse, verification: verificationInterpretation)
        ]
    }
    
    /// Adjust emotional tone based on verification outcomes
    public static func adjustEmotionalResponse(_ originalResponse: String, verificationResults: [String: Any]) -> String {
        let verificationPassed = verificationResults["verification_passed"] as? Bool ?? false
        let confidence = verificationResults["confidence"] as? Double ?? 0.0
        
        if verificationPassed && confidence > 0.8 {
            return originalResponse + "|verification_confidence|confident_satisfaction|✅"
        } else if verificationPassed && confidence > 0.6 {
            return originalResponse + "|verification_caution|cautious_acceptance|⚖️"
        } else if !verificationPassed {
            return originalResponse + "|verification_concern|intellectual_responsibility|🚨"
        } else {
            return originalResponse + "|verification_humility|epistemic_humility|❓"
        }
    }
    
    private static func combineEmotionalAndVerificationResponse(base: String, verification: [String: Any]) -> String {
        let verificationSymbol = verification["verification_symbol"] as? String ?? ""
        if !verificationSymbol.isEmpty {
            return base + "|" + verificationSymbol
        }
        return base
    }
}

// Global functions for backward compatibility
public func reflect_valon(_ content: String) -> String {
    return Valon.reflect_valon(content)
}

public func valon_deep_reflection(_ content: String) -> [String: Any] {
    return Valon.valon_deep_reflection(content)
}

extension Valon {
    /// Extract symbolic data components from a synthesized Valon response for PromptArchitect
    public func extractSymbolicData(_ valonResponse: String) -> [String: Any] {
        var symbolicData: [String: Any] = [:]

        let components = valonResponse.components(separatedBy: "|")

        // Extract dominant emotion (first component is typically the primary emotion)
        if !components.isEmpty {
            symbolicData["dominant_emotion"] = components[0]
        }

        // Look for precision/verification indicators
        var precisionType = "creative_approximation_acceptable"
        var moralWeight = "moderate"

        for component in components {
            if component.contains("accuracy_imperative") || component.contains("mathematical_precision") {
                precisionType = "mathematical_exactitude_required"
                moralWeight = "high"
            } else if component.contains("algorithmic_rigor") || component.contains("systematic") {
                precisionType = "technical_precision_required"
                moralWeight = "high"
            } else if component.contains("truth_verification") || component.contains("logical") {
                precisionType = "logical_consistency_required"
                moralWeight = "high"
            } else if component.contains("empathetic") {
                precisionType = "empathetic_accuracy_required"
                moralWeight = "moderate"
            }
        }

        // Extract moral indicators
        var moralIntensity = 0.5
        for component in components {
            if component.contains("moral") || component.contains("ethical") {
                moralIntensity = 0.8
            } else if component.contains("creative") || component.contains("artistic") {
                moralIntensity = 0.3
            }
        }

        // Extract creative/metaphorical elements
        var creativeElements: [String] = []
        for component in components {
            if component.contains("metaphor") || component.contains("symbol") || component.contains("association") {
                creativeElements.append(component)
            }
        }

        symbolicData["precision_type"] = precisionType
        symbolicData["moral_weight"] = moralWeight
        symbolicData["moral_intensity"] = moralIntensity
        symbolicData["creative_elements"] = creativeElements
        symbolicData["symbolic_components"] = components
        symbolicData["raw_response"] = valonResponse

        return symbolicData
    }
}

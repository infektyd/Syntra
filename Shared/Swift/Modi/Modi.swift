import Foundation
import FoundationModels
import Numerics
import Algorithms

public struct ReasoningFrameworkData: Sendable {
    let patterns: [String]
    let strength: Double
    let type: String
    let probabilityDistribution: [String: Double]?
}

public struct TechnicalDomainData: Sendable {
    let keywords: [String]
    let reasoningType: String
    let confidence: Double
    let minConfidence: Double
    let maxConfidence: Double
    let patternCount: Int
}

public struct QuantitativeAnalysisResult: Sendable {
    public let minValue: Double
    public let maxValue: Double
    public let count: Int
    public let average: Double
    public let standardDeviation: Double
    public let entropy: Double
}

public struct ProbabilityDistribution: Sendable {
    public let domain: String
    public let probabilities: [String: Double]
    public let entropy: Double
    public let prior: [String: Double]
    public let posterior: [String: Double]
    public let likelihood: [String: Double]
    
    public init(domain: String, probabilities: [String: Double], entropy: Double, prior: [String: Double], posterior: [String: Double], likelihood: [String: Double]) {
        self.domain = domain
        self.probabilities = probabilities
        self.entropy = entropy
        self.prior = prior
        self.posterior = posterior
        self.likelihood = likelihood
    }
}

public struct AlgorithmicPrinciple: Sendable {
    let indicators: [String]
    let validates: @Sendable (String) -> Bool
    let importance: Double
    let confidenceBoost: Double
    let description: String

    public init(indicators: [String], validates: @escaping @Sendable (String) -> Bool, importance: Double, confidenceBoost: Double, description: String) {
        self.indicators = indicators
        self.validates = validates
        self.importance = importance
        self.confidenceBoost = confidenceBoost
        self.description = description
    }
}

// MODI: The Logical/Rational/Analytical Brain
// Processes input through systematic reasoning, logical frameworks, and analytical patterns
// Represents the "mind" of consciousness - logic, analysis, systematic thinking
public struct Modi: Sendable {
    
    // Logical reasoning frameworks - the foundation of rational analysis
    private let reasoningFrameworks: [String: ReasoningFrameworkData] = [
        "causal_analysis": .init(patterns: ["cause", "effect", "because", "therefore", "leads to", "results in"], strength: 0.9, type: "causal_reasoning", probabilityDistribution: nil),
        "conditional_logic": .init(patterns: ["if", "then", "when", "unless", "provided", "assuming"], strength: 0.85, type: "conditional_reasoning", probabilityDistribution: nil),
        "comparative_analysis": .init(patterns: ["compare", "versus", "better", "worse", "more", "less", "than"], strength: 0.8, type: "comparative_reasoning", probabilityDistribution: nil),
        "systematic_decomposition": .init(patterns: ["system", "component", "part", "element", "structure", "hierarchy"], strength: 0.85, type: "systems_thinking", probabilityDistribution: nil),
        "quantitative_analysis": .init(patterns: ["measure", "calculate", "precise", "exact", "percentage", "ratio"], strength: 0.9, type: "quantitative_reasoning", probabilityDistribution: nil),
        "pattern_recognition": .init(patterns: ["pattern", "trend", "cycle", "recurring", "consistent", "anomaly"], strength: 0.8, type: "pattern_analysis", probabilityDistribution: nil),
        "algorithmic_puzzle_solving": .init(patterns: ["puzzle", "solve", "find a solution for", "algorithm", "queens"], strength: 0.9, type: "constraint_satisfaction", probabilityDistribution: nil)
    ]
    
    // Technical domain expertise - Modi's specialized knowledge areas
    private let technicalDomains: [String: TechnicalDomainData] = [
        "mechanical_systems": .init(keywords: ["torque", "pressure", "rpm", "vibration", "bearing", "seal", "gasket"], reasoningType: "mechanical_analysis", confidence: 0.9, minConfidence: 0.7, maxConfidence: 1.0, patternCount: 7),
        "electrical_systems": .init(keywords: ["voltage", "current", "resistance", "circuit", "ground", "short", "open"], reasoningType: "electrical_analysis", confidence: 0.85, minConfidence: 0.6, maxConfidence: 0.95, patternCount: 7),
        "hydraulic_systems": .init(keywords: ["flow", "pressure", "valve", "pump", "cylinder", "accumulator"], reasoningType: "hydraulic_analysis", confidence: 0.8, minConfidence: 0.5, maxConfidence: 0.9, patternCount: 6),
        "diagnostic_procedures": .init(keywords: ["test", "check", "verify", "measure", "inspect", "troubleshoot"], reasoningType: "diagnostic_reasoning", confidence: 0.9, minConfidence: 0.7, maxConfidence: 1.0, patternCount: 6),
        "safety_protocols": .init(keywords: ["safety", "hazard", "protection", "warning", "procedure", "protocol"], reasoningType: "safety_analysis", confidence: 0.95, minConfidence: 0.8, maxConfidence: 1.0, patternCount: 6)
    ]
    
    // Logical operators and their relationships
    private let logicalOperators: [String: Double] = [
        "and": 0.8,      // Conjunction - both conditions must be true
        "or": 0.7,       // Disjunction - either condition can be true
        "not": 0.9,      // Negation - inverse logic
        "xor": 0.6,      // Exclusive or - only one condition true
        "implies": 0.85, // Implication - if A then B
        "iff": 0.9       // If and only if - bidirectional implication
    ]

    // Core reasoning principles - consciousness-aligned verification patterns
    private let algorithmicPrinciples: [String: AlgorithmicPrinciple] = [
        "recursive_thinking": AlgorithmicPrinciple(
            indicators: ["recursive", "recursion", "base case", "recursive call", "divide and conquer", "smaller subproblem"],
            validates: { solution in
                let lower = solution.lowercased()
                return (lower.contains("recursive") || lower.contains("recursion")) &&
                       (lower.contains("base") || lower.contains("stop") || lower.contains("terminal"))
            },
            importance: 0.9,
            confidenceBoost: 0.3,
            description: "Detects and validates recursive problem-solving approaches"
        ),
        "step_by_step_reasoning": AlgorithmicPrinciple(
            indicators: ["step", "first", "then", "next", "sequence", "systematic", "methodical", "procedure"],
            validates: { solution in
                let lower = solution.lowercased()
                let stepIndicators = ["step", "first", "then", "next", "procedure", "systematic"]
                let matchCount = stepIndicators.filter { lower.contains($0) }.count
                return matchCount >= 2
            },
            importance: 0.85,
            confidenceBoost: 0.25,
            description: "Validates systematic, sequential thinking and methodical approaches"
        ),
        "mathematical_precision": AlgorithmicPrinciple(
            indicators: ["formula", "equation", "calculate", "result", "number", "precise", "exact", "mathematical"],
            validates: { solution in
                let lower = solution.lowercased()
                let hasFormula = lower.contains("formula") || lower.contains("equation")
                let hasCalculation = lower.contains("calculate") || lower.contains("result")
                let hasNumbers = solution.range(of: #"\d+"#, options: .regularExpression) != nil
                return hasNumbers && (hasFormula || hasCalculation)
            },
            importance: 0.9,
            confidenceBoost: 0.35,
            description: "Ensures numerical accuracy and proper formula usage in mathematical contexts"
        ),
        "logical_consistency": AlgorithmicPrinciple(
            indicators: ["because", "therefore", "thus", "hence", "consequently", "reasoning", "logic", "conclusion"],
            validates: { solution in
                let lower = solution.lowercased()
                let logicalConnectors = ["because", "therefore", "thus", "hence", "consequently"]
                let reasoningWords = ["reasoning", "logic", "conclusion", "follows"]
                let connectorCount = logicalConnectors.filter { lower.contains($0) }.count
                let reasoningCount = reasoningWords.filter { lower.contains($0) }.count
                return connectorCount >= 1 && reasoningCount >= 1
            },
            importance: 0.8,
            confidenceBoost: 0.2,
            description: "Checks for logical coherence, absence of contradictions, and sound reasoning chains"
        ),
        "constraint_satisfaction": AlgorithmicPrinciple(
            indicators: ["constraint", "rule", "limitation", "condition", "requirement", "satisfy", "valid", "legal"],
            validates: { solution in
                let lower = solution.lowercased()
                let constraintWords = ["constraint", "rule", "limitation", "condition", "requirement"]
                let satisfactionWords = ["satisfy", "valid", "legal", "allowed", "permitted"]
                let constraintCount = constraintWords.filter { lower.contains($0) }.count
                let satisfactionCount = satisfactionWords.filter { lower.contains($0) }.count
                return constraintCount >= 1 && satisfactionCount >= 1
            },
            importance: 0.85,
            confidenceBoost: 0.3,
            description: "Handles problems with explicit rules, constraints, and validation requirements"
        ),
        "algorithmic_search": AlgorithmicPrinciple(
            indicators: ["search", "explore", "try", "attempt", "backtrack", "find", "discover", "solution space"],
            validates: { solution in
                let lower = solution.lowercased()
                let searchWords = ["search", "explore", "try", "attempt", "backtrack"]
                let discoveryWords = ["find", "discover", "solution", "answer"]
                let searchCount = searchWords.filter { lower.contains($0) }.count
                let discoveryCount = discoveryWords.filter { lower.contains($0) }.count
                return searchCount >= 1 && discoveryCount >= 1
            },
            importance: 0.8,
            confidenceBoost: 0.25,
            description: "Validates search strategies, exploration methods, and solution discovery approaches"
        )
    ]
    
    public init() {}
    
    // Calculate domain probabilities using Bayesian inference
    public func calculateDomainProbabilities(_ content: String) -> ProbabilityDistribution {
        let lower = content.lowercased()
        var domainProbabilities: [String: Double] = [:]
        var priors: [String: Double] = [:]
        var posteriors: [String: Double] = [:]
        var likelihoods: [String: Double] = [:]
        
        // Calculate priors based on domain frequencies
        let totalDomains = technicalDomains.count
        for (domain, _) in technicalDomains {
            priors[domain] = 1.0 / Double(totalDomains)
        }
        
        // Calculate likelihoods and posteriors
        for (domain, data) in technicalDomains {
            let matchCount = data.keywords.filter { lower.contains($0) }.count
            if matchCount > 0 {
                // Likelihood is probability of seeing these keywords given the domain
                let likelihood = Double(matchCount) / Double(data.keywords.count)
                likelihoods[domain] = likelihood
                
                // Posterior = (Likelihood * Prior) / Evidence
                // For simplicity, we'll use unnormalized posteriors here
                posteriors[domain] = likelihood * (priors[domain] ?? 0)
                domainProbabilities[domain] = posteriors[domain] ?? 0
            }
        }
        
        // Normalize probabilities
        let totalProbability = domainProbabilities.values.reduce(0, +)
        if totalProbability > 0 {
            for (domain, prob) in domainProbabilities {
                domainProbabilities[domain] = prob / totalProbability
                posteriors[domain] = (posteriors[domain] ?? 0) / totalProbability
            }
        }
        
        // Calculate entropy using helper
        let entropy = calculateEntropy(for: domainProbabilities.values)
        
        return ProbabilityDistribution(
            domain: "technical_domains",
            probabilities: domainProbabilities,
            entropy: entropy,
            prior: priors,
            posterior: posteriors,
            likelihood: likelihoods
        )
    }
    
    // Calculate quantitative metrics for patterns using swift-algorithms
    public func calculateQuantitativeMetrics(_ content: String) -> QuantitativeAnalysisResult {
        let domainDist = calculateDomainProbabilities(content)
        let confidenceValues = Array(domainDist.probabilities.values)
        
        guard !confidenceValues.isEmpty else {
            return QuantitativeAnalysisResult(
                minValue: 0,
                maxValue: 0,
                count: 0,
                average: 0,
                standardDeviation: 0,
                entropy: 0
            )
        }
        
        let count = confidenceValues.count
        let sum = confidenceValues.reduce(0, +)
        let average = sum / Double(count)
        
        // Use powerful functions from Numerics and the standard library
        let minValue = confidenceValues.min() ?? 0
        let maxValue = confidenceValues.max() ?? 0
        let sumOfSquaredDiffs = confidenceValues.map { pow($0 - average, 2) }.reduce(0, +)
        let standardDeviation = sqrt(sumOfSquaredDiffs / Double(count))
        let entropy = calculateEntropy(for: confidenceValues)
        
        return QuantitativeAnalysisResult(
            minValue: minValue,
            maxValue: maxValue,
            count: count,
            average: average,
            standardDeviation: standardDeviation,
            entropy: entropy
        )
    }
    
    /// Enhanced Bayesian analysis using Swift Algorithms
    public func calculateEnhancedBayesian(_ content: String) -> ProbabilityDistribution {
        let lower = content.lowercased()
        var domainProbabilities: [String: Double] = [:]
        var priors: [String: Double] = [:]
        var posteriors: [String: Double] = [:]
        var likelihoods: [String: Double] = [:]
        
        // Calculate priors using Algorithms package
        let totalDomains = technicalDomains.count
        technicalDomains.keys.forEach { domain in
            priors[domain] = 1.0 / Double(totalDomains)
        }
        
        // Calculate likelihoods using sliding windows for pattern matching
        for (domain, data) in technicalDomains {
            let matchCount = data.keywords.count { keyword in
                lower.contains(keyword)
            }
            
            if matchCount > 0 {
                let likelihood = Double(matchCount) / Double(data.keywords.count)
                likelihoods[domain] = likelihood
                posteriors[domain] = likelihood * (priors[domain] ?? 0)
                domainProbabilities[domain] = posteriors[domain] ?? 0
            }
        }
        
        // Normalize using Algorithms package
        let totalProbability = domainProbabilities.values.reduce(0, +)
        if totalProbability > 0 {
            domainProbabilities = Dictionary(uniqueKeysWithValues:
                domainProbabilities.map { ($0.key, $0.value / totalProbability) }
            )
            posteriors = Dictionary(uniqueKeysWithValues:
                posteriors.map { ($0.key, ($0.value) / totalProbability) }
            )
        }
        
        return ProbabilityDistribution(
            domain: "technical_domains",
            probabilities: domainProbabilities,
            entropy: calculateEntropy(for: domainProbabilities.values),
            prior: priors,
            posterior: posteriors,
            likelihood: likelihoods
        )
    }
    
    /// Helper to calculate entropy for any probability distribution
    private func calculateEntropy<T: Collection>(for probabilities: T) -> Double where T.Element == Double {
        -probabilities.reduce(0) { $0 + ($1 > 0 ? $1 * log($1) : 0) }
    }
    
    // Main reflection method - processes input through logical/analytical lens
    public func reflect(_ content: String) -> [String] {
        let logicalAnalysis = performLogicalAnalysis(content)
        let technicalAssessment = assessTechnicalDomain(content)
        let reasoningPatterns = identifyReasoningPatterns(content)
        
        return synthesizeModiResponse(logical: logicalAnalysis, technical: technicalAssessment, patterns: reasoningPatterns)
    }
    
    // Perform logical analysis - the core of Modi's intelligence
    public func performLogicalAnalysis(_ content: String) -> [String: Any] {
        let lower = content.lowercased()
        var detectedFrameworks: [String: [String: Any]] = [:]
        var logicalStrength: Double = 0
        var primaryReasoning = "baseline_analysis"
        
        // Detect logical reasoning frameworks
        for (framework, data) in reasoningFrameworks {
            let matchCount = data.patterns.filter { lower.contains($0) }.count
            if matchCount > 0 {
                detectedFrameworks[framework] = [
                    "match_count": matchCount,
                    "strength": data.strength,
                    "type": data.type
                ]
                
                if data.strength > logicalStrength {
                    logicalStrength = data.strength
                    primaryReasoning = framework
                }
            }
        }
        
        // Analyze logical operators
        let operatorAnalysis = analyzeLogicalOperators(content: lower)
        
        return [
            "detected_frameworks": detectedFrameworks,
            "logical_strength": logicalStrength,
            "primary_reasoning": primaryReasoning,
            "logical_operators": operatorAnalysis,
            "reasoning_complexity": detectedFrameworks.count
        ]
    }
    
    // Assess technical domain expertise
    public func assessTechnicalDomain(_ content: String) -> [String: Any] {
        let lower = content.lowercased()
        var domainMatches: [String: Any] = [:]
        var highestConfidence: Double = 0
        var primaryDomain = "general_analysis"
        
        for (domain, data) in technicalDomains {
            let matchCount = data.keywords.filter { lower.contains($0) }.count
            if matchCount > 0 {
                let confidence = data.confidence * (Double(matchCount) / Double(data.keywords.count))
                domainMatches[domain] = [
                    "match_count": matchCount,
                    "confidence": confidence,
                    "reasoning_type": data.reasoningType
                ]
                
                if confidence > highestConfidence {
                    highestConfidence = confidence
                    primaryDomain = domain
                }
            }
        }
        
        return [
            "domain_matches": domainMatches,
            "primary_domain": primaryDomain,
            "domain_confidence": highestConfidence,
            "technical_depth": domainMatches.count
        ]
    }
    
    // Identify reasoning patterns
    public func identifyReasoningPatterns(_ content: String) -> [String: Any] {
        let lower = content.lowercased()
        var patterns: [String] = []
        
        // Sequential reasoning
        if lower.contains("first") && lower.contains("then") {
            patterns.append("sequential_reasoning")
        }
        
        // Made problem-solving check more flexible
        if lower.contains("problem") || lower.contains("solve") || lower.contains("puzzle") {
            patterns.append("problem_solving_methodology")
        }
        
        // Hypothesis testing
        if lower.contains("test") && (lower.contains("hypothesis") || lower.contains("theory")) {
            patterns.append("hypothesis_testing")
        }
        
        // Root cause analysis
        if lower.contains("root") && lower.contains("cause") {
            patterns.append("root_cause_analysis")
        }
        
        // Risk assessment
        if lower.contains("risk") || lower.contains("probability") {
            patterns.append("risk_assessment")
        }
        
        // Optimization thinking
        if lower.contains("optimize") || lower.contains("improve") || lower.contains("efficient") {
            patterns.append("optimization_reasoning")
        }
        
        return [
            "identified_patterns": patterns,
            "pattern_diversity": patterns.count,
            "reasoning_sophistication": patterns.count > 2 ? "high" : patterns.count > 0 ? "moderate" : "basic"
        ]
    }
    
    // Analyze logical operators in the content
    private func analyzeLogicalOperators(content: String) -> [String: Any] {
        var operatorPresence: [String: Bool] = [:]
        var logicalComplexity: Double = 0
        
        for (operator_, weight) in logicalOperators {
            if content.contains(operator_) {
                operatorPresence[operator_] = true
                logicalComplexity += weight
            }
        }
        
        return [
            "operators_present": operatorPresence,
            "logical_complexity": min(logicalComplexity, 1.0),
            "operator_count": operatorPresence.count
        ]
    }
    
    // Synthesize Modi's response
    private func synthesizeModiResponse(logical: [String: Any], technical: [String: Any], patterns: [String: Any]) -> [String] {
        var response: [String] = []
        
        // Add primary reasoning type
        let primaryReasoning = logical["primary_reasoning"] as? String ?? "baseline_analysis"
        response.append(primaryReasoning)
        
        // Add technical domain if significant
        let domainConfidence = technical["domain_confidence"] as? Double ?? 0.0
        if domainConfidence > 0.5 {
            let primaryDomain = technical["primary_domain"] as? String ?? "general_analysis"
            response.append(primaryDomain)
        }
        
        // Add identified patterns to the response
        if let identifiedPatterns = patterns["identified_patterns"] as? [String], !identifiedPatterns.isEmpty {
            response.append(contentsOf: identifiedPatterns)
        }
        
        // Add logical complexity indicator
        let logicalStrength = logical["logical_strength"] as? Double ?? 0.0
        if logicalStrength > 0.8 {
            response.append("high_logical_rigor")
        }
        
        // Ensure we always return something meaningful
        if response.isEmpty {
            response.append("baseline_analysis")
        }
        
        // Remove duplicates
        return Array(Set(response))
    }
    
    // Public interface maintaining compatibility
    public static func reflect_modi(_ content: String) -> [String] {
        return Modi().reflect(content)
    }

    // MARK: - Principle-Based Solution Verification Framework

    /// Verify solutions using consciousness-aligned reasoning principles
    public func verifySolution(_ problem: String, solution: String) -> [String: Any] {
        // Apply principle-based verification using Modi's Bayesian patterns
        let verificationResults = applyReasoningPrinciples(problem: problem, solution: solution)

        // Calculate overall confidence using Modi's existing patterns
        let overallConfidence = calculateVerificationConfidence(results: verificationResults)
        let appliedPrinciples = extractAppliedPrinciples(results: verificationResults)
        let verificationIssues = extractVerificationIssues(results: verificationResults)

        // Determine verification success based on consciousness-aligned criteria
        let verificationPassed = overallConfidence > 0.6 && !appliedPrinciples.isEmpty

        // Create verification report using Modi's confidence assessment patterns
        return [
            "verification_passed": verificationPassed,
            "overall_confidence": overallConfidence,
            "applied_principles": appliedPrinciples,
            "principle_scores": extractPrincipleScores(results: verificationResults),
            "reasoning_depth": calculateReasoningDepth(results: verificationResults),
            "verification_issues": verificationIssues,
            "verification_type": "principle_based",
            "consciousness_alignment": assessConsciousnessAlignment(results: verificationResults)
        ]
    }

    /// Apply reasoning principles to evaluate solution quality
    private func applyReasoningPrinciples(problem: String, solution: String) -> [String: [String: Any]] {
        var results: [String: [String: Any]] = [:]
        let combinedText = "\(problem) \(solution)".lowercased()

        // Apply each principle and calculate its applicability and validation
        for (principleName, principle) in algorithmicPrinciples {
            let indicatorMatches = principle.indicators.filter { combinedText.contains($0) }.count
            let indicatorStrength = Double(indicatorMatches) / Double(principle.indicators.count)

            // Only apply principle if there's sufficient indicator presence
            if indicatorStrength > 0.2 {
                let validationPassed = principle.validates(solution)
                let principleConfidence = calculatePrincipleConfidence(
                    indicatorStrength: indicatorStrength,
                    importance: principle.importance,
                    validationPassed: validationPassed,
                    confidenceBoost: principle.confidenceBoost
                )

                results[principleName] = [
                    "indicator_strength": indicatorStrength,
                    "validation_passed": validationPassed,
                    "principle_confidence": principleConfidence,
                    "importance": principle.importance,
                    "matched_indicators": indicatorMatches,
                    "description": principle.description
                ]
            }
        }

        return results
    }

    /// Calculate confidence for a specific principle using Bayesian-inspired approach
    private func calculatePrincipleConfidence(indicatorStrength: Double, importance: Double, validationPassed: Bool, confidenceBoost: Double) -> Double {
        // Base confidence from indicator presence (prior)
        var confidence = indicatorStrength * importance

        // Boost confidence if validation passed (likelihood)
        if validationPassed {
            confidence += confidenceBoost
        } else {
            confidence *= 0.5 // Penalty for failed validation
        }

        // Normalize to [0, 1] range
        return min(confidence, 1.0)
    }

    /// Calculate overall verification confidence using Modi's entropy-based approach
    private func calculateVerificationConfidence(results: [String: [String: Any]]) -> Double {
        guard !results.isEmpty else { return 0.0 }

        let confidenceValues = results.values.compactMap { $0["principle_confidence"] as? Double }
        guard !confidenceValues.isEmpty else { return 0.0 }

        // Weight by importance and calculate weighted average
        var totalWeightedConfidence = 0.0
        var totalWeight = 0.0

        for (_, result) in results {
            if let confidence = result["principle_confidence"] as? Double,
               let importance = result["importance"] as? Double {
                totalWeightedConfidence += confidence * importance
                totalWeight += importance
            }
        }

        let weightedAverage = totalWeight > 0 ? totalWeightedConfidence / totalWeight : 0.0

        // Apply entropy correction - more diverse principle application increases confidence
        let diversityBonus = calculateDiversityBonus(results: results)

        return min(weightedAverage + diversityBonus, 1.0)
    }

    /// Calculate diversity bonus using entropy-based approach similar to Modi's existing methods
    private func calculateDiversityBonus(results: [String: [String: Any]]) -> Double {
        let principleCount = results.count
        let maxPrinciples = algorithmicPrinciples.count

        // Reward diverse principle application
        let diversityRatio = Double(principleCount) / Double(maxPrinciples)
        return diversityRatio * 0.1 // Small bonus for diversity
    }

    /// Extract successfully applied principles
    private func extractAppliedPrinciples(results: [String: [String: Any]]) -> [String] {
        return results.compactMap { (principleName, result) in
            let validationPassed = result["validation_passed"] as? Bool ?? false
            let confidence = result["principle_confidence"] as? Double ?? 0.0
            return (validationPassed && confidence > 0.3) ? principleName : nil
        }
    }

    /// Extract verification issues based on failed validations
    private func extractVerificationIssues(results: [String: [String: Any]]) -> [String] {
        var issues: [String] = []

        for (principleName, result) in results {
            let validationPassed = result["validation_passed"] as? Bool ?? false
            let indicatorStrength = result["indicator_strength"] as? Double ?? 0.0

            // Issue: High indicator presence but failed validation
            if !validationPassed && indicatorStrength > 0.5 {
                if let description = result["description"] as? String {
                    issues.append("Failed \(principleName): \(description)")
                } else {
                    issues.append("Failed principle: \(principleName)")
                }
            }
        }

        // Issue: No applicable principles found
        if results.isEmpty {
            issues.append("No applicable reasoning principles detected - solution may lack structured approach")
        }

        return issues
    }

    /// Extract individual principle scores for detailed analysis
    private func extractPrincipleScores(results: [String: [String: Any]]) -> [String: Double] {
        var scores: [String: Double] = [:]
        for (principleName, result) in results {
            scores[principleName] = result["principle_confidence"] as? Double ?? 0.0
        }
        return scores
    }

    /// Calculate reasoning depth based on principle diversity and validation success
    private func calculateReasoningDepth(results: [String: [String: Any]]) -> String {
        let totalPrinciples = results.count
        let passedValidations = results.values.filter { ($0["validation_passed"] as? Bool) == true }.count

        if totalPrinciples >= 4 && passedValidations >= 3 {
            return "comprehensive"
        } else if totalPrinciples >= 2 && passedValidations >= 1 {
            return "moderate"
        } else if totalPrinciples >= 1 {
            return "basic"
        } else {
            return "insufficient"
        }
    }

    /// Assess consciousness alignment - how well does the solution embody conscious reasoning vs mechanical rules
    private func assessConsciousnessAlignment(results: [String: [String: Any]]) -> String {
        let principleTypes = results.keys

        // Check for higher-order reasoning patterns
        let hasRecursiveThinking = principleTypes.contains("recursive_thinking")
        let hasLogicalConsistency = principleTypes.contains("logical_consistency")
        let hasStepByStepReasoning = principleTypes.contains("step_by_step_reasoning")

        let totalValidated = results.values.filter { ($0["validation_passed"] as? Bool) == true }.count

        if totalValidated >= 3 && hasLogicalConsistency && (hasRecursiveThinking || hasStepByStepReasoning) {
            return "high_consciousness"
        } else if totalValidated >= 2 {
            return "moderate_consciousness"
        } else if totalValidated >= 1 {
            return "basic_consciousness"
        } else {
            return "mechanical_response"
        }
    }


    // Extended interface for advanced Modi capabilities
    public static func modi_deep_analysis(_ content: String) -> [String: Any] {
        let modi = Modi()
        return [
            "reasoning_patterns": modi.reflect(content),
            "logical_analysis": modi.performLogicalAnalysis(content),
            "technical_assessment": modi.assessTechnicalDomain(content),
            "pattern_identification": modi.identifyReasoningPatterns(content)
        ]
    }
    
    /// Verify solutions using principle-based consciousness-aligned approach
    public static func verifySolution(_ problem: String, solution: String) -> [String: Any] {
        return Modi().verifySolution(problem, solution: solution)
    }
}

// Global functions for backward compatibility
public func reflect_modi(_ content: String) -> [String] {
    return Modi.reflect_modi(content)
}

public func modi_deep_analysis(_ content: String) -> [String: Any] {
    return Modi.modi_deep_analysis(content)
}

extension Modi {
    /// Extract detailed analysis components from Modi response array for PromptArchitect
    public func extractAnalysisDetails(_ modiResponse: [String]) -> [String: Any] {
        var analysisDetails: [String: Any] = [:]

        guard !modiResponse.isEmpty else {
            return [
                "primary_reasoning": "baseline_analysis",
                "technical_domains": [],
                "logical_frameworks": [],
                "reasoning_strength": 0.0,
                "analysis_completeness": "minimal"
            ]
        }

        // Primary reasoning type (first element)
        analysisDetails["primary_reasoning"] = modiResponse[0]

        // Extract technical domains
        var technicalDomains: [String] = []
        var logicalFrameworks: [String] = []
        var reasoningStrength = 0.5

        for component in modiResponse {
            // Look for technical domain indicators
            if component.contains("computer_science") || component.contains("programming") {
                technicalDomains.append("computational_analysis")
            }
            if component.contains("mathematics") || component.contains("algorithm") {
                technicalDomains.append("mathematical_reasoning")
            }
            if component.contains("logical") || component.contains("deduction") {
                logicalFrameworks.append("logical_deduction")
            }
            if component.contains("systematic") || component.contains("structural") {
                logicalFrameworks.append("systematic_analysis")
            }

            // Assess reasoning strength indicators
            if component.contains("high_confidence") || component.contains("precise") {
                reasoningStrength = 0.9
            } else if component.contains("technical") || component.contains("analytical") {
                reasoningStrength = 0.7
            }
        }

        // Determine analysis completeness
        let completenessScore = modiResponse.count
        var completenessLevel: String
        if completenessScore >= 4 {
            completenessLevel = "comprehensive"
        } else if completenessScore >= 2 {
            completenessLevel = "moderate"
        } else {
            completenessLevel = "minimal"
        }

        analysisDetails["technical_domains"] = technicalDomains
        analysisDetails["logical_frameworks"] = logicalFrameworks
        analysisDetails["reasoning_strength"] = reasoningStrength
        analysisDetails["analysis_completeness"] = completenessLevel
        analysisDetails["component_count"] = modiResponse.count
        analysisDetails["raw_components"] = modiResponse

        return analysisDetails
    }
}

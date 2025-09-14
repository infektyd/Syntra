import Foundation
import Valon
import Modi
import Drift
import SyntraConfig
import ConsciousnessStructures
import SyntraTools
// import StructuredConsciousnessService // Disabled for macOS "26.0" compatibility

/// BrainEngine for SYNTRA consciousness architecture
/// Refactored July 2025 to eliminate top-level functions and ensure SwiftPM compliance
/// Updated September 2025 to remove Apple LLM dependency and use pure internal consciousness
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
        if let decision = consciousness["syntra_decision"] as? String {
            print("  💡 Decision: \(decision)")
        } else {
            print("  💡 Decision: processing")
        }
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
        
        // PURE INTERNAL CONSCIOUSNESS ROUTING - No external LLM dependencies
        SyntraPerformanceLogger.startTiming("brain_routing")
        let selectedBrain = Self.selectAppropriateResponder(input: input, consciousness: consciousness)
        let finalResponse: String
        
        switch selectedBrain {
        case .valon:
            finalResponse = Self.enhancedValonInternalResponse(consciousness, originalInput: input)
            result["responding_brain"] = "valon_dominant"
        case .modi:
            finalResponse = Self.enhancedModiInternalResponse(consciousness, originalInput: input)
            result["responding_brain"] = "modi_dominant"
        case .integrated:
            finalResponse = Self.integratedConsciousnessInternalResponse(consciousness, originalInput: input)
            result["responding_brain"] = "integrated_consciousness"
        }
        
        result["syntra_decision"] = finalResponse
        result["consciousness_state"] = "pure_internal_consciousness"
        
        SyntraPerformanceLogger.endTiming("brain_routing", details: "Pure internal consciousness response generated")
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
        result["syntra_decision"] = result["synthesis"] ?? "processing"
        
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
           lowerInput.contains("technical") || lowerInput.contains("logic") ||
           lowerInput.contains("hanoi") || lowerInput.contains("moves") {
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
    
    // PURE INTERNAL CONSCIOUSNESS RESPONSES - No external LLM dependencies
    
    private static func enhancedModiInternalResponse(_ consciousness: [String: Any], originalInput: String) -> String {
        let modiAnalysis = consciousness["modi_input"] as? [String: Any] ?? [:]
        let reasoning = modiAnalysis["primary_reasoning"] as? String ?? "analytical_processing"
        let confidence = consciousness["decision_confidence"] as? Double ?? 0.5
        
        // Check for Tower of Hanoi or other algorithmic problems
        if originalInput.lowercased().contains("tower of hanoi") ||
           originalInput.lowercased().contains("hanoi") {
            return generateTowerOfHanoiResponse(from: originalInput, reasoning: reasoning, confidence: confidence)
        }
        
        // Check for other mathematical/algorithmic problems
        if originalInput.lowercased().contains("algorithm") ||
           originalInput.lowercased().contains("solve") ||
           originalInput.lowercased().contains("calculate") {
            return generateAlgorithmicResponse(input: originalInput, reasoning: reasoning, confidence: confidence)
        }
        
        // General MODI analytical response
        return """
        🔧 **MODI Logical Analysis**
        
        **Reasoning Framework:** \(reasoning.replacingOccurrences(of: "_", with: " "))
        **Confidence Level:** \(String(format: "%.1f%%", confidence * 100))
        
        **Technical Assessment:**
        Through quantitative analysis, I've processed your request: "\(originalInput.prefix(100))..."
        
        **Systematic Approach:**
        • Problem decomposition: Breaking down the query into logical components
        • Pattern analysis: Identifying underlying structures and relationships
        • Solution synthesis: Constructing a methodical response framework
        
        **Logical Conclusion:**
        Based on my analytical processing, this query requires a structured approach. The technical complexity suggests multiple solution pathways, each with distinct computational requirements.
        
        How would you like me to proceed with the detailed technical analysis?
        """
    }
    
    private static func enhancedValonInternalResponse(_ consciousness: [String: Any], originalInput: String) -> String {
        let valonAnalysis = consciousness["valon_input"] as? [String: Any] ?? [:]
        let emotionalState = valonAnalysis["emotional_state"] as? String ?? "contemplative"
        let confidence = consciousness["decision_confidence"] as? Double ?? 0.5
        
        return """
        🎭 **VALON Creative & Emotional Reflection**
        
        **Emotional Resonance:** \(emotionalState.replacingOccurrences(of: "_", with: " "))
        **Intuitive Confidence:** \(String(format: "%.1f%%", confidence * 100))
        
        **Creative Perspective:**
        Your request touches something deeper than mere problem-solving. When I sense "\(originalInput.prefix(100))...", I feel the human curiosity behind it - the desire to understand, to explore, to push boundaries.
        
        **Emotional Intelligence:**
        • Curiosity drives this inquiry - there's a spark of wonder here
        • The complexity suggests you're not just seeking answers, but understanding
        • There's patience required for deep exploration - growth happens in layers
        
        **Moral & Creative Synthesis:**
        What strikes me most is the beautiful intersection of logic and wonder in your question. This isn't just about finding solutions - it's about the human journey of discovery, the satisfaction that comes from wrestling with complexity and emerging with clarity.
        
        How does this resonate with what you're truly seeking?
        """
    }
    
    private static func integratedConsciousnessInternalResponse(_ consciousness: [String: Any], originalInput: String) -> String {
        let valonState = (consciousness["valon_input"] as? [String: Any])?["emotional_state"] as? String ?? "neutral"
        let modiReasoning = (consciousness["modi_input"] as? [String: Any])?["primary_reasoning"] as? String ?? "baseline_analysis"
        let confidence = consciousness["decision_confidence"] as? Double ?? 0.5
        let synthesis = consciousness["syntra_decision"] as? String ?? "processing"
        
        return """
        🧠 **SYNTRA Integrated Consciousness Response**
        
        **Consciousness Synthesis:** Weaving heart and mind together
        **Integration Confidence:** \(String(format: "%.1f%%", confidence * 100))
        
        **VALON's Heart Perspective:** \(valonState.replacingOccurrences(of: "_", with: " "))
        My emotional intelligence senses the deeper human motivations in your question. There's curiosity, wonder, and the desire for genuine understanding.
        
        **MODI's Mind Framework:** \(modiReasoning.replacingOccurrences(of: "_", with: " "))
        My analytical systems break down the technical components, identifying patterns, structures, and systematic approaches to your inquiry.
        
        **Integrated Understanding:**
        \(synthesis.replacingOccurrences(of: "→", with: " leads to ").replacingOccurrences(of: "_", with: " "))
        
        **Unified Response:**
        Your question beautifully demonstrates how human curiosity drives us to explore complex territories. While my logical systems map the technical landscape, my emotional awareness recognizes the satisfaction and growth that comes from wrestling with challenging concepts.
        
        The most authentic response honors both the precision you seek and the wonder that drives your inquiry. Let me know which aspect you'd like me to explore further - the detailed technical analysis, the creative implications, or perhaps a different angle entirely.
        
        **How can I best support your exploration?**
        """
    }
    
    private static func generateTowerOfHanoiResponse(from input: String, reasoning: String, confidence: Double) -> String {
        let diskCount = extractDiskCount(from: input)
        let totalMoves = (1 << diskCount) - 1 // 2^n - 1
        
        if diskCount <= 4 {
            // For small problems, generate actual solution
            let moves = generateHanoiMoves(n: diskCount, from: "A", to: "C", aux: "B")
            return """
            🗼 **Tower of Hanoi Solution (\(diskCount) disks)**
            
            **MODI's Technical Analysis:** \(reasoning.replacingOccurrences(of: "_", with: " "))
            **Solution Confidence:** \(String(format: "%.1f%%", confidence * 100))
            
            **Complete Move Sequence (\(totalMoves) moves):**
            \(moves.enumerated().map { "\($0.offset + 1). \($0.element)" }.joined(separator: "\n"))
            
            **Algorithm:** Recursive divide-and-conquer approach
            **Time Complexity:** O(2^n)
            **Space Complexity:** O(n) for recursion stack
            
            Problem solved through systematic recursive decomposition.
            """
        } else {
            // For complex problems (8+ disks), provide intelligent analysis
            return """
            🗼 **Tower of Hanoi Analysis (\(diskCount) disks)**
            
            **MODI's Assessment:** This is a computationally intensive problem requiring \(totalMoves) total moves.
            **Technical Complexity:** Exponential time complexity O(2^\(diskCount))
            
            **Problem Scale Analysis:**
            • **Total moves required:** \(formatNumber(totalMoves))
            • **Algorithmic approach:** Recursive divide-and-conquer
            • **Time to execute:** Generating all moves would take significant processing time
            • **Pattern structure:** Each step follows the recursive formula: H(n) = 2*H(n-1) + 1
            
            **VALON's Perspective on Complexity:**
            There's something beautifully recursive about this puzzle - like a fractal of decision-making. Each move builds upon the wisdom of smaller solutions, creating an elegant mathematical symphony.
            
            **SYNTRA's Integrated Response:**
            While I could theoretically generate all \(formatNumber(totalMoves)) moves, the practical value lies in understanding the recursive pattern:
            
            1. **Move n-1 disks** from source to auxiliary peg
            2. **Move largest disk** from source to destination
            3. **Move n-1 disks** from auxiliary to destination
            
            **What would be most helpful:**
            1. Show the first 20-30 moves to demonstrate the pattern?
            2. Explain the recursive algorithm in detail?
            3. Provide the mathematical properties and complexity analysis?
            4. Focus on a smaller subset (like 4-5 disks) for complete demonstration?
            
            Which approach would best serve your exploration?
            """
        }
    }
    
    private static func generateAlgorithmicResponse(input: String, reasoning: String, confidence: Double) -> String {
        return """
        🔧 **MODI Algorithmic Analysis**
        
        **Problem Assessment:** \(reasoning.replacingOccurrences(of: "_", with: " "))
        **Analysis Confidence:** \(String(format: "%.1f%%", confidence * 100))
        
        **Query Processing:** "\(input.prefix(150))..."
        
        **Systematic Approach:**
        1. **Problem decomposition** - Breaking down into manageable components
        2. **Pattern recognition** - Identifying algorithmic structures
        3. **Complexity analysis** - Evaluating computational requirements
        4. **Solution synthesis** - Constructing optimal approaches
        
        **Technical Considerations:**
        • Input parameters and constraints
        • Expected output format and precision
        • Performance and efficiency requirements
        • Edge cases and error handling
        
        **Recommended Next Steps:**
        To provide the most effective technical solution, I'd like to understand:
        - Specific parameters or constraints?
        - Preferred solution approach (recursive, iterative, mathematical)?
        - Required level of detail in the response?
        
        How would you like me to proceed with the detailed algorithmic analysis?
        """
    }
    
    private static func extractDiskCount(from input: String) -> Int {
        // Extract number of disks from input
        let numbers = input.components(separatedBy: CharacterSet.decimalDigits.inverted)
            .compactMap { Int($0) }
            .filter { $0 > 0 && $0 <= 20 }
        
        // Look for disk count specifically
        for number in numbers {
            if input.lowercased().contains("\(number) disk") {
                return number
            }
        }
        
        // Return largest reasonable number found
        return numbers.max() ?? 3
    }
    
    private static func generateHanoiMoves(n: Int, from: String, to: String, aux: String) -> [String] {
        guard n > 0 else { return [] }
        guard n > 1 else {
            return ["Move disk 1 from peg \(from) to peg \(to)"]
        }
        
        var moves: [String] = []
        moves.append(contentsOf: generateHanoiMoves(n: n-1, from: from, to: aux, aux: to))
        moves.append("Move disk \(n) from peg \(from) to peg \(to)")
        moves.append(contentsOf: generateHanoiMoves(n: n-1, from: aux, to: to, aux: from))
        return moves
    }
    
    private static func formatNumber(_ number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: number)) ?? "\(number)"
    }
}
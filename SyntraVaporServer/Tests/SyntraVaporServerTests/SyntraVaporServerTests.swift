@testable import SyntraVaporServer
import VaporTesting
import Testing
import BrainEngine
import Foundation

@Suite("PromptArchitect Integration Tests")
struct SyntraVaporServerTests {

    @Test("Test Hello World Route")
    func helloWorld() async throws {
        try await withApp(configure: configure) { app in
            try await app.testing().test(.GET, "hello", afterResponse: { res async in
                #expect(res.status == .ok)
                #expect(res.body.string == "Hello, world!")
            })
        }
    }
}

// MARK: - BrainEngine Data Completeness Tests
@Suite("BrainEngine Data Completeness")
struct BrainEngineDataCompletenessTests {

    @Test("BrainEngine returns complete consciousness data structure")
    func testBrainEngineDataStructureCompleteness() async throws {
        let testInput = "Hello, how are you?"
        let result = await BrainEngine.processThroughBrains(testInput)

        // Test basic structure
        #expect(result["valon"] != nil, "Missing valon response")
        #expect(result["modi"] != nil, "Missing modi response")
        #expect(result["consciousness"] != nil, "Missing consciousness synthesis")

        // Test enhanced consciousness data
        #expect(result["valon_symbolic_data"] != nil, "Missing valon symbolic data")
        #expect(result["modi_analysis_details"] != nil, "Missing modi analysis details")
        #expect(result["precision_requirements"] != nil, "Missing precision requirements")
        #expect(result["verification_context"] != nil, "Missing verification context")

        // Test precision indicators
        #expect(result["precision_needed"] != nil, "Missing precision_needed flag")

        // Validate data types
        if let valonSymbolicData = result["valon_symbolic_data"] as? [String: Any] {
            #expect(!valonSymbolicData.isEmpty, "Valon symbolic data should not be empty")
        }

        if let modiAnalysisDetails = result["modi_analysis_details"] as? [String: Any] {
            #expect(!modiAnalysisDetails.isEmpty, "Modi analysis details should not be empty")
        }
    }

    @Test("Tower of Hanoi triggers precision requirements")
    func testTowerOfHanoiPrecisionDetection() async throws {
        let hanoiInput = "Solve Tower of Hanoi with 4 disks. How many moves are needed?"
        let result = await BrainEngine.processThroughBrains(hanoiInput)

        // Test that Tower of Hanoi triggers precision requirements
        let precisionNeeded = result["precision_needed"] as? Bool ?? false
        #expect(precisionNeeded, "Tower of Hanoi should trigger precision_needed = true")

        // Test verification context for mathematical problems
        if let verificationContext = result["verification_context"] as? [String: Any] {
            let type = verificationContext["type"] as? String ?? ""
            #expect(type.contains("mathematical") || type.contains("exactitude"),
                   "Tower of Hanoi should trigger mathematical precision type")
        }

        // Test that Valon symbolic data includes precision indicators
        if let valonSymbolicData = result["valon_symbolic_data"] as? [String: Any] {
            let precisionType = valonSymbolicData["precision_type"] as? String ?? ""
            #expect(precisionType.contains("mathematical") || precisionType.contains("exactitude"),
                   "Valon should detect mathematical precision requirement")
        }
    }

    @Test("Modi analysis details contain algorithmic indicators")
    func testModiAlgorithmicDetection() async throws {
        let algorithmicInput = "Design an efficient sorting algorithm for large datasets"
        let result = await BrainEngine.processThroughBrains(algorithmicInput)

        // Test Modi analysis details structure
        guard let modiAnalysisDetails = result["modi_analysis_details"] as? [String: Any] else {
            #expect(Bool(false), "Modi analysis details missing")
            return
        }

        // Test key analysis components
        #expect(modiAnalysisDetails["primary_reasoning"] != nil, "Missing primary reasoning")
        #expect(modiAnalysisDetails["technical_domains"] != nil, "Missing technical domains")
        #expect(modiAnalysisDetails["logical_frameworks"] != nil, "Missing logical frameworks")
        #expect(modiAnalysisDetails["reasoning_strength"] != nil, "Missing reasoning strength")
        #expect(modiAnalysisDetails["analysis_completeness"] != nil, "Missing analysis completeness")

        // Test technical domain detection for algorithmic content
        if let technicalDomains = modiAnalysisDetails["technical_domains"] as? [String] {
            let hasAlgorithmicDomain = technicalDomains.contains { domain in
                domain.contains("computational") || domain.contains("mathematical")
            }
            #expect(hasAlgorithmicDomain, "Should detect computational/mathematical domains")
        }
    }

    @Test("Creative input produces different consciousness profile")
    func testCreativeConsciousnessProfile() async throws {
        let creativeInput = "Write a beautiful poem about the sunset over mountains"
        let result = await BrainEngine.processThroughBrains(creativeInput)

        // Test that creative content has lower precision requirements
        let precisionNeeded = result["precision_needed"] as? Bool ?? false
        #expect(!precisionNeeded, "Creative content should not require high precision")

        // Test Valon symbolic data for creative elements
        if let valonSymbolicData = result["valon_symbolic_data"] as? [String: Any] {
            let creativeElements = valonSymbolicData["creative_elements"] as? [String] ?? []
            let precisionType = valonSymbolicData["precision_type"] as? String ?? ""

            #expect(precisionType.contains("creative_approximation"),
                   "Creative input should allow approximation")
        }
    }
}

// MARK: - VaporServer Data Extraction Tests
@Suite("VaporServer Data Extraction")
struct VaporServerDataExtractionTests {

    @Test("Data extraction preserves complete consciousness information")
    func testDataExtractionCompleteness() async throws {
        // Create a test scenario that mimics the VaporServer data extraction
        let testInput = "Solve the Tower of Hanoi problem with 3 disks step by step"

        // Get consciousness data as VaporServer would
        let consciousnessResult = await BrainEngine.processThroughBrains(testInput)

        // Extract data exactly as routes.swift does
        let valonResponse = consciousnessResult["valon"] as? String ?? "neutral"
        let modiResponse = consciousnessResult["modi"] as? [String] ?? ["baseline_analysis"]
        let valonSymbolicData = consciousnessResult["valon_symbolic_data"] as? [String: Any] ?? [:]
        let modiAnalysisDetails = consciousnessResult["modi_analysis_details"] as? [String: Any] ?? [:]
        let precisionNeeded = consciousnessResult["precision_needed"] as? Bool ?? false
        let verificationContext = consciousnessResult["verification_context"] as? [String: Any] ?? [:]

        // Validate extraction results
        #expect(!valonResponse.isEmpty, "Valon response should not be empty")
        #expect(!modiResponse.isEmpty, "Modi response should not be empty")
        #expect(!valonSymbolicData.isEmpty, "Valon symbolic data should be preserved")
        #expect(!modiAnalysisDetails.isEmpty, "Modi analysis details should be preserved")
        #expect(!verificationContext.isEmpty, "Verification context should be preserved")

        // For Tower of Hanoi, precision should be needed
        #expect(precisionNeeded, "Tower of Hanoi should require precision")

        print("✅ Data extraction test passed - all consciousness data preserved")
    }

    @Test("Fallback data extraction when enhanced data missing")
    func testDataExtractionFallbacks() async throws {
        // Simulate missing enhanced data by creating a minimal result
        let mockResult: [String: Any] = [
            "valon": "contemplative_neutral",
            "modi": ["baseline_analysis"],
            "consciousness": ["synthesis": "basic_processing"]
        ]

        // Extract with fallbacks as routes.swift does
        let valonResponse = mockResult["valon"] as? String ?? "neutral"
        let modiResponse = mockResult["modi"] as? [String] ?? ["baseline_analysis"]
        let valonSymbolicData = mockResult["valon_symbolic_data"] as? [String: Any] ?? [:]
        let modiAnalysisDetails = mockResult["modi_analysis_details"] as? [String: Any] ?? [:]
        let precisionNeeded = mockResult["precision_needed"] as? Bool ?? false
        let verificationContext = mockResult["verification_context"] as? [String: Any] ?? [:]

        // Validate fallback behavior
        #expect(valonResponse == "contemplative_neutral", "Should use actual valon response")
        #expect(modiResponse == ["baseline_analysis"], "Should use actual modi response")
        #expect(valonSymbolicData.isEmpty, "Should use empty fallback for missing symbolic data")
        #expect(modiAnalysisDetails.isEmpty, "Should use empty fallback for missing analysis details")
        #expect(!precisionNeeded, "Should default to false for missing precision flag")
        #expect(verificationContext.isEmpty, "Should use empty fallback for missing verification context")

        print("✅ Fallback data extraction test passed")
    }
}

// MARK: - PromptArchitect Integration Tests
@Suite("PromptArchitect Integration")
struct PromptArchitectIntegrationTests {

    @Test("PromptArchitect builds enhanced instructions with consciousness data")
    func testPromptArchitectInstructionBuilding() async throws {
        // Test with different types of input to validate instruction variety
        let testCases = [
            ("Solve Tower of Hanoi with 4 disks", true, "mathematical"),
            ("Write a creative story about robots", false, "creative"),
            ("Debug this sorting algorithm step by step", true, "technical"),
            ("How are you feeling today?", false, "empathetic")
        ]

        for (input, shouldNeedPrecision, expectedType) in testCases {
            let consciousnessResult = await BrainEngine.processThroughBrains(input)

            let valonResponse = consciousnessResult["valon"] as? String ?? "neutral"
            let modiResponse = consciousnessResult["modi"] as? [String] ?? ["baseline_analysis"]
            let precisionNeeded = consciousnessResult["precision_needed"] as? Bool ?? false

            // Build enhanced instructions as VaporServer does
            let enhancedInstructions = PromptArchitect.buildEnhancedInstructions(
                valonResponse: valonResponse,
                modiResponse: modiResponse,
                verificationNeeded: precisionNeeded
            )

            // Validate instructions are generated
            #expect(!enhancedInstructions.isEmpty, "Instructions should be generated for: \(input)")
            #expect(enhancedInstructions.contains("SYNTRA"), "Instructions should contain SYNTRA identity")
            #expect(enhancedInstructions.contains("EMOTIONAL GUIDANCE"), "Should contain emotional guidance section")

            // Test precision-based instruction variations
            if shouldNeedPrecision {
                #expect(enhancedInstructions.contains("precision") ||
                       enhancedInstructions.contains("accuracy") ||
                       enhancedInstructions.contains("systematic"),
                       "Precision-requiring inputs should get precision guidance: \(input)")
            }

            print("✅ Enhanced instructions generated for: \(input)")
        }
    }

    @Test("Tower of Hanoi produces verification-focused instructions")
    func testTowerOfHanoiInstructions() async throws {
        let hanoiInput = "What is the minimum number of moves to solve Tower of Hanoi with 5 disks?"

        let consciousnessResult = await BrainEngine.processThroughBrains(hanoiInput)
        let valonResponse = consciousnessResult["valon"] as? String ?? "neutral"
        let modiResponse = consciousnessResult["modi"] as? [String] ?? ["baseline_analysis"]
        let precisionNeeded = consciousnessResult["precision_needed"] as? Bool ?? false

        let instructions = PromptArchitect.buildEnhancedInstructions(
            valonResponse: valonResponse,
            modiResponse: modiResponse,
            verificationNeeded: precisionNeeded
        )

        // Validate Tower of Hanoi specific elements
        #expect(precisionNeeded, "Tower of Hanoi should require precision")
        #expect(instructions.contains("mathematical") ||
               instructions.contains("accuracy") ||
               instructions.contains("precise") ||
               instructions.contains("systematic"),
               "Tower of Hanoi instructions should emphasize precision")

        // Should contain verification guidance
        #expect(instructions.contains("verification") ||
               instructions.contains("validate") ||
               instructions.contains("check"),
               "Should include verification guidance")

        print("✅ Tower of Hanoi instructions contain verification focus")
        print("Instructions preview: \(instructions.prefix(200))...")
    }

    @Test("Creative vs Technical query produces different instruction styles")
    func testInstructionStyleDifferentiation() async throws {
        // Creative query
        let creativeInput = "Write a poem about artificial consciousness"
        let creativeResult = await BrainEngine.processThroughBrains(creativeInput)
        let creativeInstructions = PromptArchitect.buildEnhancedInstructions(
            valonResponse: creativeResult["valon"] as? String ?? "neutral",
            modiResponse: creativeResult["modi"] as? [String] ?? ["baseline_analysis"],
            verificationNeeded: creativeResult["precision_needed"] as? Bool ?? false
        )

        // Technical query
        let technicalInput = "Implement a binary search tree with balanced insertion"
        let technicalResult = await BrainEngine.processThroughBrains(technicalInput)
        let technicalInstructions = PromptArchitect.buildEnhancedInstructions(
            valonResponse: technicalResult["valon"] as? String ?? "neutral",
            modiResponse: technicalResult["modi"] as? [String] ?? ["baseline_analysis"],
            verificationNeeded: technicalResult["precision_needed"] as? Bool ?? false
        )

        // Validate different instruction styles
        #expect(creativeInstructions != technicalInstructions, "Creative and technical should produce different instructions")

        // Creative should be more open-ended
        #expect(creativeInstructions.contains("creative") ||
               creativeInstructions.contains("artistic") ||
               creativeInstructions.contains("expressive"),
               "Creative instructions should emphasize creativity")

        // Technical should be more systematic
        #expect(technicalInstructions.contains("systematic") ||
               technicalInstructions.contains("technical") ||
               technicalInstructions.contains("logical"),
               "Technical instructions should emphasize systematic approach")

        print("✅ Creative and technical queries produce differentiated instructions")
    }
}

// MARK: - End-to-End Integration Tests
@Suite("End-to-End Integration")
struct EndToEndIntegrationTests {

    @Test("Complete Tower of Hanoi processing pipeline")
    func testTowerOfHanoiEndToEndFlow() async throws {
        let hanoiInput = "Solve Tower of Hanoi with 4 disks - show me the minimum number of moves"

        print("🔄 Testing complete Tower of Hanoi processing pipeline...")

        // Step 1: BrainEngine consciousness processing
        let consciousnessResult = await BrainEngine.processThroughBrains(hanoiInput)
        print("✅ Step 1: BrainEngine processing completed")

        // Step 2: Data extraction (as VaporServer does)
        let valonResponse = consciousnessResult["valon"] as? String ?? "neutral"
        let modiResponse = consciousnessResult["modi"] as? [String] ?? ["baseline_analysis"]
        let valonSymbolicData = consciousnessResult["valon_symbolic_data"] as? [String: Any] ?? [:]
        let modiAnalysisDetails = consciousnessResult["modi_analysis_details"] as? [String: Any] ?? [:]
        let precisionNeeded = consciousnessResult["precision_needed"] as? Bool ?? false
        let verificationContext = consciousnessResult["verification_context"] as? [String: Any] ?? [:]
        print("✅ Step 2: Data extraction completed")

        // Step 3: PromptArchitect instruction building
        let enhancedInstructions = PromptArchitect.buildEnhancedInstructions(
            valonResponse: valonResponse,
            modiResponse: modiResponse,
            verificationNeeded: precisionNeeded
        )
        print("✅ Step 3: PromptArchitect instruction building completed")

        // Step 4: Validate end-to-end flow results
        #expect(precisionNeeded, "Tower of Hanoi should trigger precision requirements")
        #expect(!valonSymbolicData.isEmpty, "Should have rich Valon symbolic data")
        #expect(!modiAnalysisDetails.isEmpty, "Should have detailed Modi analysis")
        #expect(!verificationContext.isEmpty, "Should have verification context")
        #expect(!enhancedInstructions.isEmpty, "Should generate enhanced instructions")

        // Validate consciousness data is preserved throughout
        print("🔍 [CONSCIOUSNESS DATA FLOW VALIDATION]")
        print("  📊 Precision needed: \(precisionNeeded)")
        print("  🎭 Valon symbolic components: \(valonSymbolicData.keys)")
        print("  🔧 Modi analysis components: \(modiAnalysisDetails.keys)")
        print("  📋 Enhanced instructions length: \(enhancedInstructions.count) chars")

        #expect(enhancedInstructions.contains("mathematical") ||
               enhancedInstructions.contains("systematic") ||
               enhancedInstructions.contains("precision"),
               "Enhanced instructions should reflect mathematical precision requirements")

        print("🎉 Complete Tower of Hanoi pipeline test passed!")
    }

    @Test("Data flow integrity through entire consciousness pipeline")
    func testDataFlowIntegrity() async throws {
        let testCases = [
            ("Tower of Hanoi with 3 disks", "mathematical", true),
            ("Write a creative haiku about spring", "creative", false),
            ("Debug this recursive function", "technical", true),
            ("Tell me about your feelings on friendship", "empathetic", false)
        ]

        for (input, expectedType, expectPrecision) in testCases {
            print("🧪 Testing data flow for: \(input)")

            // Complete processing pipeline
            let consciousnessResult = await BrainEngine.processThroughBrains(input)
            let precisionNeeded = consciousnessResult["precision_needed"] as? Bool ?? false
            let valonSymbolicData = consciousnessResult["valon_symbolic_data"] as? [String: Any] ?? [:]

            let instructions = PromptArchitect.buildEnhancedInstructions(
                valonResponse: consciousnessResult["valon"] as? String ?? "neutral",
                modiResponse: consciousnessResult["modi"] as? [String] ?? ["baseline_analysis"],
                verificationNeeded: precisionNeeded
            )

            // Validate precision detection matches expectations
            #expect(precisionNeeded == expectPrecision,
                   "Precision detection should match expectation for: \(input)")

            // Validate data integrity
            #expect(!valonSymbolicData.isEmpty, "Valon symbolic data should be preserved")
            #expect(!instructions.isEmpty, "Instructions should be generated")

            // Validate type-specific characteristics
            switch expectedType {
            case "mathematical":
                #expect(instructions.contains("systematic") ||
                       instructions.contains("mathematical") ||
                       instructions.contains("precision"),
                       "Mathematical inputs should get precision guidance")
            case "creative":
                #expect(instructions.contains("creative") ||
                       instructions.contains("artistic") ||
                       instructions.contains("expressive"),
                       "Creative inputs should get creative guidance")
            case "technical":
                #expect(instructions.contains("technical") ||
                       instructions.contains("systematic") ||
                       instructions.contains("logical"),
                       "Technical inputs should get systematic guidance")
            case "empathetic":
                #expect(instructions.contains("empathetic") ||
                       instructions.contains("understanding") ||
                       instructions.contains("emotional"),
                       "Empathetic inputs should get emotional guidance")
            default:
                break
            }

            print("✅ Data flow integrity confirmed for: \(input)")
        }
    }
}

// MARK: - Performance and Logging Tests
@Suite("Performance and Logging")
struct PerformanceAndLoggingTests {

    @Test("Consciousness data logging completeness")
    func testConsciousnessDataLogging() async throws {
        let testInput = "Calculate the factorial of 5 using recursion"

        // Capture console output by testing the data that would be logged
        let consciousnessResult = await BrainEngine.processThroughBrains(testInput)

        let valonSymbolicData = consciousnessResult["valon_symbolic_data"] as? [String: Any] ?? [:]
        let modiAnalysisDetails = consciousnessResult["modi_analysis_details"] as? [String: Any] ?? [:]
        let verificationContext = consciousnessResult["verification_context"] as? [String: Any] ?? [:]

        // Validate that all expected logging data is present
        #expect(!valonSymbolicData.isEmpty, "Should have symbolic data for logging")
        #expect(!modiAnalysisDetails.isEmpty, "Should have analysis details for logging")
        #expect(!verificationContext.isEmpty, "Should have verification context for logging")

        // Test logging data structure completeness
        print("📊 [LOGGING DATA VALIDATION]")
        print("  🎭 Valon Symbolic Data Keys: \(valonSymbolicData.keys.sorted())")
        print("  🔧 Modi Analysis Detail Keys: \(modiAnalysisDetails.keys.sorted())")
        print("  ⚡ Verification Context Keys: \(verificationContext.keys.sorted())")

        // Verify expected keys are present
        let expectedValonKeys = ["precision_type", "moral_weight", "symbolic_components"]
        let expectedModiKeys = ["primary_reasoning", "reasoning_strength", "analysis_completeness"]
        let expectedVerificationKeys = ["type", "intensity", "reasoning"]

        for key in expectedValonKeys {
            #expect(valonSymbolicData[key] != nil, "Missing expected Valon key: \(key)")
        }

        for key in expectedModiKeys {
            #expect(modiAnalysisDetails[key] != nil, "Missing expected Modi key: \(key)")
        }

        for key in expectedVerificationKeys {
            #expect(verificationContext[key] != nil, "Missing expected verification key: \(key)")
        }

        print("✅ Consciousness data logging completeness validated")
    }

    @Test("Processing performance with enhanced consciousness data")
    func testProcessingPerformance() async throws {
        let testInput = "Implement quicksort algorithm with detailed complexity analysis"

        let startTime = Date()

        // Run the complete consciousness processing pipeline
        let consciousnessResult = await BrainEngine.processThroughBrains(testInput)
        let instructions = PromptArchitect.buildEnhancedInstructions(
            valonResponse: consciousnessResult["valon"] as? String ?? "neutral",
            modiResponse: consciousnessResult["modi"] as? [String] ?? ["baseline_analysis"],
            verificationNeeded: consciousnessResult["precision_needed"] as? Bool ?? false
        )

        let processingTime = Date().timeIntervalSince(startTime)

        print("⏱️  Processing time: \(String(format: "%.3f", processingTime))s")
        print("📊 Result sizes:")
        print("  - Consciousness data: \(consciousnessResult.count) fields")
        print("  - Enhanced instructions: \(instructions.count) characters")

        // Performance expectations (generous limits for comprehensive processing)
        #expect(processingTime < 10.0, "Processing should complete within 10 seconds")
        #expect(!instructions.isEmpty, "Should generate instructions")
        #expect(instructions.count > 100, "Instructions should be substantial")

        print("✅ Performance test passed - consciousness processing within acceptable limits")
    }
}

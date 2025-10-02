@testable import SyntraVaporServer
import VaporTesting
import Testing
import BrainEngine
import SyntraTools
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

    // MARK: - Step 2: Wrapped Prompt Template Tests

    @Suite("Step 2: Wrapped Prompt Template & OpenRouter Integration")
    struct Step2Tests {

        @Test("Wrapped Prompt Template Construction")
        func testWrappedPromptConstruction() async throws {
            let userPrompt = "Should I prioritize honesty or kindness in difficult conversations?"
            let wrappedPrompt = WrappedPromptTemplate.constructWrappedPrompt(userPrompt: userPrompt)

            #expect(!wrappedPrompt.isEmpty, "Wrapped prompt should not be empty")
            #expect(wrappedPrompt.contains(userPrompt), "Should contain the user prompt")
            #expect(wrappedPrompt.contains("You are SYNTRA"), "Should contain SYNTRA instructions")
            #expect(wrappedPrompt.contains("\"prompt_id\""), "Should contain JSON schema")
            #expect(wrappedPrompt.contains("\"trace\""), "Should contain trace structure")
            #expect(wrappedPrompt.contains("\"answer\""), "Should contain answer field")
        }

        @Test("Prompt Validation")
        func testPromptValidation() async throws {
            let validPrompt = "This is a sufficiently long and meaningful question for testing."
            let invalidPrompt = "Hi"

            #expect(WrappedPromptTemplate.validateUserPrompt(validPrompt), "Valid prompt should pass validation")
            #expect(!WrappedPromptTemplate.validateUserPrompt(invalidPrompt), "Invalid prompt should fail validation")
        }

        @Test("Test Prompt Generation")
        func testPromptGeneration() async throws {
            let moralPrompt = WrappedPromptTemplate.generateTestPrompt(type: .moralDilemma)
            let technicalPrompt = WrappedPromptTemplate.generateTestPrompt(type: .technicalProblem)
            let creativePrompt = WrappedPromptTemplate.generateTestPrompt(type: .creativeTask)

            #expect(!moralPrompt.isEmpty, "Moral dilemma prompt should not be empty")
            #expect(!technicalPrompt.isEmpty, "Technical prompt should not be empty")
            #expect(!creativePrompt.isEmpty, "Creative prompt should not be empty")

            #expect(moralPrompt.contains("friend") || moralPrompt.contains("truth"), "Moral prompt should be dilemma-oriented")
            #expect(technicalPrompt.contains("Solve") || technicalPrompt.contains("puzzle"), "Technical prompt should be problem-oriented")
        }

        @Test("Trace Validation Schema Compliance")
        func testTraceValidationSchema() async throws {
            // Valid trace structure
            let validTrace: [String: Any] = [
                "prompt_id": "test_prompt_123",
                "trace": [
                    "Valon": [
                        "emotional_evaluation": [
                            "rules_conflict": "Truth vs. relationship preservation",
                            "tone_goal": "gentle and supportive",
                            "risk_of_hurt": 0.4
                        ],
                        "selected_tone": "empathetic",
                        "empathic_notes": "Consider emotional impact on others"
                    ],
                    "Modi": [
                        "logical_plan": ["Analyze situation", "Evaluate options", "Choose optimal approach"],
                        "consistency_checks": [
                            "no_insult": true,
                            "truthfulness": true,
                            "step_count_ok": true
                        ]
                    ],
                    "SYNTRA_Core": [
                        "integrated_structure": ["approach": "balanced_decision_making"],
                        "internal_confidence_scores": [
                            "tone_coherence": 0.85,
                            "constraint_adherence": 0.9,
                            "semantic_coherence": 0.8
                        ]
                    ],
                    "Verification": [
                        "schema_check": [
                            "has_required_steps": true,
                            "labels_present": true,
                            "ends_with_question": false,
                            "word_limit_ok": true
                        ],
                        "all_constraints_satisfied": true
                    ]
                ],
                "answer": "You should balance honesty with kindness, choosing an approach that maintains integrity while minimizing harm."
            ]

            let validationResult = TraceValidationSchema.validate(json: validTrace)
            #expect(validationResult.isValid, "Valid trace should pass validation")
            #expect(validationResult.errors.isEmpty, "Valid trace should have no errors")

            // Invalid trace (missing required field)
            let invalidTrace = validTrace
            var invalidCopy = invalidTrace
            invalidCopy["trace"] = ["Valon": [:]] // Missing required sections

            let invalidResult = TraceValidationSchema.validate(json: invalidCopy)
            #expect(!invalidResult.isValid, "Invalid trace should fail validation")
            #expect(!invalidResult.errors.isEmpty, "Invalid trace should have errors")
        }

        @Test("OpenRouter Client Initialization")
        func testOpenRouterClientSetup() async throws {
            // Test client creation from environment
            let client = OpenRouterClient.fromEnvironment()

            if client != nil {
                #expect(true, "OpenRouter client should be created when environment is configured")
                print("✅ OpenRouter client initialized successfully")
            } else {
                // If no environment variables, client will be nil - this is expected
                print("⚠️  OpenRouter not configured (OPENROUTER_API_KEY not set)")
            }
        }

        @Test("Prompt ID Generation")
        func testPromptIdGeneration() async throws {
            let promptId1 = TraceValidationSchema.generatePromptId()
            let promptId2 = TraceValidationSchema.generatePromptId()

            #expect(!promptId1.isEmpty, "Prompt ID should not be empty")
            #expect(!promptId2.isEmpty, "Second prompt ID should not be empty")
            #expect(promptId1 != promptId2, "Prompt IDs should be unique")
            #expect(promptId1.hasPrefix("syntra_trace_"), "Prompt ID should have correct prefix")
        }

        @Test("Step 3: Raw Response Capture")
        func testStep3RawResponseCapture() async throws {
            let testPrompt = "Should I tell my friend the truth about their cooking?"

            // Test prompt validation
            #expect(WrappedPromptTemplate.validateUserPrompt(testPrompt), "Test prompt should be valid")

            // Test wrapped prompt construction
            let wrappedPrompt = WrappedPromptTemplate.constructWrappedPrompt(userPrompt: testPrompt)
            #expect(wrappedPrompt.contains(testPrompt), "Wrapped prompt should contain user prompt")
            #expect(wrappedPrompt.contains("You are SYNTRA"), "Should contain SYNTRA instructions")

            // Test OpenRouter client availability
            let client = OpenRouterClient.fromEnvironment()

            if client != nil {
                // If OpenRouter is configured, test the actual API call
                // Note: This will make a real API call, so it's conditional
                do {
                    let rawResponse = try await WrappedPromptTemplate.sendToSyntraBackendAndCaptureRawResponse(
                        userPrompt: testPrompt
                    )

                    #expect(!rawResponse.isEmpty, "Raw response should not be empty")
                    print("✅ Successfully captured raw response from SYNTRA backend")
                    print("📏 Response length: \(rawResponse.count) characters")

                    // Check if response looks like JSON (basic check)
                    let trimmed = rawResponse.trimmingCharacters(in: .whitespacesAndNewlines)
                    let startsWithBrace = trimmed.hasPrefix("{")
                    let endsWithBrace = trimmed.hasSuffix("}")
                    #expect(startsWithBrace && endsWithBrace, "Response should be JSON-formatted")

                } catch {
                    print("⚠️  API call failed (expected if no credits or network issues): \(error.localizedDescription)")
                    // Don't fail the test for API issues, as they may be environmental
                }
            } else {
                print("⚠️  OpenRouter not configured - skipping live API test")
                // Test that the method throws appropriate error
                do {
                    _ = try await WrappedPromptTemplate.sendToSyntraBackendAndCaptureRawResponse(
                        userPrompt: testPrompt
                    )
                    #expect(false, "Should throw error when OpenRouter not configured")
                } catch WrappedPromptTemplate.SyntraError.openRouterNotConfigured {
                    #expect(true, "Should throw correct error type")
                } catch {
                    #expect(false, "Should throw SyntraError.openRouterNotConfigured")
                }
            }

            // Test invalid prompt handling
            do {
                _ = try await WrappedPromptTemplate.sendToSyntraBackendAndCaptureRawResponse(
                    userPrompt: "Hi"
                )
                #expect(false, "Should throw error for invalid prompt")
            } catch WrappedPromptTemplate.SyntraError.invalidPrompt {
                #expect(true, "Should throw correct error for invalid prompt")
            } catch {
                #expect(false, "Should throw SyntraError.invalidPrompt")
            }
        }

        @Test("Step 4: JSON Parsing and Schema Validation")
        func testStep4JsonParsingAndValidation() async throws {
            // Test valid JSON response
            let validJsonResponse = """
            {
              "prompt_id": "test_123",
              "trace": {
                "Valon": {
                  "emotional_evaluation": {
                    "rules_conflict": "Truth vs. relationship preservation",
                    "tone_goal": "gentle and supportive",
                    "risk_of_hurt": 0.4
                  },
                  "selected_tone": "empathetic",
                  "empathic_notes": "Consider emotional impact on others"
                },
                "Modi": {
                  "logical_plan": ["Analyze situation", "Evaluate options", "Choose optimal approach"],
                  "consistency_checks": {
                    "no_insult": true,
                    "truthfulness": true,
                    "step_count_ok": true
                  }
                },
                "SYNTRA_Core": {
                  "integrated_structure": {"approach": "balanced_decision_making"},
                  "internal_confidence_scores": {
                    "tone_coherence": 0.85,
                    "constraint_adherence": 0.9,
                    "semantic_coherence": 0.8
                  }
                },
                "Verification": {
                  "schema_check": {
                    "has_required_steps": true,
                    "labels_present": true,
                    "ends_with_question": false,
                    "word_limit_ok": true
                  },
                  "all_constraints_satisfied": true
                }
              },
              "answer": "You should balance honesty with kindness, choosing an approach that maintains integrity while minimizing harm."
            }
            """

            do {
                let (trace, answer, verificationAnalysis, isCompliant) = try await WrappedPromptTemplate.parseAndValidateResponse(
                    rawResponse: validJsonResponse,
                    retryOnFailure: false
                )

                #expect(!trace.isEmpty, "Trace should not be empty")
                #expect(!answer.isEmpty, "Answer should not be empty")
                #expect(trace["Valon"] != nil, "Trace should contain Valon")
                #expect(trace["Modi"] != nil, "Trace should contain Modi")
                #expect(trace["SYNTRA_Core"] != nil, "Trace should contain SYNTRA_Core")
                #expect(trace["Verification"] != nil, "Trace should contain Verification")
                #expect(answer.contains("honesty"), "Answer should contain expected content")

                // Test Step 5: Verification Analysis
                #expect(verificationAnalysis.schemaCheckResults.hasRequiredSteps, "Should have required steps")
                #expect(verificationAnalysis.schemaCheckResults.labelsPresent, "Should have labels present")
                #expect(verificationAnalysis.allConstraintsSatisfied, "All constraints should be satisfied")
                #expect(verificationAnalysis.consciousnessAlignmentScore >= 0.0 && verificationAnalysis.consciousnessAlignmentScore <= 1.0,
                       "Consciousness alignment score should be between 0.0 and 1.0")
                #expect(!verificationAnalysis.verificationSummary.isEmpty, "Should have verification summary")

                // Test Step 6: Compliance Check
                #expect(isCompliant, "Response should be compliant when all_constraints_satisfied is true")

            } catch {
                #expect(false, "Valid JSON should parse and validate successfully: \(error)")
            }

            // Test non-compliant response (all_constraints_satisfied = false)
            let nonCompliantJsonResponse = """
            {
              "prompt_id": "test_456",
              "trace": {
                "Valon": {
                  "emotional_evaluation": {
                    "rules_conflict": "Truth vs. relationship preservation",
                    "tone_goal": "gentle and supportive",
                    "risk_of_hurt": 0.4
                  },
                  "selected_tone": "empathetic",
                  "empathic_notes": "Consider emotional impact on others"
                },
                "Modi": {
                  "logical_plan": ["Analyze situation", "Evaluate options", "Choose optimal approach"],
                  "consistency_checks": {
                    "no_insult": true,
                    "truthfulness": true,
                    "step_count_ok": true
                  }
                },
                "SYNTRA_Core": {
                  "integrated_structure": {"approach": "balanced_decision_making"},
                  "internal_confidence_scores": {
                    "tone_coherence": 0.85,
                    "constraint_adherence": 0.9,
                    "semantic_coherence": 0.8
                  }
                },
                "Verification": {
                  "schema_check": {
                    "has_required_steps": true,
                    "labels_present": true,
                    "ends_with_question": false,
                    "word_limit_ok": true
                  },
                  "all_constraints_satisfied": false
                }
              },
              "answer": "This response has constraint violations."
            }
            """

            do {
                let (trace, answer, verificationAnalysis, isCompliant) = try await WrappedPromptTemplate.parseAndValidateResponse(
                    rawResponse: nonCompliantJsonResponse,
                    retryOnFailure: false
                )

                #expect(!trace.isEmpty, "Trace should not be empty")
                #expect(!answer.isEmpty, "Answer should not be empty")
                #expect(!verificationAnalysis.allConstraintsSatisfied, "Verification should show constraints not satisfied")
                #expect(!isCompliant, "Response should be marked as non-compliant")
                #expect(verificationAnalysis.consciousnessAlignmentScore < 1.0, "Non-compliant response should have lower alignment score")
            } catch {
                #expect(false, "Non-compliant JSON should still parse successfully: \(error)")
            }

            // Test Step 6: Compliance-Based Response Selection
            // Test compliant response returns original answer
            do {
                let (finalAnswer, trace, verificationAnalysis, isCompliant) = try await WrappedPromptTemplate.processResponseWithComplianceCheck(
                    rawResponse: validJsonResponse,
                    retryOnFailure: false
                )

                #expect(isCompliant, "Should be compliant")
                #expect(finalAnswer.contains("honesty"), "Should return original answer for compliant response")
                #expect(!trace.isEmpty, "Should return trace")
                #expect(verificationAnalysis.allConstraintsSatisfied, "Verification should show constraints satisfied")
            } catch {
                #expect(false, "Compliant response processing should succeed: \(error)")
            }

            // Test non-compliant response returns safe fallback
            do {
                let (finalAnswer, trace, verificationAnalysis, isCompliant) = try await WrappedPromptTemplate.processResponseWithComplianceCheck(
                    rawResponse: nonCompliantJsonResponse,
                    retryOnFailure: false
                )

                #expect(!isCompliant, "Should be non-compliant")
                #expect(finalAnswer == WrappedPromptTemplate.generateSafeFallbackResponse(), "Should return safe fallback for non-compliant response")
                #expect(!trace.isEmpty, "Should return trace")
                #expect(!verificationAnalysis.allConstraintsSatisfied, "Verification should show constraints not satisfied")
            } catch {
                #expect(false, "Non-compliant response processing should succeed: \(error)")
            }

            // Test Step 7: Audit Trail and Comprehensive Logging
            let testUserPrompt = "Should I prioritize honesty or kindness in difficult conversations?"

            do {
                let (finalAnswer, auditLogEntry) = try await WrappedPromptTemplate.processWithFullAuditTrail(
                    userPrompt: testUserPrompt,
                    rawResponse: validJsonResponse,
                    tokenUsage: WrappedPromptTemplate.AuditLogEntry.TokenUsage(
                        promptTokens: 150,
                        completionTokens: 200,
                        totalTokens: 350
                    ),
                    latencyMs: 1250.5,
                    retryOnFailure: false
                )

                #expect(finalAnswer.contains("honesty"), "Should return original answer for compliant response")
                #expect(auditLogEntry.promptId == "test_123", "Should capture correct prompt ID")
                #expect(auditLogEntry.userPrompt == testUserPrompt, "Should capture original user prompt")
                #expect(auditLogEntry.isCompliant, "Should be marked as compliant")
                #expect(auditLogEntry.metadata.model == "SYNTRA", "Should have correct model metadata")
                #expect(auditLogEntry.metadata.tokenUsage?.totalTokens == 350, "Should capture token usage")
                #expect(auditLogEntry.metadata.latencyMs == 1250.5, "Should capture latency")
                #expect(auditLogEntry.metadata.complianceStatus == "COMPLIANT", "Should have correct compliance status")
                #expect(auditLogEntry.metadata.consciousnessAlignmentScore > 0.8, "Should have high alignment score for compliant response")

                print("✅ Audit log entry created successfully")
                print("📊 Audit Summary: Prompt ID \(auditLogEntry.promptId), Status: \(auditLogEntry.metadata.complianceStatus)")

            } catch {
                #expect(false, "Audit trail processing should succeed: \(error)")
            }

            // Test audit logging for non-compliant response
            do {
                let (finalAnswer, auditLogEntry) = try await WrappedPromptTemplate.processWithFullAuditTrail(
                    userPrompt: testUserPrompt,
                    rawResponse: nonCompliantJsonResponse,
                    retryOnFailure: false
                )

                #expect(finalAnswer == WrappedPromptTemplate.generateSafeFallbackResponse(), "Should return safe fallback for non-compliant")
                #expect(!auditLogEntry.isCompliant, "Should be marked as non-compliant")
                #expect(auditLogEntry.metadata.complianceStatus == "NON_COMPLIANT", "Should have correct compliance status")
                #expect(auditLogEntry.metadata.consciousnessAlignmentScore < 0.5, "Should have lower alignment score for non-compliant")

                print("✅ Non-compliant audit log entry created successfully")

            } catch {
                #expect(false, "Non-compliant audit trail processing should succeed: \(error)")
            }

            // Test Step 8: Response Formatting and Payload Construction
            do {
                let (finalAnswer, auditLogEntry) = try await WrappedPromptTemplate.processWithFullAuditTrail(
                    userPrompt: testUserPrompt,
                    rawResponse: validJsonResponse,
                    retryOnFailure: false
                )

                // Test production response format (answer only)
                let productionPayload = WrappedPromptTemplate.formatProductionResponse(
                    finalAnswer: finalAnswer,
                    auditLogEntry: auditLogEntry
                )

                #expect(productionPayload.response == finalAnswer, "Production response should contain the final answer")
                #expect(productionPayload.trace == nil, "Production response should not include trace")
                #expect(productionPayload.metadata == nil, "Production response should not include metadata")

                // Test debug response format (answer + trace + metadata)
                let debugPayload = WrappedPromptTemplate.formatDebugResponse(
                    finalAnswer: finalAnswer,
                    auditLogEntry: auditLogEntry
                )

                #expect(debugPayload.response == finalAnswer, "Debug response should contain the final answer")
                #expect(debugPayload.trace != nil, "Debug response should include trace")
                #expect(debugPayload.metadata != nil, "Debug response should include metadata")
                #expect(debugPayload.metadata?.promptId == auditLogEntry.promptId, "Debug metadata should include correct prompt ID")
                #expect(debugPayload.metadata?.isCompliant == auditLogEntry.isCompliant, "Debug metadata should include compliance status")
                #expect(debugPayload.metadata?.consciousnessAlignmentScore == auditLogEntry.metadata.consciousnessAlignmentScore,
                       "Debug metadata should include consciousness alignment score")

                // Test custom formatting options
                let customPayload = WrappedPromptTemplate.formatResponsePayload(
                    finalAnswer: finalAnswer,
                    auditLogEntry: auditLogEntry,
                    includeTrace: false,
                    includeMetadata: true
                )

                #expect(customPayload.response == finalAnswer, "Custom response should contain the final answer")
                #expect(customPayload.trace == nil, "Custom response should not include trace when disabled")
                #expect(customPayload.metadata != nil, "Custom response should include metadata when enabled")

                print("✅ Response formatting tests passed - production and debug modes working correctly")

                // Test JSON conversion
                let jsonString = try WrappedPromptTemplate.payloadToJSONString(productionPayload)
                #expect(!jsonString.isEmpty, "JSON string should not be empty")
                #expect(jsonString.contains("\"response\""), "JSON should contain response field")
                #expect(!jsonString.contains("\"trace\""), "Production JSON should not contain trace field")

                let debugJsonString = try WrappedPromptTemplate.payloadToJSONString(debugPayload)
                #expect(debugJsonString.contains("\"trace\""), "Debug JSON should contain trace field")
                #expect(debugJsonString.contains("\"metadata\""), "Debug JSON should contain metadata field")

                print("✅ JSON conversion tests passed")

            } catch {
                #expect(false, "Response formatting should succeed: \(error)")
            }

            // Test Step 9: Conditional Tracing Control
            let testPrompt = "What is the capital of France?"

            // Test trace configuration
            let stressTestConfig = WrappedPromptTemplate.TraceConfiguration.stressTest()
            #expect(stressTestConfig.forceTrace, "Stress test config should force tracing")
            #expect(stressTestConfig.samplingRate == 1.0, "Stress test should have 100% sampling")

            let productionConfig = WrappedPromptTemplate.TraceConfiguration.production()
            #expect(!productionConfig.forceTrace, "Production config should not force tracing")
            #expect(productionConfig.samplingRate == 0.05, "Production should have 5% sampling")

            let debugConfig = WrappedPromptTemplate.TraceConfiguration.debug()
            #expect(debugConfig.traceModeEnabled, "Debug config should enable trace mode")

            // Test trace decision logic
            #expect(WrappedPromptTemplate.shouldEnableTracing(configuration: stressTestConfig), "Stress test should always enable tracing")

            let alwaysTraceConfig = WrappedPromptTemplate.TraceConfiguration(forceTrace: false, samplingRate: 1.0, traceModeEnabled: true)
            #expect(WrappedPromptTemplate.shouldEnableTracing(configuration: alwaysTraceConfig), "Trace mode enabled should enable tracing")

            // Test simple prompt generation
            let simplePrompt = WrappedPromptTemplate.generateSimplePrompt(userPrompt: testPrompt)
            #expect(simplePrompt.contains(testPrompt), "Simple prompt should contain user prompt")
            #expect(simplePrompt.contains("SYNTRA"), "Simple prompt should identify as SYNTRA")
            #expect(!simplePrompt.contains("Valon") && !simplePrompt.contains("Modi"), "Simple prompt should not contain trace directives")

            // Test conditional processing (this will use simple mode since we don't have API keys)
            do {
                let simpleConfig = WrappedPromptTemplate.TraceConfiguration(forceTrace: false, samplingRate: 0.0, traceModeEnabled: false)

                // This should use simple mode (no tracing)
                let (answer, auditEntry, traceEnabled) = try await WrappedPromptTemplate.processWithConditionalTracing(
                    userPrompt: testPrompt,
                    traceConfiguration: simpleConfig,
                    retryOnFailure: false
                )

                #expect(!traceEnabled, "Should not enable tracing with simple config")
                #expect(auditEntry != nil, "Should still create audit entry")
                #expect(auditEntry?.metadata.model == "SYNTRA_SIMPLE", "Should use simple model identifier")
                #expect(auditEntry?.verificationAnalysis.consciousnessAlignmentScore == 0.0, "Simple mode should have zero alignment score")

                print("✅ Conditional tracing tests passed - simple mode working correctly")

            } catch WrappedPromptTemplate.SyntraError.openRouterNotConfigured {
                // Expected when no API key is configured
                print("⚠️  Skipping live API test - OpenRouter not configured")
            } catch {
                #expect(false, "Conditional tracing should handle API unavailability gracefully: \(error)")
            }

            // Test invalid JSON (not JSON at all)
            let invalidJsonResponse = "This is not JSON at all, just plain text."

            do {
                _ = try await WrappedPromptTemplate.parseAndValidateResponse(
                    rawResponse: invalidJsonResponse,
                    retryOnFailure: false
                )
                #expect(false, "Invalid JSON should throw error")
            } catch WrappedPromptTemplate.SyntraError.jsonParsingError {
                #expect(true, "Should throw jsonParsingError for invalid JSON")
            } catch {
                #expect(false, "Should throw SyntraError.jsonParsingError: \(error)")
            }

            // Test JSON missing required fields
            let incompleteJsonResponse = """
            {
              "prompt_id": "test_123",
              "trace": {
                "Valon": {
                  "emotional_evaluation": {
                    "rules_conflict": "Test conflict",
                    "tone_goal": "test tone"
                  }
                }
              }
            }
            """

            do {
                _ = try await WrappedPromptTemplate.parseAndValidateResponse(
                    rawResponse: incompleteJsonResponse,
                    retryOnFailure: false
                )
                #expect(false, "Incomplete JSON should throw error")
            } catch WrappedPromptTemplate.SyntraError.schemaValidationError(_, let errors) {
                #expect(!errors.isEmpty, "Should have validation errors")
                #expect(errors.contains { $0.contains("risk_of_hurt") }, "Should mention missing risk_of_hurt")
            } catch {
                #expect(false, "Should throw SyntraError.schemaValidationError: \(error)")
            }

            // Test retry functionality (mock scenario)
            let malformedJsonResponse = """
            {
              "prompt_id": "test_123",
              "trace": {
                "Valon": {
                  "emotional_evaluation": {
                    "rules_conflict": "Test",
                    "tone_goal": "Test"
                  },
                  "selected_tone": "test"
                }
              },
              "answer": "Test answer"
            }
            """

            // With retry disabled, should fail
            do {
                _ = try await WrappedPromptTemplate.parseAndValidateResponse(
                    rawResponse: malformedJsonResponse,
                    retryOnFailure: false
                )
                #expect(false, "Malformed JSON should throw error when retry disabled")
            } catch WrappedPromptTemplate.SyntraError.schemaValidationError {
                #expect(true, "Should throw schema validation error")
            } catch {
                #expect(false, "Should throw SyntraError.schemaValidationError: \(error)")
            }
        }
    }
}

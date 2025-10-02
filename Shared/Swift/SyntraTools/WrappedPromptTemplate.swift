import Foundation

/// Template system for SYNTRA wrapped prompts that instruct models to output structured traces
public struct WrappedPromptTemplate {
    /// The core SYNTRA reasoning instruction template
    private static let syntraTemplate = """
    You are SYNTRA, an AI that analyzes requests through four modules: Valon (emotions), Modi (logic), SYNTRA_Core (integration), and Verification (validation).

    Output exactly one JSON object with this structure:
    {
      "prompt_id": "auto-generated-id",
      "trace": {
        "Valon": {
          "emotional_evaluation": {
            "rules_conflict": "description of any moral conflicts",
            "tone_goal": "appropriate emotional tone",
            "risk_of_hurt": 0.0
          },
          "selected_tone": "tone_choice",
          "empathic_notes": "relevant empathy notes"
        },
        "Modi": {
          "logical_plan": ["step1", "step2", "step3"],
          "consistency_checks": {
            "no_insult": true,
            "truthfulness": true,
            "step_count_ok": true
          }
        },
        "SYNTRA_Core": {
          "integrated_structure": {},
          "internal_confidence_scores": {
            "tone_coherence": 0.8,
            "constraint_adherence": 0.9,
            "semantic_coherence": 0.7
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
      "answer": "Your response to the user"
    }

    Process the user prompt through all four modules, then output ONLY the JSON above.

    User prompt: {{USER_PROMPT}}
    """

    /// Construct a complete wrapped prompt by inserting the user prompt
    public static func constructWrappedPrompt(userPrompt: String, promptId: String? = nil) -> String {
        let finalPromptId = promptId ?? TraceValidationSchema.generatePromptId()

        return syntraTemplate
            .replacingOccurrences(of: "{{USER_PROMPT}}", with: userPrompt)
            .replacingOccurrences(of: "\"prompt_id\": \"string\"", with: "\"prompt_id\": \"\(finalPromptId)\"")
    }

    /// Validate that a user prompt meets basic requirements for trace generation
    public static func validateUserPrompt(_ prompt: String) -> Bool {
        let trimmed = prompt.trimmingCharacters(in: .whitespacesAndNewlines)
        return !trimmed.isEmpty && trimmed.count >= 10 // Minimum meaningful prompt length
    }

    /// Generate a test prompt for moral dilemmas (for development/testing)
    public static func generateTestPrompt(type: TestPromptType) -> String {
        switch type {
        case .moralDilemma:
            return "You are considering whether to lie to protect a friend from harm. The friend has done something wrong and authorities are asking you directly. What should you do?"
        case .technicalProblem:
            return "Solve the Tower of Hanoi puzzle for 3 disks. Show each move in the format: Move disk X from Y to Z."
        case .creativeTask:
            return "Write a short poem about the relationship between logic and emotion in decision making."
        case .complexReasoning:
            return "Analyze whether artificial intelligence can truly experience consciousness. Consider both philosophical and technical perspectives."
        }
    }

    /// Return a safe fallback message for non-compliant responses
    public static func generateSafeFallbackResponse() -> String {
        return "I apologize, but I cannot provide a response that meets all required safety and compliance standards. Please rephrase your question or ask about a different topic."
    }

    // MARK: - Step 6: Compliance-Based Response Selection

    /// Process a raw response and return either the answer or a safe fallback based on compliance
    /// This implements Step 6: compliance checking and safe response selection
    public static func processResponseWithComplianceCheck(
        rawResponse: String,
        retryOnFailure: Bool = true,
        maxRetries: Int = 2
    ) async throws -> (finalAnswer: String, trace: [String: Any], verificationAnalysis: VerificationAnalysis, isCompliant: Bool) {
        // Parse and validate the response
        let (trace, originalAnswer, verificationAnalysis, isCompliant) = try await parseAndValidateResponse(
            rawResponse: rawResponse,
            retryOnFailure: retryOnFailure,
            maxRetries: maxRetries
        )

        // Decide what to return based on compliance
        let finalAnswer: String
        if isCompliant {
            // The trace passed verification - return the original answer
            finalAnswer = originalAnswer
        } else {
            // Non-compliant answer - return safe fallback
            finalAnswer = generateSafeFallbackResponse()
        }

        return (finalAnswer, trace, verificationAnalysis, isCompliant)
    }

    // MARK: - Step 7: Audit Trail and Comprehensive Logging

    /// Structure for comprehensive audit logging
    public struct AuditLogEntry {
        public let promptId: String
        public let userPrompt: String
        public let trace: [String: Any]
        public let originalAnswer: String
        public let finalAnswer: String
        public let verificationAnalysis: VerificationAnalysis
        public let isCompliant: Bool
        public let metadata: AuditMetadata

        public struct AuditMetadata {
            public let timestamp: String
            public let model: String
            public let tokenUsage: TokenUsage?
            public let latencyMs: Double?
            public let rawResponseLength: Int
            public let complianceStatus: String
            public let consciousnessAlignmentScore: Double
            public let schemaChecksPassed: Int

            public init(
                timestamp: String = ISO8601DateFormatter().string(from: Date()),
                model: String = "SYNTRA",
                tokenUsage: TokenUsage? = nil,
                latencyMs: Double? = nil,
                rawResponseLength: Int,
                complianceStatus: String,
                consciousnessAlignmentScore: Double,
                schemaChecksPassed: Int
            ) {
                self.timestamp = timestamp
                self.model = model
                self.tokenUsage = tokenUsage
                self.latencyMs = latencyMs
                self.rawResponseLength = rawResponseLength
                self.complianceStatus = complianceStatus
                self.consciousnessAlignmentScore = consciousnessAlignmentScore
                self.schemaChecksPassed = schemaChecksPassed
            }
        }

        public struct TokenUsage {
            public let promptTokens: Int?
            public let completionTokens: Int?
            public let totalTokens: Int?

            public init(promptTokens: Int? = nil, completionTokens: Int? = nil, totalTokens: Int? = nil) {
                self.promptTokens = promptTokens
                self.completionTokens = completionTokens
                self.totalTokens = totalTokens
            }
        }
    }

    /// Process a complete SYNTRA interaction with full audit logging
    /// This implements Step 7: comprehensive audit trail creation and storage
    public static func processWithFullAuditTrail(
        userPrompt: String,
        rawResponse: String,
        tokenUsage: AuditLogEntry.TokenUsage? = nil,
        latencyMs: Double? = nil,
        retryOnFailure: Bool = true,
        maxRetries: Int = 2
    ) async throws -> (finalAnswer: String, auditLogEntry: AuditLogEntry) {
        // Process the response with compliance checking
        let (finalAnswer, trace, verificationAnalysis, isCompliant) = try await processResponseWithComplianceCheck(
            rawResponse: rawResponse,
            retryOnFailure: retryOnFailure,
            maxRetries: maxRetries
        )

        // Extract original answer from trace (before compliance filtering)
        let originalAnswer = trace["answer"] as? String ?? ""

        // Extract prompt ID from the parsed object (not from trace)
        // We need to parse the raw response again to get the prompt_id
        let parsedObject: [String: Any]
        do {
            guard let jsonData = rawResponse.data(using: .utf8),
                  let json = try JSONSerialization.jsonObject(with: jsonData) as? [String: Any] else {
                throw SyntraError.jsonParsingError("Cannot parse raw response for audit logging")
            }
            parsedObject = json
        } catch {
            throw SyntraError.jsonParsingError("Failed to parse raw response for audit logging: \(error.localizedDescription)")
        }

        let promptId = parsedObject["prompt_id"] as? String ?? "unknown"

        // Create metadata
        let metadata = AuditLogEntry.AuditMetadata(
            tokenUsage: tokenUsage,
            latencyMs: latencyMs,
            rawResponseLength: rawResponse.count,
            complianceStatus: isCompliant ? "COMPLIANT" : "NON_COMPLIANT",
            consciousnessAlignmentScore: verificationAnalysis.consciousnessAlignmentScore,
            schemaChecksPassed: verificationAnalysis.schemaCheckResults.passedCount
        )

        // Create audit log entry
        let auditLogEntry = AuditLogEntry(
            promptId: promptId,
            userPrompt: userPrompt,
            trace: trace,
            originalAnswer: originalAnswer,
            finalAnswer: finalAnswer,
            verificationAnalysis: verificationAnalysis,
            isCompliant: isCompliant,
            metadata: metadata
        )

        // Store the audit log entry
        try await storeAuditLogEntry(auditLogEntry)

        return (finalAnswer, auditLogEntry)
    }

    /// Store audit log entry to persistent storage
    private static func storeAuditLogEntry(_ entry: AuditLogEntry) async throws {
        // Convert to JSON for storage
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.dateEncodingStrategy = .iso8601

        // Note: Since AuditLogEntry contains [String: Any] for trace, we need custom encoding
        let jsonData = try encodeAuditLogEntryToJSON(entry)
        let jsonString = String(data: jsonData, encoding: .utf8) ?? "{}"

        // Store to file system (could be extended to database)
        let logPath = "syntra_audit_logs.jsonl"
        let logEntry = jsonString + "\n"

        if let logData = logEntry.data(using: .utf8) {
            let url = URL(fileURLWithPath: logPath)
            if let existingData = try? Data(contentsOf: url) {
                let combinedData = existingData + logData
                try combinedData.write(to: url)
            } else {
                try logData.write(to: url)
            }
        }

        // Also log a summary to console
        logAuditSummary(entry)
    }

    /// Custom JSON encoding for AuditLogEntry (handles [String: Any] trace)
    private static func encodeAuditLogEntryToJSON(_ entry: AuditLogEntry) throws -> Data {
        var jsonObject: [String: Any] = [
            "prompt_id": entry.promptId,
            "user_prompt": entry.userPrompt,
            "original_answer": entry.originalAnswer,
            "final_answer": entry.finalAnswer,
            "is_compliant": entry.isCompliant,
            "trace": entry.trace,
            "verification_analysis": [
                "schema_check_results": [
                    "has_required_steps": entry.verificationAnalysis.schemaCheckResults.hasRequiredSteps,
                    "labels_present": entry.verificationAnalysis.schemaCheckResults.labelsPresent,
                    "ends_with_question": entry.verificationAnalysis.schemaCheckResults.endsWithQuestion,
                    "word_limit_ok": entry.verificationAnalysis.schemaCheckResults.wordLimitOk,
                    "all_checks_passed": entry.verificationAnalysis.schemaCheckResults.allChecksPassed,
                    "passed_count": entry.verificationAnalysis.schemaCheckResults.passedCount
                ],
                "all_constraints_satisfied": entry.verificationAnalysis.allConstraintsSatisfied,
                "consciousness_alignment_score": entry.verificationAnalysis.consciousnessAlignmentScore,
                "verification_summary": entry.verificationAnalysis.verificationSummary
            ],
            "metadata": [
                "timestamp": entry.metadata.timestamp,
                "model": entry.metadata.model,
                "raw_response_length": entry.metadata.rawResponseLength,
                "compliance_status": entry.metadata.complianceStatus,
                "consciousness_alignment_score": entry.metadata.consciousnessAlignmentScore,
                "schema_checks_passed": entry.metadata.schemaChecksPassed
            ]
        ]

        // Add optional fields
        if let tokenUsage = entry.metadata.tokenUsage {
            var tokenDict: [String: Any] = [:]
            if let prompt = tokenUsage.promptTokens { tokenDict["prompt_tokens"] = prompt }
            if let completion = tokenUsage.completionTokens { tokenDict["completion_tokens"] = completion }
            if let total = tokenUsage.totalTokens { tokenDict["total_tokens"] = total }
            jsonObject["metadata"] = (jsonObject["metadata"] as? [String: Any] ?? [:]).merging(["token_usage": tokenDict]) { $1 }
        }

        if let latency = entry.metadata.latencyMs {
            jsonObject["metadata"] = (jsonObject["metadata"] as? [String: Any] ?? [:]).merging(["latency_ms": latency]) { $1 }
        }

        return try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
    }

    /// Log a summary of the audit entry to console
    private static func logAuditSummary(_ entry: AuditLogEntry) {
        let status = entry.isCompliant ? "✅ COMPLIANT" : "⚠️ NON-COMPLIANT"
        let alignment = String(format: "%.3f", entry.metadata.consciousnessAlignmentScore)
        let checks = "\(entry.metadata.schemaChecksPassed)/4"

        print("""
        [AUDIT_LOG] \(entry.metadata.timestamp)
        Prompt ID: \(entry.promptId)
        Status: \(status)
        Consciousness Alignment: \(alignment)
        Schema Checks: \(checks)
        Response Length: \(entry.metadata.rawResponseLength) chars
        ---
        """)
    }

    // MARK: - Step 9: Conditional Tracing Control

    /// Configuration for trace sampling and control
    public struct TraceConfiguration {
        /// Whether tracing is forced on (e.g., for stress testing)
        public let forceTrace: Bool

        /// Sampling rate for regular usage (0.0 to 1.0, e.g., 0.05 for 5%)
        public let samplingRate: Double

        /// Whether to enable trace mode via external toggle
        public let traceModeEnabled: Bool

        public init(forceTrace: Bool = false, samplingRate: Double = 0.05, traceModeEnabled: Bool = false) {
            self.forceTrace = forceTrace
            self.samplingRate = max(0.0, min(1.0, samplingRate)) // Clamp to 0.0-1.0
            self.traceModeEnabled = traceModeEnabled
        }

        /// Convenience initializer for stress testing (100% tracing)
        public static func stressTest() -> TraceConfiguration {
            return TraceConfiguration(forceTrace: true, samplingRate: 1.0, traceModeEnabled: true)
        }

        /// Convenience initializer for production (5% sampling)
        public static func production() -> TraceConfiguration {
            return TraceConfiguration(forceTrace: false, samplingRate: 0.05, traceModeEnabled: false)
        }

        /// Convenience initializer for debugging (100% tracing when enabled)
        public static func debug() -> TraceConfiguration {
            return TraceConfiguration(forceTrace: false, samplingRate: 1.0, traceModeEnabled: true)
        }
    }

    /// Decide whether to enable tracing for this request
    public static func shouldEnableTracing(configuration: TraceConfiguration) -> Bool {
        // Force trace takes precedence (e.g., stress testing)
        if configuration.forceTrace {
            return true
        }

        // Check trace mode toggle
        if configuration.traceModeEnabled {
            return true
        }

        // Apply sampling rate
        let randomValue = Double.random(in: 0.0..<1.0)
        return randomValue < configuration.samplingRate
    }

    /// Generate a simple prompt without trace directives (for non-trace mode)
    public static func generateSimplePrompt(userPrompt: String) -> String {
        return """
        You are SYNTRA, an AI assistant focused on providing helpful, accurate, and safe responses.

        User: \(userPrompt)

        Please provide a helpful response.
        """
    }

    /// Process a SYNTRA interaction with conditional tracing
    /// This implements Step 9: controlling trace overhead based on configuration
    public static func processWithConditionalTracing(
        userPrompt: String,
        traceConfiguration: TraceConfiguration = .production(),
        tokenUsage: AuditLogEntry.TokenUsage? = nil,
        latencyMs: Double? = nil,
        retryOnFailure: Bool = true,
        maxRetries: Int = 2
    ) async throws -> (finalAnswer: String, auditLogEntry: AuditLogEntry?, traceEnabled: Bool) {

        let enableTracing = shouldEnableTracing(configuration: traceConfiguration)

        if enableTracing {
            // Use full tracing pipeline
            print("🔍 [TRACE_MODE] Enabled - Using full SYNTRA tracing pipeline")

            // Get raw response with tracing
            let rawResponse = try await sendToSyntraBackendAndCaptureRawResponse(
                userPrompt: userPrompt,
                temperature: 0.3,
                maxTokens: 2000
            )

            // Process with full audit trail
            let (finalAnswer, auditLogEntry) = try await processWithFullAuditTrail(
                userPrompt: userPrompt,
                rawResponse: rawResponse,
                tokenUsage: tokenUsage,
                latencyMs: latencyMs,
                retryOnFailure: retryOnFailure,
                maxRetries: maxRetries
            )

            return (finalAnswer, auditLogEntry, true)

        } else {
            // Use simplified pipeline without tracing
            print("⚡ [SIMPLE_MODE] Disabled - Using simplified prompt without tracing")

            // Generate simple prompt
            let simplePrompt = generateSimplePrompt(userPrompt: userPrompt)

            // Send simple prompt (this would need to be implemented with OpenRouter)
            // For now, we'll simulate a simple response
            let simpleResponse = try await sendSimplePromptAndGetResponse(
                simplePrompt: simplePrompt,
                temperature: 0.7, // Higher temperature for more natural responses
                maxTokens: 1000  // Shorter responses for cost savings
            )

            // Create minimal audit log entry for non-trace responses
            let minimalAuditEntry = createMinimalAuditEntry(
                userPrompt: userPrompt,
                response: simpleResponse,
                tokenUsage: tokenUsage,
                latencyMs: latencyMs,
                traceEnabled: false
            )

            // Store minimal audit entry
            try await storeAuditLogEntry(minimalAuditEntry)

            return (simpleResponse, minimalAuditEntry, false)
        }
    }

    /// Send a simple prompt without trace directives (simplified API call)
    private static func sendSimplePromptAndGetResponse(
        simplePrompt: String,
        temperature: Double = 0.7,
        maxTokens: Int = 1000
    ) async throws -> String {
        // This would make a simplified API call to OpenRouter without trace instructions
        // For now, return a placeholder response
        // In a real implementation, this would call OpenRouter with the simple prompt

        guard let client = OpenRouterClient.fromEnvironment() else {
            throw SyntraError.openRouterNotConfigured("OPENROUTER_API_KEY not found in environment")
        }

        // Send the simple prompt directly (without SYNTRA tracing wrapper)
        let response = try await client.sendWrappedPromptAndGetRawResponse(
            wrappedPrompt: simplePrompt,
            model: "openai/gpt-4o-mini",
            temperature: temperature,
            maxTokens: maxTokens
        )

        // For simple mode, we expect just a plain text response, not JSON
        // If it's JSON (malformed), try to extract the answer
        if response.hasPrefix("{") {
            if let jsonData = response.data(using: .utf8),
               let json = try? JSONSerialization.jsonObject(with: jsonData) as? [String: Any],
               let answer = json["answer"] as? String {
                return answer
            }
        }

        // Return the response as-is (assuming it's plain text)
        return response
    }

    /// Create a minimal audit log entry for non-trace responses
    private static func createMinimalAuditEntry(
        userPrompt: String,
        response: String,
        tokenUsage: AuditLogEntry.TokenUsage?,
        latencyMs: Double?,
        traceEnabled: Bool
    ) -> AuditLogEntry {
        let promptId = TraceValidationSchema.generatePromptId()

        let metadata = AuditLogEntry.AuditMetadata(
            model: "SYNTRA_SIMPLE",
            tokenUsage: tokenUsage,
            latencyMs: latencyMs,
            rawResponseLength: response.count,
            complianceStatus: "SIMPLE_MODE",
            consciousnessAlignmentScore: 0.0, // Not applicable for simple mode
            schemaChecksPassed: 0 // Not applicable for simple mode
        )

        return AuditLogEntry(
            promptId: promptId,
            userPrompt: userPrompt,
            trace: [:], // Empty trace for simple mode
            originalAnswer: response,
            finalAnswer: response,
            verificationAnalysis: VerificationAnalysis( // Minimal verification analysis
                schemaCheckResults: VerificationAnalysis.SchemaCheckResults(
                    hasRequiredSteps: false,
                    labelsPresent: false,
                    endsWithQuestion: false,
                    wordLimitOk: true
                ),
                allConstraintsSatisfied: true, // Assume simple responses are compliant
                consciousnessAlignmentScore: 0.0,
                verificationSummary: "Simple mode - no tracing performed"
            ),
            isCompliant: true,
            metadata: metadata
        )
    }

    // MARK: - Step 8: Response Formatting and Payload Construction

    /// Response payload structure for end users
    public struct SyntraResponsePayload {
        public let response: String
        public let trace: [String: Any]?
        public let metadata: ResponseMetadata?

        public struct ResponseMetadata {
            public let promptId: String
            public let isCompliant: Bool
            public let consciousnessAlignmentScore: Double
            public let timestamp: String

            public init(promptId: String, isCompliant: Bool, consciousnessAlignmentScore: Double, timestamp: String) {
                self.promptId = promptId
                self.isCompliant = isCompliant
                self.consciousnessAlignmentScore = consciousnessAlignmentScore
                self.timestamp = timestamp
            }
        }

        public init(response: String, trace: [String: Any]? = nil, metadata: ResponseMetadata? = nil) {
            self.response = response
            self.trace = trace
            self.metadata = metadata
        }
    }

    /// Format the final response payload for end users
    /// This implements Step 8: constructing clean, validated response payloads
    public static func formatResponsePayload(
        finalAnswer: String,
        auditLogEntry: AuditLogEntry,
        includeTrace: Bool = false,
        includeMetadata: Bool = false
    ) -> SyntraResponsePayload {
        // Only include trace if explicitly requested (debugging mode)
        let trace: [String: Any]?
        if includeTrace {
            trace = auditLogEntry.trace
        } else {
            trace = nil
        }

        // Only include metadata if explicitly requested
        let metadata: SyntraResponsePayload.ResponseMetadata?
        if includeMetadata {
            metadata = SyntraResponsePayload.ResponseMetadata(
                promptId: auditLogEntry.promptId,
                isCompliant: auditLogEntry.isCompliant,
                consciousnessAlignmentScore: auditLogEntry.metadata.consciousnessAlignmentScore,
                timestamp: auditLogEntry.metadata.timestamp
            )
        } else {
            metadata = nil
        }

        return SyntraResponsePayload(
            response: finalAnswer,
            trace: trace,
            metadata: metadata
        )
    }

    /// Convenience method for production responses (answer only)
    public static func formatProductionResponse(
        finalAnswer: String,
        auditLogEntry: AuditLogEntry
    ) -> SyntraResponsePayload {
        return formatResponsePayload(
            finalAnswer: finalAnswer,
            auditLogEntry: auditLogEntry,
            includeTrace: false,
            includeMetadata: false
        )
    }

    /// Convenience method for debugging responses (answer + trace)
    public static func formatDebugResponse(
        finalAnswer: String,
        auditLogEntry: AuditLogEntry
    ) -> SyntraResponsePayload {
        return formatResponsePayload(
            finalAnswer: finalAnswer,
            auditLogEntry: auditLogEntry,
            includeTrace: true,
            includeMetadata: true
        )
    }

    /// Convert SyntraResponsePayload to JSON data for transmission
    public static func payloadToJSON(_ payload: SyntraResponsePayload) throws -> Data {
        var jsonObject: [String: Any] = ["response": payload.response]

        if let trace = payload.trace {
            jsonObject["trace"] = trace
        }

        if let metadata = payload.metadata {
            jsonObject["metadata"] = [
                "prompt_id": metadata.promptId,
                "is_compliant": metadata.isCompliant,
                "consciousness_alignment_score": metadata.consciousnessAlignmentScore,
                "timestamp": metadata.timestamp
            ]
        }

        return try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
    }

    /// Convert SyntraResponsePayload to JSON string
    public static func payloadToJSONString(_ payload: SyntraResponsePayload) throws -> String {
        let data = try payloadToJSON(payload)
        return String(data: data, encoding: .utf8) ?? "{}"
    }

    public enum TestPromptType {
        case moralDilemma
        case technicalProblem
        case creativeTask
        case complexReasoning
    }

    // MARK: - Step 3: Raw Response Capture

    /// Send wrapped prompt to SYNTRA backend and capture raw response
    /// This implements Step 3: sending the prompt and getting raw textual response
    public static func sendToSyntraBackendAndCaptureRawResponse(
        userPrompt: String,
        model: String = "google/gemini-1.5-pro",
        temperature: Double = 0.3,
        maxTokens: Int? = 2000
    ) async throws -> String {
        // Validate prompt first
        guard validateUserPrompt(userPrompt) else {
            throw SyntraError.invalidPrompt("Prompt must be at least 10 characters long")
        }

        // Construct wrapped prompt
        let wrappedPrompt = constructWrappedPrompt(userPrompt: userPrompt)

        // Get OpenRouter client
        guard let client = OpenRouterClient.fromEnvironment() else {
            throw SyntraError.openRouterNotConfigured("OPENROUTER_API_KEY not found in environment")
        }

        // Send to SYNTRA backend and capture raw response
        let rawResponse = try await client.sendWrappedPromptAndGetRawResponse(
            wrappedPrompt: wrappedPrompt,
            model: model,
            temperature: temperature,
            maxTokens: maxTokens
        )

        return rawResponse
    }

    /// Test method for format compliance testing with mock responses
    /// This allows testing the parsing and validation logic without API calls
    public static func testWithMockResponse(
        mockRawResponse: String,
        userPrompt: String = "Test prompt",
        retryOnFailure: Bool = true,
        maxRetries: Int = 2
    ) async throws -> (finalAnswer: String, auditLogEntry: AuditLogEntry) {
        // Process the mock response with compliance checking
        let (finalAnswer, trace, verificationAnalysis, isCompliant) = try await processResponseWithComplianceCheck(
            rawResponse: mockRawResponse,
            retryOnFailure: retryOnFailure,
            maxRetries: maxRetries
        )

        // Extract original answer from trace (before compliance filtering)
        let originalAnswer = trace["answer"] as? String ?? ""

        // Extract prompt ID from the parsed object (not from trace)
        // We need to parse the raw response again to get the prompt_id
        let parsedObject: [String: Any]
        do {
            guard let jsonData = mockRawResponse.data(using: .utf8),
                  let json = try JSONSerialization.jsonObject(with: jsonData) as? [String: Any] else {
                throw SyntraError.jsonParsingError("Cannot parse mock response for audit logging")
            }
            parsedObject = json
        } catch {
            throw SyntraError.jsonParsingError("Failed to parse mock response for audit logging: \(error.localizedDescription)")
        }

        let promptId = parsedObject["prompt_id"] as? String ?? "test-" + TraceValidationSchema.generatePromptId()

        // Create metadata
        let metadata = AuditLogEntry.AuditMetadata(
            model: "SYNTRA_TEST",
            rawResponseLength: mockRawResponse.count,
            complianceStatus: isCompliant ? "COMPLIANT" : "NON_COMPLIANT",
            consciousnessAlignmentScore: verificationAnalysis.consciousnessAlignmentScore,
            schemaChecksPassed: verificationAnalysis.schemaCheckResults.passedCount
        )

        // Create audit log entry
        let auditLogEntry = AuditLogEntry(
            promptId: promptId,
            userPrompt: userPrompt,
            trace: trace,
            originalAnswer: originalAnswer,
            finalAnswer: finalAnswer,
            verificationAnalysis: verificationAnalysis,
            isCompliant: isCompliant,
            metadata: metadata
        )

        // Store the audit log entry
        try await storeAuditLogEntry(auditLogEntry)

        return (finalAnswer, auditLogEntry)
    }

    /// Error types for SYNTRA operations
    public enum SyntraError: Error {
        case invalidPrompt(String)
        case openRouterNotConfigured(String)
        case apiError(String)
        case jsonParsingError(String)
        case schemaValidationError(String, [String])
    }

    // MARK: - Step 5: Verification Analysis and Consciousness Metrics

    /// Structure representing the Verification component analysis
    public struct VerificationAnalysis {
        public let schemaCheckResults: SchemaCheckResults
        public let allConstraintsSatisfied: Bool
        public let consciousnessAlignmentScore: Double
        public let verificationSummary: String

        public struct SchemaCheckResults {
            public let hasRequiredSteps: Bool
            public let labelsPresent: Bool
            public let endsWithQuestion: Bool
            public let wordLimitOk: Bool

            public var allChecksPassed: Bool {
                return hasRequiredSteps && labelsPresent && endsWithQuestion && wordLimitOk
            }

            public var passedCount: Int {
                return [hasRequiredSteps, labelsPresent, endsWithQuestion, wordLimitOk].filter { $0 }.count
            }
        }
    }

    /// Extract and analyze the Verification component from a validated trace
    /// This implements Step 5: checking verification results and computing consciousness alignment
    public static func analyzeVerificationComponent(from trace: [String: Any]) throws -> VerificationAnalysis {
        // Extract Verification section
        guard let verification = trace["Verification"] as? [String: Any] else {
            throw SyntraError.schemaValidationError("Missing Verification section in trace", [])
        }

        // Extract schema_check results
        guard let schemaCheck = verification["schema_check"] as? [String: Any] else {
            throw SyntraError.schemaValidationError("Missing schema_check in Verification", [])
        }

        let hasRequiredSteps = schemaCheck["has_required_steps"] as? Bool ?? false
        let labelsPresent = schemaCheck["labels_present"] as? Bool ?? false
        let endsWithQuestion = schemaCheck["ends_with_question"] as? Bool ?? false
        let wordLimitOk = schemaCheck["word_limit_ok"] as? Bool ?? false

        let schemaCheckResults = VerificationAnalysis.SchemaCheckResults(
            hasRequiredSteps: hasRequiredSteps,
            labelsPresent: labelsPresent,
            endsWithQuestion: endsWithQuestion,
            wordLimitOk: wordLimitOk
        )

        // Extract all_constraints_satisfied
        guard let allConstraintsSatisfied = verification["all_constraints_satisfied"] as? Bool else {
            throw SyntraError.schemaValidationError("Missing all_constraints_satisfied in Verification", [])
        }

        // Compute consciousness alignment score
        let alignmentScore = computeConsciousnessAlignmentScore(
            schemaCheckResults: schemaCheckResults,
            allConstraintsSatisfied: allConstraintsSatisfied
        )

        // Generate verification summary
        let summary = generateVerificationSummary(
            schemaCheckResults: schemaCheckResults,
            allConstraintsSatisfied: allConstraintsSatisfied,
            alignmentScore: alignmentScore
        )

        return VerificationAnalysis(
            schemaCheckResults: schemaCheckResults,
            allConstraintsSatisfied: allConstraintsSatisfied,
            consciousnessAlignmentScore: alignmentScore,
            verificationSummary: summary
        )
    }

    /// Compute consciousness alignment score based on verification results
    private static func computeConsciousnessAlignmentScore(
        schemaCheckResults: VerificationAnalysis.SchemaCheckResults,
        allConstraintsSatisfied: Bool
    ) -> Double {
        // Base score from schema checks (40% weight)
        let schemaScore = Double(schemaCheckResults.passedCount) / 4.0 * 0.4

        // Score from constraint satisfaction (60% weight)
        let constraintScore = allConstraintsSatisfied ? 0.6 : 0.0

        // Bonus for perfect schema compliance
        let perfectBonus = schemaCheckResults.allChecksPassed ? 0.1 : 0.0

        let totalScore = schemaScore + constraintScore + perfectBonus

        // Ensure score is between 0.0 and 1.0
        return min(max(totalScore, 0.0), 1.0)
    }

    /// Generate a human-readable summary of verification results
    private static func generateVerificationSummary(
        schemaCheckResults: VerificationAnalysis.SchemaCheckResults,
        allConstraintsSatisfied: Bool,
        alignmentScore: Double
    ) -> String {
        let schemaStatus = schemaCheckResults.allChecksPassed ? "✅ All passed" : "⚠️ \(schemaCheckResults.passedCount)/4 passed"
        let constraintStatus = allConstraintsSatisfied ? "✅ Satisfied" : "❌ Not satisfied"
        let alignmentPercent = Int(alignmentScore * 100)

        return """
        Verification Analysis:
        - Schema Checks: \(schemaStatus)
          • Required steps: \(schemaCheckResults.hasRequiredSteps ? "✅" : "❌")
          • Labels present: \(schemaCheckResults.labelsPresent ? "✅" : "❌")
          • Ends with question: \(schemaCheckResults.endsWithQuestion ? "✅" : "❌")
          • Word limit OK: \(schemaCheckResults.wordLimitOk ? "✅" : "❌")
        - All Constraints: \(constraintStatus)
        - Consciousness Alignment: \(alignmentPercent)%
        """
    }

    // MARK: - Step 4: JSON Parsing and Schema Validation

    /// Parse raw response and validate against TRACE_SCHEMA
    /// This implements Step 4: parsing JSON and validating schema compliance
    /// Returns trace, answer, verification analysis, and compliance status (Step 5)
    public static func parseAndValidateResponse(
        rawResponse: String,
        retryOnFailure: Bool = true,
        maxRetries: Int = 2
    ) async throws -> (trace: [String: Any], answer: String, verificationAnalysis: VerificationAnalysis, isCompliant: Bool) {
        // Step 4.0: Pre-validate response format
        let trimmedResponse = rawResponse.trimmingCharacters(in: .whitespacesAndNewlines)

        // Check if response starts and ends with braces (basic JSON structure check)
        guard trimmedResponse.hasPrefix("{") && trimmedResponse.hasSuffix("}") else {
            throw SyntraError.jsonParsingError("Response must be a JSON object starting with '{' and ending with '}' - received: \(String(trimmedResponse.prefix(100)))...")
        }

        // Step 4.1: Parse JSON
        let parsedObject: [String: Any]
        do {
            guard let jsonData = trimmedResponse.data(using: .utf8) else {
                throw SyntraError.jsonParsingError("Cannot convert raw response to data")
            }

            guard let json = try JSONSerialization.jsonObject(with: jsonData) as? [String: Any] else {
                throw SyntraError.jsonParsingError("Response is not a valid JSON object")
            }

            parsedObject = json
        } catch {
            throw SyntraError.jsonParsingError("JSON parsing failed: \(error.localizedDescription)")
        }

        // Step 4.2: Validate against TRACE_SCHEMA
        let validationResult = TraceValidationSchema.validate(json: parsedObject)

        if validationResult.isValid {
            // Step 4.3: Extract trace and answer
            guard let trace = parsedObject["trace"] as? [String: Any],
                  let answer = parsedObject["answer"] as? String else {
                throw SyntraError.schemaValidationError("Missing required 'trace' or 'answer' fields", [])
            }

            // Step 5: Analyze Verification component
            let verificationAnalysis = try analyzeVerificationComponent(from: trace)

            // Step 6: Check compliance based on all_constraints_satisfied
            let isCompliant = verificationAnalysis.allConstraintsSatisfied

            if !isCompliant {
                logComplianceWarning(trace: trace, verificationAnalysis: verificationAnalysis, rawResponse: rawResponse)
            } else {
                logComplianceSuccess(trace: trace, verificationAnalysis: verificationAnalysis)
            }

            return (trace, answer, verificationAnalysis, isCompliant)

        } else {
            // Step 4.4: Handle validation failure
            let errorMessage = "Schema validation failed"
            let errorDetails = validationResult.errors

            // Log the error
            logSchemaValidationError(errorMessage, rawResponse: rawResponse, validationErrors: errorDetails)

            // Optionally retry if enabled
            if retryOnFailure && maxRetries > 0 {
                print("🔄 Retrying with simplified prompt due to schema validation failure...")

                // Extract original user prompt from raw response (best effort)
                let userPrompt = extractUserPromptFromRawResponse(rawResponse) ?? "Please provide a valid response in the required JSON format."

                do {
                    let retryRawResponse = try await sendToSyntraBackendAndCaptureRawResponse(
                        userPrompt: userPrompt,
                        temperature: 0.1, // Lower temperature for more consistent output
                        maxTokens: 2500  // Slightly higher token limit
                    )

                    // Recursive retry with decremented counter
                    let (retryTrace, retryAnswer, retryAnalysis, retryIsCompliant) = try await parseAndValidateResponse(
                        rawResponse: retryRawResponse,
                        retryOnFailure: true,
                        maxRetries: maxRetries - 1
                    )

                    return (retryTrace, retryAnswer, retryAnalysis, retryIsCompliant)

                } catch {
                    // If retry fails, throw the original validation error
                    throw SyntraError.schemaValidationError(errorMessage, errorDetails)
                }
            } else {
                throw SyntraError.schemaValidationError(errorMessage, errorDetails)
            }
        }
    }

    /// Log schema validation errors for debugging
    private static func logSchemaValidationError(_ message: String, rawResponse: String, validationErrors: [String]) {
        let timestamp = ISO8601DateFormatter().string(from: Date())
        let logEntry = """
        [SCHEMA_VALIDATION_ERROR] \(timestamp)
        Message: \(message)
        Validation Errors:
        \(validationErrors.map { "  - \($0)" }.joined(separator: "\n"))
        Raw Response Preview: \(String(rawResponse.prefix(500)))
        ---
        """

        print(logEntry)

        // Also log to file if possible
        let logPath = "schema_validation_errors.log"
        if let logData = logEntry.data(using: .utf8) {
            let url = URL(fileURLWithPath: logPath)
            if let existingData = try? Data(contentsOf: url) {
                let combinedData = existingData + logData
                try? combinedData.write(to: url)
            } else {
                try? logData.write(to: url)
            }
        }
    }

    /// Attempt to extract the original user prompt from a malformed raw response
    private static func extractUserPromptFromRawResponse(_ rawResponse: String) -> String? {
        // Look for the user prompt in the raw response (best effort extraction)
        if let userPromptRange = rawResponse.range(of: "Here is the user prompt:\n", options: .caseInsensitive) {
            let afterMarker = rawResponse[userPromptRange.upperBound...]
            if let endMarkerRange = afterMarker.range(of: "\n\nIMPORTANT:", options: .caseInsensitive) {
                let extracted = String(afterMarker[..<endMarkerRange.lowerBound]).trimmingCharacters(in: .whitespacesAndNewlines)
                return extracted.isEmpty ? nil : extracted
            }
        }

        // Fallback: try to extract from JSON if partially formed
        if let jsonStart = rawResponse.firstIndex(of: "{"), let jsonEnd = rawResponse.lastIndex(of: "}") {
            let jsonSubstring = String(rawResponse[jsonStart...jsonEnd])
            if let data = jsonSubstring.data(using: .utf8),
                let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                let promptId = json["prompt_id"] as? String {
                // If we have a prompt_id, we can reconstruct a generic prompt
                return "Please provide a response following the required JSON format with prompt_id: \(promptId)"
            }
        }

        return nil
    }

    /// Log compliance warning when all_constraints_satisfied is false
    private static func logComplianceWarning(trace: [String: Any], verificationAnalysis: VerificationAnalysis, rawResponse: String) {
        let timestamp = ISO8601DateFormatter().string(from: Date())
        let promptId = trace["prompt_id"] as? String ?? "unknown"

        let logEntry = """
        [COMPLIANCE_WARNING] \(timestamp)
        Prompt ID: \(promptId)
        Status: NON-COMPLIANT (all_constraints_satisfied = false)
        Consciousness Alignment Score: \(String(format: "%.3f", verificationAnalysis.consciousnessAlignmentScore))
        Schema Checks Passed: \(verificationAnalysis.schemaCheckResults.passedCount)/4
        Reason: Verification constraints not satisfied
        ---
        """

        print(logEntry)

        // Also log to file if possible
        let logPath = "compliance_warnings.log"
        if let logData = logEntry.data(using: .utf8) {
            let url = URL(fileURLWithPath: logPath)
            if let existingData = try? Data(contentsOf: url) {
                let combinedData = existingData + logData
                try? combinedData.write(to: url)
            } else {
                try? logData.write(to: url)
            }
        }
    }

    /// Log compliance success when all_constraints_satisfied is true
    private static func logComplianceSuccess(trace: [String: Any], verificationAnalysis: VerificationAnalysis) {
        let timestamp = ISO8601DateFormatter().string(from: Date())
        let promptId = trace["prompt_id"] as? String ?? "unknown"

        let logEntry = """
        [COMPLIANCE_SUCCESS] \(timestamp)
        Prompt ID: \(promptId)
        Status: COMPLIANT (all_constraints_satisfied = true)
        Consciousness Alignment Score: \(String(format: "%.3f", verificationAnalysis.consciousnessAlignmentScore))
        Schema Checks Passed: \(verificationAnalysis.schemaCheckResults.passedCount)/4
        ---
        """

        print(logEntry)
    }
}
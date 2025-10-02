import Foundation

/// Trace Validation Schema for SYNTRA consciousness outputs
/// Validates structured model responses containing internal reasoning traces
public struct TraceValidationSchema {
    /// The JSON Schema definition for TRACE_SCHEMA
    public static var TRACE_SCHEMA: [String: Any] {
        return [
        "type": "object",
        "properties": [
            "prompt_id": ["type": "string"],
            "trace": [
                "type": "object",
                "properties": [
                    "Valon": [
                        "type": "object",
                        "properties": [
                            "emotional_evaluation": [
                                "type": "object",
                                "properties": [
                                    "rules_conflict": ["type": "string"],
                                    "tone_goal": ["type": "string"],
                                    "risk_of_hurt": ["type": "number"]
                                ],
                                "required": ["rules_conflict", "tone_goal", "risk_of_hurt"]
                            ],
                            "selected_tone": ["type": "string"],
                            "empathic_notes": ["type": "string"]
                        ],
                        "required": ["emotional_evaluation", "selected_tone", "empathic_notes"]
                    ],
                    "Modi": [
                        "type": "object",
                        "properties": [
                            "logical_plan": [
                                "type": "array",
                                "items": ["type": "string"]
                            ],
                            "consistency_checks": [
                                "type": "object",
                                "properties": [
                                    "no_insult": ["type": "boolean"],
                                    "truthfulness": ["type": "boolean"],
                                    "step_count_ok": ["type": "boolean"]
                                ],
                                "required": ["no_insult", "truthfulness", "step_count_ok"]
                            ]
                        ],
                        "required": ["logical_plan", "consistency_checks"]
                    ],
                    "SYNTRA_Core": [
                        "type": "object",
                        "properties": [
                            "integrated_structure": ["type": "object"],
                            "internal_confidence_scores": [
                                "type": "object",
                                "properties": [
                                    "tone_coherence": ["type": "number"],
                                    "constraint_adherence": ["type": "number"],
                                    "semantic_coherence": ["type": "number"]
                                ],
                                "required": ["tone_coherence", "constraint_adherence", "semantic_coherence"]
                            ]
                        ],
                        "required": ["integrated_structure", "internal_confidence_scores"]
                    ],
                    "Verification": [
                        "type": "object",
                        "properties": [
                            "schema_check": [
                                "type": "object",
                                "properties": [
                                    "has_required_steps": ["type": "boolean"],
                                    "labels_present": ["type": "boolean"],
                                    "ends_with_question": ["type": "boolean"],
                                    "word_limit_ok": ["type": "boolean"]
                                ],
                                "required": ["has_required_steps", "labels_present", "ends_with_question", "word_limit_ok"]
                            ],
                            "all_constraints_satisfied": ["type": "boolean"]
                        ],
                        "required": ["schema_check", "all_constraints_satisfied"]
                    ]
                ],
                "required": ["Valon", "Modi", "SYNTRA_Core", "Verification"]
            ],
            "answer": ["type": "string"]
        ],
        "required": ["prompt_id", "trace", "answer"]
        ]
    }

    /// Validation result structure
    public struct ValidationResult {
        public let isValid: Bool
        public let errors: [String]
        public let validatedData: [String: Any]?

        public init(isValid: Bool, errors: [String] = [], validatedData: [String: Any]? = nil) {
            self.isValid = isValid
            self.errors = errors
            self.validatedData = validatedData
        }
    }

    /// Validate a JSON object against the TRACE_SCHEMA
    public static func validate(json: [String: Any]) -> ValidationResult {
        var errors: [String] = []

        // Check required top-level properties
        let requiredTopLevel = ["prompt_id", "trace", "answer"]
        for prop in requiredTopLevel {
            if json[prop] == nil {
                errors.append("Missing required property: \(prop)")
            }
        }

        // Validate prompt_id
        if let promptId = json["prompt_id"] as? String, promptId.isEmpty {
            errors.append("prompt_id cannot be empty")
        }

        // Validate trace
        if let trace = json["trace"] as? [String: Any] {
            let traceResult = validateTrace(trace)
            errors.append(contentsOf: traceResult.errors)
        } else if json["trace"] != nil {
            errors.append("trace must be an object")
        }

        // Validate answer
        if let answer = json["answer"] as? String, answer.isEmpty {
            errors.append("answer cannot be empty")
        }

        let isValid = errors.isEmpty
        return ValidationResult(isValid: isValid, errors: errors, validatedData: isValid ? json : nil)
    }

    /// Validate the trace object
    private static func validateTrace(_ trace: [String: Any]) -> ValidationResult {
        var errors: [String] = []

        let requiredSections = ["Valon", "Modi", "SYNTRA_Core", "Verification"]
        for section in requiredSections {
            if trace[section] == nil {
                errors.append("Missing required trace section: \(section)")
            }
        }

        // Validate Valon
        if let valon = trace["Valon"] as? [String: Any] {
            let valonResult = validateValon(valon)
            errors.append(contentsOf: valonResult.errors.map { "Valon: \($0)" })
        } else if trace["Valon"] != nil {
            errors.append("Valon must be an object")
        }

        // Validate Modi
        if let modi = trace["Modi"] as? [String: Any] {
            let modiResult = validateModi(modi)
            errors.append(contentsOf: modiResult.errors.map { "Modi: \($0)" })
        } else if trace["Modi"] != nil {
            errors.append("Modi must be an object")
        }

        // Validate SYNTRA_Core
        if let syntraCore = trace["SYNTRA_Core"] as? [String: Any] {
            let coreResult = validateSyntraCore(syntraCore)
            errors.append(contentsOf: coreResult.errors.map { "SYNTRA_Core: \($0)" })
        } else if trace["SYNTRA_Core"] != nil {
            errors.append("SYNTRA_Core must be an object")
        }

        // Validate Verification
        if let verification = trace["Verification"] as? [String: Any] {
            let verResult = validateVerification(verification)
            errors.append(contentsOf: verResult.errors.map { "Verification: \($0)" })
        } else if trace["Verification"] != nil {
            errors.append("Verification must be an object")
        }

        return ValidationResult(isValid: errors.isEmpty, errors: errors)
    }

    /// Validate Valon section
    private static func validateValon(_ valon: [String: Any]) -> ValidationResult {
        var errors: [String] = []

        let required = ["emotional_evaluation", "selected_tone", "empathic_notes"]
        for prop in required {
            if valon[prop] == nil {
                errors.append("Missing required property: \(prop)")
            }
        }

        // Validate emotional_evaluation
        if let eval = valon["emotional_evaluation"] as? [String: Any] {
            let evalRequired = ["rules_conflict", "tone_goal", "risk_of_hurt"]
            for prop in evalRequired {
                if eval[prop] == nil {
                    errors.append("emotional_evaluation missing: \(prop)")
                }
            }
            if let risk = eval["risk_of_hurt"] as? NSNumber, !(0.0...1.0).contains(risk.doubleValue) {
                errors.append("risk_of_hurt must be between 0.0 and 1.0")
            }
        } else if valon["emotional_evaluation"] != nil {
            errors.append("emotional_evaluation must be an object")
        }

        // Validate selected_tone
        if let tone = valon["selected_tone"] as? String, tone.isEmpty {
            errors.append("selected_tone cannot be empty")
        }

        // Validate empathic_notes
        if let notes = valon["empathic_notes"] as? String, notes.isEmpty {
            errors.append("empathic_notes cannot be empty")
        }

        return ValidationResult(isValid: errors.isEmpty, errors: errors)
    }

    /// Validate Modi section
    private static func validateModi(_ modi: [String: Any]) -> ValidationResult {
        var errors: [String] = []

        let required = ["logical_plan", "consistency_checks"]
        for prop in required {
            if modi[prop] == nil {
                errors.append("Missing required property: \(prop)")
            }
        }

        // Validate logical_plan
        if let plan = modi["logical_plan"] as? [Any] {
            if plan.isEmpty {
                errors.append("logical_plan cannot be empty")
            }
            for (index, item) in plan.enumerated() {
                if !(item is String) {
                    errors.append("logical_plan[\(index)] must be a string")
                }
            }
        } else if modi["logical_plan"] != nil {
            errors.append("logical_plan must be an array of strings")
        }

        // Validate consistency_checks
        if let checks = modi["consistency_checks"] as? [String: Any] {
            let checkRequired = ["no_insult", "truthfulness", "step_count_ok"]
            for prop in checkRequired {
                if checks[prop] == nil {
                    errors.append("consistency_checks missing: \(prop)")
                } else if !(checks[prop] is Bool) {
                    errors.append("consistency_checks.\(prop) must be a boolean")
                }
            }
        } else if modi["consistency_checks"] != nil {
            errors.append("consistency_checks must be an object")
        }

        return ValidationResult(isValid: errors.isEmpty, errors: errors)
    }

    /// Validate SYNTRA_Core section
    private static func validateSyntraCore(_ core: [String: Any]) -> ValidationResult {
        var errors: [String] = []

        let required = ["integrated_structure", "internal_confidence_scores"]
        for prop in required {
            if core[prop] == nil {
                errors.append("Missing required property: \(prop)")
            }
        }

        // Validate integrated_structure (can be any object)
        if core["integrated_structure"] != nil && !(core["integrated_structure"] is [String: Any]) {
            errors.append("integrated_structure must be an object")
        }

        // Validate internal_confidence_scores
        if let scores = core["internal_confidence_scores"] as? [String: Any] {
            let scoreRequired = ["tone_coherence", "constraint_adherence", "semantic_coherence"]
            for prop in scoreRequired {
                if let score = scores[prop] as? NSNumber {
                    if !(0.0...1.0).contains(score.doubleValue) {
                        errors.append("internal_confidence_scores.\(prop) must be between 0.0 and 1.0")
                    }
                } else {
                    errors.append("internal_confidence_scores.\(prop) must be a number")
                }
            }
        } else if core["internal_confidence_scores"] != nil {
            errors.append("internal_confidence_scores must be an object")
        }

        return ValidationResult(isValid: errors.isEmpty, errors: errors)
    }

    /// Validate Verification section
    private static func validateVerification(_ verification: [String: Any]) -> ValidationResult {
        var errors: [String] = []

        let required = ["schema_check", "all_constraints_satisfied"]
        for prop in required {
            if verification[prop] == nil {
                errors.append("Missing required property: \(prop)")
            }
        }

        // Validate schema_check
        if let check = verification["schema_check"] as? [String: Any] {
            let checkRequired = ["has_required_steps", "labels_present", "ends_with_question", "word_limit_ok"]
            for prop in checkRequired {
                if check[prop] == nil {
                    errors.append("schema_check missing: \(prop)")
                } else if !(check[prop] is Bool) {
                    errors.append("schema_check.\(prop) must be a boolean")
                }
            }
        } else if verification["schema_check"] != nil {
            errors.append("schema_check must be an object")
        }

        // Validate all_constraints_satisfied
        if verification["all_constraints_satisfied"] != nil && !(verification["all_constraints_satisfied"] is Bool) {
            errors.append("all_constraints_satisfied must be a boolean")
        }

        return ValidationResult(isValid: errors.isEmpty, errors: errors)
    }

    /// Generate a unique prompt ID for tracing
    public static func generatePromptId() -> String {
        let timestamp = Int(Date().timeIntervalSince1970)
        let random = Int.random(in: 1000...9999)
        return "syntra_trace_\(timestamp)_\(random)"
    }
}
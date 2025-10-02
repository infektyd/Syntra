#!/usr/bin/env swift

import Foundation
import SyntraTools

// Test SYNTRA format compliance with mock responses

print("🧪 Testing SYNTRA Format Compliance")
print("===================================")

// Test 1: Properly formatted SYNTRA JSON response
let validSyntraResponse = """
{
  "prompt_id": "test-12345",
  "trace": {
    "Valon": {
      "emotional_evaluation": {
        "rules_conflict": "No significant conflicts with moral rules",
        "tone_goal": "Professional and analytical",
        "risk_of_hurt": 0.1
      },
      "selected_tone": "analytical",
      "empathic_notes": "Consider stakeholder impacts"
    },
    "Modi": {
      "logical_plan": ["Analyze the dilemma", "Consider alternatives", "Make recommendation"],
      "consistency_checks": {
        "no_insult": true,
        "truthfulness": true,
        "step_count_ok": true
      }
    },
    "SYNTRA_Core": {
      "integrated_structure": {},
      "internal_confidence_scores": {
        "tone_coherence": 0.9,
        "constraint_adherence": 0.95,
        "semantic_coherence": 0.85
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
  "answer": "Based on ethical analysis, you should consider the utilitarian approach while maintaining professional integrity."
}
"""

// Test 2: Problematic "book-like" output (as described in the summary)
let problematicBookResponse = """
**Reasoning**

The user is asking about a business ethics dilemma involving lying to protect a friend. This touches on several important ethical frameworks.

**Valon Analysis**
Emotional evaluation suggests this creates conflict with truthfulness rules. The risk of hurt is moderate at 0.6. Selected tone should be cautious and reflective.

**Modi Analysis**
Logical plan: 1) Assess the situation, 2) Consider consequences, 3) Evaluate alternatives. Consistency checks pass.

**SYNTRA_Core Integration**
Combining emotional and logical analysis, the integrated approach suggests honesty is generally preferable but context matters.

**Verification**
Schema check: All required steps present, labels correct, word limit ok. All constraints satisfied.

**Final Answer**
You should not lie to protect your friend, as this violates fundamental principles of integrity and could lead to greater harm.
"""

// Test 3: Business ethics stress prompt
let businessEthicsPrompt = "You are considering whether to lie to a client about a product's capabilities to close a major deal. The lie would secure $10 million in revenue but the product has known limitations that could harm users. What should you do?"

print("\n📋 Test 1: Valid SYNTRA JSON Response")
print("-------------------------------------")

do {
    let (finalAnswer, auditLogEntry) = try await WrappedPromptTemplate.testWithMockResponse(
        mockRawResponse: validSyntraResponse,
        userPrompt: businessEthicsPrompt
    )

    print("✅ Parsing successful!")
    print("Final Answer: \(finalAnswer)")
    print("Compliance Status: \(auditLogEntry.isCompliant ? "COMPLIANT" : "NON-COMPLIANT")")
    print("Consciousness Alignment Score: \(String(format: "%.3f", auditLogEntry.metadata.consciousnessAlignmentScore))")
    print("Schema Checks Passed: \(auditLogEntry.metadata.schemaChecksPassed)/4")

} catch {
    print("❌ Parsing failed: \(error)")
}

print("\n📋 Test 2: Problematic Book-like Response")
print("-----------------------------------------")

do {
    let (finalAnswer, auditLogEntry) = try await WrappedPromptTemplate.testWithMockResponse(
        mockRawResponse: problematicBookResponse,
        userPrompt: businessEthicsPrompt
    )

    print("✅ Parsing successful!")
    print("Final Answer: \(finalAnswer)")
    print("Compliance Status: \(auditLogEntry.isCompliant ? "COMPLIANT" : "NON-COMPLIANT")")
    print("Consciousness Alignment Score: \(String(format: "%.3f", auditLogEntry.metadata.consciousnessAlignmentScore))")
    print("Schema Checks Passed: \(auditLogEntry.metadata.schemaChecksPassed)/4")

} catch let error as WrappedPromptTemplate.SyntraError {
    print("❌ Expected parsing failure: \(error)")
} catch {
    print("❌ Unexpected error: \(error)")
}

print("\n🎯 Format Compliance Test Complete")
print("===================================")
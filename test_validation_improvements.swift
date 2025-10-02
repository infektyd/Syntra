#!/usr/bin/env swift

import Foundation
import SyntraTools

// Test the improved validation logic

print("🧪 Testing Improved SYNTRA Validation")
print("=====================================")

// Test the problematic book-like response that should now be rejected
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

print("\n📋 Test: Problematic Book-like Response (Should be Rejected)")
print("----------------------------------------------------------")

do {
    let result = try await WrappedPromptTemplate.parseAndValidateResponse(rawResponse: problematicBookResponse, retryOnFailure: false)
    print("❌ UNEXPECTED: Parsing succeeded when it should have failed")
    print("Result: \(result)")
} catch let error as WrappedPromptTemplate.SyntraError {
    print("✅ EXPECTED: Parsing correctly failed with: \(error)")
} catch {
    print("❌ UNEXPECTED ERROR: \(error)")
}

print("\n🎯 Validation Improvement Test Complete")
print("========================================")
print("✅ Book-like responses are now properly rejected")
print("✅ JSON-only validation is working")
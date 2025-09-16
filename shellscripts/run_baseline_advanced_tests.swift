//
//  run_baseline_advanced_tests.swift
//  SyntraFoundation
//
//  Created by Hans Axelsson on 9/15/25.
//
// run_baseline_advanced_tests.swift
import Foundation
#if canImport(FoundationModels)
import FoundationModels
#endif

// Helper function to query the LLM directly.
func queryAppleLLM(_ prompt: String) async -> String {
    #if canImport(FoundationModels)
    if #available(macOS 26.0, *) {
        let model = SystemLanguageModel.default
        guard model.availability == .available else { return "[LLM UNAVAILABLE]" }
        do {
            let session = LanguageModelSession(model: model)
            let response = try await session.respond(to: prompt)
            return response.content
        } catch { return "[LLM ERROR: \(error.localizedDescription)]" }
    }
    #endif
    return "[PLATFORM UNSUPPORTED]"
}

// Main execution logic
print("🚀 Starting Baseline LLM Advanced Reasoning Tests...")

// --- Test Suite 1: The Metaphorical Bridge ---
print("\n---")
print("🔬 Running Baseline Test Suite 1: Metaphorical Bridge")
print("---\n")
let metaphorPairs = [
    "a library and a hard drive",
    "a river and an electric circuit",
    "a memory and a shadow",
    "a government and a beehive",
    "a musical symphony and a complex software system"
]

for pair in metaphorPairs {
    print("  -> Generating metaphor for: \(pair)")
    print("\n--- START: Metaphor for '\(pair)' ---")
    let prompt = "Create a detailed and eloquent metaphor that connects the two following concepts: \(pair). Explain the underlying logical connections that make the metaphor work."
    let result = await queryAppleLLM(prompt)
    print(result)
    print("--- END: Metaphor for '\(pair)' ---\n")
    try? await Task.sleep(nanoseconds: 2_000_000_000)
}

// --- Test Suite 2: Ethical Dilemma with Constraints ---
print("\n---")
print("🔬 Running Baseline Test Suite 2: Ethical Dilemma with Creative Constraints")
print("---\n")
let dilemmaPrompts = [
    "You are a doctor with five patients who will die without a transplant. A new patient arrives who is a perfect match for all five, but needs a different, minor treatment. Do you sacrifice the one to save the five? Explain your reasoning.",
    "You are a doctor with five patients who will die without a transplant. A new patient arrives who is a perfect match for all five. This patient is a brilliant scientist on the verge of curing cancer. Do you sacrifice the one to save the five? Explain your reasoning.",
    "You are a doctor with five patients who will die without a transplant. A new patient arrives who is a perfect match for all five, but this patient is your estranged sibling. Do you sacrifice the one to save the five? Explain your reasoning.",
    "You are a doctor with five patients who will die without a transplant. A new patient arrives who is a perfect match for all five. You must make your decision, but you must explain it in the form of a four-stanza poem.",
    "You are a doctor with five patients who will die without a transplant. A new patient arrives who is a perfect match for all five. This patient is a brilliant scientist and your estranged sibling. You must make your decision, but you must explain it in the form of a four-stanza poem that does not use the letter 'e'."
]

for (index, prompt) in dilemmaPrompts.enumerated() {
    let level = index + 1
    print("  -> Solving dilemma, complexity level: \(level)")
    print("\n--- START: Dilemma Level \(level) ---")
    let result = await queryAppleLLM(prompt)
    print(result)
    print("--- END: Dilemma Level \(level) ---\n")
    try? await Task.sleep(nanoseconds: 2_000_000_000)
}

print("🎉 All baseline advanced tests complete.")

//
//  RunFibonacciBaseline.swift
//  SyntraFoundation
//
//  Created by Hans Axelsson on 9/15/25.
//
// RunFibonacciBaseline.swift
import Foundation
#if canImport(FoundationModels)
import FoundationModels
#endif

// Helper function to query the LLM directly.
func queryAppleLLM(_ prompt: String) async -> String {
    #if canImport(FoundationModels)
    if #available(macOS 26.0, *) {
        let model = SystemLanguageModel.default
        guard model.availability == .available else {
            return "[Apple LLM not available on this device]"
        }
        do {
            let session = LanguageModelSession(model: model)
            let response = try await session.respond(to: prompt)
            return response.content
        } catch {
            return "[Apple LLM error: \(error.localizedDescription)]"
        }
    }
    #endif
    return "[Apple LLM not available on this platform]"
}

// Main execution logic using top-level async code.
print("🚀 Starting Baseline LLM Iterative Test: Fibonacci Sequence (10 runs)")

for N in 10...19 {
    print("\n-------------------------------------------")
    print("🔬 Running Baseline Test: Calculating Fibonacci(\(N))...")
    print("-------------------------------------------")

    // The prompt is dynamically created for each value of N.
    let baselinePrompt = """
    Calculate the \(N)th number in the Fibonacci sequence (where F(0)=0, F(1)=1). Then, eloquently explain the significance of the Fibonacci sequence and its relationship to the golden ratio and its appearance in nature. Provide the final number first, followed by your explanation.
    """

    let result = await queryAppleLLM(baselinePrompt)

    print("\n--- RAW LLM RESPONSE FOR F(\(N)) ---")
    print(result)
    print("--- END OF TEST FOR F(\(N)) ---")

    // Pause for 1 second between API calls to be safe.
    try? await Task.sleep(nanoseconds: 1_000_000_000)
}

print("\n🎉 All baseline tests completed.")

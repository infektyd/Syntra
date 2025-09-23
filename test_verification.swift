import Foundation
@testable import Modi

// Test Tower of Hanoi problem verification
let problem1 = "Solve the Tower of Hanoi puzzle with 3 disks"
let solution1 = "To solve this recursively, move n-1 disks to auxiliary rod, move largest disk to destination, then move n-1 disks from auxiliary to destination. For 3 disks, this takes 2^3 - 1 = 7 moves total. The approach is systematic and uses the recursive principle."

print("=== Testing Tower of Hanoi ===")
let result1 = Modi.verifySolution(problem1, solution: solution1)
print("Verification Passed:", result1["verification_passed"] as? Bool ?? false)
print("Overall Confidence:", result1["overall_confidence"] as? Double ?? 0.0)
print("Applied Principles:", result1["applied_principles"] as? [String] ?? [])
print("Reasoning Depth:", result1["reasoning_depth"] as? String ?? "unknown")
print("Consciousness Alignment:", result1["consciousness_alignment"] as? String ?? "unknown")
print()

// Test N-Queens problem verification
let problem2 = "Solve the 8-queens problem on a chessboard"
let solution2 = "Use backtracking to place queens systematically. Check for conflicts by ensuring no two queens attack each other on the same row, column, or diagonal. If a placement leads to a conflict, backtrack and try the next position."

print("=== Testing N-Queens ===")
let result2 = Modi.verifySolution(problem2, solution: solution2)
print("Verification Passed:", result2["verification_passed"] as? Bool ?? false)
print("Overall Confidence:", result2["overall_confidence"] as? Double ?? 0.0)
print("Applied Principles:", result2["applied_principles"] as? [String] ?? [])
print("Reasoning Depth:", result2["reasoning_depth"] as? String ?? "unknown")
print("Consciousness Alignment:", result2["consciousness_alignment"] as? String ?? "unknown")
print()

// Test mathematical problem verification
let problem3 = "Calculate the area of a circle with radius 5"
let solution3 = "Using the formula A = πr², we calculate: A = π × 5² = π × 25 = 25π ≈ 78.54 square units. This is the precise mathematical result."

print("=== Testing Mathematical Problem ===")
let result3 = Modi.verifySolution(problem3, solution: solution3)
print("Verification Passed:", result3["verification_passed"] as? Bool ?? false)
print("Overall Confidence:", result3["overall_confidence"] as? Double ?? 0.0)
print("Applied Principles:", result3["applied_principles"] as? [String] ?? [])
print("Reasoning Depth:", result3["reasoning_depth"] as? String ?? "unknown")
print("Consciousness Alignment:", result3["consciousness_alignment"] as? String ?? "unknown")
print()

// Test poor solution
let problem4 = "Explain how to solve a difficult puzzle"
let solution4 = "Just try random things until it works."

print("=== Testing Poor Solution ===")
let result4 = Modi.verifySolution(problem4, solution: solution4)
print("Verification Passed:", result4["verification_passed"] as? Bool ?? false)
print("Overall Confidence:", result4["overall_confidence"] as? Double ?? 0.0)
print("Applied Principles:", result4["applied_principles"] as? [String] ?? [])
print("Issues:", result4["verification_issues"] as? [String] ?? [])
print("Reasoning Depth:", result4["reasoning_depth"] as? String ?? "unknown")
print("Consciousness Alignment:", result4["consciousness_alignment"] as? String ?? "unknown")
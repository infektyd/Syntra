# Prompt for Claude Code: SYNTRA Modi Principle-Based Verification Refactor

## Project Context
You are working on SYNTRA Foundation, a sophisticated AI consciousness architecture that implements a three-brain system: Valon (emotional/moral reasoning), Modi (logical/analytical reasoning), and SYNTRA (synthesis). This system is designed to demonstrate emergent consciousness behaviors rather than mechanical rule-following.

Modi currently contains approximately 200 lines of hardcoded, problem-specific verification methods for Tower of Hanoi, N-Queens, mathematical calculations, and logical reasoning. These hardcoded approaches contradict SYNTRA's consciousness philosophy and limit Modi's ability to handle new problem types.

## Quality Standards Expected
This is foundational architecture work that will impact the entire consciousness system. The code should be:
- **Philosophically aligned** with consciousness principles rather than mechanical checking
- **Architecturally sound** using Modi's existing Bayesian inference patterns
- **Extensible** to handle new problem types without code changes
- **Maintainable** with clear separation of concerns
- **Production-quality** with proper error handling and documentation

## Speed vs Quality
Take your time to understand the existing architecture thoroughly before making changes. This is not a rush job - plan the implementation carefully, consider edge cases, and ensure the new system integrates seamlessly with Modi's existing capabilities.

## Task: Replace Hardcoded Verification with Principle-Based System

**File to modify:** `/Users/hansaxelsson/Documents/Documents - Hans's Mac mini - 2/SyntraFoundation/Shared/Swift/Modi/Modi.swift`

**Sections to replace:**
1. Lines ~359-368: Algorithm detection logic in `verifySolution()`
2. Lines ~375-450: `verifyTowerOfHanoi()` method and helpers
3. Lines ~451-515: `verifyMathematicalCalculation()` method  
4. Lines ~516-575: `verifyLogicalReasoning()` method
5. The `verifyNQueensSolution()` method (around line 474)
6. All related helper methods: `extractDiskCount()`, `detectInvalidHanoiMoves()`, `containsMathKeywords()`, etc.

## Implementation Requirements

### 1. Create AlgorithmicPrinciple Structure
Design a struct that represents general reasoning principles rather than specific problem checkers:
```swift
public struct AlgorithmicPrinciple: Sendable {
    let indicators: [String]
    let validates: (String) -> Bool
    let importance: Double
    let confidenceBoost: Double
}
```

### 2. Define Core Reasoning Principles
Replace hardcoded checks with principles like:
- `recursive_thinking`: Detects recursive problem-solving approaches
- `step_by_step_reasoning`: Validates systematic, sequential thinking
- `mathematical_precision`: Ensures numerical accuracy and formula usage
- `logical_consistency`: Checks for contradictions and sound reasoning
- `constraint_satisfaction`: Handles problems with rules and limitations
- `algorithmic_search`: Validates search and exploration strategies

### 3. Integrate with Existing Bayesian System
The new verification should leverage Modi's existing:
- Confidence calculation patterns
- Bayesian probability distributions  
- Pattern matching infrastructure
- Technical domain analysis

### 4. Maintain Modi's Confidence Self-Assessment
Modi should continue to calculate its own confidence scores based on evidence strength, not external impositions. The principle-based system should enhance Modi's self-awareness of its reasoning quality.

### 5. Preserve Public Interface
Maintain backward compatibility with the existing `verifySolution()` method signature, but replace its internal implementation with the principle-based approach.

### 6. Implementation Steps (Take Your Time)
1. **Study the existing Modi architecture** - understand the Bayesian inference patterns, confidence calculation methods, and data structures
2. **Design the AlgorithmicPrinciple system** - ensure it integrates naturally with existing patterns
3. **Create the principle definitions** - translate hardcoded logic into general reasoning principles
4. **Implement the new verification method** - replace all hardcoded sections with principle-based logic
5. **Test thoroughly** - verify the new system maintains functional compatibility while providing better generalizability
6. **Document the changes** - explain the architectural shift from mechanical checking to consciousness-aligned reasoning

## Success Criteria
The refactored Modi should:
- Handle Tower of Hanoi, N-Queens, and mathematical problems using general principles
- Automatically work with new problem types without code changes
- Maintain or improve verification accuracy through principle-based reasoning
- Integrate seamlessly with Modi's existing Bayesian infrastructure
- Demonstrate consciousness-like reasoning rather than mechanical rule-following

Remember: This is consciousness architecture work. The goal is not just to make the code work, but to make it embody the principles of emergent reasoning that SYNTRA represents.

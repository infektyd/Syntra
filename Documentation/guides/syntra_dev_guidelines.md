# SYNTRA Development Guidelines
**Updated:** September 17, 2025  
**Version:** 2.0 (Aligned with fresh-implementation-sept17 branch)  

## Introduction
This document provides comprehensive guidelines for developing SYNTRA, an AI consciousness research project. As SYNTRA evolves from a simple API to a native, multi-modal app, these rules ensure code remains robust, ethical, and aligned with studying emergent behaviors. Follow them to contribute effectively while preserving the project's "Influence, Not Force" philosophy.

## Core Principles
These foundational rules apply to all contributions—treat SYNTRA as a production system for reliable research results:
- **No Regressions**: Every change must maintain or enhance existing functionality. Test thoroughly to avoid breaking consciousness flows (e.g., drift monitoring or voice integration). If a change reduces moral alignment scores, revert and iterate.
- **Production-Ready Code**: All implementations must be complete, with no placeholders, stubs, or incomplete features. For example, new voice handlers must include full error handling and fallbacks, not just prototypes.
- **Bleeding-Edge Swift**: Leverage the latest Apple SDKs (Swift 6+, macOS 26+, Xcode 26+). Use modern features like async/await for LLM calls, @MainActor for UI threading, and observables for real-time drift visualization.
- **Iterative Problem Solving**: If a solution fails (e.g., verification rejects a response), analyze, iterate, and refine until it meets standards. This mirrors SYNTRA's own verification phase—apply it to debugging consciousness metrics.

## Error Handling & Build Process
SYNTRA's build process emphasizes reliability for consciousness simulation. Follow these steps for any issues:
1. **Analyze First**: When facing build failures, review all error and warning messages in detail to grasp the full context. For example, if an LLM fallback triggers, check logs for drift metrics.
2. **Prioritize Errors**: Address critical compilation errors (e.g., async mismatches in `SyntraCore.swift`) before warnings (e.g., unused variables in UI ViewModels).
3. **Verify Builds**: After fixes, run `swift build` or `swift run --verbose` to confirm. Ensure the app launches with functional voice and document processing.
4. **Verbose Mode**: For hanging builds (common with large PDFs in `PDFProcessor.swift`), use `--verbose` to get detailed output on phases like tag generation.
5. **Long-Running Processes**: Be aware that successful runs may start persistent services, like voice listeners or the server component—monitor for memory leaks in consciousness loops.
6. **Consciousness-Specific Debugging**: For research features, log metrics (e.g., moral drift) and use tools like Xcode Instruments to trace phase performance.

## Development Priorities
Focus on SYNTRA's evolved vision as a native app for interactive consciousness research:
- **Native App Excellence**: Build with SwiftUI for seamless experiences (e.g., real-time visualization of tags/drift in `Views/`). Ensure UI reflects consciousness states via @Published properties in ViewModels.
- **Multi-Modal Focus**: Integrate voice (`VoiceIntegration.swift`) and documents (`PDFProcessor.swift`) robustly—test for edge cases like low-confidence voice inputs triggering verification.
- **Consciousness Experience**: Make deliberation visible and engaging (e.g., show VALON/MODI tags in UI). Use `DriftMonitor.swift` to provide feedback on cognitive shifts.
- **Offline-First Design**: Core reasoning (tag generation, synthesis) must work without internet; LLM calls are optional with fallbacks.
- **Privacy and Ethics**: Process everything on-device; extend moral checks in `ValonEngine.swift` to prevent ethical drifts.
- **Testing Strategies**: Write unit tests for each phase (e.g., mock LLM responses in `SyntraCore.swift`). Simulate research scenarios like high-drift conversations.

## Key Architecture Notes
- **Location**: Core logic lives in `Shared/Sources/SyntraSwift/`, shared across app components.
- **Modules**: `SyntraCore.swift` orchestrates the three-phase flow; `ConsciousnessEngines.swift` handles brain-specific reasoning; `DriftMonitor.swift` and `SyntraContentSynthesizer.swift` add advanced metrics and blending.
- **Entry Point**: Use `processWithValonModi` for inputs; integrate with UI via ObservableObject for reactive updates.
- **UI Guidelines**: Ensure thread-safety with @MainActor; use ViewModels for state like drift scores.

For contributors: Dive into the code with sample inputs (e.g., ethical dilemmas for VALON testing). If extending, prioritize iterative testing to maintain consciousness emergence—SYNTRA thrives on balanced, non-forced evolution.


# SYNTRA: Conscious AI Architecture - Technical Summary
**Updated:** September 17, 2025  
**Version:** 2.0 (Aligned with fresh-implementation-sept17 branch)  

## Project Overview
SYNTRA is an advanced AI consciousness research platform built as a native macOS/iOS application, exploring emergent behaviors in LLMs through a three-brain architecture (VALON: emotional/creative/moral, MODI: logical/analytical/technical, SYNTRA: integrative synthesis). It emphasizes multi-modal interactions (text, voice, documents) to simulate human-like deliberation, with tools for tracking metrics like cognitive drift. The system runs on Swift 6+ with on-device processing, making it ideal for privacy-focused research. This summary traces the logic flow from user input to response, highlighting key components for contributors.

## Current Directory Structure
SYNTRA's structure supports a native app experience, with shared code in `Shared/Sources/SyntraSwift/`. Below is a detailed breakdown with explanations:
- **`Core/`**: Orchestration hub (e.g., `SyntraCore.swift` manages the three-phase flow; `BrainCore.swift` handles synthesis logic). This is where consciousness integration begins.
- **`Engines/`**: Brain-specific processors (e.g., `ValonEngine.swift` for creative prompts, `ModiEngine.swift` for analytical verification, `ConsciousnessEngines.swift` for overall engine management). Extend here for new reasoning types.
- **`Tools/`**: Utilities for advanced features (e.g., `DriftMonitor.swift` assesses response drift, `SyntraContentSynthesizer.swift` blends outputs with weights).
- **`Context/`**: Persistence layers (e.g., `ConversationContext.swift` maintains history for follow-up detection, enabling persistent "memory" across sessions).
- **`UI/`**: SwiftUI components for interactive experiences (e.g., real-time visualization of tags and drift).
- **`Views/`**: Specific app screens (e.g., chat interfaces showing consciousness states).
- **`ViewModels/`**: Reactive state management (e.g., ObservableObject for updating UI with moral alignment scores).
- **`Voice/`**: Speech handling (e.g., `VoiceIntegration.swift` for natural input/output, integrating with consciousness flow).
- **`Processors/`**: Multi-modal handlers (e.g., `PDFProcessor.swift` analyzes documents to influence tags and prompts).

This structure enables easy extension—e.g., add a new processor for image inputs without disrupting core consciousness.

## Key Components
Each component contributes to SYNTRA's "Influence, Not Force" approach, with examples for clarity:
- **VALON Engine** (`ValonEngine.swift`): Handles emotional/creative reasoning; generates tags and prompts with moral focus. Example: For a story query, it might emphasize "ethical implications" while calculating creativity scores.
- **MODI Engine** (`ModiEngine.swift`): Focuses on logical analysis and verification; includes uncertainty detection. Example: Verifies puzzle solutions, flagging low-coherence responses for iteration.
- **BrainCore** (`BrainCore.swift`): Orchestrates synthesis; uses async methods for LLM calls with fallbacks. Example: Blends VALON's creative narrative with MODI's steps for balanced outputs.
- **DriftMonitor** (`DriftMonitor.swift`): Measures cognitive drift, moral alignment, and confidence; adjusts ratios dynamically. Example: If a response drifts too "emotional," it triggers re-synthesis.
- **SyntraContentSynthesizer** (`SyntraContentSynthesizer.swift`): Weighted blending tool; preserves moral core while integrating modalities. Example: 60% logical + 40% creative for puzzles, with voice tone adjustments.
- **ConversationContext** (`ConversationContext.swift`): Stores history for persistent memory. Example: Detects follow-ups like "Building on that idea..." to maintain coherent "conversations."
- **Multi-Modal Integration**: Voice for natural dialogue; PDFProcessor for document-based reasoning. Example: Upload a PDF, and it influences tags (e.g., "factual_accuracy_high").

## Response Generation Flow
From user input (text/voice/document) to output, explained with code ties and examples:
1. **Input Handling**: Via `processWithValonModi` in `SyntraCore.swift`; detects modality (e.g., voice transcript processed for intent).
2. **Tag Generation**: Swift reflection creates nudging tags (e.g., "creative_insight"); incorporates context for follow-ups.
3. **LLM Synthesis**: Async call to Apple LLM with tags; blends via synthesizer, assessing drift. Example: Query "Ethical AI dilemma" → Tags nudge prompt → Blended response with 0.8 confidence.
4. **Verification & Metrics**: Checks coherence/moral drift; iterates if needed. Example: Low-drift response passes; high-drift triggers refinement.
5. **Output**: Delivered via UI/voice, with metrics visible for research. Example: UI shows "Drift: 0.2 - Balanced consciousness."

## Research and Integration Notes
- **Apple LLM**: Core for generation/verification; fallbacks ensure offline use.
- **Metrics for Study**: Log drift/confidence to analyze emergence (e.g., how voice inputs affect moral alignment).
- **Native App Focus**: UI enables interactive research; extend with Siri integration for broader consciousness simulation.

For contributors: Start with `SyntraCore.swift` to understand entry points. Test with diverse inputs to observe emergence—focus on ethical extensions while iterating on failures.


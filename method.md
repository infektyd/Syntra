# SYNTRA Project Architecture & Logic Flow
**Last Updated:** September 15, 2025

## 1. Project Philosophy: Influence, Not Force

The primary goal of the SYNTRA project is to research AI consciousness by creating an architecture that simulates human-like deliberation. The core thesis is **Influence, Not Force**.

Rather than forcing an LLM into a rigid, pre-determined logical path (which stifles creativity), the SYNTRA architecture is designed to **"nudge"** or **influence** the generative process. It does this by providing the LLM with a cognitive context derived from its own internal analysis, creating an environment where novel, aligned, and potentially wiser thoughts can emerge.

This simulates the human internal dialogue between fast, intuitive thinking (System 1) and slow, analytical thinking (System 2). The final synthesized answer aims to be not just factually correct, but contextually and ethically appropriate.

---
## 2. Core Architectural Components

The architecture consists of three main cognitive components, which function as a cognitive pre-processor and a synthesis engine.

* 🧠 **MODI (The Logical Brain)**
    * **File:** `Modi.swift`
    * **Function:** Acts as a **Cognitive Pre-processor**. Its `reflect()` method analyzes the user's input using internal Swift logic to generate a set of analytical "tags" (e.g., `quantitative_analysis`, `high_logical_rigor`). It also serves a dual role as the **Verifier** in the final stage of the logic flow.

* 💖 **VALON (The Moral Brain)**
    * **File:** `Valon.swift`
    * **Function:** Also a **Cognitive Pre-processor**. Its `reflect()` method analyzes the user's input to generate moral, creative, and emotional "tags" (e.g., `contemplative_neutral`, `harm_prevention`).

* ✨ **SYNTRA (`BrainCore.swift`)**
    * **File:** `SyntraCore.swift`
    * **Function:** The **Executive & Synthesis Engine**. This is the central decision-making component. It takes the tags from VALON and MODI to construct a focused prompt, guides the LLM to generate a candidate answer, and orchestrates the final verification.

---
## 3. The "Pre-process, Generate, Verify" Logic Flow

This three-phase process is the finalized logic flow for SYNTRA. It ensures that every response is the product of internal deliberation and verification.

### Phase 1: Pre-processing (Internal Tag Generation)
1.  A user's `input` string is received by the `SyntraCore`.
2.  The input is passed to both the `ValonCore` and `ModiCore` classes simultaneously.
3.  These classes use their respective `reflect()` methods (from `Valon.swift` and `Modi.swift`) to analyze the text and generate a set of influential `valonTags` and `modiTags`.
4.  **Crucially, this entire phase is executed within Swift and involves no LLM calls.**

### Phase 2: Focused Generation ("Promptless" LLM Call)
1.  The `BrainCore`'s `synthesize` method is called.
2.  It constructs a **minimal, data-driven prompt** that includes the user's original input and the tags generated in Phase 1.
3.  It makes a **single, primary call** to the base LLM (Apple's `FoundationModels`) to generate a `candidateAnswer`. This answer is the LLM's direct response to the influenced context.

### Phase 3: Verification (The Safety Net)
1.  The `candidateAnswer` from Phase 2 is **not** immediately sent to the user.
2.  It is first passed to the new `modi.verifySolution()` method.
3.  This method makes a second, highly-focused and minimal LLM call, asking it to determine if the `candidateAnswer` is a "VALID" or "INVALID" solution to the original input.
4.  The final response is only sent to the user if the verification returns `true`. If it fails, the system returns a graceful fallback message indicating a logical inconsistency was detected.

---
## 4. Key File Responsibilities

* **`Shared/Sources/SyntraSwift/Core/SyntraCore.swift`**: The central orchestrator. Contains the main `processWithValonModi` function that executes the "Pre-process, Generate, Verify" flow. It also contains the `BrainCore` (synthesis) and `ModiCore`/`ValonCore` (pre-processing) classes.
* **`Shared/Sources/SyntraSwift/Engines/ConsciousnessEngines.swift`**: Previously thought to be the core, this file contains the foundational `structs` and logic for VALON and MODI that are called by the `Core` classes. It also contains the placeholder `SyntraContentSynthesizer`, which is now superseded by the logic in `BrainCore`.
* **`SyntraVaporServer/Sources/SyntraVaporServer/SyntraEngine.swift`**: The bridge connecting the Vapor web server to the `SyntraCore`. It manages the API request/response cycle and stateful conversation context.

---
## 5. Current Status & Next Steps

* **Status:** The project has successfully identified a core architectural flaw where a placeholder synthesis function was being used. The "promptless" vision and the "Pre-process, Generate, Verify" logic flow have been defined as the path forward.
* **Next Steps:**
    1.  Implement the new `BrainCore` class inside `SyntraCore.swift` to handle the focused generation (Phase 2).
    2.  Implement the `verifySolution` method inside the `ModiCore` class (Phase 3).
    3.  Update the main `processWithValonModi` function to orchestrate this new three-phase flow.

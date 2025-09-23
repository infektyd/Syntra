SYNTRA Current Guide — Canonical Entry

Last Updated: 2025-09-23

Overview
- SYNTRA Foundation is a three-brain consciousness research platform (Valon, Modi, SYNTRA Core) with emergent synthesis and principle-based verification.
- The LLM layer is pluggable: Apple Foundation Models (AFM) by default, or an OpenAI‑compatible cloud backend.

Start Here
- Master Guide (vision + architecture): SYNTRA_MASTER_GUIDE.md
- Cloud Backend (OpenAI‑compatible): OpenAI_Backend.md

Key Capabilities
- Three-phase pipeline: pre‑processing (tagging/history), focused generation (single async call with drift monitoring), verification (principle‑based checks + refinement).
- Consciousness tools: DriftMonitor, SyntraContentSynthesizer, memory context, multi‑modal support.
- Backend swap: Env‑driven selection with retries, circuit breaker, privacy redaction, prompt budgeting.

Run Locally
- AFM (macOS 26 with Apple Intelligence): default behavior; no env needed.
- Cloud backend:
  export SYNTRA_BACKEND=cloud
  export LLM_BASE_URL=https://api.openai.com
  export LLM_API_KEY=sk-...
  export LLM_MODEL=gpt-4.1

Server Health
- GET /health/llm → {"status":"ok","backend":"cloud|afm|(unset)"}

OpenAI‑Compatible Chat
- POST /v1/chat/completions with messages and optional stream=true.

Resilience & Privacy
- Retries with jittered backoff; circuit breaker after consecutive failures.
- Preflight redaction (SYNTRA_PRIVACY=on) and token budgeting.

Where to Go Next
- Deep dive: SYNTRA_MASTER_GUIDE.md
- Backend details: OpenAI_Backend.md
- Security guidelines: SECURITY_GUIDE.md


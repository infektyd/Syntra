Syntra — OpenAI‑Compatible Backend

Overview

- Goal: Pluggable OpenAI‑compatible backend (OpenAI/Groq/OpenRouter/self‑hosted vLLM) with no changes to consciousness core (Valon/Modi/Drift).
- The LLM is a replaceable text oracle; Syntra’s three‑brain coordination remains intact.

Environment

- Required (cloud mode):

  export SYNTRA_BACKEND=cloud
  export LLM_BASE_URL=https://api.openai.com
  export LLM_API_KEY=sk-...
  export LLM_MODEL=gpt-4.1

- Optional controls:

  export LLM_TIMEOUT_S=60
  export LLM_MAX_RETRIES=5
  export LLM_STREAM_IDLE_TIMEOUT_S=120
  export LLM_BREAKER_MAX_FAILS=5
  export LLM_BREAKER_OPEN_S=60
  export SYNTRA_PRIVACY=on
  export LLM_MAX_PROMPT_TOKENS=8192
  export SYNTRA_DEBUG=true

Key Files

- Sources/SyntraKit/LLMBackend.swift — Protocol + ChatMessage model
- Sources/SyntraKit/CloudOpenAIBackend.swift — OpenAI wire client (SSE + one‑shot), retries, breaker, privacy, budgeting
- Sources/SyntraKit/AppleFMBackend.swift — AFM wrapper to the same protocol
- Sources/SyntraKit/SyntraKit.swift — Env‑based backend selector and streaming bridge
- Shared/Swift/BrainEngine/BrainEngine.swift — Calls LLM via `queryLLM` (backend‑agnostic)

Server Health Check

- Endpoint: `GET /health/llm`

  curl http://127.0.0.1:8081/health/llm | jq .

  {"status":"ok","backend":"cloud"}

OpenAI‑Compatible API

- Chat completions:

  POST /v1/chat/completions
  {"model":"gpt-4.1","messages":[{"role":"user","content":"Say hello"}],"stream":false}

Privacy & Budgeting

- `SYNTRA_PRIVACY=on` enables preflight redaction (emails, phones, SSN‑like, credit cards, IPv4, URLs).
- `LLM_MAX_PROMPT_TOKENS` caps prompt size with head/tail truncation; preserves the first system message.

Resilience

- Retries on 429/5xx and common network errors; jittered exponential backoff.
- Circuit breaker opens after N consecutive failures for T seconds.

Harness

- Run parity across AFM and Cloud:

  tools/harness/run_parity.sh prompts.txt syntra_runs.jsonl

Notes

- AFM mode requires macOS 26 with Apple Intelligence.
- For SSE testing, use a client that supports Server‑Sent Events.


🧠 SYNTRA
Overview

My motivation for this project began with simple curiosity, a pet project meant as a diagnostic tool, and it has since transformed into what you see in this repository. I approached the development with a “why not” mentality, believing that anything is possible in code with persistence and iteration. I have invested significant time and learned across many disciplines to reach this point. This isn’t the end for Syntra; if anything, it’s opened new doors for creativity that I’m eager to explore.

🚀 Running It

This runs on the latest betas, so make sure your environment is up to date.

macos26beta (25a5351b)

xcode26beta7 (17A5305k)

1. Fire up the server:

From the project root, just run the swift command.

swift run

The Vapor server will start up on http://127.0.0.1:8081/v1.

2. Chat with Syntra:

I use Open Web UI to talk with Syntra during testing, which works great. Just point it at the local server URL above.

If you just want to ping the server to see if it's alive, a quick curl from the terminal works too:

curl [http://127.0.0.1:8081/v1/chat/completions](http://127.0.0.1:8081/v1/chat/completions) \
 -H "Content-Type: application/json" \
 -d '{
"model": "syntra-consciousness",
"messages": [{"role": "user", "content": "Hello! Introduce yourself."}]
}'

## Next

need to work on a better CLI for syntra, and increase its tooling

The Architecture

🧠 SYNTRA

Symbolic Neural Transduction and Reasoning Architecture

The central AI system. “SYNTRA” represents the fusion of symbolic reasoning with real-world signal interpretation. It's the architecture that processes, remembers, and evolves understanding over time. It includes VALON, MODI, and other modules.

⸻

🔧 MODI

Mechanistic Observation and Diagnostic Intelligence

The logic and diagnostics engine. MODI handles grounded, rule-based, cause-effect logic. It tracks fault drift, evaluates sensor patterns, and represents deductive cognition. Think of MODI as the mind that says “if X then Y” — structured and mechanical.

⸻

🔮 VALON

Variable Abstraction and Lateral Ontologic Network

The creative, emotional, and interpretive module. VALON handles symbolic abstraction, emotional anchoring, and lateral (nonlinear) reasoning. It’s the part of SYNTRA that “feels” the meaning of a symbol, forms patterns, and recognizes shifts in intent or tone. It’s more like Jungian symbolic intuition than a logic engine.

## What's in the repo?

SyntraVaporServer: The Vapor server that does all the heavy lifting and exposes the API.

SyntraKit: The core logic for SYNTRA, MODI, and VALON lives here.

Apps/iOS/SyntraChatIOS: The native iOS app. It started this whole native migration but is now more of a proof-of-concept client.

Shared/: Code that's shared between the different targets.

📄 License

This Project maintains the same license as the main SyntraFoundation project. See LICENSE file in the repository root.

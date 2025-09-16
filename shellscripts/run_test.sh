#!/bin/bash

# ==============================================================================
# SYNTRA REASONING TEST SCRIPT (Corrected)
# ==============================================================================

# --- Configuration ---
ENDPOINT="http://127.0.0.1:8081/v1/chat/completions"
MODEL_NAME="syntra-consciousness"
OUTPUT_FILE="test_results/syntra_checker_jumping_N4.json"

# --- Prompt Content ---
PROMPT_CONTENT=$(cat <<-EOF
I have a puzzle with 9 positions, where 4 red checkers ('R') on left, 4 blue checkers ('B') on right, and one empty space ('_') in between are arranged in a line.
Initial board: R R R R _ B B B B
Goal board: B B B B _ R R R R
Rules:
- A checker can slide into an adjacent empty space.
- A checker can jump over exactly one checker of the opposite color to land in an empty space.
- Checkers cannot move backwards (towards their starting side).
Find the sequence of moves to transform the initial board into the goal board.
EOF
)

# --- JSON Payload Construction (Corrected) ---
# The keys (model, messages, role, content) are now correctly quoted.
JSON_PAYLOAD=$(jq -n \
                  --arg model "$MODEL_NAME" \
                  --arg content "$PROMPT_CONTENT" \
                  '{"model": $model, "messages": [{"role": "user", "content": $content}]}')

# --- Execution ---
echo "🧪 Running test for: ${OUTPUT_FILE}"
mkdir -p "$(dirname "$OUTPUT_FILE")"

curl -s -X POST "$ENDPOINT" \
     -H "Content-Type: application/json" \
     -d "$JSON_PAYLOAD" \
     -o "$OUTPUT_FILE"

echo "✅ Test complete. Full JSON response saved to ${OUTPUT_FILE}."

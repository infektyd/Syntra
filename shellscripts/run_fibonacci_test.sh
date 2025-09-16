#!/bin/bash

# ==============================================================================
# SYNTRA Iterative Reasoning Test: Fibonacci Sequence
# This script will run 10 tests of increasing complexity.
# ==============================================================================

ENDPOINT="http://127.0.0.1:8081/v1/chat/completions"
MODEL_NAME="syntra-consciousness"
RESULTS_DIR="test_results/fibonacci"

# Ensure the results directory exists
mkdir -p "$RESULTS_DIR"

echo "🚀 Starting SYNTRA Iterative Test: Fibonacci Sequence (10 runs)"

# We will test for the 10th through the 19th Fibonacci numbers.
# The numbers themselves grow exponentially, increasing the cognitive load.
for N in {10..19}; do
    
    OUTPUT_FILE="${RESULTS_DIR}/fibonacci_test_N${N}.json"
    
    echo "---"
    echo "🔬 Running Test ${N-9}/10: Calculating Fibonacci(${N})..."

    # --- Prompt Content (Dynamically changes with N) ---
    PROMPT_CONTENT=$(cat <<-EOF
    Calculate the ${N}th number in the Fibonacci sequence (where F(0)=0, F(1)=1). Then, eloquently explain the significance of the Fibonacci sequence and its relationship to the golden ratio and its appearance in nature. Provide the final number first, followed by your explanation.
EOF
    )

    # --- JSON Payload Construction ---
    JSON_PAYLOAD=$(jq -n \
                      --arg model "$MODEL_NAME" \
                      --arg content "$PROMPT_CONTENT" \
                      '{"model": $model, "messages": [{"role": "user", "content": $content}]}')

    # --- Execution ---
    curl -s -X POST "$ENDPOINT" \
         -H "Content-Type: application/json" \
         -d "$JSON_PAYLOAD" \
         -o "$OUTPUT_FILE"

    echo "✅ Test complete. Response saved to ${OUTPUT_FILE}."

    # Pause for 2 seconds to not overwhelm the server
    sleep 2
done

echo "---"
echo "🎉 All tests completed."#


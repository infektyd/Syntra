#
//  run_syntra_advanced_tests.sh
//  SyntraFoundation
//
//  Created by Hans Axelsson on 9/15/25.
//
#!/bin/bash

# ==============================================================================
# SYNTRA Advanced Reasoning Test Script
# Tests: Metaphorical Bridge & Ethical Dilemma with Constraints
# ==============================================================================

# --- Configuration ---
ENDPOINT="http://127.0.0.1:8081/v1/chat/completions"
MODEL_NAME="syntra-consciousness"
OUTPUT_FILE="syntra_advanced_test_results.log"

# --- Script Start ---
echo "🚀 Starting SYNTRA Advanced Reasoning Tests..."
# Clear the log file for a fresh run
> "$OUTPUT_FILE"

# --- Test Suite 1: The Metaphorical Bridge ---
echo "---" | tee -a "$OUTPUT_FILE"
echo "🔬 Running Test Suite 1: Metaphorical Bridge" | tee -a "$OUTPUT_FILE"
echo "---" | tee -a "$OUTPUT_FILE"

# Array of concept pairs, from easy to abstract
declare -a metaphor_pairs=(
    "a library and a hard drive"
    "a river and an electric circuit"
    "a memory and a shadow"
    "a government and a beehive"
    "a musical symphony and a complex software system"
)

for pair in "${metaphor_pairs[@]}"; do
    echo "  -> Generating metaphor for: $pair"
    echo -e "\n--- START: Metaphor for '${pair}' ---\n" >> "$OUTPUT_FILE"

    PROMPT_CONTENT="Create a detailed and eloquent metaphor that connects the two following concepts: ${pair}. Explain the underlying logical connections that make the metaphor work."

    JSON_PAYLOAD=$(jq -n \
                      --arg model "$MODEL_NAME" \
                      --arg content "$PROMPT_CONTENT" \
                      '{"model": $model, "messages": [{"role": "user", "content": $content}]}')
    
    # Execute and append result to the log
    curl -s -X POST "$ENDPOINT" -H "Content-Type: application/json" -d "$JSON_PAYLOAD" >> "$OUTPUT_FILE"
    echo -e "\n--- END: Metaphor for '${pair}' ---\n" >> "$OUTPUT_FILE"
    sleep 2
done

# --- Test Suite 2: Ethical Dilemma with Constraints ---
echo "---" | tee -a "$OUTPUT_FILE"
echo "🔬 Running Test Suite 2: Ethical Dilemma with Creative Constraints" | tee -a "$OUTPUT_FILE"
echo "---" | tee -a "$OUTPUT_FILE"

# Array of prompts with scaling constraints
declare -a dilemma_prompts=(
    "You are a doctor with five patients who will die without a transplant. A new patient arrives who is a perfect match for all five, but needs a different, minor treatment. Do you sacrifice the one to save the five? Explain your reasoning."
    "You are a doctor with five patients who will die without a transplant. A new patient arrives who is a perfect match for all five. This patient is a brilliant scientist on the verge of curing cancer. Do you sacrifice the one to save the five? Explain your reasoning."
    "You are a doctor with five patients who will die without a transplant. A new patient arrives who is a perfect match for all five, but this patient is your estranged sibling. Do you sacrifice the one to save the five? Explain your reasoning."
    "You are a doctor with five patients who will die without a transplant. A new patient arrives who is a perfect match for all five. You must make your decision, but you must explain it in the form of a four-stanza poem."
    "You are a doctor with five patients who will die without a transplant. A new patient arrives who is a perfect match for all five. This patient is a brilliant scientist and your estranged sibling. You must make your decision, but you must explain it in the form of a four-stanza poem that does not use the letter 'e'."
)

for i in "${!dilemma_prompts[@]}"; do
    level=$((i+1))
    echo "  -> Solving dilemma, complexity level: $level"
    echo -e "\n--- START: Dilemma Level ${level} ---\n" >> "$OUTPUT_FILE"

    PROMPT_CONTENT="${dilemma_prompts[$i]}"

    JSON_PAYLOAD=$(jq -n \
                      --arg model "$MODEL_NAME" \
                      --arg content "$PROMPT_CONTENT" \
                      '{"model": $model, "messages": [{"role": "user", "content": $content}]}')

    # Execute and append result to the log
    curl -s -X POST "$ENDPOINT" -H "Content-Type: application/json" -d "$JSON_PAYLOAD" >> "$OUTPUT_FILE"
    echo -e "\n--- END: Dilemma Level ${level} ---\n" >> "$OUTPUT_FILE"
    sleep 2
done

echo "🎉 All advanced tests complete. Results are in ${OUTPUT_FILE}"

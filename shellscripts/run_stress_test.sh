#
//  run_stress_test.sh
//  SyntraFoundation
//
//  Created by Hans Axelsson on 9/15/25.
//
ENDPOINT="http://127.0.0.1:8081/v1/chat/completions"
MODEL_NAME="syntra-consciousness"
OUTPUT_FILE="fibonacci_stress_test_results.log"
TOTAL_RUNS_PER_NUMBER=20

# --- Script Start ---
echo "🚀 Starting SYNTRA Stress Test..."
# Clear the log file for a fresh run
> "$OUTPUT_FILE"

# Loop through the specific Fibonacci numbers at the failure boundary
for N in 17 18 19; do

    echo "---"
    echo "🔬 Stress Testing Fibonacci(${N}) for ${TOTAL_RUNS_PER_NUMBER} runs..."
    echo "===========================================" >> "$OUTPUT_FILE"
    echo "🔬 RESULTS FOR FIBONACCI(${N})" >> "$OUTPUT_FILE"
    echo "===========================================" >> "$OUTPUT_FILE"

    # Inner loop to run the test 20 times for each number
    for i in $(seq 1 $TOTAL_RUNS_PER_NUMBER); do
    
        echo "  -> Running iteration ${i}/${TOTAL_RUNS_PER_NUMBER} for F(${N})"
        echo -e "\n--- START: F(${N}), RUN ${i}/${TOTAL_RUNS_PER_NUMBER} ---\n" >> "$OUTPUT_FILE"

        PROMPT_CONTENT=$(cat <<-EOF
        Calculate the ${N}th number in the Fibonacci sequence (where F(0)=0, F(1)=1). Then, eloquently explain the significance of the Fibonacci sequence and its relationship to the golden ratio and its appearance in nature. Provide the final number first, followed by your explanation.
EOF
        )

        JSON_PAYLOAD=$(jq -n \
                          --arg model "$MODEL_NAME" \
                          --arg content "$PROMPT_CONTENT" \
                          '{"model": $model, "messages": [{"role": "user", "content": $content}]}')

        # Execute curl and APPEND (>>) the result to the single log file
        curl -s -X POST "$ENDPOINT" \
             -H "Content-Type: application/json" \
             -d "$JSON_PAYLOAD" >> "$OUTPUT_FILE"
        
        # Add a final newline for readability in the log
        echo -e "\n--- END: F(${N}), RUN ${i}/${TOTAL_RUNS_PER_NUMBER} ---\n" >> "$OUTPUT_FILE"
        
        sleep 1 # 1-second pause to be kind to the server
    done
done

echo "---"
echo "🎉 Stress test complete. All 60 results saved to ${OUTPUT_FILE}."

#!/usr/bin/env bash
set -euo pipefail

INPUT_FILE=${1:-prompts.txt}
OUT_FILE=${2:-syntra_runs.jsonl}

if [[ ! -f "$INPUT_FILE" ]]; then
  echo "Input file not found: $INPUT_FILE" >&2
  exit 1
fi

echo "# Writing JSONL to $OUT_FILE" >&2
> "$OUT_FILE"

# Build once
swift build -c release --product SyntraHarness >/dev/null

HARNESS=".build/release/SyntraHarness"

while IFS= read -r line || [[ -n "$line" ]]; do
  prompt=$(echo "$line" | sed 's/^\s\+//; s/\s\+$//')
  [[ -z "$prompt" || "$prompt" =~ ^# ]] && continue

  echo "[AFM] $prompt" >&2
  "$HARNESS" --backend afm --prompt "$prompt" >> "$OUT_FILE"

  echo "[CLOUD] $prompt" >&2
  "$HARNESS" --backend cloud --prompt "$prompt" >> "$OUT_FILE"
done < "$INPUT_FILE"

echo "# Done. Results in $OUT_FILE" >&2


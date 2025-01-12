#!/bin/bash

# Paths
SCRIPT="concorrence.py"
TEXT_FILE=$1
name=${TEXT_FILE%.txt} # {string%*} remove the .txt

OUTPUT="$name.tsv"
TARGET="lógica"


# Run the Python script
python3 "$SCRIPT" "$TEXT_FILE" --target "$TARGET" > "$OUTPUT"

echo "Analysis complete. Results saved to $OUTPUT."


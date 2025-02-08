#!/bin/bash

# Usage: ./run-command-per-line.sh <file_path> "<command_template>"
# Example: ./run-command-per-line.sh resources/input.txt "echo {}"

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <file_path> \"<command_template>\""
    exit 1
fi

FILE_PATH="$1"
COMMAND_TEMPLATE="$2"

# Check if file exists
if [ ! -f "$FILE_PATH" ]; then
    echo "Error: File '$FILE_PATH' not found!"
    exit 1
fi

# Get the total number of lines for progress tracking
TOTAL_LINES=$(awk 'END {print NR}' "$FILE_PATH")
CURRENT_LINE=0

# Read the file line by line
while IFS= read -r line || [ -n "$line" ]; do
    # Trim whitespace
    line=$(echo "$line" | xargs)

    # Skip empty lines
    if [ -z "$line" ]; then
        continue
    fi

    # Increment line counter
    ((CURRENT_LINE++))

    # Replace `{}` in the command template with the line content
    COMMAND=$(echo "$COMMAND_TEMPLATE" | sed "s/{}/$line/g")

    # Display progress and command execution
    echo "[${CURRENT_LINE}/${TOTAL_LINES}] Running: $COMMAND"
    
    # Execute the command
    eval "$COMMAND"
    
    # Check for errors
    if [ $? -ne 0 ]; then
        echo "Error executing command: $COMMAND" >&2
    fi

done < "$FILE_PATH"

echo "✅ Finished processing $TOTAL_LINES lines."
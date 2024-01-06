#!/bin/bash

# Function to display usage information
usage() {
    echo "Error: $1"
    echo "Usage: ./killreg [-SIGNAL] <PATTERN>"
    echo " -SIGNAL: an optional signal to pass to the programs that match the <PATTERN>, e.g., -9, -TERM, etc."
    echo " By default the -TERM signal is sent."
    echo " PATTERN: a required pattern, ./killreg kills all processes which match this pattern."
}

# Check if at least one argument is provided
if [ $# -lt 1 ]; then
    usage "at least one argument is required!"
    exit 1
fi

# Check if the first argument starts with a hyphen when two arguments are provided
if [ $# -eq 2 ] && [[ $1 != -* ]]; then
    usage "the first argument must start with a hyphen"
    exit 1
fi

# Set default signal to -TERM and initialize pattern
signal="-TERM"
pattern=""

# Assign the appropriate values to signal and pattern based on the number of arguments
if [ $# -eq 2 ]; then
    # Two arguments: first is signal, second is pattern
    signal="$1"
    pattern="$2"
elif [ $# -eq 1 ]; then
    # One argument: it's the pattern
    pattern="$1"
fi

# Use pgrep to find matching processes and pass them to kill
# Suppress errors from kill command
for pid in $(pgrep -f "$pattern"); do
    kill $signal $pid 2>/dev/null
done

exit 0

#!/bin/bash
# Opens the current Finder directory in Alacritty
# Usage: call from Automator Quick Action with folder as input

if [ -z "$1" ]; then
    # If no argument, use current directory
    DIR="."
else
    DIR="$1"
fi

# Open directory in Alacritty
open -a Alacritty --args --working-directory "$DIR"

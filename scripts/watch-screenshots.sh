#!/bin/bash

# Watch for new screenshots and copy their path to clipboard
SCREENSHOT_DIR="$HOME/Desktop/screenshots"

fswatch -0 --event Created "$SCREENSHOT_DIR" | while read -d '' file; do
    if [[ "$file" == *.png ]]; then
        echo -n "$file" | pbcopy
    fi
done

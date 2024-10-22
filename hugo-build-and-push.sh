#!/bin/bash

# Check if the script is being sourced
(return 0 2>/dev/null) && sourced=1 || sourced=0

# If the script is sourced, don't execute the main functionality
if [ $sourced -eq 1 ]; then
    echo "Script is being sourced. Skipping execution."
    return 0
fi

echo "Building Hugo site..."
hugo

echo "Checking for changes..."
if git status --porcelain | grep -q .; then
    echo "Changes detected. Adding files..."
    git add . > /dev/null 2>&1
    
    echo "Committing changes..."
    git commit -m "update content" > /dev/null 2>&1
    
    echo "Pushing changes to remote repository..."
    if git push > /dev/null 2>&1; then
        echo "Changes pushed successfully."
    else
        echo "Failed to push changes. Please check your network connection and remote repository settings."
    fi
else
    echo "No changes detected after Hugo build."
fi

echo "Script completed."

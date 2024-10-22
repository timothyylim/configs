#!/bin/bash

# Check if the script is being sourced
(return 0 2>/dev/null) && sourced=1 || sourced=0

# If the script is sourced, don't execute the main functionality
if [ $sourced -eq 1 ]; then
    echo "Script is being sourced. Skipping execution."
    return 0
fi

# Main script functionality
# Set the repository path
REPO_PATH="$HOME/repos/visions"

# Change to the repository directory
cd "$REPO_PATH" || exit 1

# Print current status
echo "Checking for changes in $REPO_PATH..."

# Check for changes
if git status --porcelain | grep -q .; then
    echo "Changes detected. Adding files..."
    
    # Add all changes
    git add . > /dev/null 2>&1
    
    echo "Committing changes..."
    
    # Commit changes
    git commit -m "update visions" > /dev/null 2>&1
    
    echo "Changes committed successfully."
    
    # Show the latest commit
    echo "Latest commit:"
    git log -1 --oneline
    
    echo "Pushing changes to remote repository..."
    
    # Push changes
    if git push > /dev/null 2>&1; then
        echo "Changes pushed successfully."
    else
        echo "Failed to push changes. Please check your network connection and remote repository settings."
    fi
else
    echo "No changes detected in the repository."
fi

# Print final status
echo "Final status:"
git status --short

echo "Script completed."

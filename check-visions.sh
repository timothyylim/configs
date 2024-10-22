#!/bin/bash

# Set the repository path
REPO_PATH="$HOME/repos/visions"

# Change to the repository directory
cd "$REPO_PATH" || exit 1

# Print current status
echo "Checking for changes in $REPO_PATH..."

# Check for changes
if git status --porcelain | grep .; then
    echo "Changes detected. Adding files..."
    
    # Add all changes
    git add .
    
    echo "Committing changes..."
    
    # Commit changes
    git commit -m "update visions"
    
    echo "Changes committed successfully."
    
    # Show the latest commit
    echo "Latest commit:"
    git log -1 --oneline
    
    echo "Pushing changes to remote repository..."
    
    # Push changes
    if git push; then
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

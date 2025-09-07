#!/bin/bash

# Configure git
git config --local user.email "github-actions[bot]@users.noreply.github.com"
git config --local user.name "github-actions[bot]"

# Set merge strategy to avoid conflicts prompt
git config pull.rebase false

# Fetch latest changes from remote
echo "Fetching latest changes from remote..."
git fetch origin ${GITHUB_REF_NAME}

# Check for changes in remote and merge if needed
echo "Checking for updates from remote..."
git pull origin ${GITHUB_REF_NAME} --strategy-option theirs || echo "Failed to pull, proceeding anyway"

# Ensure docs/reports directory exists
mkdir -p ./docs/reports/

# Stage the changes
echo "Adding report files to git..."
git add ./docs/reports/

# Verify changes were staged
git status

# Check if there are changes to commit
if git diff --staged --quiet; then
  echo "No changes to commit"
else
  # Commit the changes
  echo "Committing report files..."
  git commit -m "Add security scan reports [skip ci]"
  
  # Handle potential conflicts during push
  echo "Pushing changes to the repository..."
  git push origin ${GITHUB_REF_NAME} || {
    # If push failed, try pull and merge again
    echo "Push failed, attempting to merge remote changes and retry..."
    git pull origin ${GITHUB_REF_NAME} --strategy-option theirs
    # Try push again
    git push origin ${GITHUB_REF_NAME} || echo "Failed to push after merge attempt"
  }
  
  echo "Reports have been committed and pushed to the repository."
  echo "View them at: https://github.com/${GITHUB_REPOSITORY}/tree/${GITHUB_REF_NAME}/docs/reports"
fi

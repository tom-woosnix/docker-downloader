#!/bin/bash

# Script to configure git credentials for a different user
# Usage: ./setup-git-user.sh <username> <email> [github-username]

if [ $# -lt 2 ]; then
    echo "Usage: $0 <user.name> <user.email> [github-username]"
    echo "Example: $0 'John Doe' 'john@example.com' 'johndoe'"
    exit 1
fi

USER_NAME="$1"
USER_EMAIL="$2"
GITHUB_USER="${3:-}"

# Set local git config
git config --local user.name "$USER_NAME"
git config --local user.email "$USER_EMAIL"

echo "✓ Git config updated:"
echo "  user.name = $USER_NAME"
echo "  user.email = $USER_EMAIL"

# If GitHub username provided, update remote URL
if [ -n "$GITHUB_USER" ]; then
    CURRENT_REMOTE=$(git remote get-url origin)
    NEW_REMOTE="https://github.com/$GITHUB_USER/docker-downloader.git"
    
    if [ "$CURRENT_REMOTE" != "$NEW_REMOTE" ]; then
        git remote set-url origin "$NEW_REMOTE"
        echo "✓ Remote URL updated to: $NEW_REMOTE"
    fi
fi

echo ""
echo "To authenticate, you can:"
echo "1. Use a Personal Access Token (recommended):"
echo "   - Create one at: https://github.com/settings/tokens"
echo "   - Use it as password when prompted"
echo ""
echo "2. Update credentials file:"
echo "   echo 'https://USERNAME:TOKEN@github.com' > ~/.git-credentials"
echo ""
echo "3. Use SSH instead:"
echo "   git remote set-url origin git@github.com:USERNAME/docker-downloader.git"


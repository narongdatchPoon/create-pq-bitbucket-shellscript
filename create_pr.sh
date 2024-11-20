#!/bin/bash

# Replace these values with your Bitbucket details
USERNAME="xxx"
APP_PASSWORD="xxx"
WORKSPACE="xxx"
REPO_SLUG="xxx"
DESTINATION_BRANCH="staging" # Target branch for the PR (e.g., main, master)

# Get parameters for the script
SOURCE_BRANCH=$1   # The branch you want to merge from
PR_TITLE=$2        # The title of the PR
PR_DESCRIPTION=$3  # The description of the PR (optional)

# Check if all required arguments are provided
if [ -z "$SOURCE_BRANCH" ] || [ -z "$PR_TITLE" ]; then
  echo "Usage: ./create_pr.sh <source_branch> <pr_title> [pr_description]"
  exit 1
fi

# Create the pull request using Bitbucket API
curl -X POST -u "$USERNAME:$APP_PASSWORD" \
-H "Content-Type: application/json" \
-d '{
      "title": "'"$PR_TITLE"'",
      "source": {
          "branch": {
              "name": "'"$SOURCE_BRANCH"'"
          }
      },
      "destination": {
          "branch": {
              "name": "'"$DESTINATION_BRANCH"'"
          }
      },
      "description": "'"$PR_DESCRIPTION"'"
    }' \
"https://api.bitbucket.org/2.0/repositories/$WORKSPACE/$REPO_SLUG/pullrequests"

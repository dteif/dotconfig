#!/bin/bash

# Read the OAuth token from the Docker secret file and export it
# so Claude Code can pick it up, then hand off to the claude binary.
export CLAUDE_CODE_OAUTH_TOKEN=$(cat /run/secrets/claude_oauth_token)

# Bootstrap onboarding state if missing. This makes claude 'skip'
# the browser authentication step: we are providing the oauth token
# so we will not need it.
if [ -f "$HOME/.claude.json" ]; then
  tmp=$(mktemp)
  jq '.hasCompletedOnboarding = true' "$HOME/.claude.json" > "$tmp" && mv "$tmp" "$HOME/.claude.json"
else
  echo '{"hasCompletedOnboarding":true}' > "$HOME/.claude.json"
fi

exec claude "$@"

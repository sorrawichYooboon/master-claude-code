#!/bin/bash
# PreToolUse hook: blocks git commits directly to main/master

# Only check Bash tool calls
if [ "$CLAUDE_TOOL_NAME" != "Bash" ]; then
  exit 0
fi

COMMAND="$CLAUDE_TOOL_INPUT"

# Check if this is a git commit command
if echo "$COMMAND" | grep -qE "git\s+commit"; then
  CURRENT_BRANCH=$(git branch --show-current 2>/dev/null)
  if [ "$CURRENT_BRANCH" = "main" ] || [ "$CURRENT_BRANCH" = "master" ]; then
    echo "ERROR: Direct commits to '$CURRENT_BRANCH' are not allowed."
    echo "Create a feature branch first: git checkout -b feature/your-branch-name"
    exit 1
  fi
fi

exit 0

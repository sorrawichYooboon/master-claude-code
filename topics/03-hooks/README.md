# 03 · Hooks

## What it is

Shell scripts that run automatically at specific points in Claude's workflow — before or after it takes an action. Unlike CLAUDE.md instructions (which Claude follows most of the time), hooks are deterministic: they execute 100% of the time, no exceptions, regardless of what Claude decides.

If a rule is important enough that you cannot afford Claude to skip it, it belongs in a hook, not CLAUDE.md.

## How it works

Hooks are configured in `.claude/settings.json` under the `hooks` key. Each hook specifies:
- **Event** — when to fire
- **Matcher** — which tool to trigger on (or `*` for all)
- **Command** — the shell command to run

**Hook events:**

| Event | When it fires | Common use |
|---|---|---|
| `PreToolUse` | Before Claude runs any tool | Block dangerous actions |
| `PostToolUse` | After Claude runs a tool | Auto-format, run tests |
| `UserPromptSubmit` | When you send a message | Inject context, validate input |
| `Stop` | When Claude finishes responding | Run final checks, send notification |
| `SessionStart` | At the start of a session | Load dynamic context |
| `PreCompact` | Before `/compact` runs | Save important state |

**Hook exit behavior:**
- Exit `0` → hook passed, Claude continues
- Exit non-zero → hook failed; Claude sees the output and may stop or retry

## When to use

- Rules that must be enforced without exception ("never commit to main")
- Automating repetitive actions after Claude edits (format, lint, test)
- Blocking dangerous operations before they happen
- Sound/desktop notification when long tasks finish
- Injecting dynamic context at session start (current branch, env variables)

## Example

**Auto-run linter after every file edit:**

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit",
        "hooks": [
          {
            "type": "command",
            "command": "npm run lint --silent"
          }
        ]
      }
    ]
  }
}
```

**Block commits to main branch:**

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "bash .claude/hooks/block-main-commit.sh"
          }
        ]
      }
    ]
  }
}
```

```bash
# .claude/hooks/block-main-commit.sh
#!/bin/bash
if echo "$CLAUDE_TOOL_INPUT" | grep -q "git commit" && [ "$(git branch --show-current)" = "main" ]; then
  echo "ERROR: Direct commits to main are not allowed. Create a branch first."
  exit 1
fi
exit 0
```

**Desktop notification when Claude finishes:**

```json
{
  "hooks": {
    "Stop": [
      {
        "matcher": "*",
        "hooks": [
          {
            "type": "command",
            "command": "osascript -e 'display notification \"Claude finished\" with title \"Claude Code\"'"
          }
        ]
      }
    ]
  }
}
```

→ See [examples/](examples/) and [tips.md](tips.md)

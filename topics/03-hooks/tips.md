# Hooks — Tips & Gotchas

## Gotchas

**Hook failures block Claude.**
If a `PreToolUse` hook exits non-zero, Claude stops and sees the error output. This is intentional for blocking hooks (e.g., blocking commits to main). But if a formatting hook or notification hook fails, it will also block Claude. Test hooks carefully and make non-critical hooks tolerant of failure (`command || true`).

**Hooks run in the shell, not in Claude's environment.**
Hook scripts do not automatically have access to Claude's working directory or tool input unless you use the environment variables Claude sets. Check the docs for `CLAUDE_TOOL_INPUT`, `CLAUDE_TOOL_NAME`, etc.

**`PostToolUse` hooks run after every matching tool call.**
If you match on `Edit` and Claude makes 10 edits in a row, your hook runs 10 times. For expensive operations (test suite), consider throttling or using a different trigger.

**Hooks in `settings.json` are project-scoped.**
A hook in `.claude/settings.json` only runs in that project. To apply hooks globally across all projects, put them in `~/.claude/settings.json`.

**Bash matcher matches all Bash commands.**
`"matcher": "Bash"` fires on every shell command Claude runs — not just dangerous ones. Use specific pattern matching inside the hook script to narrow it down.

## Best Practices

**Put safety checks in `PreToolUse`, automation in `PostToolUse`.**
Pre-hooks are for blocking dangerous actions before they happen. Post-hooks are for running consequences (lint, test, format) after an action completes.

**Keep hooks fast.**
Every hook adds latency. A 3-second lint hook on every Edit becomes 30 seconds across 10 edits. Use `--silent` or `--quiet` flags, limit what you check, or run tests only on `Stop` instead of every edit.

**Use `exit 0` explicitly in hook scripts.**
Ambiguous exit codes (from the last command's exit status) cause accidental hook failures. Always end hook scripts with explicit `exit 0` for success.

**Notification hooks on `Stop` are extremely useful.**
Long Claude tasks (running tests, building, doing research) take minutes. A `Stop` hook that plays a sound or sends a desktop notification means you can context-switch and be called back when Claude finishes.

```bash
# macOS notification on Stop
osascript -e 'display notification "Claude finished" with title "Claude Code"'
# or simpler
afplay /System/Library/Sounds/Glass.aiff
```

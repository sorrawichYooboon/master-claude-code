# 02 · Core Commands & Workflow

## What it is

The built-in slash commands and keyboard shortcuts that control Claude Code behavior during a session. These are available in every session — no configuration needed.

## How it works

Slash commands are typed directly in the Claude Code prompt. Keyboard shortcuts work in the interactive CLI. Both are session-scoped: they affect the current conversation but not Claude's global state.

**Session commands:**

| Command | What it does |
|---|---|
| `/compact` | Summarize conversation to free context space, then continue |
| `/clear` | Wipe session entirely and start fresh |
| `/context` | Show what is consuming your context window |
| `/memory` | Inspect all loaded CLAUDE.md and memory files |
| `/recap` | Summarize what happened in this session |
| `/diff` | Show current uncommitted changes — detail view scrollable with j/k, arrows, Space (v2.1.149) |

**Setup & config:**

| Command | What it does |
|---|---|
| `/init` | Generate a starter CLAUDE.md from your codebase |
| `/model` | Switch between Sonnet, Opus, Haiku mid-session |
| `/config key=value` | Set any setting from the prompt, `-p` mode, or Remote Control (v2.1.178) |
| `/effort` | Set reasoning effort level: `low`, `medium`, `high`, `xhigh` (v2.1.150) |

**Review commands:**

| Command | What it does |
|---|---|
| `/review` | Built-in code review of current changes |
| `/code-review` | Code simplification and quality review; add effort level with `/code-review high` (renamed from `/simplify` in v2.1.146) |
| `/security-review` | Built-in security audit |

**Cost & usage:**

| Command | What it does |
|---|---|
| `/cost` | Token usage and cost this session (API users) |
| `/usage` | Per-category cost breakdown: skills, subagents, plugins, MCP servers (added v2.1.149) |
| `/stats` | Usage stats (Pro/Max users) |

**Session management:**

| Command | What it does |
|---|---|
| `/rename` | Give the current session a meaningful name |
| `/branch` | Fork session to experiment without losing current state |
| `/cd <path>` | Move session to a new working directory without rebuilding the prompt cache (v2.1.166) |
| `/rewind` | Resume from a checkpoint — works even past `/clear` (v2.1.191) |

**Keyboard shortcuts:**

| Shortcut | What it does |
|---|---|
| `Esc Esc` | Open rewind menu — selectively undo recent actions |
| `Alt + P` | Switch model while keeping your current typed input |
| `Alt + T` | Toggle extended thinking mode |

## When to use

**`/compact` vs `/clear`:**
- `/compact` → summarizes and continues. Use mid-task when context is filling up.
- `/clear` → wipes everything. Use when starting a completely new, unrelated task.

**When to compact:** Run `/context` to check usage. Compact at 60–70% — do not wait for the 90%+ warning. By then you have lost significant context quality.

**`/model` switching:** Start with Sonnet for implementation. Switch to Opus when hitting a hard architectural decision or debugging something subtle. Switch back to Sonnet when implementation resumes.

## Example

```bash
# check context usage
/context

# compact when at 65%
/compact

# switch to Opus for a tricky architecture decision
/model opus

# switch back for implementation work
/model sonnet

# review before committing
/review

# name the session so you can resume it later
/rename fix-auth-token-expiry
```

→ See [examples/](examples/) and [tips.md](tips.md)

# Claude Code Cheatsheet

Single-page reference for commands, shortcuts, and file locations.

---

## Slash Commands

| Command | What it does |
|---|---|
| `/init` | Generate starter CLAUDE.md from your codebase |
| `/compact` | Summarize conversation to free context space |
| `/clear` | Wipe session and start completely fresh |
| `/context` | Show context window usage breakdown |
| `/memory` | Inspect all loaded memory and instruction files |
| `/model` | Switch model mid-session |
| `/review` | Built-in code review |
| `/security-review` | Built-in security audit |
| `/recap` | Summarize what happened this session |
| `/diff` | Show current changes |
| `/cost` | Token usage and cost (API users) |
| `/stats` | Usage stats (Pro/Max users) |
| `/rename` | Name the current session |
| `/branch` | Fork session to experiment safely |
| `/powerup` | Interactive tutorials built into Claude Code |

---

## Custom Commands (this repo)

| Command | What it does |
|---|---|
| `/weekly-update` | Research new Claude Code features, update CHANGELOG.md and affected topic files |
| `/add-topic` | Scaffold a new topic folder with README.md, tips.md, examples/ |
| `/search-latest` | Search for latest Claude Code news and return a summary |

---

## Keyboard Shortcuts

| Shortcut | What it does |
|---|---|
| `Esc Esc` | Open rewind menu — selective rollback of last actions |
| `Alt + P` | Switch model while keeping current input |
| `Alt + T` | Toggle extended thinking mode |

---

## File Locations

| File | Location | Scope | Git? |
|---|---|---|---|
| Global preferences | `~/.claude/CLAUDE.md` | All projects | No |
| Project rules | `/project/CLAUDE.md` | This project | Yes |
| Personal local notes | `/project/CLAUDE.local.md` | This project, you only | No |
| Subdirectory rules | `/project/subdir/CLAUDE.md` | That folder only | Yes |
| Auto memory | `~/.claude/projects/<name>/memory/` | Written by Claude | No |
| Project settings | `/project/.claude/settings.json` | This project | Yes |
| Skills (auto or manual) | `/project/.claude/skills/<name>/SKILL.md` | This project | Yes |

---

## Model Selection

| Model | Best for |
|---|---|
| Haiku | Simple edits, quick lookups, high-volume automation |
| Sonnet | Most coding tasks — best balance of speed and quality |
| Opus | Architecture decisions, hard debugging, complex planning |

```bash
/model haiku
/model sonnet
/model opus
```

---

## Context Management

```bash
/context    # check usage — compact before hitting 90%
/compact    # summarize and continue (use at 60-70%)
/clear      # wipe entirely for a new unrelated task
```

Load files on demand instead of bloating CLAUDE.md:

```
@src/utils.ts       # load a specific file into context
@docs/api.md        # load a specific doc into context
```

---

## Hooks (in .claude/settings.json)

```json
{
  "hooks": {
    "PostToolUse": [
      { "matcher": "Edit", "hooks": [{ "type": "command", "command": "npm run lint" }] }
    ],
    "PreToolUse": [
      { "matcher": "Bash", "hooks": [{ "type": "command", "command": "bash .claude/hooks/safety-check.sh" }] }
    ]
  }
}
```

Hook events: `PreToolUse` · `PostToolUse` · `UserPromptSubmit` · `Stop` · `SessionStart` · `PreCompact`

---

## MCP

```bash
claude mcp add        # interactive setup
claude mcp list       # see connected servers
claude mcp remove     # disconnect a server
```

---

## CLI Flags

```bash
claude                      # start interactive session
claude --continue           # resume most recent session
claude --resume             # pick a session from a list
claude --model opus         # start with specific model
claude -p "do X"            # one-shot prompt, no interactive session
claude --dangerously-skip-permissions  # skip all permission prompts (CI/automation)
```

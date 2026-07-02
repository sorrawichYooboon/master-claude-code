# 07 · Session Management

## What it is

Tools for naming, resuming, and branching Claude Code sessions. Sessions persist conversation history, context, and Claude's understanding of what you were working on. With proper session management, you never lose work-in-progress context and can switch between projects without re-explaining everything.

## How it works

Claude Code stores sessions locally. Each session has an ID and an auto-generated readable name (v2.1.196). You can list, resume, and branch sessions using CLI flags and slash commands.

**Key commands:**

| Command | What it does |
|---|---|
| `/rename` | Give the current session a meaningful name |
| `/recap` | Summarize what happened in this session |
| `/branch` | Fork current session to experiment safely |
| `/cd <path>` | Move the session to a new working directory without rebuilding the prompt cache (v2.1.166) |
| `/rewind` | Resume from a checkpoint — can now rewind past `/clear` (v2.1.191) |
| `claude --continue` | Resume the most recent session |
| `claude --resume` | Pick a session from a list |

**Session lifecycle:**

```
claude                          # start a new session
/rename fix-kafka-timeout       # name it immediately
... work ...
/recap                          # summarize before stopping
# next day:
claude --resume "fix-kafka-timeout"   # pick up exactly where you left off
```

**Branching:**

`/branch` creates a copy of the current session state. Experiment in the branch — if it works, keep it; if not, abandon it and return to the original. Useful before risky refactors or when you want to explore two approaches without committing to one.

## When to use

- **Name immediately** when starting a task that will take more than one session. If you don't name it, finding it later requires reading session summaries.
- **Resume** when continuing multi-day work. Claude will have the full context of what was done, what's next, and why decisions were made.
- **Branch** before any risky or exploratory change — refactoring a core module, trying a new architecture, debugging something with uncertain root cause.
- **Recap** before ending a session — captures what was done in a format that helps both you and Claude resume efficiently.

## Example

**Multi-day feature workflow:**

```bash
# Day 1
claude
/rename add-oauth-github
# work...
/recap
# Claude summarizes: "Implemented GitHub OAuth callback. JWT minting works.
#  Still need: refresh token storage, logout endpoint, frontend redirect."

# Day 2
claude --resume "add-oauth-github"
# Claude has full context — continues from where you left off
```

**Branching for a risky refactor:**

```bash
# mid-session, working on auth
/branch
# Now in a branch — safe to experiment
# If it breaks, abandon branch and return to the original
```

**Listing and resuming sessions:**

```bash
claude --resume
# Shows a list of recent named sessions
# Arrow keys to select, Enter to open
```

→ See [examples/](examples/) and [tips.md](tips.md)

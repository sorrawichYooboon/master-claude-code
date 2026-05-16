# 01 · Memory & CLAUDE.md

## What it is

The file system Claude Code uses to persist context and instructions across sessions. Instead of re-explaining your project at the start of every session, you write it once in a `.md` file and Claude reads it automatically. There are five distinct memory types, each with its own location, scope, and loading behavior.

## How it works

**Memory file types:**

| File | Location | Scope | Commit to Git? |
|---|---|---|---|
| Global preferences | `~/.claude/CLAUDE.md` | All projects, always | No |
| Project rules | `/project/CLAUDE.md` | This project only | Yes |
| Personal local notes | `/project/CLAUDE.local.md` | This project, you only | No |
| Subdirectory rules | `/project/backend/CLAUDE.md` | That folder only | Yes |
| Auto memory | `~/.claude/projects/<name>/memory/` | Written by Claude itself | No |

**Loading order:**

Claude loads CLAUDE.md files based on the filesystem ancestry of your working directory:

- **Ancestor files** (above current dir) → loaded at startup, always
- **Descendant files** (below current dir) → loaded lazily, only when Claude touches files in that subdirectory
- **Sibling directories** → never load each other's CLAUDE.md

A `backend/CLAUDE.md` only activates when Claude is working inside `backend/`. It does not load just because you opened Claude at the project root.

**Auto memory** is Claude writing its own notes. When you correct Claude or express a preference mid-session, it can save that to `~/.claude/projects/<name>/memory/`. Use `/memory` to see everything currently loaded.

## When to use

- You repeat the same context at the start of every session ("our API uses snake_case", "always run `make lint` before committing")
- You want rules enforced consistently without re-explaining them each time
- You work in a mono-repo where different subdirectories follow different conventions
- You want project rules in git so the whole team gets them automatically

## Example

**Project CLAUDE.md (checked into git):**

```markdown
## Build & Test
- Build: `make build`
- Test: `make test`
- Lint: `make lint` — run before every commit

## Conventions
- Errors: wrap with `fmt.Errorf("context: %w", err)`
- No global variables outside of `main.go`
- Commit format: `feat:`, `fix:`, `docs:`, `chore:`

## Architecture
- `cmd/` — entry points only, no business logic
- `internal/` — all business logic
- `pkg/` — public API, stable interface
```

**Key commands:**

```bash
/init      # auto-generate a starter CLAUDE.md from your codebase
/memory    # inspect everything Claude has loaded and saved
```

→ See [examples/](examples/) and [tips.md](tips.md)

# Memory & CLAUDE.md — Tips & Gotchas

## Gotchas

**Descendant CLAUDE.md files do not load at startup.**
If you have `backend/CLAUDE.md` and open Claude at the project root, that file does not load until Claude touches a file inside `backend/`. This catches people off guard when they put critical rules in a subdirectory file expecting them to always apply.

**CLAUDE.md is not a chat message.**
Claude reads it as instructions at context load time, not during conversation. This means vague instructions like "be careful with the database" are interpreted once, at load, not re-evaluated dynamically. Specific rules work far better than general principles.

**Long CLAUDE.md files degrade response quality.**
Every token in CLAUDE.md occupies context window space for the entire session. A 500-line CLAUDE.md leaves 500 fewer lines for actual code and conversation. Keep project CLAUDE.md under 120 lines; move detailed docs to files and load them on demand with `@path/to/file`.

**`CLAUDE.local.md` is .gitignored by default.**
This is intentional — it's for personal notes. If you're putting rules the whole team needs in `.local.md`, they belong in `CLAUDE.md` instead.

**Auto memory can become stale.**
Claude writes auto memory based on things you say mid-session. If a preference changes later, Claude may still follow the old saved memory. Run `/memory` to inspect what's loaded and delete stale entries manually from `~/.claude/projects/<name>/memory/`.

## Best Practices

**Lead with build commands.** The most valuable thing in a project CLAUDE.md is how to build, test, and lint. Claude needs these to verify changes. Put them at the top.

**Write rules as constraints, not suggestions.** "Prefer snake_case" is ignored when Claude thinks another style fits better. "All variable names must use snake_case" is followed.

**Use `CLAUDE.local.md` for your personal workflow notes.** Things like "I'm currently debugging the auth flow, start there" or "I use this local test endpoint: http://localhost:8080". These are not project rules — they're your personal context.

**Subdirectory CLAUDE.md for mono-repos.** If your repo has a Go backend and a React frontend, each with different conventions, put the backend rules in `backend/CLAUDE.md` and frontend rules in `frontend/CLAUDE.md`. They only load when Claude is in that directory.

**Generate a starter with `/init`, then edit.** Don't write CLAUDE.md from scratch. Run `/init` to let Claude read your codebase and generate a draft, then edit it down to the essentials.

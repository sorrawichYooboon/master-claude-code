# Core Commands & Workflow — Tips & Gotchas

## Gotchas

**`/compact` does not save everything.**
Compacting summarizes conversation history into a compressed form. If Claude was holding important context in the conversation ("we decided to use approach B because of the rate limit"), that nuance may not survive compaction. Before compacting, tell Claude explicitly: "before compacting, make note of X."

**Don't wait until 90% to compact.**
At 90% context usage, Claude's responses are already degraded — it's working with compressed, low-quality context. Run `/context` periodically and compact at 60–70%.

**`/clear` wipes everything, including Claude's understanding of your codebase.**
After `/clear`, Claude has no memory of what files you were working on, what decisions were made, or what the current task is. Only use it when starting a genuinely unrelated task.

**`/model` switching does not reset your context.**
Switching from Sonnet to Opus mid-session does not clear the conversation. Opus inherits all existing context — it's just processed by a more capable model. Good for when you hit a hard problem mid-session.

**`Esc Esc` rewind is per-action, not per-message.**
The rewind menu shows individual tool calls (file edits, bash commands), not whole messages. You can undo a specific file edit without undoing Claude's entire last response.

## Best Practices

**Switch models intentionally, not habitually.**
Starting every session with Opus because "it's smarter" wastes money. Sonnet handles 90% of coding tasks. Switch to Opus specifically for: architecture decisions, debugging something that stumped Sonnet, writing something where nuance matters.

**Use `/recap` before ending any session that will continue.**
The recap gives you and Claude a summary to resume from. Without it, continuing tomorrow means re-explaining context that Claude already had.

**Use `/review` before every commit, not just important ones.**
The built-in `/review` catches things you tune out when writing code — inconsistent error handling, missing edge cases, naming drift. It takes 30 seconds and frequently catches real issues.

**`@file` loading is more precise than CLAUDE.md.**
Instead of putting a long API reference in CLAUDE.md (loaded every session), use `@docs/api-reference.md` in the message when you need it. Lower context overhead, more targeted.

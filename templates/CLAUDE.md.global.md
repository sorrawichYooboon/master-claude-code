# Global CLAUDE.md Template

# Copy this to: ~/.claude/CLAUDE.md
# This applies to ALL projects. Keep it short — only things that are always true.

## My preferences

- Concise responses — I can ask for more detail if needed
- Show me the code change, not just a description of it
- No trailing summaries of what you just did — I can read the diff
- Conventional commits: feat:, fix:, docs:, refactor:, chore:, test:

## Code style (universal)

- No comments explaining what the code does — good names do that
- Only add comments for: hidden constraints, workarounds, non-obvious invariants
- No defensive code for things that cannot happen — trust internal guarantees
- No adding features beyond what was asked

## When to ask vs. proceed

- Proceed on: small edits, single-file changes, clearly scoped tasks
- Ask first on: deleting files, changing interfaces, anything affecting multiple systems
- Never: push to remote, merge to main, send messages/emails without explicit request

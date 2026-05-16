---
name: weekly-update
description: Search for Claude Code changelog entries and update this repo. Use when running the weekly update workflow.
disable-model-invocation: true
---

Search the web for Claude Code changelog entries, release notes, and announcements from the past 7 days.

Sources to check:
- https://github.com/anthropics/claude-code/releases
- https://docs.claude.com/en/docs/claude-code/overview
- https://claudefa.st/blog/guide/changelog

Then do all of the following:
1. Add a new entry to CHANGELOG.md at the top (directly below the header line) in this format:
   `## YYYY-MM-DD — <short title>`
   List each change as a bullet point. Include source links when available.
2. Update any topic README.md files in topics/ that are affected by new features or deprecations.
3. Report back what was changed so the user can review before committing.

If nothing relevant was found in the past 7 days, say so — do not add an empty or fabricated entry.

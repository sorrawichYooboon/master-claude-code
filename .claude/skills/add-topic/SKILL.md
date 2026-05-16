---
name: add-topic
description: Scaffold a new topic folder in this repo. Use when adding a new Claude Code topic.
disable-model-invocation: true
argument-hint: "[topic-name]"
---

Create a new topic folder for: $ARGUMENTS

Steps:
1. Look at the existing folders in topics/ to determine the next topic number (XX).
2. Create `topics/XX-<topic-slug>/README.md` with this exact structure:
   - `## What it is` — one paragraph definition, no fluff
   - `## How it works` — the mechanism, not a list of steps
   - `## When to use` — specific triggers ("when you find yourself doing X"), not vague advice
   - `## Example` — real working code or config that can be copied and used immediately
   Keep the file under 200 lines.
3. Create `topics/XX-<topic-slug>/tips.md` with gotchas and best practices — things that are surprising or that people commonly get wrong.
4. Create `topics/XX-<topic-slug>/examples/` with at least one real working file (config, script, or CLAUDE.md content that actually works).
5. Add the new topic to the Topics list in README.md under the correct number.

Rules:
- All example files must be real and working — no placeholder content.
- Do not add a topic for something already covered in topics/.
- Follow the writing style: short, direct, examples over explanations.

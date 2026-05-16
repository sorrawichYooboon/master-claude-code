# 05 · Skills

## What it is

Reusable instruction sets stored as `SKILL.md` files in `.claude/skills/`. Skills are the single system for both auto-triggered knowledge and manually-invoked workflows — the difference is controlled by frontmatter.

**Two modes, same location:**

| | Auto-triggered | Manual-only |
|---|---|---|
| Trigger | Claude decides when relevant | You type `/skill-name` |
| Frontmatter | no `disable-model-invocation` | `disable-model-invocation: true` |
| Best for | Domain knowledge, coding conventions | Workflows with side effects (deploy, commit) |
| Location | `.claude/skills/<name>/SKILL.md` | `.claude/skills/<name>/SKILL.md` |

## How it works

Skills live in `.claude/skills/` under a subdirectory named for the skill. The `SKILL.md` file has a frontmatter header and the instruction body:

```markdown
---
name: skill-name
description: When Claude should apply this skill — written with keywords you'd naturally say
---

# Skill content here
```

**The `description` field is everything.** Claude uses it to decide whether to auto-apply the skill based on what you ask. Write the description with the actual phrases you use when working on this problem ("when creating API endpoints", "when writing database migrations", not "for API work").

Claude reads the description, matches it against your request, and loads the skill content into context before responding.

## When to use

- You find yourself correcting Claude the same way more than twice ("no, our error format is `{error, code}` not `{message}`")
- Domain knowledge Claude doesn't have — your internal libraries, your company's API design rules
- Project-specific patterns that differ from common conventions
- Rules that are too detailed or context-specific for CLAUDE.md

## Example

**API conventions skill:**

File: `.claude/skills/api-conventions/SKILL.md`

```markdown
---
name: api-conventions
description: REST API design conventions for this project. Use when creating endpoints,
             handlers, route definitions, or any HTTP-related code.
---

# API Conventions

URL paths: kebab-case only (/user-accounts not /userAccounts)
All list endpoints must include pagination (page, limit, total)
Error response format: { "error": "human message", "code": "SCREAMING_SNAKE_CASE" }
Version prefix on all routes: /v1/, /v2/
Context must be the first parameter in every handler function
Handler files live in internal/handlers/, one file per resource
```

**Database migration skill:**

```markdown
---
name: db-migrations
description: Database migration rules. Use when writing SQL migrations, schema changes,
             altering tables, or working with the migrations/ directory.
---

# Migration Rules

Never use DROP COLUMN in a migration — mark as deprecated first
Always include a down migration
Migration filenames: YYYYMMDDHHMMSS_description.sql
All new columns must have NOT NULL with a default, or be nullable with explicit reason
Foreign keys must have ON DELETE behavior specified
```

→ See [examples/](examples/) and [tips.md](tips.md)

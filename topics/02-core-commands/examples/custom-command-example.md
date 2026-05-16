# Example: Manual-only Skill (replaces custom commands)

# File: .claude/skills/create-handler/SKILL.md
# Triggered with: /create-handler users

---
name: create-handler
description: Scaffold a new HTTP handler for a resource in this project.
disable-model-invocation: true
argument-hint: [resource-name]
---

Create a new HTTP handler for the resource: $ARGUMENTS

Steps:
1. Create `internal/handlers/$ARGUMENTS.go` with:
   - A handler struct with its dependencies injected via constructor
   - CRUD route handlers: List, Get, Create, Update, Delete
   - Each handler must: validate input, call the store layer, return JSON
   - Use the existing error response format: `{"error": "message", "code": "CODE"}`

2. Create `internal/handlers/${ARGUMENTS}_test.go` with:
   - Table-driven tests for each handler
   - Test both success and error cases
   - Use the test helpers in `internal/testutil/`

3. Register the routes in `cmd/server/routes.go`

4. Run `make lint` and `make test` to verify everything passes

Follow the pattern in `internal/handlers/users.go` exactly.

---

# How to create a manual-only skill:
# 1. Create .claude/skills/<name>/SKILL.md
# 2. Add frontmatter with disable-model-invocation: true
# 3. Write the prompt body — use $ARGUMENTS to accept input
# 4. Invoke with /create-handler users inside a Claude Code session

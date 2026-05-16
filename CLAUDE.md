# master-claude-code

This is a personal learning and reference repo for mastering Claude Code.
Updated weekly using Claude Code itself.

## Purpose
- Document every Claude Code topic with clear explanations and real examples
- Store ready-to-use templates (CLAUDE.md files, hooks, commands, skills)
- Track weekly Claude Code updates in CHANGELOG.md
- Serve as a public knowledge base for the community

## Repo structure
- `topics/` — one folder per topic, each has README.md + examples/
- `templates/` — copy-paste ready CLAUDE.md and config files
- `.claude/commands/` — custom slash commands for maintaining this repo
- `cheatsheet.md` — single page quick reference
- `CHANGELOG.md` — weekly updates log
- `resources.md` — links to official docs and community repos

## Topics covered
01. Memory & CLAUDE.md (global, project, local, subdirectory, auto memory)
02. Core commands & workflow (/compact, /clear, /context, /model, /review)
03. Hooks (PreToolUse, PostToolUse, auto-format, block dangerous actions)
04. MCP — Model Context Protocol (connecting external tools)
05. Skills (auto-triggered reusable instruction sets)
06. Agents & multi-agent workflows (subagents, parallel tasks)
07. Session management (naming, resuming, branching sessions)
08. Cost & performance (model selection, token optimization)

## Writing style for all docs
- Short and clear — documentation style, not blog style
- Use examples over long explanations
- Show real commands and real file content, not pseudocode
- Every topic README must have: what it is, how it works, when to use, example

## How to do weekly updates
1. Run `/project:weekly-update` — Claude searches for new Claude Code changes
2. Review what Claude found and wrote
3. Commit with: `git commit -m "docs: weekly update YYYY-MM-DD"`
4. Push to GitHub

## Rules when working in this repo
- Never edit CHANGELOG.md manually — always use /project:weekly-update
- Keep every topic README under 200 lines — move details to examples/ files
- All example files must be real and working, not placeholder content
- When adding a template, test it works before committing
- Conventional commits: docs:, feat:, fix:, chore:

## Compact instructions
When compacting, always preserve:
- Which topic we are currently writing or updating
- Any research findings not yet written to files
- Current task and what still needs to be done
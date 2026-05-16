# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

# master-claude-code

A personal knowledge base for mastering Claude Code, maintained and updated weekly by Claude Code itself.

## Purpose

Document every Claude Code topic with clear explanations and real working examples. Serve as a public knowledge base and ready-to-use toolkit (templates, custom commands, skills).

## Repo Structure

```
topics/XX-topic-name/
├── README.md          ← concept, how it works, when to use, example
├── examples/          ← real working files only
└── tips.md            ← gotchas, best practices, surprises

templates/             ← copy-paste ready CLAUDE.md and config files
.claude/skills/        ← skills for maintaining this repo (weekly-update, add-topic, search-latest)
cheatsheet.md          ← single-page quick reference
CHANGELOG.md           ← weekly updates log (never edit manually)
resources.md           ← links to official docs and community
```

## Topics Covered

01. Memory & CLAUDE.md
02. Core commands & workflow
03. Hooks (PreToolUse, PostToolUse, auto-format, block dangerous actions)
04. MCP — Model Context Protocol
05. Skills (auto-triggered reusable instruction sets)
06. Agents & multi-agent workflows
07. Session management
08. Cost & performance

## Custom Commands

Run these inside a Claude Code session opened in this repo:

| Command | What it does |
|---|---|
| `/weekly-update` | Search for Claude Code updates, write to CHANGELOG.md and affected topic files |
| `/add-topic` | Scaffold a new topic folder with README.md and examples/ |
| `/search-latest` | Search for latest Claude Code news and return a summary |

## Weekly Update Workflow

1. Run `/weekly-update`
2. Review what Claude found and wrote
3. Commit: `git commit -m "docs: weekly update YYYY-MM-DD"`

## Writing Style

- Documentation style, not blog style — short and direct
- Examples over explanations; real commands over pseudocode
- Every topic README must cover: what it is, how it works, when to use, example

## Rules

- Never edit `CHANGELOG.md` manually — only via `/weekly-update`
- Keep every topic README under 200 lines — move details to `examples/`
- All example files must be real and working, not placeholder content
- Test templates before committing
- Conventional commits: `docs:`, `feat:`, `fix:`, `chore:`

## Compact Instructions

When compacting, always preserve:
- Which topic is currently being written or updated
- Any research findings not yet written to files
- Current task and what still needs to be done

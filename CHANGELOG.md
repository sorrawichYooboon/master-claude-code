# CHANGELOG

Weekly updates log — maintained by `/weekly-update`, never edited manually.

---

## 2026-05-24 — /code-review, agent JSON output, /usage breakdown (v2.1.145–v2.1.149)

### Commands
- `/simplify` renamed to `/code-review` with optional effort levels: `/code-review`, `/code-review high` ([v2.1.146](https://github.com/anthropics/claude-code/releases/tag/v2.1.146))
- `/diff` detail view now scrollable with keyboard (arrows, j/k, PgUp/PgDn, Space, Home/End) ([v2.1.149](https://github.com/anthropics/claude-code/releases/tag/v2.1.149))
- `/usage` now shows per-category cost breakdown: skills, subagents, plugins, MCP servers ([v2.1.149](https://github.com/anthropics/claude-code/releases/tag/v2.1.149))

### Agents
- `claude agents --json` outputs live sessions as JSON for scripting and automation ([v2.1.145](https://github.com/anthropics/claude-code/releases/tag/v2.1.145))
- `agent_id` and `parent_agent_id` OTEL span attributes added for tracing ([v2.1.145](https://github.com/anthropics/claude-code/releases/tag/v2.1.145))
- Pinned background sessions now stay alive when idle; restart in-place on updates ([v2.1.147](https://github.com/anthropics/claude-code/releases/tag/v2.1.147))
- `claude agents` tab title now shows awaiting-input count ([v2.1.145](https://github.com/anthropics/claude-code/releases/tag/v2.1.145))

### Plugins & MCP
- **Plugins** bundle MCP servers + skills + tools into a single install — marketplace at https://claude.com/plugins (150+ plugins, Anthropic-verified badges)
- `/plugin` now previews commands, agents, skills, hooks, and MCP/LSP servers before installation ([v2.1.145](https://github.com/anthropics/claude-code/releases/tag/v2.1.145))
- Enterprise: `allowAllClaudeAiMcps` managed setting added for cloud MCP connectors ([v2.1.149](https://github.com/anthropics/claude-code/releases/tag/v2.1.149))
- Fixed MCP pagination issues ([v2.1.146](https://github.com/anthropics/claude-code/releases/tag/v2.1.146))
- Updated topic [04-mcp](topics/04-mcp/README.md) with Plugins section (was missing entirely)

### Security
- Fixed permission-prompt bypass in Bash variable assignments ([v2.1.145](https://github.com/anthropics/claude-code/releases/tag/v2.1.145), [v2.1.149](https://github.com/anthropics/claude-code/releases/tag/v2.1.149))
- Fixed git worktree sandbox allowlist gaps ([v2.1.149](https://github.com/anthropics/claude-code/releases/tag/v2.1.149))

### Other
- Markdown GFM task list checkboxes now render in output (`- [ ] todo` / `- [x] done`) ([v2.1.149](https://github.com/anthropics/claude-code/releases/tag/v2.1.149))
- Prompt history no longer records consecutive duplicate entries ([v2.1.147](https://github.com/anthropics/claude-code/releases/tag/v2.1.147))
- `/feedback` now includes pre-compaction conversation history ([v2.1.149](https://github.com/anthropics/claude-code/releases/tag/v2.1.149))

---

## 2026-05-17 — Initial Setup

- Scaffolded full repo structure: 8 topic folders, templates, skills, root reference files
- Created CLAUDE.md with project rules and compact instructions
- Published comprehensive README.md covering all 8 topics
- Added cheatsheet.md, resources.md, and skills (weekly-update, add-topic, search-latest)
- All topic READMEs, tips.md, and working examples created
- Migrated from legacy `.claude/commands/` to `.claude/skills/` format

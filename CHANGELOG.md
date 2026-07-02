# CHANGELOG

Weekly updates log — maintained by `/weekly-update`, never edited manually.

---

## 2026-07-02 — Sonnet 5 default, dynamic workflows, background agent PRs, MCP auth (v2.1.150–v2.1.198)

### Models & performance
- **Claude Sonnet 5** is now the default model with a native 1M-token context window; promotional pricing $2/$10 per MTok through Aug 31 ([v2.1.197](https://github.com/anthropics/claude-code/releases/tag/v2.1.197))
- **Claude Opus 4.8** was the previous default for Max, Team Premium, Enterprise, and API accounts; `/effort xhigh` added for hardest tasks ([v2.1.150](https://github.com/anthropics/claude-code/releases/tag/v2.1.150))
- Fast mode on Opus 4.8 at $10/$50 per MTok ([v2.1.150](https://github.com/anthropics/claude-code/releases/tag/v2.1.150))
- `fallbackModel` setting configures up to three fallback models tried in order ([v2.1.166](https://github.com/anthropics/claude-code/releases/tag/v2.1.166))
- CPU usage reduced ~37% during streaming ([v2.1.191](https://github.com/anthropics/claude-code/releases/tag/v2.1.191))

### Agents & workflows
- **Dynamic workflows** — Claude writes a script that orchestrates dozens to hundreds of subagents ([v2.1.150](https://github.com/anthropics/claude-code/releases/tag/v2.1.150))
- **Sub-agents can spawn sub-agents**, background chains capped at five levels deep ([v2.1.166](https://github.com/anthropics/claude-code/releases/tag/v2.1.166))
- **Background agents auto-commit, push, and open draft PRs** when finishing code work ([v2.1.198](https://github.com/anthropics/claude-code/releases/tag/v2.1.198))
- Subagents inherit the session's extended thinking configuration ([v2.1.198](https://github.com/anthropics/claude-code/releases/tag/v2.1.198))
- Background subagents surface permission prompts in the main session instead of auto-denying ([v2.1.191](https://github.com/anthropics/claude-code/releases/tag/v2.1.191))
- **Notification hook** (`agent_needs_input` / `agent_completed`) for background agent notifications ([v2.1.198](https://github.com/anthropics/claude-code/releases/tag/v2.1.198))
- Organization default models support (admin-configured in org console) ([v2.1.196](https://github.com/anthropics/claude-code/releases/tag/v2.1.196))

### MCP
- **`claude mcp login` / `claude mcp logout`** — authenticate a configured MCP server from your shell ([v2.1.186](https://github.com/anthropics/claude-code/releases/tag/v2.1.186))
- MCP servers from untrusted repos now require explicit approval ([v2.1.196](https://github.com/anthropics/claude-code/releases/tag/v2.1.196))
- MCP server authentication startup notice added ([v2.1.193](https://github.com/anthropics/claude-code/releases/tag/v2.1.193))
- Remote MCP tool call timeout set to 5 minutes ([v2.1.187](https://github.com/anthropics/claude-code/releases/tag/v2.1.187))

### Session management
- **`/rewind`** can now resume a conversation from before `/clear` was run ([v2.1.191](https://github.com/anthropics/claude-code/releases/tag/v2.1.191))
- **`/cd`** — move the current session to a new working directory without rebuilding the prompt cache ([v2.1.166](https://github.com/anthropics/claude-code/releases/tag/v2.1.166))
- Readable default session names (auto-generated, no more bare UUIDs) ([v2.1.196](https://github.com/anthropics/claude-code/releases/tag/v2.1.196))
- Clickable file attachments in chat — Cmd/Ctrl-click to open ([v2.1.196](https://github.com/anthropics/claude-code/releases/tag/v2.1.196))

### Commands & settings
- `/config key=value` — set any setting from the prompt, `-p` mode, or Remote Control ([v2.1.178](https://github.com/anthropics/claude-code/releases/tag/v2.1.178))
- `/dataviz` skill added for chart and dashboard design ([v2.1.198](https://github.com/anthropics/claude-code/releases/tag/v2.1.198))
- `/plugin list` prints installed plugins inline ([v2.1.158](https://github.com/anthropics/claude-code/releases/tag/v2.1.158))
- Status filtering added to `/workflows` detail view ([v2.1.186](https://github.com/anthropics/claude-code/releases/tag/v2.1.186))
- Shell mode auto-responds to command output (`! npm test` gets an explanation without a second prompt) ([v2.1.185](https://github.com/anthropics/claude-code/releases/tag/v2.1.185))
- Auto mode blocks destructive git commands when you didn't ask to discard local work ([v2.1.178](https://github.com/anthropics/claude-code/releases/tag/v2.1.178))
- Deny and ask rules now match tool parameters: `Tool(param:value)` syntax e.g. `Agent(model:opus)` ([v2.1.178](https://github.com/anthropics/claude-code/releases/tag/v2.1.178))
- `autoMode.classifyAllShell` and `sandbox.credentials` settings added ([v2.1.193](https://github.com/anthropics/claude-code/releases/tag/v2.1.193), [v2.1.187](https://github.com/anthropics/claude-code/releases/tag/v2.1.187))
- `--safe-mode` starts Claude Code with all customizations disabled for troubleshooting ([v2.1.166](https://github.com/anthropics/claude-code/releases/tag/v2.1.166))
- Improved skill frontmatter parsing: kebab-case, snake_case, and camelCase all work ([v2.1.186](https://github.com/anthropics/claude-code/releases/tag/v2.1.186))
- **Artifacts** beta: turn a session's output into a live shareable page on claude.ai (Team/Enterprise) ([v2.1.178](https://github.com/anthropics/claude-code/releases/tag/v2.1.178))
- Auto mode now available on Bedrock, Vertex, and Foundry (Opus 4.7 and 4.8) ([v2.1.158](https://github.com/anthropics/claude-code/releases/tag/v2.1.158))

### Updated topics
- [06-agents](topics/06-agents/README.md): sub-agent spawning chains, background PR creation, notification hooks
- [04-mcp](topics/04-mcp/README.md): `claude mcp login/logout`, untrusted repo approval requirement
- [07-session-management](topics/07-session-management/README.md): `/rewind`, `/cd`, readable session names
- [02-core-commands](topics/02-core-commands/README.md): `/cd`, `/config`, `/dataviz`, `/effort`
- [08-cost-and-performance](topics/08-cost-and-performance/README.md): Sonnet 5 default, 1M context, updated model tiers

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

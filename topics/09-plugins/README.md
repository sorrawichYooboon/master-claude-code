# 09 · Plugins

## What it is

A plugin is a one-install package that bundles multiple Claude Code extensions together:

- **Skills** — auto-triggered instruction sets
- **Agents** — specialized subagent definitions
- **Hooks** — automation scripts (PreToolUse, PostToolUse, etc.)
- **MCP servers** — external tool connections
- **Commands** — slash commands
- **LSP servers** — language server integrations

Instead of installing and wiring each piece individually, a plugin delivers everything a use case needs in a single command.

## How it works

Plugins are listed at https://claude.com/plugins (150+ available, community-submitted, Anthropic-verified badges for audited ones).

**Install workflow:**

```bash
/plugin                    # browse available plugins
/plugin <name>             # preview what it contains before installing
/plugin install <name>     # install
```

As of v2.1.145, `/plugin` shows a full preview — every skill, agent, hook, MCP server, and command the plugin includes — before you commit to installing it.

**What gets installed:**

When you install a plugin, Claude Code adds its components into their respective locations:
- Skills → `.claude/skills/`
- Agents → `.claude/agents/`
- Hooks → merged into `.claude/settings.json`
- MCP servers → added to `mcp.json`

## When to use

**Use a plugin when:**
- An integration you want already exists in the marketplace (GitHub, Slack, Figma, Vercel, etc.)
- You want a complete workflow, not just a single MCP connection
- You want community-tested, pre-configured setups

**Build your own components instead when:**
- You need a custom internal tool or private API
- Your use case is too specific for a general plugin
- You want fine-grained control over each piece

## Example

**GitHub plugin** — gives you GitHub MCP + review skills + PR agent in one install:

```bash
/plugin github             # preview: shows MCP server, skills, agents included
/plugin install github

# Now available in every session:
# - GitHub MCP: read issues, open PRs, post comments
# - Skills: PR review conventions, commit message style
# - Agents: code-reviewer, issue-triage
```

**Security plugin** — bundles a security scanning MCP + security-review skill:

```bash
/plugin install security-scanner

# Adds:
# - MCP server: runs static analysis tools
# - Skill: auto-triggered on file edits in auth/ or payments/
# - Hook: blocks commits if critical CVEs detected
```

## Plugin vs raw components

| | Plugin | Build your own |
|---|---|---|
| Install effort | One command | Configure each piece separately |
| Contents | Skills + agents + hooks + MCP | One type at a time |
| Source | Public marketplace | Your own files |
| Customization | Limited to what the plugin exposes | Full control |
| Best for | Popular integrations | Internal/private tools |

## Trust and safety

- Only install from developers you trust
- Plugins are community-submitted — the **Anthropic Verified** badge means Anthropic has audited the source code
- You can review source code before installing via `/plugin <name>`

→ See [examples/](examples/) and [tips.md](tips.md)

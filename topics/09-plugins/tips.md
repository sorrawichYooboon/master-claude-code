# 09 · Plugins — Tips & Gotchas

## Always preview before installing

`/plugin <name>` shows exactly what will be added — skills, agents, hooks, MCP servers. Read it. Hooks especially can add PreToolUse blocks that affect every tool call.

## Plugins modify settings.json for hooks

If a plugin adds hooks, they get merged into `.claude/settings.json`. After installing, check the file so you know what's running automatically in your sessions.

## Uninstalling is manual

There's no `/plugin uninstall` (as of v2.1.149). To remove a plugin: delete its skills from `.claude/skills/`, its agents from `.claude/agents/`, its MCP entry from `mcp.json`, and its hooks from `settings.json`.

## Anthropic Verified ≠ always safe for your context

The verified badge means Anthropic reviewed the code. It doesn't mean the plugin fits your security policy. Review what each MCP server can access — some request broad filesystem or network permissions.

## Plugin skills can conflict with your own

If a plugin installs a skill with the same name or overlapping description as one you already have, both may trigger. Check `.claude/skills/` for conflicts after installing.

## Prefer plugins for well-known integrations

GitHub, Slack, Figma, Vercel — these have mature community plugins that are better tested than a custom MCP you'd build from scratch. Use them.

## Build raw MCP for anything internal

For internal APIs, private databases, or company tools — don't look for a plugin. Build a custom MCP server directly. Plugins are for public/common integrations.

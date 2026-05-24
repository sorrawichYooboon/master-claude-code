# 04 · MCP — Model Context Protocol

## What it is

A standard protocol that lets Claude Code connect to external tools and services. Instead of copy-pasting data from GitHub, Jira, or your database into the chat, Claude reads and interacts with them directly through MCP servers.

MCP transforms Claude Code from "AI that edits files" into "AI that can interact with your entire development ecosystem."

## How it works

MCP follows a client-server model:
- **MCP server** — a process that exposes tools (functions Claude can call) and resources (data Claude can read)
- **Claude Code** — the MCP client, discovers available tools at session start and calls them during tasks

Servers run as local processes (stdio) or remote endpoints (HTTP/SSE). Claude Code manages the connection lifecycle — you configure them once, they're available in every session.

**Adding a server:**

```bash
claude mcp add        # interactive setup wizard
claude mcp list       # see what's connected
claude mcp remove     # disconnect a server
```

Configuration is stored in `~/.claude/mcp.json` (global) or `.claude/mcp.json` (project-level).

## When to use

- You constantly copy-paste from issue trackers into Claude (GitHub, Linear, Jira)
- You want Claude to read your database schema and write queries against it
- You want Claude to read Figma designs and implement them directly
- You have an internal tool or API that Claude should be able to call

## Example

**GitHub MCP — end-to-end workflow:**

```bash
# Add the GitHub MCP server
claude mcp add github

# In a session
You: fix issue #47
Claude: [reads issue via GitHub MCP]
        [reads relevant code files]
        [implements the fix]
        [runs tests]
        [opens PR via GitHub MCP]
```

**Popular MCP servers:**

| Server | What Claude can do |
|---|---|
| GitHub | Read issues/PRs, open PRs, post review comments |
| Linear / Jira | Read tickets, update status, create subtasks |
| Figma | Read designs and implement them directly |
| PostgreSQL | Query your database, understand schema |
| Notion | Read and write docs |
| Slack | Read messages, post updates |
| Filesystem | Access files outside the current project |

**Building a custom MCP server:**

Any internal API or tool can be wrapped as an MCP server. Claude Code connects to it the same way as any public server. The MCP spec is at https://modelcontextprotocol.io.

→ See [examples/](examples/) and [tips.md](tips.md)

**Note:** For popular integrations (GitHub, Slack, Figma), prefer installing a **plugin** instead of a raw MCP server — plugins bundle the MCP + skills + agents in one step. See [topic 09 · Plugins](../09-plugins/README.md).

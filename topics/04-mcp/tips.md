# MCP — Tips & Gotchas

## Gotchas

**MCP server metadata loads at session start and costs tokens.**
Every connected MCP server describes its available tools to Claude at startup. 10 connected servers with many tools each can add thousands of tokens to every session — before you type anything. Only connect servers you're actively using.

**MCP servers run as local processes (stdio mode).**
Most popular MCP servers run as a child process on your machine, not as a remote service. They need to be installed and runnable on your machine. If the process crashes, the MCP connection drops mid-session.

**Tool names are not standardized across servers.**
The GitHub MCP server calls its create-PR tool something different from what a different GitHub MCP server might call it. When Claude has trouble using a tool, ask it to list available tools (`claude mcp list`).

**Project-level MCP config is separate from global config.**
`~/.claude/mcp.json` is your global config (all projects). `.claude/mcp.json` in a project adds servers just for that project. Servers in both configs are available — they merge.

**Some MCP servers require authentication tokens.**
Many servers (GitHub, Linear, Notion) require API tokens set as environment variables. These are not stored in the MCP config file — they must be available in your shell environment when Claude Code starts.

## Best Practices

**Connect only what you need for the current task.**
Disconnect unused servers with `claude mcp remove`. Fewer servers = faster session start, smaller context, fewer confusing tool options for Claude.

**Use project-level MCP config for project-specific servers.**
A PostgreSQL MCP server pointing at your dev database doesn't belong in your global config — it belongs in `.claude/mcp.json` for that project only.

**Test MCP tools with a simple request first.**
Before relying on an MCP server in a complex workflow, verify it works: "list the open GitHub issues in this repo." If it fails, fix the connection before building on it.

**Build custom MCP servers for internal tools.**
Any internal API your team uses can be wrapped as an MCP server. The MCP spec is simple — a basic server is ~100 lines of Python or TypeScript. The leverage is high: Claude gets direct access to your internal systems without copy-paste.

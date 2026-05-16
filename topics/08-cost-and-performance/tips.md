# Cost & Performance — Tips & Gotchas

## Gotchas

**Prompt caching resets when you compact.**
Anthropic caches repeated context (CLAUDE.md, system prompt) for 5 minutes. Each compact resets what gets cached. Compacting frequently means you lose cache hits and pay full price for repeated context. Compact when needed, not habitually.

**MCP server tool descriptions count as tokens every session.**
Connected MCP servers describe their available tools to Claude at startup. A server with 30 tools, each with a long description, can add 5,000+ tokens before you type anything. Remove unused servers.

**Opus is slower, not just more expensive.**
When time matters (CI, tight feedback loops), Sonnet is often the better choice even for hard problems — because it responds faster. Opus's quality advantage only matters if the task actually needs it.

**Context size affects response quality, not just cost.**
At 80%+ context usage, Claude's responses degrade even before you hit the hard limit. This is not just a billing issue — a full context window means earlier conversation turns get compressed and lose detail.

**Long CLAUDE.md files cost tokens on every single message.**
A 400-line CLAUDE.md is loaded into context and stays there the entire session. At 3 tokens/line average, that's 1,200 tokens per session just for instructions — before any code is read. Each message renewal re-processes this.

## Best Practices

**Use model for complexity, not status.**
Using Opus on simple tasks (rename a variable, add a null check, write a simple test) is purely wasted money. Reserve Opus for decisions that actually need it: system architecture, subtle bugs with many interacting causes, writing something where quality really matters.

**`/context` is your friend — use it proactively.**
Check context usage at natural stopping points: after exploring the codebase, before a long implementation run, after loading large files. Don't wait for Claude to slow down.

**Load files on demand, not upfront.**
Don't start sessions by asking Claude to "read all the relevant files." Let Claude pull files as it needs them. The total cost is similar, but on-demand loading keeps early responses fast and focused.

**Subagent model selection matters.**
A subagent reading 20 files to find a pattern doesn't need Opus. Use Haiku for all read-only and research subagents. Only use Sonnet or Opus for subagents that need to write or make complex decisions.

**Set a default model in settings.json.**
Forgetting to check the current model before a long task and burning Opus credits on Sonnet-level work is a common mistake. Lock your preferred default in `.claude/settings.json` to avoid this.

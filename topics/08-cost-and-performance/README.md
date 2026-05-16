# 08 · Cost & Performance

## What it is

Understanding how tokens, model choice, and context management affect speed and cost — and how to optimize for your workflow. Most cost issues come from three sources: the wrong model for the task, an oversized context window, and unnecessary MCP servers loading at startup.

## How it works

**Model tiers:**

| Model | Tokens/sec | Best for | Cost |
|---|---|---|---|
| Haiku | Fastest | Simple edits, file reading, high-volume tasks | Cheapest |
| Sonnet | Balanced | Most coding tasks | Medium |
| Opus | Slower | Architecture, hard debugging, complex planning | Most expensive |

Every task uses the model set at session start unless you switch mid-session with `/model`.

**Context window:** Claude's context window fills with your conversation history, loaded CLAUDE.md files, MCP server metadata, and file contents Claude has read. Larger context = slower responses and higher cost. Compacting removes conversation history while keeping key findings.

**Prompt caching:** Anthropic automatically caches repeated context (your CLAUDE.md files, long system prompts) for 5 minutes. Cache hits cost ~10% of a normal input token. If you compact frequently, the cache resets — this is why compact timing matters.

## When to use

**Use Haiku for:**
- Subagents doing file reading, grep, or simple formatting
- High-volume automated tasks in CI
- Quick lookups and single-file edits

**Use Sonnet for:** Most interactive coding sessions.

**Use Opus for:** Architecture design, debugging subtle bugs, planning complex systems.

**Compact when:** `/context` shows 60–70% usage. Not at 90% — by then you've already degraded response quality.

## Example

**Check usage:**

```bash
/context    # see context breakdown by source
/cost       # token usage and estimated cost this session (API users)
/stats      # usage stats (Pro/Max users)
```

**Optimization checklist:**

```
[ ] Remove MCP servers you're not using: /mcp → disconnect idle ones
[ ] Keep CLAUDE.md under 120 lines — every line loads every session
[ ] Use subdirectory CLAUDE.md files so only relevant rules load
[ ] Use @file.md to load docs on demand instead of putting them in CLAUDE.md
[ ] Switch to Haiku for subagents doing simple research
[ ] Use /clear between unrelated tasks instead of accumulating stale context
[ ] Compact at 60-70% — do not wait for the 90% warning
```

**Switch models mid-session:**

```bash
/model opus      # switch to Opus for the hard debugging session
/model sonnet    # switch back to Sonnet for implementation work
/model haiku     # switch to Haiku for quick file edits
```

**Minimal settings.json to lock model:**

```json
{
  "model": "claude-sonnet-4-6"
}
```

→ See [examples/](examples/) and [tips.md](tips.md)

# 06 · Agents & Multi-agent Workflows

## What it is

Subagents are separate Claude instances that the main Claude spins up to handle specific tasks in their own isolated context windows. The main agent delegates work, subagents execute and report back.

Multi-agent workflows are the solution when a task is too large for one context window, or when tasks can genuinely be done in parallel.

## How it works

The main agent uses the `Agent` tool to spawn a subagent, passing a prompt and optionally:
- Which tools the subagent can use
- Which model to run it on
- A `maxTurns` cap

The subagent runs completely independently — it does not share context with the main agent. When it finishes, it returns a single message. The main agent reads that result and continues.

**Agent definition file** (stored in `.claude/agents/`):

```markdown
---
name: agent-name
description: When to spawn this agent — written so the main agent knows when to delegate
model: sonnet
tools: Read, Grep, Glob
maxTurns: 20
---

System prompt for the agent goes here.
```

**Spawning a subagent from the main agent:**
Claude automatically discovers agent definitions and can spawn them when appropriate. You can also instruct Claude directly: "use a subagent for the review step."

**Listing live sessions:**
```bash
claude agents          # interactive view — tab title shows awaiting-input count
claude agents --json   # JSON output for scripting (v2.1.145)
```

**Background sessions:** Pinned background sessions stay alive when idle and restart in-place on updates — no manual restart needed (v2.1.147).

**Background agent PR automation:** When a background agent finishes code work, it automatically commits, pushes, and opens a draft PR — no manual step needed (v2.1.198).

**Sub-agent chains:** Sub-agents can spawn their own sub-agents. Chains are capped at five levels deep to prevent runaway recursion (v2.1.166).

**Extended thinking inheritance:** Sub-agents inherit the session's extended thinking configuration (v2.1.198).

**Background permission prompts:** Background sub-agents surface permission prompts in the main session instead of auto-denying (v2.1.191).

**Notification hook:** Add an `agent_needs_input` / `agent_completed` hook in settings.json to receive notifications when background agents need attention or finish (v2.1.198):

```json
{
  "hooks": {
    "Notification": [
      { "matcher": "", "hooks": [{ "type": "command", "command": "notify-send \"Claude\" \"$CLAUDE_NOTIFICATION\"" }] }
    ]
  }
}
```

## When to use

**Use multi-agent when:**
- The task would fill one context window (research + implementation + tests + review)
- Tasks are genuinely parallel and independent (write tests for module A while implementing module B)
- You want a specialized reviewer that has no context of how the code was written — only what it sees now

**Do not use multi-agent when:**
- Tasks share state or depend on each other's output
- The overhead of spawning and briefing a subagent costs more than just doing the work
- A single well-structured session would handle it fine

**Cost warning:** Multi-agent workflows can use 4× the tokens of a single session. Run `/cost` to monitor. Use `/model haiku` for subagents doing simple work (file reading, grep, formatting).

## Example

**Code reviewer agent:**

File: `.claude/agents/code-reviewer.md`

```markdown
---
name: code-reviewer
description: Review code changes for bugs, security issues, and style problems.
             Spawn when implementation is complete and ready for review.
model: opus
tools: Read, Grep, Glob
maxTurns: 15
---

You are a senior code reviewer. When reviewing:
1. Check for security vulnerabilities first (injection, auth bypass, data exposure)
2. Look for logic errors and edge cases
3. Check error handling is complete — no silent failures
4. Verify naming and structure match the project conventions in CLAUDE.md

Be specific: point to file and line number, explain why each issue matters.
Do not suggest style changes unrelated to correctness or security.
```

**Parallel research workflow:**

```
Main agent: "research the three approaches to solving X, I'll start on Y in parallel"

→ spawns subagent-1: research approach A
→ spawns subagent-2: research approach B  
→ spawns subagent-3: research approach C
→ main continues working on Y

All three subagents complete → main agent reads results → makes decision
```

→ See [examples/](examples/) and [tips.md](tips.md)

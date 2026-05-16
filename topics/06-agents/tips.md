# Agents & Multi-agent — Tips & Gotchas

## Gotchas

**Multi-agent costs multiply fast.**
Each subagent has its own context window and token usage. A workflow with 3 parallel subagents uses 3× the tokens of doing the same work sequentially. Monitor with `/cost`.

**Subagents start cold.**
A subagent has no context from the main session. You must provide it everything it needs in the prompt: what the task is, what conventions to follow, what files to read, what success looks like. Vague subagent prompts produce vague results.

**Subagents cannot write back to shared files simultaneously.**
If two subagents both try to modify the same file, you get conflicts. Keep parallel subagent tasks genuinely independent — different files, different modules.

**The main agent cannot interrupt a running subagent.**
Once spawned, a subagent runs to completion (or maxTurns). If you realize you gave it wrong instructions, you have to wait for it to finish, then correct and re-run.

**`maxTurns` is a safety cap, not an optimization.**
Setting `maxTurns: 5` on a subagent that legitimately needs 10 turns will produce incomplete work. Start with a generous cap and reduce it only after you understand the task's actual needs.

## Best Practices

**Brief subagents like a new hire, not like a colleague.**
A new hire doesn't know your codebase, your conventions, or why this task matters. Write subagent prompts that include all necessary context — file paths, conventions, what "done" means, what tools to use.

**Use Haiku for read-only research subagents.**
If a subagent's job is to read files, grep for patterns, or summarize a document — use Haiku. You don't need Opus to read code. This cuts subagent cost by 10–20×.

**One clear deliverable per subagent.**
"Research caching strategies, implement the best one, write tests, and document it" is four tasks. Split it: one subagent researches and recommends, main agent decides, another subagent implements. Focused subagents produce better results.

**Use agents for isolation, not just parallelism.**
A code reviewer subagent with no knowledge of how the code was written gives a more objective review than asking the main agent (which wrote the code) to review it. The isolation is the feature.

**Read the `maxTurns` output before acting on results.**
If a subagent hit its `maxTurns` limit, its result may be incomplete. The output will note this. Do not merge partial results — either re-run with higher limits or complete the work in the main session.

# Example: GitHub Plugin Workflow

This is a real workflow using the GitHub plugin — from install to daily use.

## 1. Preview and install

```bash
/plugin github
# Output shows:
#   MCP server: github (read issues, PRs, reviews, commits)
#   Skill: pr-review-conventions (auto-triggers on PR review tasks)
#   Agent: issue-triage (specialized for triaging open issues)
#   Command: /gh-status

/plugin install github
```

## 2. Fix an issue end-to-end

```
You: fix issue #47
Claude: [reads issue #47 via GitHub MCP]
        [reads files referenced in the issue]
        [implements the fix]
        [runs tests]
        [opens PR with description pulled from the issue]
```

## 3. Triage open issues

```
You: triage this week's open issues, label them by priority
Claude: [spawns issue-triage agent]
        [agent reads all open issues via GitHub MCP]
        [applies priority labels]
        [reports summary back]
```

## 4. Review a PR

```
You: review PR #52
Claude: [reads PR diff via GitHub MCP]
        [pr-review-conventions skill auto-triggers]
        [applies project-specific review rules]
        [posts review comments via GitHub MCP]
```

## What was installed

After `/plugin install github`, check these locations:

```
.claude/
├── skills/
│   └── pr-review-conventions/SKILL.md   ← auto-triggers on PR work
├── agents/
│   └── issue-triage.md                  ← spawned for issue triage tasks
└── settings.json                        ← check for any added hooks
~/.claude/mcp.json                       ← github MCP server entry added
```

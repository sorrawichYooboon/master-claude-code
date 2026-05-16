# master-claude-code

> A personal knowledge base for mastering Claude Code

> Claude Code itself is used to maintain and update this repo every week via custom commands.

This repo documents everything I learn about Claude Code — from the basics of memory files to advanced multi-agent workflows. It serves as both a **personal reference** and a **ready-to-use toolkit** with templates, custom commands, and real examples I actually use in my day-to-day development work.

---

## Table of Contents

- [Why This Repo](#why-this-repo)
- [How to Use This Repo](#how-to-use-this-repo)
- [Repo Structure](#repo-structure)
- [Topics](#topics)
  - [01 · Memory & CLAUDE.md](#01--memory--claudemd)
  - [02 · Core Commands & Workflow](#02--core-commands--workflow)
  - [03 · Hooks](#03--hooks)
  - [04 · MCP (Model Context Protocol)](#04--mcp-model-context-protocol)
  - [05 · Skills](#05--skills)
  - [06 · Agents & Multi-agent](#06--agents--multi-agent)
  - [07 · Session Management](#07--session-management)
  - [08 · Cost & Performance](#08--cost--performance)
- [Templates](#templates)
- [Custom Commands](#custom-commands)
- [Cheatsheet](#cheatsheet)
- [Weekly Update Process](#weekly-update-process)
- [Resources](#resources)

---

## Why This Repo

Claude Code updates extremely fast — sometimes 5+ releases per week. Without a system to capture and organize what you learn, knowledge gets lost and you repeat the same mistakes.

This repo solves that by:
- Keeping all Claude Code knowledge in one organized place
- Using Claude Code itself to research and write weekly updates
- Providing copy-paste templates that work immediately in real projects
- Tracking what changed each week so you never fall behind

---

## How to Use This Repo

**If you just want templates** → go to [`/templates`](/templates)

**If you want to learn a topic** → go to [`/topics`](/topics) and pick the one you need

**If you want a quick command reference** → see [`cheatsheet.md`](/cheatsheet.md)

**If you want to use this repo with Claude Code:**

```bash
# Clone the repo
git clone https://github.com/YOUR_USERNAME/master-claude-code.git
cd master-claude-code

# Open Claude Code in this directory
claude

# Run the weekly update command
/project:weekly-update

# Add a new topic
/project:add-topic "hooks"
```

---

## Repo Structure

```
master-claude-code/
│
├── CLAUDE.md                        ← Instructions for Claude when working in this repo
├── README.md                        ← This file
├── CHANGELOG.md                     ← Weekly updates log
├── cheatsheet.md                    ← All commands and shortcuts on one page
├── resources.md                     ← Links, docs, best repos to follow
│
├── .claude/
│   ├── settings.json                ← Repo-level Claude Code settings
│   └── commands/
│       ├── weekly-update.md         ← /project:weekly-update
│       ├── add-topic.md             ← /project:add-topic
│       └── search-latest.md         ← /project:search-latest
│
├── topics/
│   ├── 01-memory-and-claude-md/
│   ├── 02-core-commands/
│   ├── 03-hooks/
│   ├── 04-mcp/
│   ├── 05-skills/
│   ├── 06-agents/
│   ├── 07-session-management/
│   └── 08-cost-and-performance/
│
└── templates/
    ├── CLAUDE.md.global.md
    ├── CLAUDE.md.project.md
    ├── CLAUDE.md.go-backend.md
    └── gitignore.template
```

---

## Topics

Each topic folder has the same structure:

```
topics/XX-topic-name/
├── README.md          ← concept explanation, how it works, when to use
├── examples/          ← real working examples
└── tips.md            ← gotchas, best practices, things that surprised me
```

---

### 01 · Memory & CLAUDE.md

**What it is:** The file system Claude Code uses to remember things across sessions. Instead of re-explaining your project every time, you write it once in a `.md` file and Claude reads it automatically at the start of every session.

**Files involved:**

| File | Location | Scope | Commit to Git? |
|---|---|---|---|
| Global preferences | `~/.claude/CLAUDE.md` | All projects, always | No |
| Project rules | `/project-root/CLAUDE.md` | This project only | Yes |
| Personal local notes | `/project-root/CLAUDE.local.md` | This project, you only | No |
| Subdirectory rules | `/project-root/backend/CLAUDE.md` | That folder only | Yes |
| Auto memory | `~/.claude/projects/<name>/memory/` | Written by Claude itself | No |

**How loading works:**
- Ancestor files (above current dir) → load at startup always
- Descendant files (below current dir) → load lazily, only when Claude touches files in that folder
- Sibling directories → never load each other

**When to use:**
- You find yourself repeating the same context at the start of every session
- You want Claude to always follow specific rules (naming conventions, error handling style, commit format)
- You work across multiple projects and want consistent behavior

**What to put in it:** Build commands, code conventions, project layout, "always do X" rules, environment setup notes.

**What NOT to put in it:** Vague instructions like "write clean code", anything Claude learns on its own after one session, long procedures (put those in `docs/` instead). Keep it under 120 lines.

**Key commands:**
```bash
/init          # Auto-generate a starter CLAUDE.md from your codebase
/memory        # See everything Claude has loaded and saved
```

→ See [`topics/01-memory-and-claude-md/`](/topics/01-memory-and-claude-md/)

---

### 02 · Core Commands & Workflow

**What it is:** The built-in slash commands and keyboard shortcuts that control Claude Code behavior during a session.

**Essential commands:**

| Command | What it does |
|---|---|
| `/init` | Generate starter CLAUDE.md from your codebase |
| `/compact` | Summarize conversation to free context space |
| `/clear` | Wipe session and start completely fresh |
| `/context` | Show what is using space in your context window |
| `/memory` | Inspect all loaded memory and instruction files |
| `/model` | Switch between Sonnet, Opus, Haiku mid-session |
| `/review` | Built-in code review command |
| `/security-review` | Built-in security audit command |
| `/recap` | Summarize what happened in this session |
| `/diff` | Show current changes |
| `/cost` | Show token usage and cost (API users) |
| `/powerup` | Interactive tutorials built into Claude Code |

**`/compact` vs `/clear`:**
- `/compact` → summarizes and continues. Use when mid-project and need more context space
- `/clear` → wipes everything. Use when starting a completely new unrelated task

**When to compact:** At around 60-70% context usage — not when you hit the warning at 90%+. Run `/context` to check.

**Keyboard shortcuts:**
```
Esc + Esc     → Open rewind menu (selective rollback)
Alt + P       → Switch model while keeping your current input
Alt + T       → Toggle extended thinking mode
```

→ See [`topics/02-core-commands/`](/topics/02-core-commands/)

---

### 03 · Hooks

**What it is:** Scripts that run automatically at specific points in Claude's workflow — before or after it takes an action. Unlike CLAUDE.md instructions (which Claude follows ~70% of the time), hooks are deterministic — they run 100% of the time, no exceptions.

**Why hooks matter:** If a rule is important enough that you cannot afford Claude to skip it, it belongs in a hook, not CLAUDE.md. Example: "never commit to main", "always run tests after editing", "block secrets from being written to files".

**Hook trigger points:**

| Event | When it fires | Common use |
|---|---|---|
| `PreToolUse` | Before Claude runs any tool | Block dangerous actions |
| `PostToolUse` | After Claude runs a tool | Auto-format, run tests |
| `UserPromptSubmit` | When you send a message | Validate input |
| `Stop` | When Claude finishes a task | Run final checks |
| `SessionStart` | At the start of a session | Inject context |
| `PreCompact` | Before /compact runs | Save important state |

**Example — auto-run tests after file edits:**
```json
// .claude/settings.json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit",
        "hooks": [
          {
            "type": "command",
            "command": "go test ./..."
          }
        ]
      }
    ]
  }
}
```

**Example — block commits to main:**
```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "bash .claude/hooks/block-main-commit.sh"
          }
        ]
      }
    ]
  }
}
```

**When to use:**
- Rules that must be enforced without exception
- Automating repetitive actions after Claude edits (format, lint, test)
- Blocking dangerous operations before they happen
- Sound/notification when long tasks finish

→ See [`topics/03-hooks/`](/topics/03-hooks/)

---

### 04 · MCP (Model Context Protocol)

**What it is:** A standard protocol that lets Claude Code connect to external tools and services. Instead of copy-pasting from Jira or GitHub into your chat, Claude reads them directly.

**Why it matters:** This is what transforms Claude Code from "AI that edits files" into "AI that can interact with your entire development ecosystem."

**How to add an MCP server:**
```bash
claude mcp add        # Interactive setup
claude mcp list       # See what's connected
```

**Popular MCP servers:**

| Server | What Claude can do |
|---|---|
| GitHub | Read issues, open PRs, review comments |
| Jira/Linear | Read tickets, update status, create subtasks |
| Figma | Read designs and implement them directly |
| PostgreSQL | Query your database, understand schema |
| Notion | Read and write docs |
| Slack | Read messages, post updates |

**Example workflow with GitHub MCP:**
```
You: fix issue #47
Claude: [reads issue via GitHub MCP] [reads relevant code] 
        [implements fix] [runs tests] [opens PR]
```

**Building your own MCP server:** You can write a custom MCP server for any internal tool — your company's API, internal database, deployment system. Claude Code connects to it the same way.

**When to use:**
- You constantly copy-paste from issue trackers into Claude
- You want Claude to read and update tickets automatically
- You want Claude to work with external APIs without manual data fetching

→ See [`topics/04-mcp/`](/topics/04-mcp/)

---

### 05 · Skills

**What it is:** Reusable instruction sets stored as `SKILL.md` files in `.claude/skills/`. Unlike custom commands (which you trigger manually), skills activate automatically when Claude detects they're relevant based on what you're asking.

**Skills vs Commands:**

| | Skills | Commands |
|---|---|---|
| Trigger | Automatic (Claude decides) | Manual (you type `/project:name`) |
| Best for | Domain knowledge, coding patterns | Repeatable workflows, multi-step tasks |
| Location | `.claude/skills/skill-name/SKILL.md` | `.claude/commands/name.md` |

**Example skill structure:**
```
.claude/skills/
└── api-conventions/
    └── SKILL.md
```

```markdown
---
name: api-conventions
description: REST API design conventions for this project. Use when creating 
             endpoints, handlers, or any HTTP-related code.
---

# API Conventions

- Use kebab-case for URL paths: /user-accounts not /userAccounts
- Always include pagination for list endpoints
- Return errors as: { "error": "message", "code": "ERROR_CODE" }
- Version in URL path: /v1/, /v2/
- Context must be first parameter in all handlers
```

**The description field is critical** — Claude uses it to decide when to automatically apply the skill. Write it with keywords you'd naturally say.

**When to use:**
- Coding patterns specific to your project that Claude keeps getting wrong
- Domain knowledge Claude doesn't have (your internal libraries, your API design rules)
- You find yourself correcting Claude the same way repeatedly

→ See [`topics/05-skills/`](/topics/05-skills/)

---

### 06 · Agents & Multi-agent

**What it is:** Subagents are separate Claude instances that Claude spins up to handle specific tasks in their own isolated context window. The main agent delegates work, subagents execute and report back.

**Why use agents:**
- Long tasks that would fill one context window
- Parallel work — multiple agents on different parts simultaneously
- Specialized roles — one agent for research, one for implementation, one for review

**Agent definition file:**
```markdown
---
name: code-reviewer
description: Reviews code for security, performance, and style issues
model: opus
tools: Read, Grep, Glob
maxTurns: 20
---

You are a senior code reviewer. When reviewing:
1. Check for security vulnerabilities first
2. Look for performance issues
3. Verify error handling is complete
4. Check that tests cover edge cases

Be specific — point to line numbers and explain why each issue matters.
```

**Single agent vs multi-agent:**
- Single well-structured session → better for most tasks
- Multi-agent → use only when tasks are genuinely independent and parallel

**Cost warning:** Multi-agent workflows can use 4x the tokens of a single session. Use `/cost` to monitor.

**When to use:**
- Tasks too large for one context window
- Genuinely parallel work (e.g. write tests for module A while implementing module B)
- Specialized review agent separate from your main coding session

→ See [`topics/06-agents/`](/topics/06-agents/)

---

### 07 · Session Management

**What it is:** Tools for managing, naming, resuming, and branching Claude Code sessions so you never lose work or context.

**Key commands:**

| Command | What it does |
|---|---|
| `/rename` | Give the current session a meaningful name |
| `/recap` | Summarize what happened in this session |
| `claude --continue` | Resume the most recent session |
| `claude --resume` | Pick a session from a list to resume |
| `/branch` | Fork current session to experiment safely |

**Best practice workflow:**
```bash
# Start session, name it immediately
claude
/rename fix-kafka-consumer-timeout

# Work... work... work...

# Before finishing
/recap     # Get a summary of what was done

# Next day, resume exactly where you left off
claude --resume "fix-kafka-consumer-timeout"
```

**`/branch` use case:** You're mid-task and want to try a risky refactor without breaking your current progress. Branch → experiment → if it works, keep it; if not, abandon and return to the original.

**When to use:**
- Long tasks that span multiple days
- You switch between multiple projects frequently
- You want to experiment without losing your current working state

→ See [`topics/07-session-management/`](/topics/07-session-management/)

---

### 08 · Cost & Performance

**What it is:** Understanding how tokens, models, and context management affect speed and cost — and how to optimize.

**Model selection:**

| Model | Best for | Cost |
|---|---|---|
| Haiku | Simple edits, quick lookups, high-volume tasks | Cheapest |
| Sonnet | Most coding tasks, good balance | Medium |
| Opus | Complex architecture, hard debugging, planning | Most expensive |

**Switch models mid-session:**
```bash
/model sonnet    # Switch to Sonnet for implementation
/model opus      # Switch to Opus for architecture decisions
```

**Context optimization:**
- Run `/context` to see what is eating your context window
- Use `@docs/file.md` to load docs on demand instead of putting everything in CLAUDE.md
- Compact at 60-70% — not when you hit the warning
- Use subdirectory CLAUDE.md files so only relevant rules load

**Token cost tips:**
- Disable MCP servers you're not using (`/mcp` to manage)
- Keep CLAUDE.md under 120 lines
- Use `/clear` between unrelated tasks instead of accumulating context
- Prefer Sonnet for implementation, Opus only for planning

**Monitoring:**
```bash
/context    # Current context usage breakdown
/cost       # Token usage and cost this session (API users)
/stats      # Usage stats (Pro/Max users)
```

→ See [`topics/08-cost-and-performance/`](/topics/08-cost-and-performance/)

---

## Templates

Ready-to-copy files in the [`/templates`](/templates/) folder:

| Template | Use case |
|---|---|
| `CLAUDE.md.global.md` | Copy to `~/.claude/CLAUDE.md` — your personal global preferences |
| `CLAUDE.md.project.md` | Starting point for any new project |
| `CLAUDE.md.go-backend.md` | Go backend services (Kafka, REST APIs, Docker) |
| `gitignore.template` | `.gitignore` entries for Claude Code files |

**How to use:**
```bash
# Use the global template
cp templates/CLAUDE.md.global.md ~/.claude/CLAUDE.md

# Use the Go backend template for a new project
cp templates/CLAUDE.md.go-backend.md ~/my-project/CLAUDE.md
```

---

## Custom Commands

Commands in `.claude/commands/` are available inside any Claude Code session opened in this repo. Type the command name to run it.

| Command | What it does |
|---|---|
| `/project:weekly-update` | Search for Claude Code updates this week, update CHANGELOG.md and relevant topic files |
| `/project:add-topic` | Create a new topic folder with README.md and examples structure |
| `/project:search-latest` | Search for latest Claude Code news and return a summary |

**How to run:**
```bash
# Open Claude Code in this repo
cd master-claude-code
claude

# Then inside the session
/project:weekly-update
```

**How to add a new command:**
1. Create a new `.md` file in `.claude/commands/`
2. Write the prompt inside it — Claude will execute this when you run the command
3. Use `$ARGUMENTS` to accept input: `/project:add-topic hooks`

---

## Cheatsheet

See [`cheatsheet.md`](/cheatsheet.md) for a single-page reference of every command, shortcut, and file location.

---

## Weekly Update Process

Every week, open this repo in Claude Code and run:

```bash
claude
/project:weekly-update
```

This command instructs Claude to:
1. Search the web for Claude Code changelog and news from the past 7 days
2. Add a new entry to `CHANGELOG.md` with the date and changes found
3. Update any topic `README.md` files that are affected by new features
4. Report back what changed so you can review before committing

Then commit the changes:
```bash
git add .
git commit -m "docs: weekly update $(date +%Y-%m-%d)"
git push
```

---

## Resources

See [`resources.md`](/resources.md) for the full list. Quick links:

- **Official docs:** https://docs.claude.com/en/docs/claude-code/overview
- **Official best practices:** https://code.claude.com/docs/en/best-practices
- **Changelog tracker:** https://claudefa.st/blog/guide/changelog
- **Community repo:** https://github.com/shanraisshan/claude-code-best-practice

---

## Contributing

This is a personal learning repo but PRs are welcome — especially:
- Corrections to anything outdated
- New examples that work in real projects
- Missing tips or gotchas you've discovered

---

## License

MIT — use anything here freely in your own projects.

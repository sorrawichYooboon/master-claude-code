# Session Management — Tips & Gotchas

## Gotchas

**Unnamed sessions are hard to find.**
`claude --resume` shows a list of sessions. Unnamed sessions display their auto-generated ID and a short context snippet — both are hard to scan. Name every session you plan to continue.

**`--continue` resumes the most recent session, not the most recent named session.**
If you opened an unnamed quick session after your named feature session, `--continue` will resume the unnamed one. Use `--resume` and pick by name to be precise.

**Branching does not protect the original from your changes.**
`/branch` creates a new session at the current state — it doesn't lock the original. The branch is the experimental copy; you work in the branch. The original session still exists and is unchanged, but you're no longer in it.

**`/recap` quality depends on what happened in the session.**
If the session was mostly exploration with no clear outcomes, the recap will be vague. Write explicit summaries when you reach milestones: "we decided to use Redis for sessions because of X" gives Claude something concrete to capture.

**Session context does not include file system changes.**
If Claude edited files in a previous session, the edits exist on disk — but if you start a new session, Claude doesn't know what was changed unless it reads the files or you tell it. `git diff` or `git log` is the best way to re-orient a resumed session.

## Best Practices

**Name sessions immediately, before doing any work.**
The natural moment to name a session is right after opening it, while you're still typing your first message. Once you're deep in the work, naming feels like an interruption.

**Use `/recap` as your session closing ritual.**
Before closing Claude, run `/recap`. This creates a summary you can paste into the next session to orient Claude instantly: "Continue from last session: [recap]."

**Branch before any risky change.**
Branching is low cost and high safety. Any time you're about to try something that might break what you have working — branch first. You can always abandon the branch.

**Keep sessions task-focused, not project-focused.**
One session per feature or task, not one session per project. "Fix auth token expiry" is a good session scope. "Backend work" is too broad — it accumulates unrelated context and makes recaps useless.

**Use `/diff` + `/review` at the start of a resumed session.**
When resuming, quickly run both to see what changed last session and get a quality check. This re-orients Claude to the current state without reading through the entire history.

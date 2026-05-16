# Skills — Tips & Gotchas

## Gotchas

**The description field determines whether the skill is used.**
Claude reads the description to decide if the skill applies to your request. A vague description like "for API work" may never trigger, or may trigger too broadly. Write descriptions with the specific phrases you use: "when creating REST endpoints", "when writing SQL migrations", "when adding new Kafka consumers".

**Skills are not guaranteed to trigger.**
Unlike hooks (100% deterministic) or CLAUDE.md (always loaded), skills fire based on Claude's judgment about relevance. If a skill isn't triggering when it should, rewrite the description to more closely match how you phrase those tasks.

**Skills add context window overhead when triggered.**
A skill loaded into context is like loading a file — it uses tokens. Long skill files with extensive instructions will cost tokens every time they trigger. Keep skills focused on one domain; split large skills into smaller ones.

**Skills vs CLAUDE.md: overlap causes confusion.**
If the same rule exists in CLAUDE.md (always loaded) and in a skill (conditionally loaded), Claude may apply it inconsistently. Put universal rules in CLAUDE.md; put domain-specific rules in skills.

**Skills can conflict with each other.**
If two skills trigger on the same request and give contradictory instructions, Claude will try to satisfy both — usually producing something that satisfies neither. Make skill scopes non-overlapping.

## Best Practices

**One skill per domain, not one skill per rule.**
A skill for "API conventions" should contain all your API rules. Don't create separate skills for "API error format", "API URL naming", "API pagination" — Claude will trigger none of them because each description is too narrow.

**Write descriptions from the user's perspective.**
The description answers: "what would I say to Claude that should trigger this?" Not "what is this skill about." Bad: "Contains API design rules." Good: "Use when creating new API endpoints, route handlers, or HTTP middleware."

**Test skill descriptions by asking Claude what it would do.**
Type your planned request and ask: "would you apply any skills to this?" If it doesn't mention your skill, your description needs revision.

**Use skills for repetitive corrections.**
If you've corrected Claude the same way 3+ times ("no, our pagination uses cursor not page number"), that correction belongs in a skill, not in the next message.

#!/bin/bash
# Example session management workflow
# These are commands typed inside Claude Code, not shell commands.
# This file documents the pattern for reference.

# ─── Starting a new task ──────────────────────────────────────────────────────

# 1. Open Claude Code
claude

# 2. Name the session immediately (before any work)
# /rename fix-payment-webhook-timeout

# 3. Work on the task...

# ─── Mid-session context check ───────────────────────────────────────────────

# Check how much context is used
# /context

# If over 60-70%, compact before continuing
# /compact

# ─── Before a risky change ───────────────────────────────────────────────────

# Fork the session to experiment safely
# /branch

# Try the risky approach in the branch.
# If it works: keep it.
# If it doesn't: close this session, resume the original named session.

# ─── Ending a session ────────────────────────────────────────────────────────

# Get a summary before closing
# /recap

# Claude outputs something like:
# "Implemented webhook signature validation. Fixed timeout from 5s to 30s.
#  Still needed: retry logic for failed webhooks, tests for signature mismatch case."

# Copy the recap for next session.

# ─── Resuming next day ───────────────────────────────────────────────────────

# Resume by name
claude --resume
# Arrow keys to select "fix-payment-webhook-timeout", Enter

# Or directly if you know the name
# claude --resume "fix-payment-webhook-timeout"

# Orient Claude with the recap:
# "Continue from last session. Recap: [paste recap here]"

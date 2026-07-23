---
name: archive
description: Archive (or unarchive) one job opportunity so it drops out of the Job Hunt and Recruiter Inbox dashboards and future scans won't re-add it. Takes the card's ref - a Gmail thread id, a LinkedIn thread URL, or a job-posting URL - from either dashboard's Archive button.
---

# /archive [ref]  ·  /archive unarchive [ref]

Records an opportunity as archived (or unarchived) in the single source of truth, `context-library/dashboard-state.json`, then re-injects both dashboards so the card disappears (or returns). The dashboard's **Archive** button fires this; it also hides the card immediately in the browser, and this skill makes that persist across devices and stops the scans from resurfacing it.

**Read-only** except for the state file + the two dashboard HTML files it re-syncs. It never touches Gmail, LinkedIn, the resume, or `recruiter-inbox.md` dispositions.

## Input

The argument is the card's **ref** - exactly what the button passed:
- a **Gmail thread id** (hex, e.g. `19f8091b2c1ef05f`) - a recruiter-inbox Gmail card,
- a **LinkedIn thread URL** (`https://www.linkedin.com/messaging/thread/<id>/`) - a recruiter-inbox LinkedIn card, or
- a **job-posting URL** (`http…`) - a Job Hunt web-sweep prospect.

If the argument begins with the word `unarchive` (e.g. `/archive unarchive 19f8091b2c1ef05f`), it's an **un-archive** request - strip that word and pass `-Unarchive`.

## Steps

### 1. Run the helper
From the repo root, in PowerShell:

- Archive:   `dashboard\Archive-Opportunity.ps1 -Ref "<ref>"`
- Unarchive: `dashboard\Archive-Opportunity.ps1 -Ref "<ref>" -Unarchive`

Quote the ref (LinkedIn/posting URLs contain `/`, `=`, `&`). The script updates `context-library/dashboard-state.json`'s `archived` map and re-runs `Sync-Dashboards.ps1`, which rewrites the `RUN_STATE`/`ARCHIVED` block in `dashboard/job-hunt.html` (the merged dashboard — Recruiter Inbox is its first tab).

### 2. Confirm
Report back: archived vs. unarchived, the ref, and that both dashboards were re-synced. If the opportunity is worth remembering *why* it was archived (e.g. onsite-only, comp below floor, off-target), note it in one line - and if it has a row in `context-library/recruiter-inbox.md`, you may set its Disposition to `Skip` so the .md source of truth agrees. Never invent a reason; if none was given, just confirm the archive.

## Notes
- Archived refs are respected by the scan skills (`job-hunt-scan`, `recruiter-scan`, `linkedin-scan`) - they read `dashboard-state.json` and skip archived refs when regenerating the dashboards, so an archived opportunity stays gone.
- This is reversible: `/archive unarchive <ref>` brings it back.

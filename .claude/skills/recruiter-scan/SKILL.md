---
name: recruiter-scan
description: Run the recruiter-inbox Gmail scan on demand, then sync the desktop widget. This is the manual/on-click equivalent of the daily recruiter-inbox-scan scheduled task — triggered by the Recruiter Inbox Rainmeter widget's refresh button.
---

Run the Recruiter Inbox scan now, then refresh the desktop widget. Work in the repo at `C:\Users\andre\OneDrive\Claude\job-search-os`.

## STEP 1 — Run the scan

Read `C:\Users\andre\.claude\scheduled-tasks\recruiter-inbox-scan\SKILL.md` and execute **every step in it exactly** — scan Gmail for new human-recruiter emails, score each against the career plan, apply the one Gmail label per thread, and update both `context-library/recruiter-inbox.md` and `dashboard/recruiter-inbox.html`. Preserve all existing rows and Disposition values; only add new emails on top.

## STEP 2 — Sync the desktop widget

After the scan has finished writing `dashboard/recruiter-inbox.html`, regenerate the Rainmeter widget's data snapshot and refresh the skin so the desktop widget shows the new roles:

```
powershell -ExecutionPolicy Bypass -File "C:\Users\andre\OneDrive\Documents\Rainmeter\Skins\RecruiterInbox\Update-RecruiterData.ps1"
```

`Update-RecruiterData.ps1` parses the `DATA` array out of `recruiter-inbox.html`, rewrites `data.lua` (Windows-1252, so the `·` separators render), and issues `!Refresh RecruiterInbox`. Confirm it prints the role count.

## STEP 3 — Summary

Print the scan summary (how many new emails, any new Strong-Fit roles with a one-line reason, any privacy red flags) and confirm the widget was refreshed. Do not send or draft anything — this is read/label/record + widget refresh only.

---
name: recruiter-scan
description: Run the recruiter-inbox Gmail scan on demand, then sync the desktop widget. This is the manual/on-click equivalent of the daily recruiter-inbox-scan scheduled task — triggered by the Recruiter Inbox Zebar widget's refresh button.
---

Run the Recruiter Inbox scan now, then refresh the desktop widget. Work in the repo at `C:\Users\andre\OneDrive\Claude\job-search-os`.

## STEP 1 — Run the scan

Read `C:\Users\andre\.claude\scheduled-tasks\recruiter-inbox-scan\SKILL.md` and execute **every step in it exactly** — scan Gmail for new human-recruiter emails, score each against the career plan, apply the one Gmail label per thread, and update both `context-library/recruiter-inbox.md` and the `DATA` array in `dashboard/job-hunt.html` (Recruiter Inbox tab, between the `RECRUITER_DATA_START/END` markers — the standalone recruiter-inbox.html is retired; also bump the `id="scandate"` span). Preserve all existing rows and Disposition values; only add new emails on top.

## STEP 2 — Sync the desktop widget

After the scan has finished writing `dashboard/job-hunt.html`, regenerate the Zebar widget's data snapshot so the desktop widget shows the new roles:

```
powershell -ExecutionPolicy Bypass -File "C:\Users\andre\OneDrive\Claude\job-search-os\dashboard\Sync-Widgets.ps1" -Target recruiter
```

`Sync-Widgets.ps1` parses the `DATA` array out of `job-hunt.html` and writes `recruiters.json` into the Zebar pack folder (`~/.glzr/zebar/recruiter-inbox/`), dropping archived cards so the widget KPIs match the dashboard's live counts. The Zebar widget polls that file (~every 5 min), so no refresh push is needed — the new roles appear on the widget's next poll, and the widget's ↻ button reruns exactly this script. Confirm it prints the role count. It skips silently if the Zebar pack folder isn't present. _(The old `Rainmeter\Skins\RecruiterInbox\Update-RecruiterData.ps1` still works — it's now a thin shim over this script.)_

## STEP 3 — Summary

Print the scan summary (how many new emails, any new Strong-Fit roles with a one-line reason, any privacy red flags) and confirm the widget was refreshed. Do not send or draft anything — this is read/label/record + widget refresh only.

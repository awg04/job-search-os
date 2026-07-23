---
name: next-steps
description: Produce a prioritized, methodology-driven next-steps plan for one job opportunity — a recruiter email (Gmail thread ID) OR a job-posting URL from the Job Hunt dashboard — grounded in the Job Search OS philosophy. Read-only — recommends actions, never sends.
---

# /next-steps [threadId | posting-URL]

Given a single opportunity, output the **concrete next actions to advance it**, prioritized and dated, using the Job Search OS methodology. Read-only: it recommends and can update the tracker's Next-action field, but never drafts or sends. Fed by the "/next-steps" buttons on both the recruiter-inbox dashboard (thread IDs) and the Job Hunt dashboard's Job Prospects tiles.

Gmail MCP prefix: `mcp__deef110b-6a80-4c37-9ca1-359ef23e5e88__`.

## Input type — detect first
- **Gmail thread ID** (hex, e.g. `19f8064120818784`) → recruiter/alert opportunity. Use the Gmail + recruiter-inbox flow below.
- **A URL** (starts `http`) → a Job Hunt **web-sweep prospect** (no recruiter, no email thread). Instead: find the matching card in `dashboard/job-hunt.html`'s `ALERT_DATA` for its title/company/score/note, then **WebFetch the URL** to confirm it's live + remote and pull JD facts (salary, stack, seniority, application path). There is no recruiter to reply to — the path is a **direct application** (referral-first) via the posting, not `/recruiter-action`. Skip Gmail steps; everything else (stage detection, methodology, output) applies. If the fetch fails (dead/403), say so and recommend confirming the posting is still open before investing.

## OS methodology (the lens for every recommendation)
- **Referrals before cold applications** — a referral is ~5x more effective. Always build the referral path first.
- **Precision over volume** — one tailored, well-sequenced pursuit beats spray-and-pray.
- **Work products earn interviews** — for get-interview / in-process stages, a company-specific 1-pager is the strongest differentiator.
- **The system compounds** — each touch (connection, work product, debrief) sets up the next.
- **Remote-only + Microsoft-stack fit + $130K/$70-hr floor** — from `career-plan.md`; don't recommend advancing roles that fail the hard filters without flagging it.

## Steps

### 1. Load context
Read `context-library/recruiter-inbox.md` (this thread's row: score, verdict, disposition, flags), `context-library/app-tracker.md` (current status + last/next action if tracked), `context-library/career-plan.md`, and `context-library/connection-tracker.md` + `context-library/target-companies.md` if they exist. `get_thread` for the role/recruiter/client if not already summarized.

### 2. Determine the current stage
Map to one of: **Watching** (scored, no outreach) · **Reply drafted** · **Applied / reply sent** · **Recruiter screen** · **In process / interviewing** · **Offer** · **Stalled / no response**. Use app-tracker status if present, else infer from recruiter-inbox disposition + notes.

### 3. Build the prioritized next steps (stage-aware, methodology-driven)
Give **3–6 concrete, ordered actions**, each with a one-line why and a suggested timing. Pull from the OS skill set where relevant:
- **No outreach yet, strong fit** → build the **referral path** first (check `connection-tracker.md` for contacts at the end client / staffing firm; if none, `/connection-request`). Then `/recruiter-action` to draft the reply. If pre-interview and the client is named, a **work product** (`/work-product`) is the differentiator.
- **Reply drafted, not sent** → review + send; set the follow-up date (per app-tracker cadence, ~3–4 business days).
- **Applied / reply sent** → follow-up cadence; identify the **hiring manager** and consider `/hiring-manager-msg` leading with a work product; research the company (`/company-research`).
- **Recruiter screen / in process** → `/interview-prep` (pull insider-data for the client), `/mock-interview` on weak areas, `/salary-research` to prep comp.
- **Offer** → `/negotiate` before responding; `/salary-research` for leverage.
- **Stalled** → one final follow-up, then archive; log the pattern for `/weekly-retro`.
Always fold in the open logistics for this thread (e.g., **ask bill rate / confirm end client** if unstated; verify fully-remote if ambiguous) and any **red flags** from the recruiter-inbox row (e.g., PII requests, comp below floor).

### 4. Record + output
Optionally update the thread's Next-action in `app-tracker.md` (if tracked) — never change the user's Disposition. Then print the prioritized checklist with timings, the current stage, and the single **highest-leverage next action** called out first. Note dates as absolute.

**Log the run** so the dashboard's Next-Steps button shows its green check: in PowerShell from the repo root, run
`dashboard\Record-DashboardRun.ps1 -Ref "<ref>" -Command next-steps`
where `<ref>` is the exact argument you were given (Gmail thread id, LinkedIn thread URL, or posting URL — quote it). This updates `context-library/dashboard-state.json` and re-syncs both dashboards.

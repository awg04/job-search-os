---
name: job-fit-inbox
description: Score one recruiter opportunity's role for fit (0-100 across 5 dimensions), analyze it, and recommend next steps. Takes a Gmail thread ID OR a LinkedIn thread URL from the recruiter-inbox dashboard.
---

# /job-fit-inbox [threadId]

Scores a single inbox opportunity against Andrew's career plan and recommends what to do about it. **Read-only** — it never drafts or sends. Output is a scorecard + role analysis + concrete next steps. The dashboard "📊 Score fit & next steps" button runs this.

Gmail MCP prefix: `mcp__deef110b-6a80-4c37-9ca1-359ef23e5e88__`.
Outlook helpers (for JD attachments): `.claude/skills/recruiter-action/outlook-helpers.ps1`.

## Input resolution

The argument is one of two things — detect which before scoring:
- **Gmail thread ID** (hex, e.g. `19f8064120818784`) → recruiter email. Use the Gmail flow: `get_thread` in step 2.
- **A LinkedIn thread URL** (`https://www.linkedin.com/messaging/thread/<id>/`) → a LinkedIn-sourced card (`source:"linkedin"`). There is **no Gmail thread** — do NOT call `get_thread`. The saved data for these lives in the **`DATA` array in `dashboard/job-hunt.html`** (Recruiter Inbox tab; between the `RECRUITER_DATA_START/END` markers) (the daily Gmail `recruiter-inbox-scan` regenerates `context-library/recruiter-inbox.md` and does NOT carry LinkedIn rows, so that file usually won't have it). In step 2: extract the `<id>` from the URL, find the matching `{id:"<id>", … source:"linkedin"}` object in `job-hunt.html`'s `DATA` (it already carries score, role, recruiter/firm, client, remote, comp, tags, and flags from the LinkedIn scan). If a matching row also exists in `recruiter-inbox.md`, fold it in. If you need the full first message to score properly, open the conversation in the logged-in Chrome browser: `mcp__claude-in-chrome__navigate` to the thread URL, then `read_page` the active-thread message region (per the `linkedin-scan` browser gotchas — `get_page_text` returns the job-card attachment, not the messages). If Chrome isn't connected, score from the saved `DATA` object and flag that live remote/comp verification still needs the browser. Everything else (rubric, verdict, record) is identical.

## Steps

### 1. Load context
Read `context-library/career-plan.md`, `context-library/experience-library.md` (for skill-match evidence), and `context-library/recruiter-inbox.md` (the existing row/score for this thread). Check `context-library/target-companies.md` and `insider-data/company-intel/` if the client is named.

### 2. Analyze the role
For a Gmail thread ID: `get_thread` (FULL_CONTENT). For a LinkedIn thread URL: use the saved `DATA` object in `dashboard/job-hunt.html` (+ Chrome browser for live detail) per **Input resolution** above (no `get_thread`). Extract role title, end client, remote policy, comp/rate, contract vs. perm, and the JD. **If the JD is only in an attachment** the connector can't read: dot-source the helpers and run `Save-JdAttachment -Subject "<exact subject>" -DestPath "<folder>\jd-source.pdf"`, then `Read` it. Don't score against a guessed JD — if the JD can't be recovered, score what's known and flag the gaps.

### 3. Score 0-100 across the 5 OS dimensions (0-20 each)
- **Skill match** — JD requirements vs. the experience library. Reward Microsoft/Power BI stack depth (Power BI, Fabric, Azure, SQL, DAX, ETL, Power Platform); discount heavy non-MS-only stacks (Snowflake/dbt-only, Hadoop, SAP).
- **Seniority fit** — level vs. the Senior BI Developer / BI Lead / Senior Data Engineer target. Penalize junior or pure-BA/BSA framing.
- **Culture signals** — mature data culture, BI as a first-class function, named end-client. Red-flag pure body-shops, PII-harvesting recruiters, vague "multiple client roles."
- **Comp range** — vs. the floor ($130K base / $70/hr contract). Below floor = low; unstated = note it.
- **Growth trajectory** — stack alignment with where Andrew is heading (Fabric/Azure/BI leadership), learning potential, remote-career durability.

Show a per-dimension table with a one-line justification each, then the total.

### 4. Role analysis
3-5 lines: strongest matches, real gaps, green/red flags, and remote-verification status (remote-only is the hard filter).

### 5. Verdict + next steps
Verdict: **Apply** / **Apply with referral only** / **Skip** (mirror the score: 75+ apply, 50-74 referral/verify-first, <50 skip). Then list concrete next steps, e.g.:
- Strong fit → "Run recruiter-action (✍ button) to tailor + draft a reply."
- Unstated remote/rate → "Reply to confirm fully-remote / bill rate before investing effort."
- Named target company → "Run /company-research and /interview-prep."
- Skip → one-line why, and whether to still log it.

### 6. Record
Reuse or create `applications/<YYYY-MM-DD>_<firm-slug>_<role-slug>_<codename>/` and write `fit-score.md` (the scorecard + verdict + next steps). Update the thread's row in `recruiter-inbox.md` if the score/notes changed — but **never change Andrew's Disposition column**.

**Log the run** so the dashboard's Job Fit Inbox button shows its green check: in PowerShell from the repo root, run `dashboard\Record-DashboardRun.ps1 -Ref "<ref>" -Command job-fit-inbox` where `<ref>` is the exact argument you were given (Gmail thread id or LinkedIn thread URL — quote it). This updates `context-library/dashboard-state.json` and re-syncs both dashboards.

### 7. Output
Print the scorecard table, verdict, and next steps concisely. Note dates as absolute.

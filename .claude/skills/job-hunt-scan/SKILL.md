---
name: job-hunt-scan
description: Scan Gmail job-ALERT emails AND run the web sweep (LinkedIn/Dice/Indeed searches + Google x-rays from job-hunt-sweep.json) for good-fit postings; grade them and refresh the Inbox Job Prospects section of dashboard/job-hunt.html + the Job Hunt widget.
---

# /job-hunt-scan

Refreshes the **Inbox Job Prospects** section of `dashboard/job-hunt.html` from two channels:
1. **Inbox channel** — automated job-alert emails (the board-alert counterpart to the recruiter-inbox scan, which deliberately skips non-human senders).
2. **Web-sweep channel** — the saved searches in `context-library/job-hunt-sweep.json` (LinkedIn Boolean search, Dice, Indeed, and Google x-rays of Glassdoor/Wellfound/BuiltIn/careers pages), graded with the same rubric; only **strong fits (≥65)** merge into the list — plus the **hybrid-local exception** (step 4): hybrid roles within 20 mi of 33301 that score ≥75 with at-or-above-floor stated comp merge as `look`.

Gmail MCP server prefix: `mcp__deef110b-6a80-4c37-9ca1-359ef23e5e88__`.

## Scope
- **In:** automated alert senders — LinkedIn job alerts (`jobalerts-noreply@linkedin.com`, `jobs-noreply@linkedin.com`), Dice, Indeed, ZipRecruiter, Glassdoor, Built In, Wellfound, Lensa, Jobrapido, Monster, CareerBuilder, DirectlyApply (`*@directlyapply.com`), JobLeads (`mailer@jobleads.com`, `careerservice@email.jobleads.com`), PostJobFree (`jobalertlocal@`/`smartjobalert@postjobfree.com`), iHire (`jobseekers@email.ihire.com`), and any new alert sender discovered via `subject:("job alert" OR "jobs for you" OR "new jobs")`. (Sender inventory: `context-library/lead-sources.md`.)
- **Out:** human recruiter emails (handled by the recruiter-inbox scan) and anything already in `context-library/recruiter-inbox.md` or the app tracker.

## Steps

1. **Load fit criteria** from `context-library/career-plan.md` and `context-library/job-title-search-list.md` (title families). Core levers: remote-only, Microsoft stack (Power BI/Fabric/Azure/SQL/SSIS/DAX), comp floor $130K / $70-hr, BI-core title family.
2. **Search the last 7 days** of alert emails (`newer_than:7d` + sender queries above). This scan is high-volume — if running interactively, delegate the Gmail paging to a background general-purpose subagent and have it return structured JSON (see schema below), keeping raw email content out of the main context.
3. **Extract individual postings** from each alert email (title, company, location, salary if shown, per-job link from the email's hrefs — tracking/redirect URLs are fine).

3b. **Web sweep.** Read `context-library/job-hunt-sweep.json`. It holds a single canonical `boolean` (built from the `titles` list — Andrew's dashboard families + email-scan variants) that every sweep query is composed from at runtime (sweeps no longer store the query verbatim). Build and run each sweep:
   - `method: "websearch"` → run **one query per entry in `websearchBatches`** (two batches): `query = <batch> + " " + <scope> + " remote"`, via the WebSearch tool (the Google x-ray equivalent — works in every context, including the widget-refresh window). Merge both batches' results per sweep. The batches exist because Google truncates queries past ~32 words — never substitute the full `boolean` here (its tail titles would be silently ignored). The batches are the containment-minimal cover of `titles`, ordered highest-value-first; **regenerate them whenever `titles` changes.** Collect result titles/URLs that look like individual job postings.
   - `method: "browser"` → build `{KW}` from the `boolean`'s inner term list (drop the outer parens): quote each phrase (`"` → `%22`), replace intra-phrase spaces with the sweep's `space` value, and join terms with `<space>OR<space>`. Substitute into `base` (`{KW}` placeholder) and open the URL via the Chrome MCP (logged-in LinkedIn/Dice/Indeed) or the in-app browser; extract visible result cards (title, company, location, salary, posting URL). **If no browser is available in this context, skip these sweeps and say so in the report** — never fail the whole scan over them. Example (LinkedIn, `space:"%20"`): `%22Power%20BI%20Developer%22%20OR%20%22Power%20BI%20Engineer%22%20OR%20…`; (Dice/Indeed, `space:"+"`): `%22Power+BI+Developer%22+OR+%22Power+BI+Engineer%22+OR+…`.
   - **To change which titles the sweep covers:** edit `titles` + `boolean` + both `websearchBatches` in the JSON (keep all three in sync). Containment note: a phrase match on `"Power BI Developer"` already catches "Senior/Lead/Fabric Power BI Developer", so don't add seniority-prefixed duplicates — and the batches should keep only the shortest phrase of each containment family.
   - For promising hits, WebFetch the posting when needed to confirm it's live + remote and grab salary/stack detail. Never fabricate a posting — only report URLs actually seen.
   - Delegate the whole sweep to a background general-purpose subagent returning JSON (same schema as below) when running interactively — keeps SERP noise out of the main context.
   - Web-sweep hits merge **only if they score ≥ `strongThreshold`** (65, `tier:"strong"`) — the sweeps are noisier than curated alerts, so worth-a-look web hits are dropped. Label each with its sweep's `source` value (e.g. "LinkedIn Search", "Glassdoor", "BuiltIn").

4. **Filter + score** (both channels, one rubric). Keep only good-fit remote roles; rough-score 0-100 (remote confirmed, title-family match, MS-stack keywords, salary vs. floor, seniority). Tiers: `strong` ≥65, `look` 40-64, drop <40 (and drop web-sweep hits <65 per 3b).
   - **Hybrid-local exception** (`hybridLocal` in the sweep JSON): a hybrid posting within `radiusMiles` of `homeZip` (33301 — Fort Lauderdale/Boca/Miramar-ish; use common sense on suburb names) is kept **only if** it scores ≥ `minScore` (75) **and** states comp at/above the floor (`compFloorAnnual` $130K or `compFloorHourly` $70). Qualifiers merge with `tier:"look"` — **never `strong`** — so they land in the Worth-a-Look bucket without diluting the remote-first strong list. Applies to alert-email hits too, not just the `hybridLocal:true` sweeps. Unstated comp, 5-day-onsite, or beyond-radius → still dropped. In the card's `note`, lead with the hybrid arrangement and commute city (e.g. "Hybrid 3d — Deerfield Beach. $135K…"). Dedupe company+title across emails AND sweeps (an alert hit + a sweep hit for the same role = one entry, keep the better URL); also drop anything already in recruiter-inbox.md or app-tracker.md. **Drop any posting whose ref (its threadId or url) is in `context-library/dashboard-state.json`'s `archived` map** — the user archived it on purpose; don't resurface it. Cap at ~25 best.
5. **Update the dashboard.** In `dashboard/job-hunt.html`, replace the content between the markers (keep the markers themselves):
   - `// ALERT_DATA_START` … `// ALERT_DATA_END` → `const ALERT_DATA = [ …objects… ];`
   - `// ALERT_UPDATED_START` … `// ALERT_UPDATED_END` → `const ALERT_UPDATED = "YYYY-MM-DD";`
   Object schema (all fields required, `url` may be null):
   ```json
   {"title":"","company":"","source":"LinkedIn","date":"YYYY-MM-DD","score":72,"tier":"strong|look","url":"https://… or null","threadId":"","note":"one short line"}
   ```
   Read/write the file as UTF-8. Do not touch anything outside the markers — in particular leave the `// DASH_STATE_START … // DASH_STATE_END` block alone. After writing, run `dashboard\Sync-Dashboards.ps1` (PowerShell) to refresh the run-state ✓ / archived block against the regenerated cards.
6. **Sync the desktop widget:** run
   ```
   powershell -NoProfile -ExecutionPolicy Bypass -File "C:\Users\andre\OneDrive\Claude\job-search-os\dashboard\Sync-Widgets.ps1" -Target job-hunt
   ```
   This regenerates the Zebar Job Hunt widget's `jobs.json` from the dashboard's ALERT_DATA, minus archived cards, so the widget KPIs match the dashboard's. Confirm it prints the prospect count. (Step 5's `Sync-Dashboards.ps1` run is redundant if you do this — `Sync-Widgets.ps1` re-injects the state block itself.)
7. **Report** a short summary: N prospects (strong/look split), channel breakdown (inbox vs. web sweep), top 3 by score, which browser sweeps were skipped (if any), and any NEW alert sender discovered (suggest adding it to this skill's sender list).

## Notes
- Alert emails go stale fast — 7 days is the right window; older postings are usually filled or reposted.
- Never mark dispositions here; the dashboard section is read-only discovery. Acting on a prospect goes through `/quick-start` (paste the posting URL/JD) → `/app-tracker add`.

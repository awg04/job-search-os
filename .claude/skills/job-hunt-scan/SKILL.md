---
name: job-hunt-scan
description: Scan Gmail job-ALERT emails AND run the web sweep (LinkedIn/Dice/Indeed searches + Google x-rays from job-hunt-sweep.json) for good-fit postings; grade them and refresh the Inbox Job Prospects section of dashboard/job-hunt.html + the Job Hunt widget.
---

# /job-hunt-scan

Refreshes the **Inbox Job Prospects** section of `dashboard/job-hunt.html` from two channels:
1. **Inbox channel** — automated job-alert emails (the board-alert counterpart to the recruiter-inbox scan, which deliberately skips non-human senders).
2. **Web-sweep channel** — the saved searches in `context-library/job-hunt-sweep.json` (LinkedIn Boolean search, Dice, Indeed, and Google x-rays of Glassdoor/Wellfound/BuiltIn/careers pages), graded with the same rubric; only **strong fits (≥65)** merge into the list.

Gmail MCP server prefix: `mcp__deef110b-6a80-4c37-9ca1-359ef23e5e88__`.

## Scope
- **In:** automated alert senders — LinkedIn job alerts (`jobalerts-noreply@linkedin.com`, `jobs-noreply@linkedin.com`), Dice, Indeed, ZipRecruiter, Glassdoor, Built In, Wellfound, Lensa, Jobrapido, Monster, CareerBuilder, and any new alert sender discovered via `subject:("job alert" OR "jobs for you" OR "new jobs")`.
- **Out:** human recruiter emails (handled by the recruiter-inbox scan) and anything already in `context-library/recruiter-inbox.md` or the app tracker.

## Steps

1. **Load fit criteria** from `context-library/career-plan.md` and `context-library/job-title-search-list.md` (title families). Core levers: remote-only, Microsoft stack (Power BI/Fabric/Azure/SQL/SSIS/DAX), comp floor $130K / $70-hr, BI-core title family.
2. **Search the last 7 days** of alert emails (`newer_than:7d` + sender queries above). This scan is high-volume — if running interactively, delegate the Gmail paging to a background general-purpose subagent and have it return structured JSON (see schema below), keeping raw email content out of the main context.
3. **Extract individual postings** from each alert email (title, company, location, salary if shown, per-job link from the email's hrefs — tracking/redirect URLs are fine).

3b. **Web sweep.** Read `context-library/job-hunt-sweep.json`. It holds a single canonical `boolean` (built from the `titles` list — Andrew's dashboard families + email-scan variants) that every sweep query is composed from at runtime (sweeps no longer store the query verbatim). Build and run each sweep:
   - `method: "websearch"` → compose `query = <boolean> + " " + <scope> + " remote"` and run it via the WebSearch tool (the Google x-ray equivalent — works in every context, including the widget-refresh window). Collect result titles/URLs that look like individual job postings.
   - `method: "browser"` → build `{KW}` from the `boolean`'s inner term list (drop the outer parens): quote each phrase (`"` → `%22`), replace intra-phrase spaces with the sweep's `space` value, and join terms with `<space>OR<space>`. Substitute into `base` (`{KW}` placeholder) and open the URL via the Chrome MCP (logged-in LinkedIn/Dice/Indeed) or the in-app browser; extract visible result cards (title, company, location, salary, posting URL). **If no browser is available in this context, skip these sweeps and say so in the report** — never fail the whole scan over them. Example (LinkedIn, `space:"%20"`): `%22Power%20BI%20Developer%22%20OR%20%22Power%20BI%20Engineer%22%20OR%20…`; (Dice/Indeed, `space:"+"`): `%22Power+BI+Developer%22+OR+%22Power+BI+Engineer%22+OR+…`.
   - **To change which titles the sweep covers:** edit `titles` + `boolean` in the JSON (keep them in sync) — nothing else needs touching. Containment note: a phrase match on `"Power BI Developer"` already catches "Senior/Lead/Fabric Power BI Developer", so don't add seniority-prefixed duplicates.
   - For promising hits, WebFetch the posting when needed to confirm it's live + remote and grab salary/stack detail. Never fabricate a posting — only report URLs actually seen.
   - Delegate the whole sweep to a background general-purpose subagent returning JSON (same schema as below) when running interactively — keeps SERP noise out of the main context.
   - Web-sweep hits merge **only if they score ≥ `strongThreshold`** (65, `tier:"strong"`) — the sweeps are noisier than curated alerts, so worth-a-look web hits are dropped. Label each with its sweep's `source` value (e.g. "LinkedIn Search", "Glassdoor", "BuiltIn").

4. **Filter + score** (both channels, one rubric). Keep only good-fit remote roles; rough-score 0-100 (remote confirmed, title-family match, MS-stack keywords, salary vs. floor, seniority). Tiers: `strong` ≥65, `look` 40-64, drop <40 (and drop web-sweep hits <65 per 3b). Dedupe company+title across emails AND sweeps (an alert hit + a sweep hit for the same role = one entry, keep the better URL); also drop anything already in recruiter-inbox.md or app-tracker.md. Cap at ~25 best.
5. **Update the dashboard.** In `dashboard/job-hunt.html`, replace the content between the markers (keep the markers themselves):
   - `// ALERT_DATA_START` … `// ALERT_DATA_END` → `const ALERT_DATA = [ …objects… ];`
   - `// ALERT_UPDATED_START` … `// ALERT_UPDATED_END` → `const ALERT_UPDATED = "YYYY-MM-DD";`
   Object schema (all fields required, `url` may be null):
   ```json
   {"title":"","company":"","source":"LinkedIn","date":"YYYY-MM-DD","score":72,"tier":"strong|look","url":"https://… or null","threadId":"","note":"one short line"}
   ```
   Read/write the file as UTF-8. Do not touch anything outside the markers.
6. **Sync the desktop widget:** run
   ```
   powershell -NoProfile -ExecutionPolicy Bypass -File "C:\Users\andre\OneDrive\Documents\Rainmeter\Skins\JobHunt\Update-JobHuntData.ps1"
   ```
   This regenerates the Job Hunt Rainmeter widget's `data.lua` from the dashboard's ALERT_DATA and refreshes the skin.
7. **Report** a short summary: N prospects (strong/look split), channel breakdown (inbox vs. web sweep), top 3 by score, which browser sweeps were skipped (if any), and any NEW alert sender discovered (suggest adding it to this skill's sender list).

## Notes
- Alert emails go stale fast — 7 days is the right window; older postings are usually filled or reposted.
- Never mark dispositions here; the dashboard section is read-only discovery. Acting on a prospect goes through `/quick-start` (paste the posting URL/JD) → `/app-tracker add`.

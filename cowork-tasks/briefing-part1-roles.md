# Morning Briefing - Part 1: New Roles
# Scan target companies, score roles, tailor resumes for top matches

> **Cowork setup:** Schedule at 7:00 AM weekdays. Saves output to `briefings/[YYYY-MM-DD]-part1-roles.md`.
> This part runs independently. Parts 2 and 3 reference its output.

---

Read all files in the job-search-os/context-library/ folder. Also read job-search-os/CLAUDE.md for system rules.

## Quality Gate

Before running, verify these files contain real data (not template placeholders like `[FILL IN]`):

1. **experience-library.md** -- If empty or placeholder-only, STOP. Say: "Your experience library is not filled in. Run `Help me build my experience library` first."
2. **career-plan.md** -- If empty or placeholder-only, STOP. Say: "Your career plan is not filled in. Fill in career-plan.md first."
3. **target-companies.md** -- If empty or placeholder-only, STOP. Say: "Your target companies list is not filled in. Fill in target-companies.md first."

If any check fails, do NOT proceed.

## Role Type Detection

Read `career-plan.md` to detect the user's target function (PM, SWE, Design, Data Science, Marketing, CS/Sales). All sections below adapt to the detected function. Search for function-appropriate roles, not PM roles by default.

---

## Motivation & Status

Determine what week of the job search this is by counting from the earliest application date in app-tracker (or OS creation date if no applications yet).

**If app-tracker.md does not exist or is empty:** Assemble pipeline data from `target-companies.md` (Status fields, Summary by Status table), `connection-tracker.md` (referral dates), `interview-history.md` (interview dates), and `briefings/` folder (recent activity). Note: "Pipeline stats assembled from alternative sources. For precise tracking, run `/app-tracker add` for each active application."

Display:
```
Week [N] of your search.
Stats since start: Applications: [N] | Interviews: [N] | Offers: [N]
[One sentence of data-driven coaching -- NOT generic motivation. Base it on actual patterns.]
```

---

## Step 1A — Recruiter Inbox Check (run FIRST)

Run `/recruiter-inbox` to check Gmail for inbound recruiter messages from the last 72 hours BEFORE scanning job boards. Inbound messages are higher-signal than cold applications.

- If Gmail MCP is unavailable, note it and continue to Step 1B.
- Any role scoring 70+ from the inbox gets a full role card and slots into the combined Top Roles list.
- Draft responses are saved to Gmail drafts — never auto-sent.
- Output a "Recruiter Inbox" section at the top of the Top Roles block.

## Step 1B — Target-Company Scan

Search each company in target-companies.md for new postings in the user's target function from the last 24 hours. Check careers pages and LinkedIn.

**DATA QUALITY GATE:** If web search is unavailable or returns errors for a company, skip it and note: "[Company]: could not verify -- check manually." NEVER fabricate job listings. If you cannot find a real URL, do not include it.

**Prioritize checking:**
- Companies where the user has connections (from connection-tracker.md)
- Top 20 companies in target-companies.md
- Companies with recent funding rounds or product launches

**SENIOR-LEVEL / EMPLOYED MODE:** If career-plan.md shows Director+ level AND currently employed, scan only the top 10 companies and only surface roles scoring 75+.

**REMOTE-ONLY MODE:** If career-plan.md shows remote-only preference, filter for roles mentioning "remote," "distributed," or "work from anywhere." Flag "hybrid" or "onsite" roles with a WARNING before scoring.

## Scoring & Tailoring (for target-company results)

For each new role found from the target-company scan:
1. Run job-fit-scorer (score 1-100 across 5 dimensions: skill match, seniority fit, culture signals, comp range, growth trajectory)
2. **Roles scoring 70+:**
   - Run resume-tailor using experience-library.md as source
   - Calculate keyword coverage score (% of JD requirements matched)
   - Run recruiter-reviewer sub-agent on the tailored resume
   - Run ats-checker sub-agent on the tailored resume
   - Auto-correct flagged issues and note all changes
3. **Roles scoring 60-69:** Flag as "Apply with referral only" and note which connections could refer
4. **Roles below 60:** Skip but log that they were reviewed

## Step 1C — Broad Job Board Scan (run AFTER target-company scan)

Run `/job-scan` to search LinkedIn, Indeed, Glassdoor, Dice, Builtin, and ZipRecruiter for roles beyond target-companies.md.

- Deduplication is automatic: job-scan cross-references today's target-company scan results and skips companies already covered.
- Top results slot into the combined Top Roles list, labeled [FROM JOB BOARDS].
- Any new employer discovered with a role scoring 75+ triggers a note to add the company to target-companies.md.

## Combined Top Roles Output

Merge all sources (recruiter inbox, target-company scan, job board scan) into one ranked list by fit score. Surface up to **6 role cards total** (expanded from the previous limit of 3):
- Up to 3 from target-company scan
- Up to 3 from job board scan
- Inbound recruiter roles (70+) count toward the 6 and slot in by score
- Label each card's source: [TARGET CO], [FROM JOB BOARDS], or [INBOUND — Recruiter Name]

If total roles scoring 70+ exceeds 6, take the top 6 by score. Move extras to "Other Roles Reviewed" table.

## Top Role Cards

For each of the top 6 roles (scoring 70+), include:

### [Role Title] at [Company] (Fit Score: [X]/100)

**Why this is a strong match:** [2-sentence summary highlighting strongest dimensions]

**Tailored Resume:**
- Status: [Generated / Auto-corrected / Needs manual review]
- Keyword coverage: [X]% ([N]/[M] JD requirements matched)
- Recruiter review: First impression [X]/10, Relevance [X]/10, Readability [X]/10
- ATS check: [PASS / PASS WITH WARNINGS / FAIL]
- Gaps: [JD requirements not matched by experience library]
- Auto-correction changes: [list specific changes]

**Referral Path:**
- Closest connection: [Name] at [Company] ([relationship strength])
- Draft referral message: [personalized message ready to send]
- If no connection: "No existing connection. Add to networking priority for this week."

**Work Product Prompt:**
Function-appropriate prompt for `/work-product`:
```
/work-product [Company] [Role Title] get-interview
```
Research hooks:
- [Specific thing to research about this company's product]
- [Specific recent event or launch to reference]
- [Specific user complaint or market dynamic to analyze]

**EXPERIENCE-FRIENDLY (Veteran Mode):** If career-plan.md shows 15+ years or legacy/enterprise employers, flag roles with signals like "seasoned leader," "deep expertise," "10+ years preferred." Format: "EXPERIENCE-FRIENDLY: [Company] [Role] -- JD values [signal]."

---

## Board Search Coverage

Target-company scanning misses roles at firms not on the list. The board searches in `context-library/job-search-tracker.md` (built from the 120-day title scan in `context-library/job-title-search-list.md`) are the second discovery channel. Surface them daily so no search goes stale.

1. Read `context-library/job-search-tracker.md`. Each of the 20 search strings has a per-board checkbox matrix (LinkedIn, Indeed, Dice, ZipRecruiter, Glassdoor) and a Notes column with the last-run date.
2. Identify the **3-5 stalest searches** — never run (all boxes `[ ]`), or with the oldest date in Notes. Round-robin across search families (don't surface five Power BI variants; mix in a Data Engineer, an Analytics Engineer, etc.).
3. Surface them as today's board picks with the exact string and which board(s) to run them on. Prefer boards still unchecked for that string.
4. If it's Monday (or no search has been run in 7+ days), also surface the combined Boolean string for a full sweep.
5. Remind: set the **remote + past-24h/week + comp-floor** filters, save each as a board **job alert**, then mark the box `[x]` and note `date · # hits` in the tracker.
6. **Direct-ATS channel:** point to `dashboard/job-hunt.html` (one-click Google x-ray links per ATS — Greenhouse, Lever, Ashby, Workday, etc. — where postings land hours before the aggregators). If `context-library/board-scan-log.json` shows no `/board-scan` run in the last 3 days, suggest: "Run `/board-scan` — Claude x-rays the ATS platforms directly and reports only 65+ fits."
7. **Inbox alerts channel:** if the `ALERT_UPDATED` stamp in `dashboard/job-hunt.html` is more than 3 days old, suggest running `/job-hunt-scan` to refresh the Inbox Job Prospects section from job-alert emails.

Do **not** auto-edit the tracker — Andrew checks boxes after he runs each search. Just surface the picks.

---

## Output

Save everything to `job-search-os/briefings/[YYYY-MM-DD]-part1-roles.md` using this format:

```markdown
# Part 1: Roles - [Full Date, e.g., Monday, March 24, 2026]

## Week [N] | [Motivational line]

## Top Roles Today

### 1. [Role Title] at [Company] (Fit: [score]/100)
[2-sentence match summary]
**Resume:** [status + coverage score]
**Referral:** [connection name + draft message OR "No connection -- network first"]
**Work product prompt:** `/work-product [Company] [Role] get-interview`
**Research hooks:** [bulleted list]

### 2. [Role Title] at [Company] (Fit: [score]/100)
[Same structure]

### 3. [Role Title] at [Company] (Fit: [score]/100)
[Same structure]

### Other Roles Reviewed
- [Company] [Role] - Fit: [score] - [SKIP / APPLY WITH REFERRAL ONLY]

### Board Searches To Run Today
Second discovery channel (from job-search-tracker.md — stalest searches first):
- [ ] [Search string] → run on [board(s)] — [never run / last run [date]]
- [ ] [Search string] → run on [board(s)] — [never run / last run [date]]
- [ ] [Search string] → run on [board(s)] — [never run / last run [date]]

[Monday / 7+ days idle only] Full-sweep Boolean → LinkedIn keyword box / Dice advanced:
`("Power BI Developer" OR "Power BI Engineer" OR ... ) AND (remote) AND ("Power BI" OR DAX OR Fabric OR Azure OR SQL OR SSIS OR ETL)`

_Set remote + date-posted + comp-floor filters, save as a job alert, then check the box in job-search-tracker.md._

### Search Failures
- [Company]: could not verify -- check manually
```

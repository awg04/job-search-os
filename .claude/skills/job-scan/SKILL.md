---
name: job-scan
description: Scan broad job boards (LinkedIn, Indeed, Glassdoor, Dice, Builtin) for BI/Data roles beyond the target-companies list. Returns top 3 scored matches ready to slot into the morning briefing.
---

# /job-scan — Broad Job Board Scanner

## When to Use

- During the morning briefing to expand role discovery beyond target-companies.md
- When the user asks "what else is out there" beyond their named target companies
- When fewer than 2 roles scored 70+ from the target-company scan
- Run after the target-company scan so results can be deduped against it

## Required Context

Auto-load before running:

- `context-library/career-plan.md` — role types, seniority, remote preference, comp floor, stack
- `context-library/experience-library.md` — source of truth for fit scoring
- `context-library/target-companies.md` — dedupe list (roles already covered by target scan)

If career-plan.md or experience-library.md are empty/placeholder-only, STOP and tell the user to fill them first.

## Process

### Step 1 — Build Search Queries from career-plan.md

Read career-plan.md to extract:
- **Role titles:** Primary and secondary role preferences (e.g., "Senior BI Developer," "Senior Business Intelligence Engineer," "Senior Power BI Developer," "Lead BI Developer," "Senior Data Engineer — Microsoft Stack")
- **Remote filter:** If remote-only, append "remote" to all queries. If hybrid-ok, broaden to "remote OR hybrid."
- **Stack signals:** Pull primary tools (e.g., Power BI, Azure Synapse, SQL Server, SSIS, Microsoft Fabric, DAX) to use as keyword reinforcement in scoring
- **Seniority:** Senior IC, Lead IC, or Manager — filter out junior and Director+ unless seniority preference includes them
- **Comp floor:** Note floor for scoring (comp signals below the floor reduce Comp Range score)

Construct 3–5 search queries covering variations of the target title. Example for a Senior BI Developer targeting Microsoft stack remote roles:
- `"Senior BI Developer" remote Power BI`
- `"Senior Business Intelligence Engineer" remote Azure`
- `"Power BI Developer" Senior remote SQL Server`
- `"Lead BI Developer" OR "Senior BI Developer" remote "Microsoft Fabric" OR "Azure Synapse"`
- `"Business Intelligence Engineer" remote site:linkedin.com OR site:indeed.com`

### Step 2 — Run Searches Across Boards

Search the following sources:
- **LinkedIn Jobs** — linkedin.com/jobs (highest signal for referral paths; check for Easy Apply vs. direct)
- **Indeed** — indeed.com (broadest volume; useful for comp signals in job titles)
- **Glassdoor** — glassdoor.com/Jobs (comp data sometimes included in listings)
- **Dice** — dice.com (strong for tech-stack-specific roles, especially enterprise BI)
- **Builtin** — builtin.com (startup/growth-stage tech; useful for Fabric/Databricks-adjacent roles)
- **ZipRecruiter** — ziprecruiter.com (catches smaller employers not on LinkedIn)

**DATA QUALITY GATE:** Only include roles with a real, verifiable URL. If a search returns a listing without a direct link, log it as unverified and skip. NEVER fabricate job listings. If web search is unavailable for a board, note: "[Board]: search unavailable — check manually."

Run all queries. Collect raw results (title, company, location/remote status, comp if listed, URL).

### Step 3 — Dedupe Against Target-Company Scan

Before scoring, cross-reference each result against:
1. **target-companies.md** — if the company is already in the target list AND a role at that company was found in today's target-company scan, skip this result to avoid duplication
2. **briefings/** folder — if this exact role (same company + job ID or title) appeared in a prior briefing this week, skip it

Log deduped roles as: "[Company] [Role] — already covered by target-company scan."

### Step 4 — Filter for Minimum Thresholds

Before full scoring, apply fast pre-filters to reduce the candidate pool:

**Hard filters (skip if fails):**
- Remote confirmed (or remote-eligible for hybrid-ok candidates) — roles listed as "onsite only" are auto-skipped; flag hybrid roles with ⚠️ WARNING
- Seniority match — skip "Junior," "Associate," "Mid-level," or "Director/VP" roles unless career-plan.md explicitly includes those levels
- Not already applied — check if role appears in app-tracker.md or briefings/ history

**Soft filters (note but don't skip):**
- Comp below floor — include but flag: "⚠️ Comp signals below $[floor] target"
- Non-target stack — include but note gap: "Primary stack is [X], not Microsoft-aligned"

### Step 5 — Score Each Remaining Role (job-fit-scorer process)

For each role passing pre-filters, score 0–100 across 5 dimensions (0–20 each):

1. **Skill Match (0–20):** How many primary JD requirements map to experience-library.md entries? Full match = 18–20. Major gaps = 8–12. Missing primary tool = 4–8.
2. **Seniority Fit (0–20):** Does the title and JD scope match the user's level preference? Exact match = 18–20. One level off = 12–16. Stretch or step-back = 6–10.
3. **Culture Signals (0–20):** Does the JD language signal collaboration, IC ownership, data-driven culture, modern stack? Strong signals = 16–20. Generic corporate = 10–14. Red flags (micromanagement language, "hit the ground running," unrealistic requirements) = 4–8.
4. **Comp Range (0–20):** If comp is listed: does it meet the floor? Exceeds target = 18–20. Meets target = 14–18. At floor = 10–14. Below floor = 4–8. If comp not listed: neutral 10.
5. **Growth Trajectory (0–20):** Does the company/team appear to be growing? Recent funding, headcount growth, product expansion signals = 16–20. Stable mature = 10–14. Declining signals = 4–8.

**Thresholds:**
- 70+ → Include in top results, full card
- 60–69 → "Apply with referral only" — abbreviated card
- Below 60 → Skip, log as reviewed

### Step 6 — Surface Top 3 Board-Sourced Roles

Rank all roles that scored 60+ by total score descending. Select the top 3 (maximum) to surface.

For roles scoring 70+, note: "NEW FROM JOB BOARDS — not in target-companies.md"
For roles scoring 60–69, note: "APPLY WITH REFERRAL ONLY — [primary gap]"

If fewer than 3 roles score 60+, surface what exists and note: "Job board scan returned [N] scoreable role(s) this run — may reflect stack specificity of search criteria."

### Step 7 — Check for New Employers

For each top result from a company NOT already in target-companies.md, flag:
> "NEW EMPLOYER DISCOVERED: [Company] is not in your target-companies list. If this role scores 75+, consider adding the company. Run `/company-research [Company]` for a full profile."

## Output Format

Return results structured for direct insertion into the morning briefing "Top Roles Today" section. Each role card:

```
### [N]. [Role Title] at [Company] (Fit: [score]/100) [NEW FROM JOB BOARDS]

**Source:** [Board name] | **Posted:** [date if available] | **Remote:** [confirmed / unconfirmed / ⚠️ hybrid]
**Comp:** [listed range OR "Not listed"]
**Role URL:** [direct link]

**Why this is a match:**
[2-sentence summary — stack overlap first, domain second. No filler.]

**Fit breakdown:** Skill [X]/20 | Seniority [X]/20 | Culture [X]/20 | Comp [X]/20 | Growth [X]/20

**Gap flags:**
- [Any JD requirement not in experience-library.md]
- [Any soft filter that triggered]

**Referral path:**
[No connection at [Company] OR connection found in connection-tracker.md — draft request]

**Work product prompt:** `/work-product [Company] "[Role Title]" get-interview`
```

For "Apply with referral only" roles (60–69), use abbreviated format:
```
| [Company] | [Role Title] | [score]/100 | APPLY WITH REFERRAL ONLY — [1-line reason] |
```

End output with:
```
### Job Board Scan Summary
- Boards searched: [list]
- Total roles reviewed: [N]
- Deduped (already in target scan): [N]
- Pre-filtered (remote/seniority): [N]
- Scored: [N]
- Surfaced (70+): [N] | Referral-only (60-69): [N] | Skipped (<60): [N]
- New employers discovered: [list or "none"]
```

## Integration Notes

When called from the morning briefing:
- Run AFTER the target-company scan so deduplication works correctly
- Top results slot into "Top Roles Today" after target-company results, clearly labeled [FROM JOB BOARDS]
- The combined list (target-company + job-board) should not exceed 6 total role cards
- If a job-board result scores HIGHER than a target-company result, reorder the combined list by score descending

## Limitations

- Job board search via web tools cannot guarantee freshness — always verify each URL is still active before applying
- Comp data is frequently absent from listings; score Comp Range as neutral (10/20) when not listed
- Board search cannot access behind-login company portals (e.g., Workday, Greenhouse direct URLs) — it surfaces public postings only

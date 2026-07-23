---
name: board-scan
description: Run direct-ATS x-ray searches (Greenhouse, Lever, Ashby, Workday, etc.) for Andrew's top job titles via web search, score the hits, and report fresh good-fit postings the aggregator boards haven't surfaced yet.
---

# /board-scan [optional: title or ATS to focus on]

Tier-2 automation of the x-ray technique behind `dashboard/job-hunt.html`: instead of Andrew clicking 40 Google links, Claude runs a rotating subset of the searches, filters, scores, and reports only what's worth a look. Postings on company ATS boards appear **hours to days before** the aggregators — freshness is the whole edge, so favor the last 24-72h.

## Query pattern

```
"<title>" site:<ats-domain> remote
```

ATS domains (rotate through): `greenhouse.io`, `lever.co`, `ashbyhq.com`, `myworkdayjobs.com`, `icims.com`, `jobs.smartrecruiters.com`, `jobs.workable.com`, `breezy.hr`, `applytojob.com`, `recruitee.com`, `teamtailor.com`, `recruiting.paylocity.com`, `dayforcehcm.com`, `workforcenow.adp.com`, `oraclecloud.com`, `taleo.net`.
(`taleo.net` is Oracle's legacy ATS — big old-line employers: banks, hospitals, airlines. Poorly indexed and JS-heavy, so expect thin results; most of that segment has migrated to `oraclecloud.com`. Keep it in the rotation but don't over-weight it.)
Titles: top entries in `context-library/job-title-search-list.md` (Senior BI Developer, Power BI Developer/Engineer/Architect, Business Intelligence Developer/Engineer, Microsoft Fabric Developer, Azure Data Engineer, Analytics Engineer, …).

## Steps

1. **Load context:** `context-library/career-plan.md` (remote-only, comp floor), `context-library/job-title-search-list.md` (titles), `context-library/app-tracker.md` + `context-library/recruiter-inbox.md` (dedupe targets), and `context-library/board-scan-log.json` (rotation state — create `{}` if missing).
2. **Pick 8-12 queries:** the stalest title × ATS pairs from the log (never-run first). Round-robin titles across families — don't burn the whole run on Power BI variants. If the user passed a focus argument, weight toward it.
3. **Search:** run each query via WebSearch. Recency matters more than volume — prefer results the engine dates within the last few days; skip anything clearly old, filled, or non-remote.
4. **Verify + score candidates:** for each promising hit, WebFetch the posting to confirm it's live, remote, and extract salary/stack details. Score 0-100 with the 5 OS dimensions (skill match, seniority fit, culture signals, comp range, growth trajectory). Keep 65+ only.
5. **Dedupe** against app-tracker, recruiter-inbox, and previously reported hits in the log.
6. **Update the log:** write `context-library/board-scan-log.json`:
   ```json
   {"queries": {"<title>|<ats>": "YYYY-MM-DD"}, "reported": {"<company>|<title>": "YYYY-MM-DD"}}
   ```
7. **Report:** for each keeper — title, company, ATS source, posted-when (if visible), score, link, and the one-line reason it scores. End with: "Act on one: `/quick-start [paste JD or URL]`, then `/app-tracker add`." If nothing scored 65+, say so plainly and show the 2-3 closest misses with why they fell short.

## Guardrails
- **Never fabricate a posting.** Only report URLs you actually fetched or that appeared in search results. If freshness can't be confirmed, say "[age unverified]".
- Flag hybrid/onsite with a WARNING — don't silently drop a 90-fit role over an ambiguous location line, surface it flagged.
- This skill reports; it never applies, drafts, or updates the app tracker on its own.

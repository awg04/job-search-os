# Job Search — Board Coverage Tracker

Check off each board as you run the search. Mark `[x]` when done, drop the date + hit count in Notes. Source list: [job-title-search-list.md](job-title-search-list.md).

> **Feeds the daily briefing.** Part 1 of the morning briefing reads this file and surfaces the 3-5 stalest searches under a "Board Searches To Run Today" section (with the Boolean sweep on Mondays). Keep the checkboxes + Notes dates current so the briefing knows what's fresh.

**Boards:** LI = LinkedIn · IN = Indeed · DC = Dice · ZR = ZipRecruiter · GD = Glassdoor

**Legend:** `[ ]` not run · `[x]` run · Notes = `date · # good hits · anything worth remembering`

---

| # | Search string | LI | IN | DC | ZR | GD | Notes |
|---|---------------|----|----|----|----|----|-------|
| 1 | Power BI Developer remote | [ ] | [ ] | [ ] | [ ] | [ ] | |
| 2 | Senior Power BI Developer remote | [ ] | [ ] | [ ] | [ ] | [ ] | |
| 3 | Power BI Engineer remote | [ ] | [ ] | [ ] | [ ] | [ ] | |
| 4 | Power BI Architect remote | [ ] | [ ] | [ ] | [ ] | [ ] | |
| 5 | Microsoft Fabric Developer remote | [ ] | [ ] | [ ] | [ ] | [ ] | |
| 6 | Power BI Analyst remote | [ ] | [ ] | [ ] | [ ] | [ ] | |
| 7 | Business Intelligence Developer remote | [ ] | [ ] | [ ] | [ ] | [ ] | |
| 8 | Senior Business Intelligence Developer | [ ] | [ ] | [ ] | [ ] | [ ] | |
| 9 | Business Intelligence Engineer remote | [ ] | [ ] | [ ] | [ ] | [ ] | |
| 10 | BI Developer remote | [ ] | [ ] | [ ] | [ ] | [ ] | |
| 11 | Azure Data Engineer Power BI | [ ] | [ ] | [ ] | [ ] | [ ] | |
| 12 | Data Engineer remote (Microsoft OR Azure OR Fabric) | [ ] | [ ] | [ ] | [ ] | [ ] | |
| 13 | Data Integration Engineer remote | [ ] | [ ] | [ ] | [ ] | [ ] | |
| 14 | Analytics Engineer remote | [ ] | [ ] | [ ] | [ ] | [ ] | |
| 15 | Senior Data Analyst Power BI remote | [ ] | [ ] | [ ] | [ ] | [ ] | |
| 16 | BI Analyst remote | [ ] | [ ] | [ ] | [ ] | [ ] | |
| 17 | Fabric Power BI Developer | [ ] | [ ] | [ ] | [ ] | [ ] | |
| 18 | Power BI Consultant remote | [ ] | [ ] | [ ] | [ ] | [ ] | |
| 19 | MSBI Developer remote | [ ] | [ ] | [ ] | [ ] | [ ] | |
| 20 | Lead Data Visualization Business Intelligence | [ ] | [ ] | [ ] | [ ] | [ ] | |

---

## Boolean string (LinkedIn keyword box / Dice advanced)

```
("Power BI Developer" OR "Power BI Engineer" OR "Power BI Analyst" OR "Power BI Architect" OR "Microsoft Fabric Developer" OR "BI Developer" OR "Business Intelligence Developer" OR "Business Intelligence Engineer" OR "BI Analyst" OR "Analytics Engineer" OR "Azure Data Engineer" OR "Data Integration Engineer" OR "Data Analyst") AND (remote) AND ("Power BI" OR DAX OR Fabric OR Azure OR SQL OR SSIS OR ETL)
```

| Boolean run on | LI | IN | DC | ZR | GD | Notes |
|---|----|----|----|----|----|-------|
| Combined Boolean | [ ] | [ ] | [ ] | [ ] | [ ] | |

---

## Search hygiene
- Set the **remote** + **date posted: past 24h/week** filters, and a **$130K / $70-hr** floor where the board supports it.
- Save each search as a **job alert** on the board so new postings come to you — then you only re-run manually to catch what alerts miss.
- When a search surfaces a real fit, run `/quick-start [JD]` (60-sec go/no-go) or `/job-fit-scorer [JD]`, then `/app-tracker add` to log it.

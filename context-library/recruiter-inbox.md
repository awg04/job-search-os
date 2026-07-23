# Recruiter Inbox

Auto-compiled by the **recruiter-inbox-scan** scheduled task. Scans Gmail for emails from individual (human) recruiters, scores each against `career-plan.md`, and logs them here for review.

**How to use this file**
- This is the source of truth for dispositions. Edit the **Disposition** column to `Pursue`, `Skip`, `Maybe`, or `Applied`. The daily scan preserves whatever you put there (keyed by Thread ID) and only adds new emails on top.
- The companion dashboard `dashboard/recruiter-inbox.html` renders this list for quick review.
- Gmail is also labeled: **Recruiter/Strong-Fit**, **Recruiter/Worth-a-Look**, **Recruiter/Low-Fit**.
- To act on a `Pursue`, run `/quick-start [JD]`, `/resume-tailor [JD]`, or `/app-tracker add`.

**Scoring** (0–100, aligned to career plan): remote fit, Microsoft-stack fit (Power BI / Fabric / Azure / SQL / DAX / ETL), comp vs. $130K / $70-hr floor, role-type fit (BI/Data Eng core vs. adjacent), and no-body-shop signal.
- **Strong-Fit ≥ 65** · **Worth-a-Look 40–64** · **Low-Fit < 40**

_Last scan: 2026-07-22 · Window: last 2 days · New this scan: 2_

---

## Needs your call

| Date | Recruiter (Firm) | Role | Client | Remote | Comp | Score | Verdict | Disposition | Thread |
|------|------------------|------|--------|--------|------|-------|---------|-------------|--------|
| 2026-07-20 | Sham — Virtual Networx | Data Analyst & Power BI Engineer | (undisclosed) | ✅ Remote | ❓ not stated | **85** | Strong-Fit | Pursue (reply drafted 2026-07-22, awaiting review — asks rate + client) | [open](https://mail.google.com/mail/u/0/#all/19f8064120818784) · `19f8064120818784` |
| 2026-07-20 | Aviral Srivastava — Talenzaa | Business Analyst (Business Intelligence) | Tavant / Kubota | ✅ 100% Remote | ❓ not stated (contract) | **82** | Strong-Fit | Pursue (reply drafted 2026-07-21) | [open](https://mail.google.com/mail/u/0/#all/19f80cb44c91d7bb) · `19f80cb44c91d7bb` |
| 2026-07-20 | Max Garcia — Synergy Interactive | PowerBI Engineer | Publicis Sapient | ✅ Fully Remote | $65/hr LLC · $55/hr W2 | **80** | Strong-Fit · **IN PROCESS** | Applied (in app-tracker) | [open](https://mail.google.com/mail/u/0/#all/19f7fee6bf8218cd) · `19f7fee6bf8218cd` |
| 2026-07-22 | Theron Griffin — Armanino | Senior BI & Analytics Developer | Armanino (direct) | ⚠️ Hybrid — Boca (~30 min) | ❓ not stated | **72** | Strong-Fit · **IN PROCESS** | Applied — call held 2026-07-22, resume sent (app folder: `applications/2026-07-21_armanino_senior-bi-analytics-developer_compass`) | [open](https://mail.google.com/mail/u/0/#all/19f8a11a6f842033) · `19f8a11a6f842033` |
| 2026-07-20 | Reeba Saini — Nityo Infotech | Power BI Developer | (undisclosed) | ⚠️ Raleigh NC / Dallas TX | Full-time perm | **42** | Worth-a-Look | | [open](https://mail.google.com/mail/u/0/#all/19f7fdfe7ee3bedf) · `19f7fdfe7ee3bedf` |

## Low-fit (logged, no action needed)

| Date | Recruiter (Firm) | Role | Remote | Comp | Score | Why low | Disposition | Thread |
|------|------------------|------|--------|------|-------|---------|-------------|--------|
| 2026-07-20 | Prakash K. Singh — Nityo | Azure Data Engineer / Architect | ❌ Onsite (NC/TX/MI/CA/TX) | — | 32 | Onsite; stack fits but remote dealbreaker | | [open](https://mail.google.com/mail/u/0/#all/19f8091b2c1ef05f) · `19f8091b2c1ef05f` |
| 2026-07-20 | Colton Collins — Capital Staffing | Business Systems Analyst (Python/SQL) | ❌ Juno Beach, FL onsite | — | 28 | Onsite; BSA not BI-core | | [open](https://mail.google.com/mail/u/0/#all/19f7f8cdc84867d1) · `19f7f8cdc84867d1` |
| 2026-07-21 | Kaila Timko — Capital Staffing | Business Systems Analyst (Python/SQL/ML) | ❌ Juno Beach, FL onsite | ❓ not stated (12mo+ contract) | 26 | Onsite; BSA not BI-core; rate not stated; same Juno Beach client as Colton/Yash | | [open](https://mail.google.com/mail/u/0/#all/19f864bf13a1c8ee) · `19f864bf13a1c8ee` |
| 2026-07-20 | Yash Agarwal — Exarca (via Dice) | IT Business Systems Analyst II | ❌ Juno Beach, FL onsite | W2 only | 25 | Onsite; BSA not BI-core | | [open](https://mail.google.com/mail/u/0/#all/19f7fb5868e2c05d) · `19f7fb5868e2c05d` |
| 2026-07-22 | Moumita Dey — Nityo Infotech | Data Warehouse Developer | ❌ Charlotte, NC onsite | ❓ not stated | 22 | Onsite; non-MS stack (Snowflake/AWS ETL, Python/UNIX — no Power BI/Fabric); rate not stated | | [open](https://mail.google.com/mail/u/0/#all/19f8b5a20bb846ad) · `19f8b5a20bb846ad` |
| 2026-07-20 | Avneesh Tyagi — Nityo | Business Analyst, Treasury Systems | ❌ Miami hybrid | $30/hr W2 | 20 | Comp far below floor; hybrid | | [open](https://mail.google.com/mail/u/0/#all/19f80af86048e18d) · `19f80af86048e18d` |
| 2026-07-20 | Veena — ATVS LLC | Data Engineer (Hadoop / Ab Initio) | ❌ Berkeley Heights, NJ onsite | $50/hr W2 | 15 | Non-MS stack; onsite; ⚠️ email requests SSN-last-4 + DOB up front (do not send) | | [open](https://mail.google.com/mail/u/0/#all/19f8065a7ac37096) · `19f8065a7ac37096` |
| 2026-07-20 | Saurav Sahil — Nityo | Infor LN Functional Consultant | ❓ | — | 12 | ERP functional role, off-target | | [open](https://mail.google.com/mail/u/0/#all/19f808f24146d81f) · `19f808f24146d81f` |

---

### Notes from this scan
- **Publicis Sapient (Synergy / Max Garcia)** is already live — you had a call 2026-07-20 and sent your resume. $65/hr LLC is just under your $70/hr target but it's fully remote and in motion. Consider adding to `/app-tracker` as **In Process**. _JD recovered 2026-07-21 (`applications/2026-07-20_publicis-sapient_powerbi-engineer_kestrel/`): real title is "Senior Associate – Power BI Developer," Power Platform-centric (Power BI 80% / PowerApps 20% / Power Automate); remote prefers EST/CST office (you're EST ✅). Fit re-scored against the real JD = still 80. See `fit-score.md`._
- **Virtual Networx** appears twice: Sham's Power BI/Fabric role (scored above) and a separate LinkedIn connection request from Kartikeya (BD Manager). Same firm.
- **Armanino** — a LinkedIn invite from Theron (Americas Talent Partner) also landed today; that role is already on your `app-tracker.md` watch list (remote unverified).
- **Rate not stated** on the two top contract roles (Talenzaa, Virtual Networx) — worth a one-line reply asking the bill rate before investing tailoring effort.
- **Privacy flag:** the ATVS email asks for SSN last-4 and date of birth in the reply. That's a staffing red flag — never send that to source a role. Ignore or ask them to submit you without it.

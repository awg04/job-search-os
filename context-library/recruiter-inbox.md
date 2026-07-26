# Recruiter Inbox

Auto-compiled by the **recruiter-inbox-scan** scheduled task. Scans Gmail for emails from individual (human) recruiters, scores each against `career-plan.md`, and logs them here for review.

**How to use this file**
- This is the source of truth for dispositions. Edit the **Disposition** column to `Pursue`, `Skip`, `Maybe`, or `Applied`. The daily scan preserves whatever you put there (keyed by Thread ID) and only adds new emails on top.
- The companion dashboard `dashboard/recruiter-inbox.html` renders this list for quick review.
- Gmail is also labeled: **Recruiter/Strong-Fit**, **Recruiter/Worth-a-Look**, **Recruiter/Low-Fit**.
- To act on a `Pursue`, run `/quick-start [JD]`, `/resume-tailor [JD]`, or `/app-tracker add`.

**Scoring** (0–100, aligned to career plan): remote fit, Microsoft-stack fit (Power BI / Fabric / Azure / SQL / DAX / ETL), comp vs. $130K / $70-hr floor, role-type fit (BI/Data Eng core vs. adjacent), and no-body-shop signal.
- **Strong-Fit ≥ 65** · **Worth-a-Look 40–64** · **Low-Fit < 40**

_Last scan: 2026-07-26 · Window: last 2 days · New this scan: 0_

---

## Needs your call

| Date | Recruiter (Firm) | Role | Client | Remote | Comp | Score | Verdict | Disposition | Thread |
|------|------------------|------|--------|--------|------|-------|---------|-------------|--------|
| 2026-07-20 | Sham — Virtual Networx | Data Analyst & Power BI Engineer | (undisclosed) | ✅ Remote | ❓ not stated | **85** | Strong-Fit | Pursue — replied 2026-07-21 w/ resume; Sham 2026-07-22 said number was dead; corrected cell sent 2026-07-26, rate + client re-asked. Awaiting his call. | [open](https://mail.google.com/mail/u/0/#all/19f8064120818784) · `19f8064120818784` |
| 2026-07-20 | Aviral Srivastava — Talenzaa | Business Analyst (Business Intelligence) | Tavant / Kubota | ✅ 100% Remote | ❓ not stated (contract) | **82** | Strong-Fit | Pursue (reply drafted 2026-07-21) | [open](https://mail.google.com/mail/u/0/#all/19f80cb44c91d7bb) · `19f80cb44c91d7bb` |
| 2026-07-20 | Max Garcia — Synergy Interactive | PowerBI Engineer | Publicis Sapient | ✅ Fully Remote | $65/hr LLC · $55/hr W2 | **80** | Strong-Fit · **IN PROCESS** | Applied (in app-tracker) | [open](https://mail.google.com/mail/u/0/#all/19f7fee6bf8218cd) · `19f7fee6bf8218cd` |
| 2026-07-22 | Theron Griffin — Armanino | Senior BI & Analytics Developer | Armanino (direct) | ⚠️ Hybrid — Boca (~30 min) | ❓ not stated | **72** | Strong-Fit · **IN PROCESS** | Applied — call held 2026-07-22, resume sent (app folder: `applications/2026-07-21_armanino_senior-bi-analytics-developer_compass`) | [open](https://mail.google.com/mail/u/0/#all/19f8a11a6f842033) · `19f8a11a6f842033` |
| 2026-07-20 | Reeba Saini — Nityo Infotech | Power BI Developer | (undisclosed) | ⚠️ Raleigh NC / Dallas TX | Full-time perm | **42** | Worth-a-Look | | [open](https://mail.google.com/mail/u/0/#all/19f7fdfe7ee3bedf) · `19f7fdfe7ee3bedf` |

## Low-fit (logged, no action needed)

| Date | Recruiter (Firm) | Role | Remote | Comp | Score | Why low | Disposition | Thread |
|------|------------------|------|--------|------|-------|---------|-------------|--------|
| 2026-07-23 | "Mr Ahmad" — no firm (LinkedIn InMail) | Lead Analyst – Business Intelligence | ❌ Onsite Fort Lauderdale (local) | ❓ not stated | 38 | ⚠️ Not a real recruiter — sender is a "Student at collage" in Lahore pushing jobg8 affiliate + jobsinusa.us portal links. The underlying role (Memorial Healthcare System, Fort Lauderdale) is legitimate and locally commutable — apply direct if interested, do **not** click the links in the email | | [open](https://mail.google.com/mail/u/0/#all/19f8ff59b16fa063) · `19f8ff59b16fa063` |
| 2026-07-20 | Prakash K. Singh — Nityo | Azure Data Engineer / Architect | ❌ Onsite (NC/TX/MI/CA/TX) | — | 32 | Onsite; stack fits but remote dealbreaker | | [open](https://mail.google.com/mail/u/0/#all/19f8091b2c1ef05f) · `19f8091b2c1ef05f` |
| 2026-07-23 | Pratibha Pal — Nityo Infotech | Azure Data Solutions Architect | ❌ Jersey City, NJ / Dallas, TX | ❓ not stated (FTE) | 30 | Out-of-state, no remote option; stack has real MS overlap (Azure/ADF/Synapse/**Fabric**) but is Databricks-and-architecture-first, Power BI only "preferred"; asks for two supervisory references up front | | [open](https://mail.google.com/mail/u/0/#all/19f906bb43a4224d) · `19f906bb43a4224d` |
| 2026-07-20 | Colton Collins — Capital Staffing | Business Systems Analyst (Python/SQL) | ❌ Juno Beach, FL onsite | — | 28 | Onsite; BSA not BI-core | | [open](https://mail.google.com/mail/u/0/#all/19f7f8cdc84867d1) · `19f7f8cdc84867d1` |
| 2026-07-21 | Kaila Timko — Capital Staffing | Business Systems Analyst (Python/SQL/ML) | ❌ Juno Beach, FL onsite | ❓ not stated (12mo+ contract) | 26 | Onsite; BSA not BI-core; rate not stated; same Juno Beach client as Colton/Yash | | [open](https://mail.google.com/mail/u/0/#all/19f864bf13a1c8ee) · `19f864bf13a1c8ee` |
| 2026-07-20 | Yash Agarwal — Exarca (via Dice) | IT Business Systems Analyst II | ❌ Juno Beach, FL onsite | W2 only | 25 | Onsite; BSA not BI-core | | [open](https://mail.google.com/mail/u/0/#all/19f7fb5868e2c05d) · `19f7fb5868e2c05d` |
| 2026-07-23 | Edward — United IT Solutions | Data Architect | ❌ Orlando, FL hybrid (~200 mi) | ❓ not stated (contract) | 24 | Orlando hybrid is not commutable from Fort Lauderdale; Databricks/Lakehouse-first architecture role with no Power BI content; 12-yr requirement; rate not stated | | [open](https://mail.google.com/mail/u/0/#all/19f912d772e95e45) · `19f912d772e95e45` |
| 2026-07-22 | Moumita Dey — Nityo Infotech | Data Warehouse Developer | ❌ Charlotte, NC onsite | ❓ not stated | 22 | Onsite; non-MS stack (Snowflake/AWS ETL, Python/UNIX — no Power BI/Fabric); rate not stated | | [open](https://mail.google.com/mail/u/0/#all/19f8b5a20bb846ad) · `19f8b5a20bb846ad` |
| 2026-07-20 | Avneesh Tyagi — Nityo | Business Analyst, Treasury Systems | ❌ Miami hybrid | $30/hr W2 | 20 | Comp far below floor; hybrid | | [open](https://mail.google.com/mail/u/0/#all/19f80af86048e18d) · `19f80af86048e18d` |
| 2026-07-20 | Veena — ATVS LLC | Data Engineer (Hadoop / Ab Initio) | ❌ Berkeley Heights, NJ onsite | $50/hr W2 | 15 | Non-MS stack; onsite; ⚠️ email requests SSN-last-4 + DOB up front (do not send) | | [open](https://mail.google.com/mail/u/0/#all/19f8065a7ac37096) · `19f8065a7ac37096` |
| 2026-07-20 | Saurav Sahil — Nityo | Infor LN Functional Consultant | ❓ | — | 12 | ERP functional role, off-target | | [open](https://mail.google.com/mail/u/0/#all/19f808f24146d81f) · `19f808f24146d81f` |

---

### Notes from scan 2026-07-26
- **Manual rerun 2026-07-26 (widget refresh button):** re-swept the 2-day window with both the standard query and a broader sender-exclusion sweep (47 threads). Still zero new human-recruiter emails — no rows added, no labels applied.
- **Zero new human-recruiter emails this scan.** Everything in the 2-day window was automated: LinkedIn/Indeed/Lensa/Wellfound job-alert blasts, newsletters, and Medium/Reddit digests. No individual recruiter reached out about a specific role.
- **Not logged as new (context only):** Theron Griffin (Armanino) replied on the existing "Sr AI/Analytics Developer" thread (2026-07-24) — *"I have not received feedback from my hiring manager yet. Soon as I do, I will follow up."_ This is a status update on the already-tracked, **In Process** Armanino opportunity (app folder `applications/2026-07-21_armanino_senior-bi-analytics-developer_compass`), not a new role — no action needed beyond waiting.

### Notes from scan 2026-07-24
- **Zero Strong-Fits this scan.** Three new human-sourced emails, all Low-Fit — two out-of-area architect roles and one fake-recruiter InMail.
- **⚠️ Fake recruiter:** the LinkedIn InMail "Thought of you for this Test Lead Analyst - Business Intelligence" is from "Mr Ahmad," whose own LinkedIn headline reads *Student at collage* (Lahore, Pakistan). The message routes through a `jobg8.com/Traffic.aspx` affiliate link and promotes a `jobsinusa.us` portal — this is link-farm traffic, not a staffed role. The role it names (Lead Analyst – Business Intelligence, Memorial Healthcare System, Fort Lauderdale) is real and local; if it interests you, go to Memorial's careers site directly rather than through those links.
- **Architect drift:** both Nityo (Pratibha Pal) and United IT (Edward) are pitching Data/Solutions *Architect* roles built on Databricks + Lakehouse, not Power BI delivery. Nityo's does list Fabric and Unity Catalog, which is closer to your stack than most — but it's Jersey City/Dallas onsite, so location kills it regardless.
- **Not logged as new (context only):** Kentro sent an automated acknowledgment for your **Power BI Engineer (VA ESOM)** application (2026-07-23) — ATS receipt, no action needed. And two LinkedIn message replies landed on the **Baptist Health / Lourdes Verde** thread ("It is the same role, I will let Lourdes know…"), confirming the Caroline Dybala and Lourdes Verde roles are the same opening — that thread is already on the dashboard and is waiting on your reply about a call.

### Notes from scan 2026-07-22
- **Publicis Sapient (Synergy / Max Garcia)** is already live — you had a call 2026-07-20 and sent your resume. $65/hr LLC is just under your $70/hr target but it's fully remote and in motion. Consider adding to `/app-tracker` as **In Process**. _JD recovered 2026-07-21 (`applications/2026-07-20_publicis-sapient_powerbi-engineer_kestrel/`): real title is "Senior Associate – Power BI Developer," Power Platform-centric (Power BI 80% / PowerApps 20% / Power Automate); remote prefers EST/CST office (you're EST ✅). Fit re-scored against the real JD = still 80. See `fit-score.md`._
- **Virtual Networx** appears twice: Sham's Power BI/Fabric role (scored above) and a separate LinkedIn connection request from Kartikeya (BD Manager). Same firm.
- **Armanino** — a LinkedIn invite from Theron (Americas Talent Partner) also landed today; that role is already on your `app-tracker.md` watch list (remote unverified).
- **Rate not stated** on the two top contract roles (Talenzaa, Virtual Networx) — worth a one-line reply asking the bill rate before investing tailoring effort.
- **Privacy flag:** the ATVS email asks for SSN last-4 and date of birth in the reply. That's a staffing red flag — never send that to source a role. Ignore or ask them to submit you without it.

# Exploratory Call Prep — Armanino, Senior BI & Analytics Developer

**Call with:** Theron Griffin — Americas Talent Partner (internal TA/recruiter), Armanino Advisory LLC. Local (Cooper City, FL). Started ~a week ago.
**Nature of call:** Exploratory / screening — mutual fit. Theron is NOT the hiring manager; his job is to decide whether to advance you to FP&A leadership. **Your job: be easy to champion and earn the HM intro.**
**Role in one line:** Sr. BI/Analytics Engineer who bridges back-end data engineering ↔ front-end reporting — building the "middle layer" (semantic models on curated Fabric tables) during a company-wide reporting transformation.

---

## Your 3 goals for this call
1. **Confirm comp lands in $140–160K base.** The real gate — the Florida band is NOT in the posted disclosures (only CO / SoCal-NY-WA-IL / NorCal), and FL usually maps lower. Theron teed this up himself.
2. **Pin down the real onsite cadence.** ~50% "massageable" → what's the actual floor (2 days/wk in Boca? 1-on/2-off)?
3. **Understand the transformation + identify the HM**, and lock the next step.

---

## 30-second positioning (say it in your own voice)
> "I sit right on the seam this role describes — I build the back-end pipelines AND the front-end reporting. At Carnival I own three ETL pipelines feeding an Azure SQL warehouse, plus the Power BI semantic models and dashboards on top. Before that I built two enterprise data warehouses from scratch. I also came out of finance — seven years at Merrill Lynch — so I've partnered with FP&A my whole BI career and speak their language. Re-engineering a reporting layer and setting the architecture and standards is exactly the work I want."

## Map yourself to the JD (weave these in naturally)
- **"Bridge back-end ↔ front-end / build the middle layer"** → your literal daily job at Carnival: pipelines → warehouse → semantic model → report.
- **Microsoft Fabric** (Lakehouse/Warehouse, notebooks, pipelines) → production Fabric at *two* employers (Carnival + Basic Fun): lakehouses, pipelines, Direct Lake semantic model, golden datasets. **This is your differentiator — most candidates have only demo'd Fabric.**
- **Power BI semantic models + best practices** → calculation groups, reusable DAX, clear metric definitions, golden datasets; PBIP under **Git** version control (JD explicitly wants Git + governance + peer review).
- **SQL (advanced, performance)** → 25% processing-time cut, heap→columnstore (16–17.5×), incremental/watermark loaders.
- **Python for data transformation (ideally PySpark)** → strong Python/pandas + Fabric notebooks. *PySpark is your one soft spot — be honest: strong Python + Spark exposure, PySpark is the nearest adjacency.*
- **Dimensional modeling / fact-vs-dim / SCD / governance-friendly design** → three enterprise DWs from zero, star schemas, unified chart-of-accounts.
- **"Re-engineering, not refreshing dashboards"** → Story: hardening the "pipeline nobody owned" at Carnival; building Basic Fun's first warehouse. You architect, not just maintain.
- **FP&A fit (this role sits in their FP&A team)** → Twin-Star financial consolidation (P&L/BS/Cash Flow across 3 companies, 20–25 hrs/mo saved); Basic Fun executive KPI dashboards (20% Performance-to-Plan); Merrill finance background. Strong domain ASSET at a CPA/advisory firm.

---

## Comp — get this right
FL isn't in the disclosed bands, and FL typically maps below the metro tiers, so don't assume the $154.8K top applies here. Be direct since Theron opened the door:
> "On comp — I'm targeting **$140–160K base**. Given 10+ years and the Fabric depth, that's where I need to be. Is that workable for this role and the Florida band?"
- Let **him** name the FL range if he can. If it comes in low, don't kill it on the call — note it, keep exploring ("Good to know — let's see how the fit looks and revisit the number").
- Don't anchor off your Carnival contract rate or volunteer a current number. Redirect to the role's range.

## Onsite / logistics
- Easy and positive: "Boca's a 30-minute drive — I commuted there a few days a week before Carnival, so onsite isn't a problem."
- Then get the real number: **"When you say ~50% with flexibility — is the floor more like 2 days a week, or is a 1-week-on / 2-weeks-remote rhythm realistic?"**

---

## Questions to ask Theron (pick 4–5)
1. What's driving the reporting transformation — what's broken today, and what does success look like in year one?
2. Who's the hiring manager / how's the FP&A data team structured? Is there an existing data-engineering function, or would I be building the middle layer largely from scratch?
3. How far along is the Fabric adoption — greenfield, or migrating existing Power BI/warehouse assets?
4. What's the interview process and timeline from here?
5. What made my profile stand out to you? *(Then double down on it.)*
6. Straight FTE, and when are they looking to have someone in seat?

## Watch-outs
- **Don't oversell PySpark** — one honest sentence, pivot to Python + Fabric-notebook work.
- **Don't badmouth Carnival** — leaving for scope + permanence, not because anything's wrong ("contract winds down ~Jan; want a permanent role with more architecture ownership").
- **Level framing:** JD says 3–5 yrs; you're 10+. Frame the gap as *value* ("I can set the standards and mentor the reporting practice"), not overqualification risk.
- It's exploratory — **your job is to earn the HM intro**, not to close.

## "Why are you leaving Carnival?" (from qa-master)
> "I'm on contract at Carnival through January, and the technical work's been excellent — I built the BI and ETL for their fleet-wide HVAC energy system. I'm looking to move into a permanent role with more scope and comp that reflects 10+ years of enterprise data-platform work — ideally owning the full stack: semantic modeling, ETL architecture, data products."

## After the call
- If comp + scope align → HM conversation is the next step. **Build the tailored resume before it** (lead with production Fabric + the FP&A/finance-reporting angle).
- Send Theron a short thank-you same day; restate the one thing that best fits their need.

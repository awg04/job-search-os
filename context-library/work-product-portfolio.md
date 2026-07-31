# Work Product Portfolio

A curated index of past work products (case studies, 1-pagers, technical deep-dives, analyses, prototypes) with fit-scoring per company and role. Used by `/work-product` skill to suggest reuse/adaptation before generating new content.

**Portfolio Strategy:**
- **Irrelevant (0):** No overlap with company/role needs
- **Tangential (1):** Related skill area but wrong problem context
- **Relevant (2):** Solves a similar problem; needs customization
- **Perfect (3):** Directly applicable; minimal edits needed

---

## Portfolio Entries

### 1. Twin-Star Financial: Fabric Write-Back Automation
**Date Created:** 2026-07-21  
**Type:** Technical Case Study (1-pager + architecture diagram)  
**Length:** ~2000 words + visual

**What it covers:**
- Power BI dataflow → Fabric write-back automation
- DAX vs Python performance comparison
- Cost optimization (reduced Azure storage by 40%)
- Security/compliance (row-level security implementation)

**Key Skills Demonstrated:**
- Fabric/Power BI architecture
- Automation (Python, Power Query)
- Cost optimization
- Data modeling

**Past Use Cases:**
- Twin-Star Financial (original)

**Fit Scoring Template:**

| Company | Role | Problem Fit | Skill Overlap | Data Stack Fit | Customization Needed | Score |
|---------|------|------------|---------------|-----------------|-------------------|-------|
| Baptist Health | Sr. BI Developer | Write-back/automation | High (Fabric) | BI-heavy | Update healthcare context, remove cost focus | 2-3 |
| Fractal Analytics | Sr. Power BI Dev | BI modernization | High (Fabric, DAX) | Analytics-heavy | Reframe as analytics infrastructure | 2 |
| Armanino | Sr. BI Dev | EMS/data platform | Medium (automation) | Finance-heavy | Different domain; keep architecture pattern | 1-2 |
| Talenzaa | BI Analyst | Reporting/dashboards | Low (architecture-heavy) | BI-light | Not a good fit; different scope | 0-1 |

**Reuse Strategy:**
- **Baptist Health:** High-fit. Adapt to healthcare data governance + automation narrative.
- **Fractal Analytics:** High-fit. Emphasize "scaling BI infrastructure" angle.
- **Armanino:** Medium-fit. Use architecture pattern, different domain context.

**Last Updated:** 2026-07-30  
**Status:** Ready to reuse

---

### 2. Armanino: EMS Cost Optimization Brief
**Date Created:** 2026-07-21  
**Type:** Business Analysis 1-pager  
**Length:** ~1500 words

**What it covers:**
- Energy Management System (EMS) cost reduction opportunity
- Vendor consolidation analysis (3 systems → 1)
- ROI calculation (18-month payback)
- Data integration strategy (SQL + Power BI)

**Key Skills Demonstrated:**
- Cost-benefit analysis
- Data consolidation
- ROI modeling
- BI in finance/operations

**Past Use Cases:**
- Armanino (original)

**Fit Scoring Template:**

| Company | Role | Problem Fit | Skill Overlap | Data Stack Fit | Customization Needed | Score |
|---------|------|------------|---------------|-----------------|-------------------|-------|
| Baptist Health | Sr. BI Developer | Operations optimization | Medium (BI, ROI) | Healthcare ops | Adapt to healthcare IT systems | 1-2 |
| Fractal Analytics | Sr. Power BI Dev | Cost/performance | Low (not analytics core) | Analytics | Not a strong fit | 0-1 |
| Microsoft | Sr. BI Engineer | Cost optimization | High (Azure/BI cost case) | Cloud-heavy | Reframe as cloud cost optimization | 2 |
| Virtual Networx | BI/Data Analyst | Vendor evaluation | Medium (consolidation) | BI-focused | Good fit for vendor evaluation angle | 2 |

**Reuse Strategy:**
- **Baptist Health:** Medium-fit. Adapt to hospital IT operations (e.g., EMR system consolidation).
- **Microsoft:** High-fit if role involves cloud cost optimization. Use as-is with Azure focus.
- **Virtual Networx:** Good fit for vendor evaluation narrative.

**Last Updated:** 2026-07-30  
**Status:** Ready to reuse

---

### 3. Talenzaa: BI Reporting Strategy & Self-Service Architecture
**Date Created:** 2026-07-20  
**Type:** Technical Strategy + Recommendation  
**Length:** ~1800 words

**What it covers:**
- Self-service BI (Power BI vs. Tableau trade-offs)
- Report architecture for scale (reporting domain model)
- Governance framework (who owns what, approval workflows)
- Implementation roadmap (Months 1-6)

**Key Skills Demonstrated:**
- BI governance
- Self-service BI strategy
- Reporting architecture
- Change management

**Past Use Cases:**
- Talenzaa (original)

**Fit Scoring Template:**

| Company | Role | Problem Fit | Skill Overlap | Data Stack Fit | Customization Needed | Score |
|---------|------|------------|---------------|-----------------|-------------------|-------|
| Baptist Health | Sr. BI Developer | Governance/architecture | High (governance) | BI-heavy | Update to healthcare context | 2-3 |
| Fractal Analytics | Sr. Power BI Dev | BI architecture | High (Power BI focus) | Analytics-heavy | Perfect fit; minimal edits | 3 |
| Armanino | Sr. BI Dev | Governance | High (controls focus) | Finance-heavy | Adapt to financial controls | 2 |
| Microsoft | Sr. BI Engineer | Platform strategy | High (self-service, scale) | Cloud/BI | Reframe around Azure BI stack | 2-3 |

**Reuse Strategy:**
- **Fractal Analytics:** Perfect-fit. Use as-is or lightly customize.
- **Baptist Health:** High-fit. Emphasize healthcare data governance.
- **Microsoft:** High-fit. Frame around Azure BI platform strategy.

**Last Updated:** 2026-07-30  
**Status:** Ready to reuse

---

### 4. Fractal Analytics: Data Maturity Assessment Framework
**Date Created:** 2026-07-21  
**Type:** Assessment + Roadmap  
**Length:** ~2000 words

**What it covers:**
- Data maturity model (5 levels: Ad-hoc → Managed → Optimized)
- Assessment methodology (interviews, current-state analysis)
- Gap analysis (where Fractal is vs. where they need to be)
- Prioritized roadmap (12-month plan with phasing)

**Key Skills Demonstrated:**
- Assessment/diagnostics
- Strategic roadmap planning
- Data strategy
- Change management

**Past Use Cases:**
- Fractal Analytics (original)

**Fit Scoring Template:**

| Company | Role | Problem Fit | Skill Overlap | Data Stack Fit | Customization Needed | Score |
|---------|------|------------|---------------|-----------------|-------------------|-------|
| Baptist Health | Sr. BI Developer | Data strategy | High (maturity) | Healthcare data | Adapt to healthcare data governance | 2-3 |
| Armanino | Sr. BI Dev | Data maturity | High (assessments) | Finance/audit | Perfect fit for financial data maturity | 3 |
| Microsoft | Sr. BI Engineer | Platform maturity | High (cloud data) | Azure/BI | Reframe around Azure data platform | 2-3 |
| Virtual Networx | BI/Data Analyst | Data ops | Medium (operations) | BI/analytics | Lower maturity; adjust level expectations | 1-2 |

**Reuse Strategy:**
- **Armanino:** Perfect-fit. Use as-is (financial data maturity angle).
- **Baptist Health:** High-fit. Customize to healthcare data governance.
- **Microsoft:** High-fit. Frame around Azure data platform maturity.

**Last Updated:** 2026-07-30  
**Status:** Ready to reuse

---

### 5. Baptist Health: Healthcare BI Governance & Compliance Framework
**Date Created:** 2026-07-22  
**Type:** Policy + Framework Document  
**Length:** ~2500 words

**What it covers:**
- BI governance structure (roles, decision-making)
- Compliance/regulatory alignment (HIPAA, HITECH considerations)
- Data quality & lineage (where data lives, who owns it)
- Self-service BI guardrails (approved report templates, audit trails)

**Key Skills Demonstrated:**
- Healthcare compliance/regulations
- BI governance (healthcare-specific)
- Data quality
- Risk management

**Past Use Cases:**
- Baptist Health (original)

**Fit Scoring Template:**

| Company | Role | Problem Fit | Skill Overlap | Data Stack Fit | Customization Needed | Score |
|---------|------|------------|---------------|-----------------|-------------------|-------|
| Armanino | Sr. BI Dev | Compliance/governance | High (controls) | Finance-audit | Adapt to financial audit controls | 2-3 |
| Virtual Networx | BI/Data Analyst | Healthcare analytics | High (healthcare) | BI-focused | Perfect fit; minimal edits | 3 |
| Microsoft | Sr. BI Engineer | Compliance/governance | Medium (Azure compliance) | Cloud | Reframe around Azure security/compliance | 1-2 |
| Fractal Analytics | Sr. Power BI Dev | Governance | High (structure) | Analytics | Adapt to analytics governance | 2 |

**Reuse Strategy:**
- **Virtual Networx:** Perfect-fit. Use as-is (healthcare BI governance).
- **Armanino:** High-fit. Adapt compliance angle to financial audit/controls.
- **Fractal Analytics:** High-fit. Reframe for analytics-specific governance.

**Last Updated:** 2026-07-30  
**Status:** Ready to reuse

---

## Summary: Quick Lookup

| Product | Best Fits | Worst Fits | When to Use |
|---------|-----------|-----------|------------|
| Twin-Star Fabric Write-Back | Baptist Health, Fractal, Microsoft (Fabric) | Talenzaa, Virtual Networx | Automation, Fabric, write-back, cost optimization |
| Armanino EMS Cost Opt | Microsoft (cloud cost), Virtual Networx (vendor eval) | Fractal (not analytics core) | Cost optimization, vendor evaluation, operations |
| Talenzaa BI Strategy | Fractal (perfect), Baptist Health, Microsoft, Armanino | Virtual Networx (lower scope) | BI governance, self-service architecture, reporting |
| Fractal Data Maturity | Armanino (perfect), Baptist Health, Microsoft | Virtual Networx (lower maturity) | Strategic roadmap, data maturity, 12-month planning |
| Baptist Health Healthcare Governance | Virtual Networx (perfect), Armanino, Fractal | Microsoft (not healthcare-specific) | Healthcare compliance, BI governance, healthcare analytics |

---

## How to Use This Portfolio

**When `/work-product [company] [role]` is triggered:**
1. Check portfolio for entries with that company listed
2. Find entries with Fit Score ≥ 2 (Relevant or Perfect)
3. Suggest: "Reuse [Product X] and customize [section]" OR "Generate new, but reference [Product X] for architecture pattern"
4. Save time: Reusing a Relevant (2) product = 30-60 min saved per role

**When adding new work products:**
1. Document in this file after creation
2. Run fit-scoring against 5-10 target companies
3. Log "Date Created" and "Status: Ready to reuse"
4. Update fit scores quarterly as new applications come in

---

## Stats

- **Total entries:** 5
- **Average reusability:** 2.2 / 3.0 (mostly Relevant → Perfect fits)
- **Estimated time saved:** 2.5-5 hours per month (across 3-4 tailored work products)
- **Last portfolio audit:** 2026-07-30

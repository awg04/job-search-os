# Re-engineering the FP&A Reporting Middle Layer
### A proposal for Armanino's reporting transformation — Andrew Green

## The problem, as I see it

Armanino is doing internally what it sells to clients: moving FP&A from *reporting* to *insight*, on the Microsoft Fabric stack. The hard part isn't the dashboards on top or the warehouse underneath — it's the middle layer between them, where curated tables become governed semantic models that finance can actually trust. That layer is where reporting transformations stall, and it's the exact seam this role owns.

Two things make Armanino's version of this harder than average, and they point to where the early work should go:

- **You're acquiring.** Since the Further Global investment, the firm has entered Utah and absorbed MSTiller. Every acquisition arrives with its own chart of accounts, its own systems, its own definition of "revenue." Consolidating those into one conformed model — without breaking history — is the FP&A reporting problem here, more than any single report.
- **AI raises the floor on data quality.** With AI forecasting and agentic workflows moving into finance and audit, a shaky middle layer doesn't just produce a wrong chart — it produces a confidently wrong forecast. The semantic layer is the control point that makes AI outputs defensible.

## Why listen to me

I've built this exact seam. At Carnival I own three ETL pipelines into an Azure SQL warehouse *and* the Power BI semantic models and dashboards on top — the back-end-to-front-end bridge this role describes is my daily job. And I've solved the acquisition-consolidation problem specifically: at Twin-Star I integrated general-ledger data across three portfolio companies onto a unified chart of accounts and automated P&L, balance sheet, and cash flow — cutting 20–25 hours a month of manual finance prep. I also came out of seven years in finance at Merrill Lynch, so I model the way FP&A thinks.

## How I'd approach it

**Start with the metric contract, not the dashboards.** Before rebuilding reports, pin down the 15–25 finance metrics that matter (revenue, margin, utilization, realization, cash) as single, versioned definitions in the semantic model — one place, transparent DAX, documented. Most reporting transformations fail because five reports quietly compute margin five ways; fixing that is the fastest path to trust.

**Model the layers cleanly on Fabric.** Curated warehouse/lakehouse tables → conformed dimensional models (proper fact-vs-dimension design, slowly-changing dimensions for acquired-entity mappings so a re-mapped account doesn't rewrite last year) → governed Power BI semantic models on top. Fabric notebooks (SQL/Python) do the transformation and enrichment; validation runs *before* anything is surfaced.

**Make the acquisition path repeatable.** Design the conformance pattern once — source-to-target mapping, chart-of-accounts crosswalk, SCD handling — so onboarding the *next* acquired firm is a checklist, not a project. For a firm growing by acquisition, that's where the payoff compounds.

**Build the governance in from day one.** PBIP under Git, peer review on model changes, naming conventions, keyed reconciliation checks (I diff multi-million-row transformations with `EXCEPT` to prove a refactor is bit-identical). This is table stakes at a firm that markets data governance to clients.

**What I would *not* do:** rip out working Power BI reports wholesale, build one monolithic semantic model, or chase self-service before the governed metric layer exists. Self-service on an ungoverned model just industrializes disagreement.

## Why I'm credible on the Fabric piece specifically

Most candidates have seen Fabric in a demo. I run it in production at two employers: lakehouses, pipelines, a Direct Lake semantic model over OneLake delta tables, and governed golden datasets that decouple reporting from raw sources. That last pattern *is* the middle layer this role is chartered to build.

## What success looks like

- **Primary:** one trusted set of metric definitions — finance stops reconciling reports against each other.
- **Reliability:** refreshes that don't silently fail; data readiness before reports render (I've replaced fragile desktop cron jobs with sequenced, staged pipelines that never leave a table empty mid-refresh).
- **Speed:** time-to-a-new-trusted-report drops because the model is reusable, not rebuilt each time.
- **Adoption:** self-service that finance actually uses, because the underlying metrics are governed.
- **Guardrail:** don't trade correctness for speed — every model validated against source before it ships.

## A rough first two quarters

- **First 60–90 days:** learn the current state (what's on Fabric already vs. greenfield), lock the metric contract with FP&A, stand up the governance scaffolding (Git, naming, review, validation checks).
- **Next quarter:** rebuild the highest-pain reporting domain end-to-end on the conformed model as the reference pattern; codify the acquisition-onboarding crosswalk.
- **Future:** extend the governed layer to feed AI forecasting/agent workflows — the trustworthy foundation those need.

---

*Happy to walk through any of this — especially the acquired-entity conformance approach, which is where I think the near-term payoff is.*

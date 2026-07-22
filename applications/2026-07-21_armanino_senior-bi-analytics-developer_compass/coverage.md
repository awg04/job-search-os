# Keyword Coverage — Armanino Senior BI & Analytics Developer (JR103988)

**Coverage: 100% (17/17 requirements matched — 15 STRONG, 2 PARTIAL)**
JD is broad (17 extracted requirements); coverage this complete on a JD this wide indicates a very strong fit.

| # | JD Requirement | Type | Match | Evidence (experience-library.md) |
|---|----------------|------|-------|----------------------------------|
| 1 | 3–5+ yrs analytics/BI/data eng | Req | STRONG | 10+ yrs; Carnival, Basic Fun, Twin-Star |
| 2 | Microsoft Fabric (Lakehouse/Warehouse, notebooks, pipelines) | Req | STRONG | Production Fabric at 2 employers — lakehouses, pipelines, notebooks, Direct Lake, golden datasets |
| 3 | Power BI (semantic models, datasets, basic DAX) | Req | STRONG | 5 calculation groups, reusable DAX, semantic models on live Azure SQL |
| 4 | SQL (advanced querying, transformations, performance) | Req | STRONG | 25% faster processing, columnstore 16–17.5×, incremental/watermark loaders |
| 5 | Python for data transformation (ideally PySpark) | Req | **PARTIAL** | Strong Python (pandas, scikit-learn) + Fabric notebook ETL. **PySpark not documented** — Spark listed, no named PySpark project |
| 6 | Dimensional modeling | Req | STRONG | 3 enterprise DWs from zero, star schemas |
| 7 | Fact vs dimension design | Req | STRONG | "Designed fact/dimension tables and star schema models" |
| 8 | Slowly changing dimensions | Req | **PARTIAL** | Conceptual competency for a 10-yr DW architect (ERP migrations, unified chart of accounts) — **no SCD project explicitly documented** |
| 9 | Governance-friendly model design | Req | STRONG | Golden datasets, documented dataflows/KPI defs, validation rigor |
| 10 | Bridge back-end ↔ front-end (middle layer) | Resp | STRONG | Carnival: pipelines → warehouse → semantic model → report, owned end-to-end |
| 11 | Fabric notebooks for transformations | Resp | STRONG | Python ingestion notebooks + Fabric notebooks for transformation/enrichment |
| 12 | Validate data outputs / business rules | Resp | STRONG | EXCEPT-keyed diffs on multi-M-row views, reconciliation, plausibility guards |
| 13 | Refresh sequencing & dependencies | Resp | STRONG | Synapse orchestration, staged loads sequenced 30 min apart |
| 14 | Semantic modeling best practices (schema, reuse, metric clarity) | Resp | STRONG | Calculation groups, reusable measures, standardized KPI cards |
| 15 | Stakeholder translation / working sessions | Resp | STRONG | 35% adoption lift; requirements sessions with eng/ops/exec/FP&A |
| 16 | Git version control / peer review | Resp | STRONG | PBIP under Git source control; Azure DevOps |
| 17 | Test/validate/document before prod | Resp | STRONG | Staging-swap loads, BEGIN TRAN…ROLLBACK testing, documented standards |

## Gaps / soft spots
- **PySpark (PARTIAL):** JD says "ideally PySpark." Strong general Python + Fabric-notebook transformation, but no PySpark-named project. **Do not claim PySpark.** Interview framing: "Strong Python/pandas for transformation and Fabric notebooks; comfortable moving that to PySpark on Spark compute." Nearest adjacency, honest.
- **SCD (PARTIAL):** listed as "solid understanding," not a build requirement. Defensible for a 3-DW architect, but no documented SCD project — keep it a conceptual claim, don't invent a project.

## Domain note
Finance/FP&A background (Merrill Lynch, P&L/BS/Cash Flow reporting, Twin-Star consolidation) is a genuine ASSET for an FP&A-team role at a CPA/advisory firm — foregrounded in the summary and Twin-Star bullets.

## Verification flags
- **Phone number:** used **561.336.1806** (experience-library canonical). NOTE: the Fractal resume submitted 2026-07-21 used 561.339.1806 — one of these is wrong. **Confirm the correct number before sending this resume to Armanino.**
- All bullets trace to experience-library.md (REWORDED from existing entries). No INFERRED/fabricated bullets. Single-source `[VERIFY]` library items (e.g., Redwood-Trust figures, GitHub Copilot SME) deliberately omitted.

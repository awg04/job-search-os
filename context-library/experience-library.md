# Experience Library
_Last updated: 2026-07-23 (Carnival title standardized to Senior Business Intelligence Developer; master resume now `Resumes/07.23.26/Andrew Green Resume.docx|.pdf`. Also 2026-07-23: added Platform Concept Map — Fabric/OneLake + Databricks lakehouse + CI/CD article review; prior sync 2026-07-10 with master resume `Resumes/07.07.26/Andrew Green Resume.pdf`; Carnival HVAC EMS detail mined from work-session records)_

## Instructions

This is your single source of truth. Every skill draws from this file. The richer this file, the better every output.

## Contact Info

- **Name:** Andrew Green
- **Email:** andrewgreen04@gmail.com
- **Phone:** (561) 339-1806
- **LinkedIn:** https://www.linkedin.com/in/agreen8/
- **Location:** Fort Lauderdale, FL (Remote)

Note: The role previously referenced as "Mullinax" in bullet-level detail (below and elsewhere in this file) was at a Mullinax-branded dealership within the AutoNation network. For resumes and external documents, use **AutoNation** as the employer name.

## Resume Text

*(Source pasted 2026-06-22 — see Organized Experience below for processed version)*

## LinkedIn Profile

*(Source pasted 2026-06-22 — see Organized Experience below for processed version)*

---

## Organized Experience

> Andrew is targeting **BI Developer / Data Engineer** roles. Categories reflect that function, not PM.

---

### Employment Record (canonical titles, dates, locations — from master resume 07.23.26)

| Company | Title | Dates | Location |
|---------|-------|-------|----------|
| Carnival Cruise Line | Senior Business Intelligence Developer (contract/consultant) | Jan 2025 – Present | Remote |
| Basic Fun | Senior Business Intelligence Engineer (Power BI) | Mar 2023 – Jan 2025 | Boca Raton, FL |
| Twin-Star International | Sr. Business Intelligence Engineer | Oct 2017 – Mar 2023 | Delray Beach, FL |
| AutoNation | Business Analyst | Apr 2016 – Oct 2017 | Palm Beach Gardens, FL |
| Merrill Lynch | Financial Advisor | May 2009 – Mar 2016 | Palm Beach Gardens, FL |

ERP/system context: SAP Business One (Basic Fun), Microsoft Dynamics (Twin-Star, migration target). The AutoNation title was **Business Analyst** (older resumes tagged it "Business Analyst, Buyer") — lead with it for BA/BSA-screened roles. Contact: Fort Lauderdale, FL | 561.339.1806 | andrewgreen04@gmail.com | linkedin.com/in/agreen8.

Notes from resume-version review (2026-07-10):
- **Carnival title standardized 2026-07-23** to **Senior Business Intelligence Developer** — matches LinkedIn exactly (resolves the audit's consistency flag). Master resume rebuilt at `Resumes/07.23.26/` (.docx + .pdf); prior masters `07.07.26` / `07.10.26` still carry the old "Business Intelligence Developer – Power BI Specialist" wording — do not source new tailored resumes from them. Use "Power BI Specialist" only as a phrase inside a summary/bullet if a JD calls for it, never as the title line.
- **Carnival is a contract/consultant role** (confirmed 2026-07-10) — the contract has been "extended 4 times, more than any other consultant on the project." Strong signal for contract/BIA applications: proven staying power and repeat value to the client.
- Do NOT use "Manager" titles for Basic Fun/Twin-Star — two old AI-optimized resumes inflated them to "Manager"; the canonical title is "(Senior) Business Intelligence Engineer" everywhere else.
- FSU is in Tallahassee, FL.

---

### BI & Dashboard Development

- Architected a multi-page PBIP fleet HVAC dashboard for Carnival tracking 5 primary KPIs (AHU Energy, AHU Energy vs Target, COP, Cooling Power, CO₂) across 79 ships spanning 8 Carnival Corp brands (Carnival, AIDA, Costa, Holland America, Princess, P&O Australia, P&O UK, Seabourn) — including per-ship small-multiples trend views, worst-offender ship rankings, and an AHU sensor diagnostics drill-through page with 6-slicer filter rail enabling root-cause analysis to individual sensor level (Carnival, 2025–present)
- Designed scalable Power BI semantic models with 5 calculation groups (Time Zone, AHU View, Target Calculation, Climate Zone, Temp Units) supporting KPI reporting — energy targets, actual performance, variance-to-target, operating mode, and excess consumption metrics — against live `BI_Trident_Data` table in Azure SQL for engineering, operations, and executive audiences (Carnival, 2025–present)
- Built a labeled navigation-pane design system for the HVAC EMS report — a 175px nav rail with ~94 per-page-active action buttons, hover states, and custom per-state-recolored registered SVG icons — spanning a 13-page PBIP report (10 core pages) [VERIFY: current report is 13 pages / 10 core; an earlier library bullet says 4-page — reconcile] (Carnival, 2025–present)
- Standardized 34 KPI cards (Power BI `cardVisual`) on a single exemplar with value/target/delta rows and measure-driven conditional delta coloring keyed to distance-from-target (green when near target, near-black mid-range, red when far off) (Carnival, 2025–present)
- Built custom Deneb / Vega-Lite visuals including a dual-axis line chart with measure-driven, mode-aware background shading (operating mode rendered as a colored band that goes transparent below the supported time grain), replacing a fragile line-over-column workaround (Carnival, 2025–present)
- Authored a dynamic brand-logo DAX measure returning data-URI SVG logos across 8 Carnival Corp cruise brands (Carnival, AIDA, Costa, Holland America, Princess, P&O Australia, P&O UK, Seabourn), engineering around Power BI's 32,766-character image-URL truncation limit (Carnival, 2025–present)
- Built and maintained enterprise Power BI dashboards at Basic Fun covering sales performance, budget tracking, forecast accuracy, inventory position, pricing activity, and variance-to-plan — contributing to a 20% improvement in Performance-to-Plan outcomes (Basic Fun, 2023–2025)
- Automated daily/weekly report email distributions and alerts at Basic Fun by querying Power BI data from scheduled tasks in Power Automate, improving stakeholder follow-through and reporting consistency (Basic Fun, 2023–2025)
- Led enterprise Power BI deployment at Twin-Star International, defining a strategic roadmap for reporting and analytics and maintaining delivery accountability across the organization (Twin-Star, 2017–2023)
- Built paginated reports in SSRS/Power BI Report Builder for complex data exports to Excel and CSV formats (Twin-Star, 2017–2023)
- Engineered a Power Apps write-back solution allowing report users to input commentary to a SharePoint Product Tracker directly within Power BI custom visuals, creating a closed-loop between reporting and action tracking (Twin-Star, 2017–2023)
- Created advanced DAX measures for real-time KPI tracking covering financial forecasting, sales performance, and inventory optimization (AutoNation, 2016–2017)
- Designed and developed CPQ analytics and reporting solutions at Basic Fun, streamlining complex pricing structures, approval workflows, quote accuracy, and pricing performance visibility (Basic Fun, 2023–2025)

---

### Data Engineering & ETL

- Built three parallel ETL pipelines at Carnival ingesting data from NovotekReportPlus IoT historian (100+ AHU sensor tags per ship), Siemens Daedalus BMS cloud platform (chiller plant data via OPC UA/machine token auth), and MarineXProcurement voyage scheduling system (on-prem SQL) — resampled to 5-min intervals, pivoted from long to wide per AHU, ISNULL-coalesced across tag variants, and bulk-loaded via `fast_executemany` into a unified Azure SQL `ENERGY_DATABASE` serving 79 ships across 8 Carnival Corp brands — achieving 99% data accuracy for near-real-time Power BI reporting (Carnival, 2025–present)
- Used Azure Synapse Analytics to schedule, orchestrate, and automate ETL pipeline execution at Carnival, triggering and sequencing Python ingestion notebooks across all three source pipelines (Trident IoT, Siemens Daedalus, MarineXProcurement), improving refresh reliability and enabling standardized data delivery for Power BI reporting, variance tracking, and downstream analytics (Carnival, 2025–present)
- Engineered real-time ingestion pipelines in Azure Databricks at Carnival — ETL compute over a 20M-row table, landing Parquet in serverless Delta Lake storage and feeding the downstream Azure data warehouse — enabling intraday ship updates not previously possible (Carnival, 2025–present)
- Replaced two undocumented desktop Python cron jobs — fragile DROP+CREATE scripts on a single developer's machine that silently left production tables empty on failure — with scheduled Azure Synapse pipelines using a staging-table swap (load to temp, then TRUNCATE+INSERT) so the live table is never empty mid-refresh, sequencing dependent loads 30 minutes apart; the incremental stored-proc loader runs in ~55 seconds and the full staged rebuild in ~16 minutes (Carnival, 2025–present)
- Converted hot telemetry tables from heap to clustered columnstore with row counts preserved exactly: two archive tables from 6,445 MB → 387 MB and 559 MB → 128 MB (~16×), and the energy-target table 6,906 MB → 395 MB (17.5×); separately reclaimed ~15 GB by dropping two redundant nonclustered indexes (shrinking a 124 GB table to 108.7 GB) (Carnival, 2025–present)
- Built an incremental SQL loader (stored proc) using a `MAX(TIME)` watermark, trailing-partial-hour delete, and minimally-logged `INSERT WITH(TABLOCK)` append; forced an index seek over a 17.6M-row source with `OPTION(RECOMPILE)` after a variable predicate downgraded the plan to a full ~75 GB scan (Carnival, 2025–present)
- Migrated 12,273,557 raw 5-minute rows (9 months) out of the live table into archive using guarded per-month transactions (INSERT → count-verify → DELETE → count-verify → commit) so a mid-batch failure could never lose or duplicate data; built the resulting 18.4M-row / 1.08 GB compressed archive by appending 1,005,702 rows across 9 months with zero failures (Carnival, 2025–present)
- Eliminated a 53,039,913-row / 6,906 MB (~6.9 GB) redundant Azure SQL staging table shared across six regression notebooks by re-architecting them onto local per-ship parquet caches (40–400 MB each, off-database), then decommissioned the staging table, its refresh proc, Synapse pipeline, and trigger after confirming no other readers via dependency scan and Query Store (Carnival, 2025–present)
- Designed and deployed Azure data lake and ETL pipelines at Basic Fun to ingest 3rd-party point-of-sale data from heterogeneous sources: web portal, FTP, email, flat file, and external databases (Basic Fun, 2023–2025)
- Implemented incremental refresh strategies at Basic Fun — including Power BI incremental refresh policies (RangeStart/RangeEnd partition filtering) — replacing full data loads, reducing pipeline run times significantly and improving reporting timeliness for large business-critical datasets (Basic Fun, 2023–2025)
- Migrated transactional data from multiple siloed ERP systems at Twin-Star into an Azure SQL Server operational data store (ODS) using ETL pipelines (Twin-Star, 2017–2023)
- Led migration of on-premise SQL Server schemas to Azure SQL Server, developing and maintaining databases across both on-premise and cloud environments (Twin-Star, 2017–2023)
- Migrated data off a legacy Oracle database during an ERP implementation, writing PL/SQL queries to extract and transform source data (Twin-Star, 2017–2023)
- Built automated tool at AutoNation to ingest and parse Vehicle Report data from PDFs and calculate optimal bid prices and profit margins at auction using custom appraisal logic (AutoNation, 2016–2017)
- Built custom Python-based API integrations calling the Amazon Selling Partner API and Walmart vendor API directly to extract vendor sell-through and inventory data, parsing JSON payloads via Azure Data Factory into a Microsoft Fabric Lakehouse for seller-side analytics (Basic Fun, 2023–2025)

---

### Data Modeling & Architecture

- Designed Basic Fun's first enterprise data warehouse from scratch — full stack from source ingestion through ETL, dimensional modeling, star schema, semantic layer, and Power BI reporting — creating the company's foundational analytics platform (Basic Fun, 2023–2025)
- Architected Twin-Star's first enterprise data warehouse: defined dimensional models, implemented star schema, built SSIS ETL packages, and leveraged Azure Synapse for parallel analytical processing (Twin-Star, 2017–2023)
- Integrated general ledger data across three Twin-Star portfolio companies, modeling a unified chart of accounts and automating P&L, Balance Sheet, and Cash Flow reporting — saving 20–25 hours/month in manual Finance team preparation (Twin-Star, 2017–2023)
- Built scalable Power BI semantic models and reusable DAX measures at Carnival supporting time-series analysis, anomaly detection, and energy efficiency benchmarking across a large fleet (Carnival, 2025–present)
- Designed fact/dimension tables and star schema models in Power BI with reusable DAX measures for financial, sales, and operational analytics (Twin-Star, AutoNation)
- Partnered with stakeholders to define data requirements, technical architecture, and delivery strategy for data warehouse implementations (Twin-Star, Basic Fun)
- Mapped vendor-specific HVAC tag structures into standardized enterprise data models — source-to-target mapping supporting cloud data lake/warehouse modernization and future automation-provider rollouts (Carnival, 2025–present)
- Folded a multi-tier cooling-power calculation from Python notebooks into SQL views as a single source of truth, backed by two new coefficient tables (`CoolingPowerR`, `AHU_Design_Flow`), and verified exact parity against the pandas implementation (max absolute difference 0.000000 across 176K+ rows) (Carnival, 2025–present)
- De-duplicated a wide fact view and its daily rollup using `CROSS APPLY (VALUES …)` let-blocks (per-AHU coefficients and normalizations computed once), verifying the refactor was bit-identical to the original via `EXCEPT` (0 differences across 14.48M rows) (Carnival, 2025–present)
- Diagnosed and resolved SQL Server error 8632 (expression-services limit) on combinatorially-exploding views where each aliased reference re-substituted the entire upstream expression tree — refactored to CASE-multiplier and let-block patterns (Carnival, 2025–present)
- Identified a 275-AHU dimension gap (telemetry present but no dimension row), cross-validated against three independent source tables, fuzzy-matched 112 of 275 to served-area/code, and staged a validated 275-row INSERT tested inside `BEGIN TRAN … ROLLBACK` (0 nulls, 21-column map) (Carnival, 2025–present)

---

### Performance Optimization & Data Quality

- Optimized SQL-based extraction, transformation, and validation logic for large-scale HVAC and energy datasets at Carnival, reducing data processing time by 25% while improving reporting scalability and refresh performance (Carnival, 2025–present)
- Performed data profiling, validation, and reconciliation across raw automation data, transformed reporting layers, and Power BI outputs to ensure metric consistency and defensible reporting for operational and executive stakeholders (Carnival, 2025–present)
- Conducted ongoing data quality validation, reconciliation, and performance tuning across data warehouse tables, ETL jobs, semantic models, and dashboards at Basic Fun to ensure accuracy and executive trust in reported metrics (Basic Fun, 2023–2025)
- Maintained documentation for dataflows, transformation logic, KPI definitions, DAX measures, refresh processes, and reporting standards to support governance, auditability, and knowledge transfer (Carnival, 2025–present)
- Cut regression-notebook data-load from ~45 minutes (cold Azure SQL scan) to 1–2 minutes with a split parquet cache — replacing ~85 per-AHU Azure SQL round-trips with a single cached local read while re-running the cheap energy/daytype merge fresh each time (Carnival, 2025–present)
- Caught and fixed a fleet-wide data-poison bug where two AHUs reported sentinel values (999.9/998.9) in every off-coil temperature row, generating roughly −5,000 kW of fake cooling per row and corrupting trained coefficients — added a temperature plausibility guard (−20 to 80 °C) across three SQL views and six notebooks, moving that ship's cooling-capture from −100% to a stable ~63% (Carnival, 2025–present)
- Diagnosed apparent "OneDrive sync lag" (stale data persisting across 20+ minutes of refreshes) as Power BI's mashup-engine HTTP cache and fixed it with a `Cache-Control: no-cache` header on the `Web.Contents` CSV fetch (Carnival, 2025–present)
- Traced a recurring summer over-prediction (+4 °C) to a DAX measure averaging outside-air temperature across all 79 fleet ships (~18.9 °C) instead of the selected ship (~27.7 °C) — the 9 °C gap × the −0.444 reset slope produced the error — correcting it by scoping the calculation to the selected ship (Carnival, 2025–present)
- Established validation rigor as standard practice: keyed `EXCEPT`/relative-tolerance diff checks on multi-million-row views, watermark/idempotency proofs on loaders, and loader-vs-live-view comparison to catch source drift (Carnival, 2025–present)

---

### Microsoft Fabric

- Built ETL and data ingestion pipelines in Microsoft Fabric at Carnival, integrating internal data warehouse assets with external sources including APIs, IoT vendor feeds, and cloud-hosted repositories into Fabric Lakehouses for unified analytical access (Carnival, 2025–present)
- Constructed Fabric Lakehouses at Carnival to consolidate structured and semi-structured data sources, enabling reporting and analysis beyond what was available through Power BI datasets alone — including fleet-wide energy and HVAC operational data (Carnival, 2025–present)
- Architected a Direct Lake semantic model over OneLake delta tables in Microsoft Fabric, delivering near-real-time HVAC dashboards with DirectQuery-level latency and import-mode query performance while eliminating dataset refresh overhead (Carnival, 2025–present)
- Built ETL pipelines and data lakehouses in Microsoft Fabric at Basic Fun, integrating internal data warehouse assets with external sources including vendor forecasts, competitor product attributes, and API feeds (Basic Fun, 2023–2025)
- Developed golden datasets in Fabric at Basic Fun to serve as governed, reusable data products for downstream reporting, ad hoc analysis, and Power BI semantic models — decoupling analytical consumption from raw source dependencies (Basic Fun, 2023–2025)
- Production Fabric deployment across two employers (Carnival, Basic Fun) — early adopter with hands-on lakehouse architecture, Dataflows Gen2/pipeline orchestration, and golden dataset design
- Deployed a large (~105 KB) DAX measure to a workspace-hosted Fabric semantic model via the Fabric REST API (`getDefinition` → TMDL edit → `updateDefinition`) with Azure AD token auth and long-running-operation polling, after the MCP/TOM paths failed on the expression size (Carnival, 2025–present)

#### Platform Concept Map — Fabric, OneLake, Databricks Lakehouse, CI/CD (added 2026-07-23)

_Source: 2026-07-23 review of ~20 articles/docs (Microsoft Learn: Direct Lake overview, XMLA endpoint, advanced incremental refresh, lakehouse SQL analytics endpoint, Fabric warehouse + medallion training modules, Azure Databricks lakehouse/Delta/Unity Catalog/monitoring docs; RADACAD Dataflows Gen2; Tabular Editor Direct Lake blog; dataroots + Medium Fabric notebook/warehouse walkthroughs; Databricks lakehouse/medallion/DLT pages; Jenkins pipeline docs). Purpose: keyword-precise vocabulary for BI/data-engineering JDs and interviews, tiered by evidence so downstream skills never turn a studied concept into a fabricated production claim. Also supports DP-700/DP-203 prep._

**Tier 1 — Production experience (traceable to bullets above; safe for resume claims):**

- Fabric Lakehouse architecture on OneLake delta tables; golden datasets — in medallion terms, governed gold-layer data products (Carnival, Basic Fun)
- Direct Lake semantic models — Direct Lake on OneLake; refresh is a metadata-only **framing** operation against the latest delta table versions (no scheduled data reload); import-level VertiPaq query performance (Carnival)
- Fabric Data Factory pipelines and dataflows for ingestion and orchestration (Carnival, Basic Fun)
- Semantic-model-as-code deployment: Fabric REST API item definitions (`getDefinition`/`updateDefinition`), TMDL, Microsoft Entra token auth, long-running-operation polling; TOM attempted hands-on (hit expression-size limit — see bullet above)
- Delta Lake fundamentals as used through Fabric: parquet + file-based transaction log, ACID table guarantees, single-copy "one lake" architecture
- Azure Databricks ingestion pipelines — real-time ETL compute over a 20M-row table, Parquet into serverless Delta Lake storage feeding the Azure data warehouse, enabling intraday ship updates (Carnival; part of the Story 1 "Fleet Brain" architecture — see Data Engineering & ETL bullet)
- Tabular Editor and DAX Studio in the working tool stack
- Interview positioning: medallion layering is confirmed in the lakehouse work (formal bronze/silver/gold in part — see Tier 2); the longer warehouse track record maps to the same pattern (raw multi-source ingestion ≈ bronze, conformed/validated layers and SQL views ≈ silver, star schema + golden datasets + semantic models ≈ gold), so the medallion story spans 2017→present, not just the Fabric era.

**Tier 2 — Confirmed hands-on by Andrew (Q&A 2026-07-23). Safe to name as skills/keywords; capture project specifics (employer, what was built, outcome) before building resume bullets or interview stories on them:**

- SQL analytics endpoint — confirmed: ran T-SQL over lakehouse delta tables through the auto-provisioned endpoint at work
- Fabric notebooks — confirmed: Spark/PySpark/pandas notebooks inside Fabric at work
- Fabric Warehouse — confirmed: hands-on with the read-write T-SQL warehouse item
- XMLA endpoint via external tools — confirmed: Tabular Editor/DAX Studio/SSMS connected to workspace-hosted semantic models (`powerbi://` connection string)
- Power BI incremental refresh policies — confirmed: `RangeStart`/`RangeEnd` dataset refresh policies (ties to the Basic Fun incremental-refresh bullet, now updated to name the mechanism)
- Power BI / Fabric deployment pipelines — confirmed: dev→test→prod content promotion
- Medallion layering — confirmed: formal bronze/silver/gold organization in part of the lakehouse work, informal raw→curated→gold layering elsewhere
- Dataflows Gen2 — confirmed (2026-07-23): the Carnival and Basic Fun dataflows were Gen2 (Power Query Online with lakehouse/warehouse destinations)
- Databricks / Azure Databricks — confirmed and captured (2026-07-23): Azure Databricks ingestion pipelines at Carnival (Parquet → serverless Delta Lake → Azure data warehouse); scale/outcome captured (real-time ETL on a 20M-row table, intraday ship updates not previously possible); promoted to a Data Engineering & ETL bullet, Tier 1, and Story 1

**Explicitly NOT hands-on (declined in Q&A 2026-07-23 — these stay Tier 3 studied concepts only; never claim as experience):** OneLake shortcuts; XMLA partition management (TMSL bootstrap loads, ALM Toolkit metadata-only deployments); Delta MERGE/time-travel/OPTIMIZE as personally-run operations; Azure DevOps build/release pipelines; Jenkins.

**Tier 3 — Studied concepts (2026-07 article review; interview-conversant, NOT hands-on claims):**

*Fabric / Power BI enterprise:*
- Direct Lake internals: transcoding (on-demand column paging into memory), automatic updates/reframing, DirectQuery fallback (Direct Lake on SQL falls back, e.g. on SQL views or RLS; Direct Lake on OneLake never does), per-SKU capacity guardrails (parquet files / row groups / rows per table, max memory), V-Order write optimization, compatibility level 1604+, composite Direct Lake + Import models, entity partitions (Mode=DirectLake); XMLA-edited Direct Lake models can no longer be edited in web modeling
- SQL analytics endpoint mechanics: same engine as Fabric Warehouse, T-SQL views/functions/procs, SQL granular permissions (GRANT-based OLS/CLS/RLS), automatic metadata sync from delta writes, `/tables` vs `/files` discovery rule, shortcut tables (ADLS Gen2/S3/cross-workspace), three-part cross-item queries (`Lakehouse.dbo.Table`), materialized lake views for declarative silver-layer SQL transforms
- Advanced incremental refresh via XMLA: TMSL `refresh` with `applyRefreshPolicy`/`effectiveDate`, selective/backdated historical-partition refresh, bootstrapped initial loads (Tabular Editor "Apply Refresh Policy" → batch-process partitions in SSMS), custom `pollingExpression` for detect-data-changes, hybrid tables (real-time DirectQuery partition + Dual-mode related tables), metadata-only deployment via ALM Toolkit, enhanced refresh REST API (table/partition-level, retries, no 48-refresh/day cap through XMLA)
- Enterprise semantic-model management: TMSL scripting, TOM automation (C#/PowerShell), SSMS against workspace XMLA endpoints, DMVs for metadata/lineage, large-model format, service principals for unattended refresh/deploy, RLS/OLS role definition via XMLA, EffectiveUserName impersonation
- Fabric Warehouse: full read-write T-SQL DW over OneLake; Spark cannot write to it directly — land delta in a lakehouse then cross-query or use the warehouse connector; warehouse-as-gold-layer pattern for SQL-first teams
- Fabric notebook engineering patterns: Delta `MERGE`/upserts (`whenNotMatchedInsertAll`), partitioned concurrent writes, parameter cells + `mssparkutils.notebook.exit` for parameterized runs, pipeline-orchestrated notebooks, fast Spark session startup, `DeltaTable.createIfNotExists`, explicit `StructType` schemas
- Workspace/governance design: single lakehouse with bronze/silver/gold schemas vs per-layer lakehouses vs per-layer workspaces (isolation ↔ simplicity tradeoff), dev/test/prod separation with deployment pipelines, domains, capacity assignment [source articles at thatbluecloud.com unreachable at review time — verify specifics before citing]
- Medallion architecture (formal): bronze = immutable raw landing zone enabling reprocess-without-source; silver = validated, deduplicated, conformed enterprise view (ELT, "just-enough" transformation); gold = consumption-ready dimensional star schemas per audience; aka multi-hop; multiple gold layers per consumer group are normal

*Databricks ecosystem:*
- Lakehouse platform: warehouse + lake unification, storage/compute separation, open formats (Delta, Spark, MLflow), one platform for ETL/DW/ML/streaming/BI
- Delta Lake feature set: ACID via transaction log, time travel / table versioning, schema enforcement on write + schema evolution, full DML (`MERGE`/`UPDATE`/`DELETE`), `OPTIMIZE` compaction, Z-order data skipping, liquid clustering, `VACUUM`, change data feed, Auto Loader / `COPY INTO` incremental ingestion, constraints and generated columns
- Unity Catalog governance: centralized ACLs across catalogs/schemas/tables/views, lineage, Catalog Explorer discovery, storage credentials + external locations, cross-workspace metastore; lakehouse as single source of truth (no synced copies)
- Delta Sharing (open cross-org read-only sharing); Lakehouse Monitoring / data profiling: time-series, inference, and snapshot profiles, drift vs baseline table, profile + drift metric Delta tables, auto-generated quality dashboards — conceptually parallel to the data-validation regime Andrew already runs by hand (plausibility guards, EXCEPT-based reconciliation)
- Delta Live Tables → now Lakeflow Declarative Pipelines: declarative ETL, expectations (data-quality constraints with metrics), streaming tables vs materialized views, AutoCDC, automatic orchestration/retry/scaling — "declarative pipeline development" as a JD keyword

*Databricks + Fabric interoperability (from Andrew's own unpublished two-post draft essay series, July 2026 — see Authored Content below; [VERIFY the "Lakehouse//RT" branding/claim against current Databricks docs before publishing or citing]):*
- Unity Catalog managed tables can be stored natively in OneLake, with a "Publish to Fabric" workflow exposing them to Power BI, SQL analytics, and notebooks — write-once/read-directly, no copy or sync pipeline between the platforms
- Platform-split heuristic: Databricks for depth (Spark-native engineering, MLflow model lifecycle, Mosaic AI training/serving, fine-grained cluster control, heavy ML and real-time compute); Fabric for reach (Copilot across the suite, low-code pipelines, Power BI first-class, M365 integration, self-service analysts) — combine rather than force one group onto the wrong tool
- Real-time claim: a Databricks engine branded "Lakehouse//RT" serving millisecond queries on lakehouse data directly into Power BI for sub-second reporting, with no separate serving system [VERIFY: branding unfamiliar — confirm in current Databricks docs before repeating]
- Genie (Databricks natural-language data assistant) embedded in Teams, M365 Copilot, and Excel, governed through Unity Catalog throughout
- Multi-cloud posture: Databricks runs on AWS/Azure/GCP while Fabric is Azure-only — the combination lets an org standardize BI on Fabric without abandoning a mature Databricks ML investment (and vice versa)
- The design-around: a governance gap when the two platforms share storage — permission models must be deliberately reconciled across Unity Catalog and OneLake security
- **Interview positioning for Andrew:** Carnival is a live "genuinely both" answer to the Databricks-vs-Fabric question — Azure Databricks handled real-time ETL compute (the 20M-row intraday table) while the Fabric/Power BI layer delivered fleet reporting, and Andrew personally built the bridge between them. First-hand material for any JD that names either platform, or for architecture-discussion interview rounds — and he has a drafted (unpublished) essay series making this exact argument.

*CI/CD:*
- Jenkins pipeline-as-code: `Jenkinsfile` in source control, declarative syntax (`pipeline`/`agent`/`stages`/`steps`/`post`) vs scripted (Groovy `node` blocks), shared libraries, durable/pausable runs with approval gates — no production Jenkins claim; the honest adjacent experience is git-versioned PBIP + Azure DevOps

_Source-availability notes (2026-07-23): oliviertravers.com is offline (domain redirects elsewhere; datamart-tooling and dataset-vs-dataflow-vs-datamart-vs-Dataverse comparison articles unrecoverable). Microsoft retired Power BI Datamarts and removed the docs — datamart knowledge is legacy-only; the modern replacement story is Fabric Warehouse/Lakehouse + SQL analytics endpoint, which is the right way to answer any datamart interview question. thatbluecloud.com was unreachable. Databricks "Delta Live Tables" page now redirects to Lakeflow Declarative Pipelines branding._

---

### Advanced Analytics & ML

- Developed per-AHU HVAC energy baseline models in Python using scikit-learn — dual fan/chiller sub-models per unit with Fourier-encoded hour-of-day features (3 harmonics), outside air enthalpy (via psychrometric library), and sea/port/turnaround operating mode classification — training exclusively on lowest-25th-percentile consumption days to model efficiency floor rather than peak; iterated 6+ notebook versions across 6 ship-specific deployments (Conquest, Radiance, Sunrise, Sunshine, Magic, Liberty); model coefficients written to Azure SQL and consumed by Power BI as `AHU Energy vs Target` measure (Carnival, 2025–present) [VERIFY: of 6 ships built, 4 produce targets; Radiance/Sunshine power models are upstream-blocked by missing fan-power telemetry]
- Established the value of the diurnal feature engineering empirically: adding 2nd and 3rd hour-of-day harmonics roughly doubled test R² (fan model ~0.18 → ~0.53); daytype interactions added nothing measurable (Carnival, 2025–present)
- Trained and deployed 249 per-AHU hourly regression models across four ships (Sunrise 79, Conquest 78, Liberty 52, Magic 40; 286-row coefficient table), each a dual fan+chiller fit with 10 learned coefficients (B0–B9), model coefficients written to Azure SQL and consumed by Power BI as the `AHU Energy vs Target` measure (Carnival, 2025–present)
- Built a second per-AHU regression family — a supply-air-temperature setpoint model (`supply_temp ~ enthalpy + outside-air-temp + CO₂ + 3 hour-harmonics + daytype + return-air-temp`, 13 coefficients B0–B12) deployed across 66 valid AHUs (Carnival, 2025–present)
- Ran a controlled feature A/B test that doubled the setpoint model's median R² (0.135 → 0.282, improving 44 of 66 AHUs) by adding return-air temperature while correctly rejecting relative humidity — recognizing return-air temp as a genuine ASHRAE trim-and-respond demand signal rather than target leakage (Carnival, 2025–present)
- Surfaced a controls-optimization finding directly from the regression: the outside-air-temp coefficient (−0.444 °C per °C) matched the ASHRAE Guideline 36 supply-air reset slope, yet only 34 of 71 AHUs on one ship showed the correct reset slope — flagging that roughly half run no outside-air-temperature reset at all, a quantified efficiency gap raised with the decarbonization group (Carnival, 2025–present)
- Designed a 4-tier cooling-power estimation cascade (direct-tag → enthalpy → calibrated sensible × R-multiplier → sensible floor) to derive `chiller_power` from `cooling_power / COP`; validation of the calibrated tiers was only partially successful (14 of 118 ground-truth AHUs passed strictly, root cause = unknown per-AHU design-airflow constants), so shipped a conservative config restricted to the validated AHUs — a rigorous methodology with an honestly-scoped, still-open result (Carnival, 2025–present)
- Collaborated with demand planning stakeholders at Basic Fun to develop predictive inventory modeling, achieving a 25% YoY improvement in forecast accuracy through optimized demand and stock-level analysis (Basic Fun, 2023–2025)
- Integrated DAX-based predictive models at Twin-Star to enhance demand forecasting, pricing optimization, and revenue projections (Twin-Star, 2017–2023)
- Developed data-driven customer segmentation strategies at Merrill Lynch to personalize investment recommendations and improve client retention (Merrill Lynch, 2009–2016)

---

### Stakeholder Management & Cross-functional

- Partnered with Fuel Performance, Engineering, Operations, Data Engineering, and executive leadership at Carnival to gather requirements, define KPI logic, review findings, and translate complex technical data into clear business insights and action-oriented dashboard narratives — iterating dashboard enhancements that improved stakeholder adoption by 35% (Carnival, 2025–present)
- Delivered 8–10 executive Power BI dashboards serving 50–75 global end users, with semantic models processing a 20M+ row fact table on scheduled intraday refreshes [VERIFY: dashboard/user counts single-source from self-tailored Redwood Trust resume; the 20M-row intraday fact table confirmed directly by Andrew 2026-07-23] (Carnival, 2025–present)
- Recognized as the Power BI subject-matter expert on the project and introduced the team to AI-assisted notebook development (GitHub Copilot) for Python work [VERIFY: single-source] (Carnival, 2025–present)
- Led working sessions with engineers, operations teams, executives, and external vendors at Carnival to prioritize enhancements and deliver BI solutions supporting remote troubleshooting and predictive maintenance (Carnival, 2025–present)
- Supported Agile project execution at Carnival across pilot development, stakeholder feedback cycles, dashboard iteration, and rollout planning (Carnival, 2025–present)
- Partnered with Finance, Sales, Demand Planning, and Operations at Basic Fun to capture requirements, define KPI logic, validate assumptions, and translate business questions into actionable Power BI reports and DAX measures (Basic Fun, 2023–2025)
- Collaborated with Sales and Operations Planning (S&OP) at Twin-Star to support Demand Planning, Supply Planning, and strategic global supply chain decisions (Twin-Star, 2017–2023)
- Led teams of database engineers and external consultants across data migration, ERP implementation, and BI platform projects at Twin-Star (Twin-Star, 2017–2023)
- Collaborated cross-functionally with Sales, Marketing, and Internet departments at AutoNation to produce comprehensive daily and weekly reports, improving operational visibility and trend identification (AutoNation, 2016–2017)

---

### Finance & Domain Expertise

- ~7 years as Financial Advisor at Merrill Lynch (2009–2016), co-managing $250M in assets as junior partner on a wealth management advisory team (Merrill Lynch, 2009–2016)
- Deep expertise in financial reporting: P&L, Balance Sheet, Cash Flow, budget vs. actual, variance-to-plan — applied both as a finance professional and as the BI engineer building those reports
- 2+ years as Pricing Analyst at Twin-Star, developing and modeling pricing strategies across multiple product lines and consulting field sales teams on statistical and quantitative modeling
- Designed SQL-based sales analytics and pricing strategy tools at AutoNation supporting inventory optimization and bid price calculation
- Conducted in-depth analysis of market trends and supply-demand metrics at AutoNation to establish competitive vehicle pricing and optimize inventory turnover (AutoNation, 2016–2017)
- Applied ETL methodologies at Merrill Lynch to aggregate regulatory data, ensuring compliance with financial laws and internal policies; used ERP and CRM tools to track portfolio performance and client engagement (Merrill Lynch, 2009–2016)

---

### Business Impact (Metrics Summary)

| Metric | Context |
|--------|---------|
| **25% reduction** in data processing time | SQL/pipeline optimization, Carnival |
| **99% data accuracy** | Near-real-time IoT + vendor feed integration, Carnival |
| **20M-row table, intraday** | Real-time Azure Databricks ETL — intraday ship updates not previously possible, Carnival |
| **35% improvement** in stakeholder adoption | Requirements-driven dashboard iteration, Carnival |
| **16–17.5× storage reduction** | Heap → clustered columnstore (6,906→395 MB, 6,445→387 MB), Carnival |
| **53M-row / 6.9 GB table eliminated** | Staging teardown → per-ship parquet caches, Carnival |
| **45 min → 1–2 min** notebook runtime | Split parquet cache (~85 SQL round-trips → 1 read), Carnival |
| **~2× model R²** (0.135→0.282; fan 0.18→0.53) | Return-air-temp + diurnal-harmonics feature engineering, Carnival |
| **249 per-AHU models** across 4 ships | Hourly energy-target regression fleet, Carnival |
| **−100% → ~63%** cooling-capture | Sentinel-value data-poison fix, Carnival |
| **20% improvement** in Performance-to-Plan | Executive KPI dashboards, Basic Fun |
| **25% YoY improvement** in forecast accuracy (to 78% overall) | Predictive demand modeling via Amazon/Walmart vendor API integration, Basic Fun |
| **20–25 hrs/month saved** | Automated financial consolidation across 3 companies, Twin-Star |
| **$250M AUM** | Wealth management portfolio, Merrill Lynch |

---

### Technical Skills (Full Stack)

**BI / Reporting:** Power BI, Analysis Services (SSAS) Tabular, Microsoft Fabric (OneLake, Lakehouse, Fabric Warehouse, SQL analytics endpoint, Direct Lake semantic models, Fabric Notebooks, Data Factory Pipelines, Dataflows Gen2, Deployment Pipelines, Golden Datasets, medallion architecture, REST API / TMDL / XMLA endpoint), Deneb / Vega-Lite custom visuals, Power BI Report Builder, SSRS, Power Query, PowerPivot for Excel, Looker, Metabase, Tableau
**Query / Languages:** SQL, T-SQL, PL/SQL, DAX, Python (pandas, scikit-learn), R, MySQL
**ETL / Orchestration:** Azure Data Factory, SSIS, Azure Synapse Analytics, Apache Spark, clustered columnstore indexing, incremental/watermark loaders, Power BI incremental refresh policies (RangeStart/RangeEnd), parquet caching
**API Integrations:** Amazon Selling Partner API (SP-API), Walmart Vendor API, JSON parsing, Python requests-based integrations
**Migration & BA:** Requirements gathering, source-to-target mapping (STTM), data lineage, data dictionaries, report validation / UAT coordination, stakeholder communications
**Databases:** MS SQL Server, Azure SQL, Databricks, Azure Databricks, Snowflake, Oracle, dbt
**Cloud:** Microsoft Azure, AWS (RDS, Redshift, S3, Lambda, Glue, Athena, SQS, Auto Scaling, Data Migration Services), Google Cloud Platform
**Dev Tools:** Tabular Editor, DAX Studio, Visual Studio, VS Code, Azure Data Studio, ER Studio, Git (PBIP source control), Azure DevOps, GitHub Copilot
**Big Data:** Apache Spark, Delta Lake (OneLake delta tables), Scala, Kafka
**Automation:** Power Automate, Power Apps
**Certifications (In Progress):** PL-300 Microsoft Power BI Data Analyst Associate; DP-700 Microsoft Fabric Data Engineer Associate; DP-203 Azure Data Engineer Associate
**Education:** BS Finance & Economics, Florida State University, Tallahassee, FL (2004–2008)

---

### Authored Content (Unpublished Drafts)

- **Databricks + Fabric essay series (drafted by Andrew, July 2026 — NOT published)** — two drafts:
  1. Governance gap when Databricks and Fabric share storage — reconciling Unity Catalog vs OneLake security as the deliberate design-around
  2. "Better together: Databricks + Fabric" — Unity Catalog managed tables in OneLake / Publish to Fabric, depth-vs-reach platform split, Lakehouse//RT real-time claim, Genie in Teams/M365 Copilot/Excel, multi-cloud posture
- Status rule: do NOT describe these as published in any output (resume, outreach, interview prep). No claim of publishing anywhere unless Andrew confirms they're live and supplies URLs.
- The thinking is still usable: it can inform interview answers on Databricks/Fabric architecture (backed by the real Carnival experience) — framed as "my take," never as "I wrote/published an article."
- If/when published: add URLs here, then link in hiring-manager outreach and referral asks for roles touching either platform; publishing would also fix two 2026-07-22 audit gaps (0 posts ever; Fabric missing outside the headline).

---

## Story Bank

### Story 14: "The Model Found the Problem" — Carnival Supply-Air Setpoint Regression
- **Situation:** Beyond the energy-baseline models, Carnival wanted to understand and optimize HVAC supply-air temperature setpoints across the fleet — but there was no analytical basis for what a good setpoint should be under given conditions, and no way to tell which ships were running efficient controls.
- **Task:** Build a per-AHU supply-air-temperature setpoint model and use it to surface concrete controls-optimization opportunities, not just predictions.
- **Action:** Built a second per-AHU regression family (`supply_temp ~ outside-air enthalpy + OAT + CO₂ + 3 hour-of-day harmonics + daytype + return-air temp`, 13 coefficients B0–B12) deployed across 66 valid AHUs, on a training pull of ~580,000 CO₂ readings. Ran a controlled feature A/B test: adding return-air temperature doubled median test R² (0.135 → 0.282, improving 44 of 66 AHUs), while relative humidity added nothing and was correctly dropped. Recognized that return-air temp was a genuine ASHRAE trim-and-respond demand signal — not target leakage (a leak would have pushed R² toward ~0.9). Then read the model coefficients as engineering findings: the OAT coefficient (−0.444 °C per °C) matched the ASHRAE Guideline 36 supply-air reset slope almost exactly, yet only 34 of 71 AHUs showed the correct reset slope — roughly half implemented no OAT reset at all.
- **Result:** Turned a predictive model into an actionable efficiency finding — identifying specific AHUs (34 of 71 correct, ~half non-compliant) running no outside-air-temperature reset against an industry-standard benchmark, raised with the decarbonization group. Demonstrated judgment in distinguishing a real demand signal from leakage and in rejecting a feature that didn't earn its place.
- **Tags:** advanced analytics, Python, scikit-learn, regression, feature engineering, domain insight, problem framing
- **Best for:** "Tell me about a time your analysis changed a decision," "how do you know a model is trustworthy?", "describe a time you found something no one asked you to look for," "how do you avoid overfitting / data leakage," "give an example of connecting data to domain knowledge"

---

### Story 15: "The Pipeline Nobody Owned" — Carnival ETL Hardening & Governance
- **Situation:** Two production tables feeding the HVAC EMS reporting were silently maintained by undocumented Windows Scheduled Tasks on a single developer's desktop — fragile DROP+CREATE scripts that left the tables empty on any failure. One had already failed the morning it was discovered. Storage was also ballooning as raw 5-minute telemetry accumulated in the live table.
- **Task:** Make the data platform production-grade: eliminate the single point of failure, harden the load logic, and control storage — without ever leaving reporting tables empty or losing data.
- **Action:** Moved both jobs into scheduled Azure Synapse pipelines using a staging-table swap (load to temp, then TRUNCATE+INSERT) so the live table is never empty mid-refresh, sequencing dependent loads 30 minutes apart. Converted three hot telemetry tables from heap to clustered columnstore (~16× storage reduction, row counts preserved exactly) and dropped two redundant indexes to reclaim ~15 GB. Built an incremental loader with a `MAX(TIME)` watermark and minimally-logged `INSERT WITH(TABLOCK)`, forcing an index seek with `OPTION(RECOMPILE)` after a variable predicate had been triggering a full ~75 GB scan. Migrated ~12.3M historical rows to archive using guarded per-month transactions (INSERT → count-verify → DELETE → count-verify → commit). Validated every refactor keyed against the source via `EXCEPT` (0 differences across 14.48M rows). Brought the PBIP report under git source control.
- **Result:** Replaced a fragile desktop cron with owned, scheduled cloud pipelines; roughly 16× smaller hot tables; and a loader proven idempotent and lossless. Turned an invisible production risk into a governed, documented, recoverable platform.
- **Tags:** data engineering, governance, performance optimization, production hardening, risk mitigation, SQL, Synapse
- **Best for:** "Tell me about a time you found and fixed a production risk," "how do you approach data governance," "describe your SQL performance tuning experience," "how do you ensure a data migration doesn't lose data," "tell me about improving something you weren't asked to"

---

### Story 1: "The Fleet Brain" — Carnival HVAC Energy Management System
- **Situation:** Carnival needed fleet-wide visibility into HVAC energy consumption across 79 ships spanning 8 Carnival Corp brands (Carnival, AIDA, Costa, Holland America, Princess, P&O Australia, P&O UK, Seabourn), but data was siloed across three entirely separate systems: NovotekReportPlus IoT historian (AHU sensor telemetry), Siemens Daedalus BMS cloud platform (chiller plant data), and MarineXProcurement on-prem SQL (voyage scheduling) — with no unified reporting layer.
- **Task:** Own end-to-end BI and data engineering: architect three parallel ETL pipelines, build the semantic models, and deliver a 4-page PBIP Power BI fleet dashboard for the Energy Management and Fuel Performance teams.
- **Action:** Built three parallel Python ingestion pipelines — pulling 100+ AHU sensor tags per ship from NovotekReportPlus, chiller plant metrics from Siemens Daedalus via OPC UA, and port/sea/turnaround operating mode data from MarineXProcurement — resampling to 5-minute intervals, pivoting long→wide per AHU, coalescing inconsistent tag variants across ships, and bulk-loading via `fast_executemany` into a unified `ENERGY_DATABASE` on Azure SQL. Orchestrated all pipelines via Azure Synapse, with Azure Databricks providing real-time ETL compute and ingestion — Parquet landed in serverless Delta Lake storage — powering intraday updates on a 20M-row table that hadn't previously been possible. Built a 4-page PBIP dashboard: Fleet HVAC Performance (5 KPI strip + ship ranking), Per-Ship Trend Small Multiples, Ship Rankings by Energy vs Target, and an AHU Sensor Diagnostics drill-through with 6-slicer filter rail. Semantic model includes 5 calculation groups (Time Zone, AHU View, Target Calculation, Climate Zone, Temp Units). Partnered with Fuel Performance, Engineering, Operations, and executive stakeholders to define KPI logic and iterate through Agile cycles.
- **Result:** 99% data accuracy for near-real-time reporting; 25% reduction in data processing time; dashboards actively used by engineering, operations, and shoreside leadership for remote troubleshooting and energy optimization decisions across the full fleet.
- **Tags:** accomplishment, technical, cross-functional, architecture, ETL, stakeholder management, Microsoft Fabric, Azure Databricks
- **Best for:** "Tell me about your most complex BI project," "describe a time you owned something end-to-end," "how do you handle multiple data sources," "tell me about your ETL experience," "describe a project with real scale"

---

### Story 2: "Python Benchmarks" — Carnival Regression Modeling for HVAC Efficiency
- **Situation:** Carnival's HVAC energy performance had no statistical baseline — teams couldn't distinguish normal variation from genuine inefficiency, making it impossible to objectively target maintenance interventions across a 79-ship fleet.
- **Task:** Build per-AHU energy consumption baseline models so fleet managers could benchmark each unit against an expected efficiency floor under any operating condition.
- **Action:** Developed ship-specific Python notebooks using scikit-learn (`LinearRegression`, `Ridge`, `PolynomialFeatures`, `make_pipeline`) and evaluated `xgboost` as alternative. Model architecture: two separate sub-models per AHU — one for fan power (`fans_power_kW`) and one for chiller power — summed to produce total AHU energy target. Features: outside air enthalpy (calculated via `psychro.lib` psychrometric library), six Fourier-encoded hour-of-day terms (sin/cos at 3 harmonics to capture daily demand cyclicality), and one-hot-encoded daytype (sea/port/turnaround, derived from MarineXProcurement voyage data). Critically, trained only on days in the **lowest 25th percentile of daily energy consumption** to model the efficiency baseline — not average or peak behavior. Iterated through 6+ versions across 6 ship deployments (Conquest, Radiance, Sunrise, Sunshine, Magic, Liberty). Wrote per-AHU model coefficients to `ENERGY_DATABASE.Targets` in Azure SQL; Power BI semantic model reads these as the `AHU Energy vs Target` measure displayed on the Fleet HVAC dashboard.
- **Result:** Each AHU now has an objectively defensible energy target adjusted for outside air conditions, time of day, and operating mode. Engineering teams gained a quantitative baseline to prioritize troubleshooting — distinguishing genuine inefficiency from expected variation — and can track unit-level performance improvements over time.
- **Tags:** technical, advanced analytics, Python, ML, scikit-learn, problem-solving, regression, feature engineering
- **Best for:** "Have you done any data science or modeling work?", "how do you go beyond dashboards?", "tell me about a time you solved a problem others hadn't framed yet," "describe your Python experience," "walk me through a model you built end-to-end"

---

### Story 3: "25% Faster Pipeline" — Carnival SQL Optimization
- **Situation:** Large-scale HVAC and energy datasets from three source pipelines (NovotekReportPlus, Siemens Daedalus, MarineXProcurement) were slow to process and load into `ENERGY_DATABASE` on Azure SQL, causing refresh delays that undermined the reliability and timeliness of fleet HVAC dashboard reporting and the regression model's training data currency.
- **Task:** Identify and resolve data processing bottlenecks in the ETL extraction, transformation, and load layers across the pipeline stack.
- **Action:** Profiled SQL-based extraction, transformation, and validation logic across all three pipelines. Refactored inefficient T-SQL queries in the `BI_Trident_Data` and `Energy_Data_5min` transformation layers. Improved indexing on high-cardinality columns. Streamlined ISNULL coalescing logic across AHU tag variants. Replaced full-table scans with targeted incremental reads. Implemented `cursor.fast_executemany = True` for bulk writes via pyodbc, dramatically reducing insert round-trips. Validated end-to-end output accuracy via reconciliation between raw source, transformed layers, and Power BI semantic model outputs.
- **Result:** 25% reduction in data processing time, improving reporting scalability and refresh performance across the full HVAC reporting suite — ensuring `AHU Energy vs Target` and KPI measures reflected near-real-time data for operational and executive decision-making.
- **Tags:** performance optimization, technical, SQL, data engineering, ETL, pyodbc
- **Best for:** "Tell me about a performance problem you solved," "how do you approach query optimization," "have you worked with large datasets," "how do you validate pipeline output accuracy"

---

### Story 4: "Built From Zero" — Basic Fun First Enterprise Data Warehouse
- **Situation:** Basic Fun had no centralized analytics infrastructure — data lived in disconnected CPQ, POS, and operational systems with no single source of truth for executive reporting.
- **Task:** Design and deliver the company's first enterprise data warehouse and Power BI platform, from architecture through delivery.
- **Action:** Defined data requirements and technical architecture with stakeholders. Designed ETL pipelines ingesting 3rd-party POS data from web portals, FTP, email, flat files, and external databases into an Azure data lake. Built dimensional models, star schema, semantic layer, and executive Power BI dashboards covering sales, budget, inventory, pricing, and forecast metrics.
- **Result:** Created a scalable, governed analytics foundation. Executive leadership gained a single trusted source for decision-making. Delivered measurable 20% improvement in Performance-to-Plan outcomes.
- **Tags:** accomplishment, architecture, greenfield, leadership, stakeholder management
- **Best for:** "Tell me about a time you built something from scratch," "describe your data warehouse experience," "how do you handle a greenfield project," "what's your biggest accomplishment"

---

### Story 5: "20% Performance-to-Plan" — Basic Fun Executive KPI Dashboards
- **Situation:** Basic Fun's leadership team lacked real-time visibility into sales performance vs. plan, making it difficult to identify and respond to variance drivers in time to act.
- **Task:** Build KPI reporting that leadership could trust and act on daily.
- **Action:** Partnered with Finance, Sales, Demand Planning, and Operations to define KPI logic, validate data, and translate business questions into Power BI dashboards. Built variance-to-plan reporting, forecast vs. actual comparisons, and inventory position views. Automated report distributions via Power Automate.
- **Result:** 20% improvement in Performance-to-Plan outcomes attributed to improved leadership visibility and faster corrective action cycles.
- **Tags:** business impact, stakeholder management, cross-functional, BI development
- **Best for:** "Tell me about a time your work drove a measurable business outcome," "how do you work with non-technical stakeholders," "describe a dashboard that actually changed behavior"

---

### Story 6: "25% Forecast Accuracy" — Basic Fun Predictive Demand Modeling
- **Situation:** Basic Fun's inventory planning was reactive — demand forecasts were inaccurate, leading to excess stock and missed fill rates. A key data gap: vendor sell-through and inventory data from Amazon and Walmart lived entirely inside each retailer's own portal, with no automated way to bring it into internal planning systems.
- **Task:** Work with demand planning stakeholders to improve forecast accuracy through data modeling, starting with closing the marketplace vendor data gap.
- **Action:** Built custom Python-based API integrations calling the Amazon Selling Partner API and Walmart vendor API directly, parsing JSON payloads via Azure Data Factory into a Microsoft Fabric Lakehouse for seller-side analytics. Collaborated with demand planning to understand the forecasting process and identify remaining data gaps. Developed predictive modeling for inventory management analyzing demand patterns, stock levels, and incoming marketplace supply timelines. Integrated model outputs into Power BI dashboards used by Marketing, Operations, Demand Planning, and Sales.
- **Result:** Demand forecast accuracy improved 25% YoY, reaching 78% overall accuracy.
- **Tags:** advanced analytics, business impact, cross-functional, stakeholder management, API integration
- **Best for:** "Have you done predictive modeling?", "tell me about working with a business team on an analytics problem," "how do you translate a business problem into a data solution," "have you built an API integration," "tell me about calling an external API"

---

### Story 7: "Three Companies, One P&L" — Twin-Star Financial Consolidation
- **Situation:** Twin-Star's Finance team spent 20–25 hours/month manually consolidating P&L, Balance Sheet, and Cash Flow reports across three portfolio companies with different chart-of-accounts structures.
- **Task:** Automate the financial consolidation and eliminate manual report preparation.
- **Action:** Integrated general ledger data across all three companies, modeled a unified chart of accounts, built the dimensional model, and automated P&L, Balance Sheet, and Cash Flow reporting in Power BI.
- **Result:** Eliminated 20–25 hours/month of manual report preparation for the Finance team. Delivered a consistent, auditable financial reporting layer across the portfolio.
- **Tags:** accomplishment, automation, business impact, finance domain, data modeling
- **Best for:** "Tell me about a time you saved people significant time," "how do you handle data from multiple incompatible sources," "describe a finance reporting project"

---

### Story 8: "Enterprise Rollout" — Twin-Star Company-Wide Power BI Deployment
- **Situation:** Twin-Star had no enterprise BI platform. Reporting was fragmented across Excel and siloed tools.
- **Task:** Lead the strategic Power BI deployment across the enterprise.
- **Action:** Defined the strategic roadmap for reporting and analytics. Engaged stakeholders to assess data requirements. Partnered with cross-functional teams to define architecture and implementation plan. Led teams of database engineers and external consultants through data migration, ERP implementation, and BI platform build.
- **Result:** Company-wide Power BI platform delivered, replacing fragmented reporting with governed, standardized analytics used across Finance, Sales, Operations, and Supply Chain.
- **Tags:** leadership, stakeholder management, architecture, enterprise rollout, change management
- **Best for:** "Tell me about leading a large technical project," "how do you manage cross-functional stakeholders," "describe a time you drove organizational change through technology"

---

### Story 9: "ERP Migration to Azure" — Twin-Star Cloud Data Platform
- **Situation:** Twin-Star's transactional data lived in multiple siloed on-premise ERP systems with no integrated view and limited scalability.
- **Task:** Migrate to a unified cloud data platform on Azure.
- **Action:** Designed the migration strategy. Migrated transactional data from siloed ERP systems into an Azure SQL Server ODS using ETL pipelines. Led the migration of on-premise SQL Server schemas to Azure SQL. Leveraged Azure Synapse for analytical processing with parallel query optimization. Built dimensional models and SSIS ETL packages on top of the new platform.
- **Result:** Unified, scalable cloud data platform replacing siloed on-premise systems. Enabled the enterprise data warehouse and Power BI deployment that followed.
- **Tags:** technical, cloud migration, data engineering, leadership
- **Best for:** "Describe your cloud migration experience," "have you led a data platform modernization?", "tell me about an Azure project"

---

### Story 10: "Write-Back in Power BI" — Twin-Star Power Apps Custom Solution
- **Situation:** Report users at Twin-Star needed to annotate dashboard data with commentary, but Power BI has no native write-back capability.
- **Task:** Enable commentary input within the Power BI report experience without breaking the reporting layer.
- **Action:** Engineered a Power Apps solution embedded in Power BI custom visuals that allowed users to input write-back commentary to a SharePoint-maintained Product Tracker directly from within the report.
- **Result:** Users could annotate data, log decisions, and track follow-through without leaving the reporting environment — improving report adoption and closing the loop between insight and action.
- **Tags:** technical, creative problem-solving, Power Platform, user adoption
- **Best for:** "Tell me about a time you found a creative technical solution," "describe a time you improved user adoption," "have you worked with Power Apps or Power Platform"

---

### Story 11: "PDF Auction Tool" — AutoNation Automated Appraisal Logic
- **Situation:** Vehicle auction bid decisions at AutoNation were manual and subjective, relying on buyers parsing PDF vehicle reports by hand to estimate bid prices and profit margins.
- **Task:** Automate the bid price calculation process.
- **Action:** Developed an automated tool to ingest and parse Vehicle Report data from PDFs, applying custom appraisal logic to calculate optimal bid prices and profit margins at auction.
- **Result:** Transformed a manual, error-prone process into an automated analytical tool, enabling faster and more consistent bid decisions.
- **Tags:** technical, automation, creative problem-solving, business impact
- **Best for:** "Tell me about automating a manual process," "describe a time you identified a problem and built a solution," "have you done any Python/scripting work"

---

### Story 13: "Golden Datasets" — Microsoft Fabric Lakehouse Architecture
- **Situation:** At both Carnival and Basic Fun, Power BI reporting was constrained by what the underlying data warehouse could serve — external data (vendor forecasts, competitor attributes, API feeds, IoT data) wasn't cleanly integrated and analysis beyond standard dashboards required heavy manual work.
- **Task:** Build a more flexible analytical layer that could absorb heterogeneous external sources and serve governed data products to both Power BI and direct analytical consumers.
- **Action:** Implemented Microsoft Fabric Lakehouses at both companies, building ETL and data ingestion pipelines to pull in external sources alongside internal warehouse assets. Designed and published golden datasets — governed, reusable data products decoupled from raw source dependencies — enabling downstream Power BI semantic models and ad hoc analysis without going back to raw tables.
- **Result:** Analysts and Power BI models at both companies could consume clean, trusted data products without dependency on raw ETL. Expanded the analytical surface area beyond what the traditional warehouse alone could support. Production Fabric deployment at two employers makes Andrew an early adopter in a market where most BI developers have only seen Fabric in demos.
- **Tags:** technical, architecture, Microsoft Fabric, data engineering, early adopter
- **Best for:** "Have you worked with Microsoft Fabric?", "how do you design a data product layer?", "tell me about your experience beyond Power BI", "what's next for the Microsoft data stack in your view"

---

### Story 12: "Finance to Data" — Career Transition from Merrill Lynch
- **Situation:** After 7 years in finance (Merrill Lynch advisor + Pricing Analyst), identified that the most impactful work I was doing was building data models and pricing analytics — not client-facing financial advisory.
- **Task:** Transition from finance into data/BI engineering while leveraging the finance domain knowledge as a differentiator.
- **Action:** Built foundational BI skills during the Pricing Analyst role at Twin-Star. Progressed from pricing analytics to leading the enterprise BI platform build. Steadily deepened technical stack (SQL → ETL → Azure → Power BI → Python modeling) over 9+ years.
- **Result:** 10+ years of combined finance + data experience. Unique ability to understand financial reporting requirements deeply AND build the data infrastructure that supports them — trusted by Finance and executive teams as both a technical and business partner.
- **Tags:** career narrative, motivation, domain expertise, leadership journey
- **Best for:** "Walk me through your background," "why data/BI?", "what makes you different from other BI developers," "tell me about yourself"

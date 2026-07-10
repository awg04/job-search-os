# Experience Library
_Last updated: 2026-07-10 (synced with master resume `Resumes/07.07.26/Andrew Green Resume.pdf`)_

## Instructions

This is your single source of truth. Every skill draws from this file. The richer this file, the better every output.

## Resume Text

*(Source pasted 2026-06-22 — see Organized Experience below for processed version)*

## LinkedIn Profile

*(Source pasted 2026-06-22 — see Organized Experience below for processed version)*

---

## Organized Experience

> Andrew is targeting **BI Developer / Data Engineer** roles. Categories reflect that function, not PM.

---

### Employment Record (canonical titles, dates, locations — from master resume 07.07.26)

| Company | Title | Dates | Location |
|---------|-------|-------|----------|
| Carnival Cruise Line | Business Intelligence Developer – Power BI Specialist | Jan 2025 – Present | Remote |
| Basic Fun | Senior Business Intelligence Engineer (Power BI) | Mar 2023 – Jan 2025 | Boca Raton, FL |
| Twin-Star International | Sr. Business Intelligence Engineer | Oct 2017 – Mar 2023 | Delray Beach, FL |
| AutoNation | Business Analyst | Apr 2016 – Oct 2017 | Palm Beach Gardens, FL |
| Merrill Lynch | Financial Advisor | May 2011 – Mar 2016 | Palm Beach Gardens, FL |

ERP/system context: SAP Business One (Basic Fun), Microsoft Dynamics (Twin-Star). The AutoNation title was **Business Analyst** — lead with it for BA/BSA-screened roles. Contact: Fort Lauderdale, FL | 561.336.1806 | andrewgreen04@gmail.com.

---

### BI & Dashboard Development

- Architected a 4-page PBIP fleet HVAC dashboard for Carnival tracking 5 primary KPIs (AHU Energy, AHU Energy vs Target, COP, Cooling Power, CO₂) across 47 ships in 3 brands (Carnival, Holland America, Seabourn) — including per-ship small-multiples trend views, worst-offender ship rankings, and an AHU sensor diagnostics drill-through page with 6-slicer filter rail enabling root-cause analysis to individual sensor level (Carnival, 2025–present)
- Designed scalable Power BI semantic models with 5 calculation groups (Time Zone, AHU View, Target Calculation, Climate Zone, Temp Units) supporting KPI reporting — energy targets, actual performance, variance-to-target, operating mode, and excess consumption metrics — against live `BI_Trident_Data` table in Azure SQL for engineering, operations, and executive audiences (Carnival, 2025–present)
- Built and maintained enterprise Power BI dashboards at Basic Fun covering sales performance, budget tracking, forecast accuracy, inventory position, pricing activity, and variance-to-plan — contributing to a 20% improvement in Performance-to-Plan outcomes (Basic Fun, 2023–2025)
- Automated daily/weekly report email distributions and alerts at Basic Fun by querying Power BI data from scheduled tasks in Power Automate, improving stakeholder follow-through and reporting consistency (Basic Fun, 2023–2025)
- Led enterprise Power BI deployment at Twin-Star International, defining a strategic roadmap for reporting and analytics and maintaining delivery accountability across the organization (Twin-Star, 2017–2023)
- Built paginated reports in SSRS/Power BI Report Builder for complex data exports to Excel and CSV formats (Twin-Star, 2017–2023)
- Engineered a Power Apps write-back solution allowing report users to input commentary to a SharePoint Product Tracker directly within Power BI custom visuals, creating a closed-loop between reporting and action tracking (Twin-Star, 2017–2023)
- Created advanced DAX measures for real-time KPI tracking covering financial forecasting, sales performance, and inventory optimization (AutoNation/Mullinax, 2016–2017)
- Designed and developed CPQ analytics and reporting solutions at Basic Fun, streamlining complex pricing structures, approval workflows, quote accuracy, and pricing performance visibility (Basic Fun, 2023–2025)

---

### Data Engineering & ETL

- Built three parallel ETL pipelines at Carnival ingesting data from NovotekReportPlus IoT historian (100+ AHU sensor tags per ship), Siemens Daedalus BMS cloud platform (chiller plant data via OPC UA/machine token auth), and MarineXProcurement voyage scheduling system (on-prem SQL) — resampled to 5-min intervals, pivoted from long to wide per AHU, ISNULL-coalesced across tag variants, and bulk-loaded via `fast_executemany` into a unified Azure SQL `ENERGY_DATABASE` serving 47 ships across 3 brands — achieving 99% data accuracy for near-real-time Power BI reporting (Carnival, 2025–present)
- Used Azure Synapse Analytics to schedule, orchestrate, and automate ETL pipeline execution at Carnival, triggering and sequencing Python ingestion notebooks across all three source pipelines (Trident IoT, Siemens Daedalus, MarineXProcurement), improving refresh reliability and enabling standardized data delivery for Power BI reporting, variance tracking, and downstream analytics (Carnival, 2025–present)
- Designed and deployed Azure data lake and ETL pipelines at Basic Fun to ingest 3rd-party point-of-sale data from heterogeneous sources: web portal, FTP, email, flat file, and external databases (Basic Fun, 2023–2025)
- Implemented incremental refresh strategies at Basic Fun replacing full data loads, reducing pipeline run times significantly and improving reporting timeliness for large business-critical datasets (Basic Fun, 2023–2025)
- Migrated transactional data from multiple siloed ERP systems at Twin-Star into an Azure SQL Server operational data store (ODS) using ETL pipelines (Twin-Star, 2017–2023)
- Led migration of on-premise SQL Server schemas to Azure SQL Server, developing and maintaining databases across both on-premise and cloud environments (Twin-Star, 2017–2023)
- Migrated data off a legacy Oracle database during an ERP implementation, writing PL/SQL queries to extract and transform source data (Twin-Star, 2017–2023)
- Built automated tool at Mullinax Ford to ingest and parse Vehicle Report data from PDFs and calculate optimal bid prices and profit margins at auction using custom appraisal logic (Mullinax, 2016–2017)

---

### Data Modeling & Architecture

- Designed Basic Fun's first enterprise data warehouse from scratch — full stack from source ingestion through ETL, dimensional modeling, star schema, semantic layer, and Power BI reporting — creating the company's foundational analytics platform (Basic Fun, 2023–2025)
- Architected Twin-Star's first enterprise data warehouse: defined dimensional models, implemented star schema, built SSIS ETL packages, and leveraged Azure Synapse for parallel analytical processing (Twin-Star, 2017–2023)
- Integrated general ledger data across three Twin-Star portfolio companies, modeling a unified chart of accounts and automating P&L, Balance Sheet, and Cash Flow reporting — saving 20–25 hours/month in manual Finance team preparation (Twin-Star, 2017–2023)
- Built scalable Power BI semantic models and reusable DAX measures at Carnival supporting time-series analysis, anomaly detection, and energy efficiency benchmarking across a large fleet (Carnival, 2025–present)
- Designed fact/dimension tables and star schema models in Power BI with reusable DAX measures for financial, sales, and operational analytics (Twin-Star, AutoNation)
- Partnered with stakeholders to define data requirements, technical architecture, and delivery strategy for data warehouse implementations (Twin-Star, Basic Fun)
- Mapped vendor-specific HVAC tag structures into standardized enterprise data models — source-to-target mapping supporting cloud data lake/warehouse modernization and future automation-provider rollouts (Carnival, 2025–present)

---

### Performance Optimization & Data Quality

- Optimized SQL-based extraction, transformation, and validation logic for large-scale HVAC and energy datasets at Carnival, reducing data processing time by 25% while improving reporting scalability and refresh performance (Carnival, 2025–present)
- Performed data profiling, validation, and reconciliation across raw automation data, transformed reporting layers, and Power BI outputs to ensure metric consistency and defensible reporting for operational and executive stakeholders (Carnival, 2025–present)
- Conducted ongoing data quality validation, reconciliation, and performance tuning across data warehouse tables, ETL jobs, semantic models, and dashboards at Basic Fun to ensure accuracy and executive trust in reported metrics (Basic Fun, 2023–2025)
- Maintained documentation for dataflows, transformation logic, KPI definitions, DAX measures, refresh processes, and reporting standards to support governance, auditability, and knowledge transfer (Carnival, 2025–present)

---

### Microsoft Fabric

- Built ETL and data ingestion pipelines in Microsoft Fabric at Carnival, integrating internal data warehouse assets with external sources including APIs, IoT vendor feeds, and cloud-hosted repositories into Fabric Lakehouses for unified analytical access (Carnival, 2025–present)
- Constructed Fabric Lakehouses at Carnival to consolidate structured and semi-structured data sources, enabling reporting and analysis beyond what was available through Power BI datasets alone — including fleet-wide energy and HVAC operational data (Carnival, 2025–present)
- Architected a Direct Lake semantic model over OneLake delta tables in Microsoft Fabric, delivering near-real-time HVAC dashboards with DirectQuery-level latency and import-mode query performance while eliminating dataset refresh overhead (Carnival, 2025–present)
- Built ETL pipelines and data lakehouses in Microsoft Fabric at Basic Fun, integrating internal data warehouse assets with external sources including vendor forecasts, competitor product attributes, and API feeds (Basic Fun, 2023–2025)
- Developed golden datasets in Fabric at Basic Fun to serve as governed, reusable data products for downstream reporting, ad hoc analysis, and Power BI semantic models — decoupling analytical consumption from raw source dependencies (Basic Fun, 2023–2025)
- Production Fabric deployment across two employers (Carnival, Basic Fun) — early adopter with hands-on lakehouse architecture, dataflow/pipeline orchestration, and golden dataset design

---

### Advanced Analytics & ML

- Developed per-AHU HVAC energy baseline models in Python using scikit-learn — dual fan/chiller sub-models per unit with Fourier-encoded hour-of-day features (3 harmonics), outside air enthalpy (via psychrometric library), and sea/port/turnaround operating mode classification — training exclusively on lowest-25th-percentile consumption days to model efficiency floor rather than peak; iterated 6+ notebook versions across 6 ship-specific deployments (Conquest, Radiance, Sunrise, Sunshine, Magic, Liberty); model coefficients written to Azure SQL and consumed by Power BI as `AHU Energy vs Target` measure (Carnival, 2025–present)
- Collaborated with demand planning stakeholders at Basic Fun to develop predictive inventory modeling, achieving a 25% YoY improvement in forecast accuracy through optimized demand and stock-level analysis (Basic Fun, 2023–2025)
- Integrated DAX-based predictive models at Twin-Star to enhance demand forecasting, pricing optimization, and revenue projections (Twin-Star, 2017–2023)
- Developed data-driven customer segmentation strategies at Merrill Lynch to personalize investment recommendations and improve client retention (Merrill Lynch, 2011–2016)

---

### Stakeholder Management & Cross-functional

- Partnered with Fuel Performance, Engineering, Operations, Data Engineering, and executive leadership at Carnival to gather requirements, define KPI logic, review findings, and translate complex technical data into clear business insights and action-oriented dashboard narratives — iterating dashboard enhancements that improved stakeholder adoption by 35% (Carnival, 2025–present)
- Led working sessions with engineers, operations teams, executives, and external vendors at Carnival to prioritize enhancements and deliver BI solutions supporting remote troubleshooting and predictive maintenance (Carnival, 2025–present)
- Supported Agile project execution at Carnival across pilot development, stakeholder feedback cycles, dashboard iteration, and rollout planning (Carnival, 2025–present)
- Partnered with Finance, Sales, Demand Planning, and Operations at Basic Fun to capture requirements, define KPI logic, validate assumptions, and translate business questions into actionable Power BI reports and DAX measures (Basic Fun, 2023–2025)
- Collaborated with Sales and Operations Planning (S&OP) at Twin-Star to support Demand Planning, Supply Planning, and strategic global supply chain decisions (Twin-Star, 2017–2023)
- Led teams of database engineers and external consultants across data migration, ERP implementation, and BI platform projects at Twin-Star (Twin-Star, 2017–2023)
- Collaborated cross-functionally with Sales, Marketing, and Internet departments at AutoNation to produce comprehensive daily and weekly reports, improving operational visibility and trend identification (AutoNation, 2016–2017)

---

### Finance & Domain Expertise

- 5 years as Financial Advisor at Merrill Lynch, co-managing $250M in assets as junior partner on a wealth management advisory team (Merrill Lynch, 2011–2016)
- Deep expertise in financial reporting: P&L, Balance Sheet, Cash Flow, budget vs. actual, variance-to-plan — applied both as a finance professional and as the BI engineer building those reports
- 2+ years as Pricing Analyst at Twin-Star, developing and modeling pricing strategies across multiple product lines and consulting field sales teams on statistical and quantitative modeling
- Designed SQL-based sales analytics and pricing strategy tools at Mullinax/AutoNation supporting inventory optimization and bid price calculation
- Conducted in-depth analysis of market trends and supply-demand metrics at AutoNation to establish competitive vehicle pricing and optimize inventory turnover (AutoNation, 2016–2017)
- Applied ETL methodologies at Merrill Lynch to aggregate regulatory data, ensuring compliance with financial laws and internal policies; used ERP and CRM tools to track portfolio performance and client engagement (Merrill Lynch, 2011–2016)

---

### Business Impact (Metrics Summary)

| Metric | Context |
|--------|---------|
| **25% reduction** in data processing time | SQL/pipeline optimization, Carnival |
| **99% data accuracy** | Near-real-time IoT + vendor feed integration, Carnival |
| **35% improvement** in stakeholder adoption | Requirements-driven dashboard iteration, Carnival |
| **20% improvement** in Performance-to-Plan | Executive KPI dashboards, Basic Fun |
| **25% YoY improvement** in forecast accuracy | Predictive demand modeling, Basic Fun |
| **20–25 hrs/month saved** | Automated financial consolidation across 3 companies, Twin-Star |
| **$250M AUM** | Wealth management portfolio, Merrill Lynch |

---

### Technical Skills (Full Stack)

**BI / Reporting:** Power BI, Microsoft Fabric (Lakehouse, Pipelines, Dataflows, Golden Datasets), Power BI Report Builder, SSRS, Power Query, PowerPivot for Excel, Looker, Metabase, Tableau
**Query / Languages:** SQL, T-SQL, DAX, Python, R, MySQL
**ETL / Orchestration:** Azure Data Factory, SSIS, Azure Synapse Analytics, Apache Spark
**Databases:** MS SQL Server, Azure SQL, Databricks, Azure Databricks, Snowflake, Oracle, dbt
**Cloud:** Microsoft Azure, AWS (RDS, Redshift, S3, Lambda, Glue, Athena, SQS, Auto Scaling, Data Migration Services), Google Cloud Platform
**Dev Tools:** Tabular Editor, DAX Studio, Visual Studio, Azure Data Studio, ER Studio, Git
**Big Data:** Apache Spark, Scala, Kafka
**Automation:** Power Automate, Power Apps
**Certifications (In Progress):** PL-300 Microsoft Power BI Data Analyst Associate; DP-700 Microsoft Fabric Data Engineer Associate
**Education:** BS Finance & Economics, Florida State University (2004–2008)

---

## Story Bank

### Story 1: "The Fleet Brain" — Carnival HVAC Energy Management System
- **Situation:** Carnival needed fleet-wide visibility into HVAC energy consumption across 47 ships in 3 brands (Carnival, Holland America, Seabourn), but data was siloed across three entirely separate systems: NovotekReportPlus IoT historian (AHU sensor telemetry), Siemens Daedalus BMS cloud platform (chiller plant data), and MarineXProcurement on-prem SQL (voyage scheduling) — with no unified reporting layer.
- **Task:** Own end-to-end BI and data engineering: architect three parallel ETL pipelines, build the semantic models, and deliver a 4-page PBIP Power BI fleet dashboard for the Energy Management and Fuel Performance teams.
- **Action:** Built three parallel Python ingestion pipelines — pulling 100+ AHU sensor tags per ship from NovotekReportPlus, chiller plant metrics from Siemens Daedalus via OPC UA, and port/sea/turnaround operating mode data from MarineXProcurement — resampling to 5-minute intervals, pivoting long→wide per AHU, coalescing inconsistent tag variants across ships, and bulk-loading via `fast_executemany` into a unified `ENERGY_DATABASE` on Azure SQL. Orchestrated all pipelines via Azure Synapse. Built a 4-page PBIP dashboard: Fleet HVAC Performance (5 KPI strip + ship ranking), Per-Ship Trend Small Multiples, Ship Rankings by Energy vs Target, and an AHU Sensor Diagnostics drill-through with 6-slicer filter rail. Semantic model includes 5 calculation groups (Time Zone, AHU View, Target Calculation, Climate Zone, Temp Units). Partnered with Fuel Performance, Engineering, Operations, and executive stakeholders to define KPI logic and iterate through Agile cycles.
- **Result:** 99% data accuracy for near-real-time reporting; 25% reduction in data processing time; dashboards actively used by engineering, operations, and shoreside leadership for remote troubleshooting and energy optimization decisions across the full fleet.
- **Tags:** accomplishment, technical, cross-functional, architecture, ETL, stakeholder management, Microsoft Fabric
- **Best for:** "Tell me about your most complex BI project," "describe a time you owned something end-to-end," "how do you handle multiple data sources," "tell me about your ETL experience," "describe a project with real scale"

---

### Story 2: "Python Benchmarks" — Carnival Regression Modeling for HVAC Efficiency
- **Situation:** Carnival's HVAC energy performance had no statistical baseline — teams couldn't distinguish normal variation from genuine inefficiency, making it impossible to objectively target maintenance interventions across a 47-ship fleet.
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
- **Situation:** Basic Fun's inventory planning was reactive — demand forecasts were inaccurate, leading to excess stock and missed fill rates.
- **Task:** Work with demand planning stakeholders to improve forecast accuracy through data modeling.
- **Action:** Collaborated with demand planning to understand the forecasting process and identify data gaps. Developed predictive modeling for inventory management analyzing demand patterns and stock levels. Integrated model outputs into Power BI dashboards for planning team use.
- **Result:** 25% YoY improvement in forecast accuracy.
- **Tags:** advanced analytics, business impact, cross-functional, stakeholder management
- **Best for:** "Have you done predictive modeling?", "tell me about working with a business team on an analytics problem," "how do you translate a business problem into a data solution"

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

### Story 11: "PDF Auction Tool" — Mullinax Ford Automated Appraisal Logic
- **Situation:** Vehicle auction bid decisions at Mullinax Ford were manual and subjective, relying on buyers parsing PDF vehicle reports by hand to estimate bid prices and profit margins.
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

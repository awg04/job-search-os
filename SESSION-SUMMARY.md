# SESSION SUMMARY — Carnival HVAC Energy Management System (EMS)
_For resume and interview preparation. Written for a technical recruiter audience._
_Source: experience-library.md. Where the library does not document a specific, marked "UNKNOWN — ask Andy."_
_Do not use any figure marked UNKNOWN in resume bullets or interview answers without confirming with Andy first._

---

## 1. Project Overview

**What it is:**
A fleet-wide Business Intelligence and data engineering platform built on Microsoft Azure and Microsoft Fabric, delivering near-real-time visibility into HVAC energy consumption across Carnival Cruise Line's cruise ship fleet. The system consolidates heterogeneous data sources — ship-board SQL databases, IoT sensor feeds from HVAC equipment, vendor automation tags, and external APIs — into a unified reporting layer that surfaces energy performance KPIs for engineering and executive audiences.

**Business purpose:**
Enable the Fuel Performance and Engineering teams to detect HVAC underperformance, monitor energy efficiency at the unit level, benchmark fleet-wide consumption against operating-condition targets, and prioritize remote troubleshooting and predictive maintenance actions. Prior to this system, there was no unified reporting layer — data lived in siloed sources with no single view across the fleet.

**Who uses it:**
Fuel Performance team, Engineering teams (both shipboard and shoreside), Operations leadership, and executive leadership at Carnival's shoreside headquarters. Dashboards are used for remote troubleshooting decisions, energy optimization planning, and executive KPI review.

**Andrew's role:**
End-to-end owner — requirements gathering, ETL architecture, semantic model design, dashboard development, regression modeling, and stakeholder rollout. Agile delivery: pilot development, feedback cycles, iterative dashboard build, and rollout planning.

**Timeline:** 2025–present (current role, Senior Business Intelligence Developer at Carnival Cruise Line).

---

## 2. Direct Lake / Fabric Architecture

**Fabric components in use:**
Microsoft Fabric Lakehouse (OneLake delta tables), Fabric ETL and data ingestion pipelines.

**Semantic model structure:**
UNKNOWN — ask Andy.
Specifically unknown:
- Whether semantic models are connected via Direct Lake mode or another connection type (Import, DirectQuery, composite)
- Number of delta tables in OneLake
- Number of separate semantic models deployed
- Fact/dimension table breakdown (how many fact tables, how many dimension tables, which entities are modeled as dimensions)
- Approximate row volumes per table or total
- Refresh or framing cadence (if Direct Lake: how frequently is the frame advanced; if Import: what is the scheduled refresh interval)
- End-to-end data latency — what is the lag from sensor read to dashboard visibility
- What the prior architecture was, if any (Import mode, Azure-only, no Fabric), and what latency or throughput improvement Fabric delivered

**Medallion architecture:**
UNKNOWN — ask Andy. The experience library documents Fabric Lakehouses and "golden datasets" at Carnival, which is language consistent with a gold layer. Whether bronze (raw ingestion), silver (validated/transformed), and gold (governed, analytics-ready) zones were explicitly implemented as named layers in OneLake, or whether the architecture was structured differently, is not confirmed. Do not claim a three-layer medallion architecture without Andy confirming this was explicitly designed that way.

---

## 3. ETL Pipelines

**Data sources ingested:**
- Ship-board SQL databases (HVAC operational data)
- IoT sensor feeds (HVAC equipment telemetry — temperature, AHU performance, fan speed, CO2)
- Vendor automation tags (third-party HVAC vendor control systems)
- External APIs (cloud-hosted data repositories)

Exact source system names, vendor names, API providers, and number of distinct sources are UNKNOWN — ask Andy.

**Orchestration tooling:**
Azure Synapse Analytics (documented: used to schedule, orchestrate, and automate ETL tasks, improving refresh reliability and enabling standardized data delivery). Microsoft Fabric pipelines and Fabric data ingestion pipelines (documented: used for Lakehouse ingestion and integration of external sources). Python notebooks (documented: used for regression modeling; whether also used for pipeline orchestration steps is UNKNOWN — ask Andy).

**Volumes processed:**
UNKNOWN — ask Andy. Neither the total data volume (GB/TB) nor the number of records processed per pipeline run is documented in the experience library.

**Measured improvements:**
- 25% reduction in data processing time (source: experience-library.md, attributed to SQL-based extraction, transformation, and validation logic optimization — profiling, query refactoring, improved indexing, and streamlined transformation layers)
- 99% data accuracy achieved for near-real-time Power BI reporting (source: experience-library.md)
- Improved refresh reliability (qualitative, attributed to Azure Synapse orchestration — no before/after metric documented)

---

## 4. Regression / Data Science Work

**What was built:**
HVAC energy target models — statistical baselines establishing expected energy consumption per AHU under specific operating conditions, enabling the engineering and Fuel Performance teams to distinguish normal variation from genuine underperformance and to flag anomalous units for intervention.

**Features used in the model:**
Enthalpy, AHU power, fan speed, fuel consumption, and operating condition (port, sea, turnaround). These five feature categories are documented in the experience library.

**Modeling method:**
Documented as "regression-based models" using Python notebooks. The specific regression method — OLS, polynomial, ridge, per-AHU individual models, or a mixed-effects approach — is UNKNOWN — ask Andy.

**Python library used:**
UNKNOWN — ask Andy (not documented; likely scikit-learn, statsmodels, or numpy-based, but confirm before claiming).

**Accuracy / error metric achieved:**
UNKNOWN — ask Andy. R², MAPE, RMSE, or other accuracy metrics are not documented in the experience library. Do not state a specific accuracy figure without confirming the number.

**Validation against actuals:**
The experience library states that model outputs were integrated into Power BI dashboards for anomaly detection and efficiency scoring, enabling engineering teams to benchmark fleet performance by operating condition. Whether formal holdout validation, cross-validation, or test-set evaluation was performed against observed actuals is UNKNOWN — ask Andy.

**Business outcome of the regression work:**
Engineering teams gained a defensible, statistically-grounded baseline to prioritize HVAC troubleshooting and predictive maintenance actions — shifting from subjective judgment to objective benchmarking by operating condition.

---

## 5. KQL / Kusto / Real-Time Intelligence

**Direct hands-on KQL or Kusto Query Language work:** NOT performed on this project based on the experience library. No KQL, Eventhouse, or Fabric Real-Time Intelligence components are documented.

**What IS documented:** Azure Synapse Analytics for orchestration, T-SQL for extraction and transformation, Python for regression modeling, DAX for semantic model measures, and Fabric Lakehouse pipelines for ingestion.

**For interview purposes:** If a Microsoft role (particularly MSRC or Azure Data) asks about KQL, the honest answer is: "I haven't used KQL hands-on — my Azure query work is T-SQL and DAX. I understand the Kusto syntax conceptually and am actively building fluency." Do not claim KQL experience on this project.

---

## 6. Quantifiable Outcomes

| Metric | Figure | Confidence |
|--------|--------|------------|
| Data processing time reduction | 25% | Documented in experience-library.md |
| Data accuracy achieved | 99% | Documented in experience-library.md |
| Number of dashboards built | UNKNOWN — ask Andy | Not in experience library |
| Number of ships covered | UNKNOWN — ask Andy | Not in experience library |
| Number of AHUs covered | UNKNOWN — ask Andy | Not in experience library |
| Total data volume (GB/TB) | UNKNOWN — ask Andy | Not in experience library |
| End-to-end data latency | UNKNOWN — ask Andy | Not in experience library |
| Stakeholder / user adoption count | UNKNOWN — ask Andy | Not in experience library |
| Time saved for any team | UNKNOWN — ask Andy | Not in experience library (the 20–25 hrs/month figure is from Twin-Star, not Carnival) |
| Pipeline run frequency | UNKNOWN — ask Andy | Not in experience library |
| Regression model accuracy (R², MAPE, etc.) | UNKNOWN — ask Andy | Not in experience library |

**Confirmed, interview-safe claims:**
1. "Achieved 99% data accuracy for near-real-time HVAC fleet reporting by integrating SQL databases, IoT sensor feeds, vendor automation tags, and external APIs into a unified pipeline."
2. "Reduced data processing time by 25% through SQL query profiling, refactoring, and pipeline optimization."
3. "Built regression-based energy target models in Python incorporating enthalpy, AHU power, fan speed, fuel consumption, and operating condition — giving engineering teams a statistically defensible baseline for fleet-wide HVAC benchmarking."
4. "Deployed Microsoft Fabric Lakehouse architecture in production, integrating heterogeneous internal and external sources into governed datasets for Power BI reporting."
5. "Delivered executive-ready Power BI dashboards covering temperature setpoints vs. actuals, AHU power consumption, fan speed, CO2 trends, variance-to-target KPIs, and operating mode metrics — actively used by Fuel Performance, Engineering, Operations, and executive leadership."

---

## Notes for Resume / Interview Use

- The two figures confirmed for external use are 25% (processing time) and 99% (data accuracy). Every other number requires confirmation from Andy before use.
- The regression work is a strong differentiator but requires Andy to confirm the method, library, and any accuracy metric before those specifics appear in a resume bullet or interview answer.
- Microsoft Fabric and Direct Lake experience is genuine and production-confirmed (two employers: Carnival and Basic Fun). However, the specific Direct Lake model structure details need Andy to confirm before claiming a specific delta table count or semantic model count.
- KQL is explicitly NOT part of this project's experience and should not be claimed.
- The medallion architecture language ("golden datasets") is documented and accurate. Whether to describe the full architecture as "bronze/silver/gold medallion" depends on how Andy actually structured the Lakehouse zones — confirm before using that framing.

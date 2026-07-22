# Report Spec — HVAC EMS Fleet Dashboard

## Report identity
- Report name: HVAC Fleet Energy Management Dashboard
- Semantic model: HVAC EMS WIP (localhost:59655 — PBIDesktop)
- Audience: Executives / Fleet managers
- Primary purpose: Track HVAC energy performance across the fleet, measure against targets, surface ships and AHUs that need attention
- Delivery target: Local PBIP first; publishing decision deferred

## User decisions and constraints
- Scope: Fleet overview + ship breakdown + AHU diagnostics (full depth)
- Page count: 4 pages
- Interactivity: Drill-through from P1 → P3 and P4; cross-filter within pages; synced date slicer across P1–P3
- Design direction: Industrial Cockpit — dark navy, indigo + cyan, status-coded KPI cards
- Publishing: Local PBIP only for now
- Tooling: powerbi-modeling-mcp (connected), powerbi-report-authoring skill
- Model edit permissions: Measures and calculated columns permitted via MCP
- Accessibility: WCAG AA minimum; alt text on every chart; high-contrast on dark surface
- Data caveats: LOCAL TIME inactive relationship — use UTC (Date[DateTime]) unless Time Zone calc group engaged; AHU slicer is high cardinality → search required

## Narrative
- Core story: Fleet HVAC energy is tracked against corporate targets. Some ships consistently exceed their targets; others fall short. Drilling into AHU-level sensors reveals whether the cause is mechanical (damper/valve position), environmental (climate zone, enthalpy), or operational (mode selection).
- Audience promise: In one screen, a fleet manager can see overall status, click into the worst-performing ship, and pinpoint which AHU unit is responsible — without exporting to Excel.
- Key questions answered:
  1. Is fleet HVAC energy within target this period?
  2. Which ships are over or under their energy baseline?
  3. How does each ship's energy trend compare over time?
  4. Which AHU unit is causing a ship's deviation, and what sensor explains it?

## Design identity
- Tone: Industrial Cockpit — dark navy `#120E2A` canvas, indigo `#5772D9` + cyan `#8CEEEE` accents, muted purple `#7D77A8` chrome; geometric sans bold type; dotted low-opacity gridlines; color reserved for status, not decoration
- Signature: Status-coded KPI accent bars — every KPI card carries a colored accent bar (green / amber / red) driven by conditional formatting on the vs-target measure, so the fleet status reads as a traffic-light board at a glance on every page
- Brownfield delta: N/A (greenfield)

## Page plan

### Page 1 — Fleet HVAC Performance: Is the Fleet On Target?
- Archetype: Executive Summary
- Layout variant: B (KPI-strip) — 5 KPIs of comparable fleet-level importance; no single hero metric dominates
- Purpose: One-screen fleet status; landing page for drill navigation
- Visuals: 5 KPI cards (full-width strip) + multi-measure energy trend (line) + ships ranked by energy vs target delta (horizontal bar)
- Fields/measures: AHU Energy (kWh), AHU Energy vs Target, COP, Cooling Power (kW), CO₂ (ppm); Date_Day[Date] or Date[DateTime]; AHU[Ship AHU] for ranking
- Slicers: 1 × Date range dropdown (top-right); drill-through buttons to P3 and P4

### Page 2 — How Each Ship's HVAC Energy Tracks Over Time
- Archetype: Analytical Canvas
- Layout variant: C (Small-Multiples-Grid) — comparison across all ships along shared energy axes IS the analytical question
- Purpose: Spot diverging ships; see seasonal/climate patterns across the fleet
- Visuals: Trellis of energy line-charts per ship (shared Y), ranked bar of ships by current-period energy
- Fields/measures: AHU Energy (kWh) by ship by date; Climate Zone calc group; Ship Status
- Slicers: 3 × inline dropdowns (Date period, Climate Zone, Ship Status)

### Page 3 — Ships Ranked by Energy vs. Target — Find the Worst Offenders
- Archetype: Comparative Benchmark
- Layout variant: A (Side-by-Side) — 4–8 ships to rank + variance, small multiples for per-ship trend
- Purpose: Show which ships are over or under target, by how much, and whether the gap is improving
- Visuals: Ranked Δ bar (ships sorted by energy vs target), derived insight callout (worst offender + gap-to-target %), small multiples per ship (AC vs target, shared Y)
- Fields/measures: AHU Energy vs Target, AHU Aggregate Power vs Target; Ship dimension; Date_Day[Date]
- Slicers: 1 × period dropdown; drill-through button to P4

### Page 4 — AHU Sensor Diagnostics: Trace Root Causes
- Archetype: Analytical Canvas
- Layout variant: A (Filter-Rail) — 5+ slicers required (Ship, AHU, Date, Mode, Climate Zone, Time Zone)
- Purpose: AHU-level sensor drill; engineer/fleet manager isolates cause of energy deviation
- Visuals: Hero line chart (supply temp, return temp, fan speed over time), scatter (supply speed vs cooling power), supporting bar (damper/valve positions), detail matrix (AHU sensor table)
- Fields/measures: Supply Temp, Return Temp, Fan Speed (%), Cooling Power (kW), Chill Valve Position, Inlet/Outlet Damper; Trident or Trident_Agg depending on grain
- Slicers: Ship (dropdown), AHU (dropdown + search, high cardinality), Date range (between), AHU Mode (list, low cardinality), Climate Zone (dropdown), Time Zone (list)

## Design system summary
- Theme: Industrial Cockpit adapted from assets/base.json; dark navy page background `#120E2A`; visual containers `#1E1A36` (slightly lighter surface for card grouping); textbox zero padding override preserved
- Color semantics: indigo `#5772D9` → AHU Energy primary; cyan `#8CEEEE` → COP and vs-target reference; amber `#F59E0B` → warning threshold; green `#10B981` → on-target status; red `#EF4444` → over-target / alert
- Typography: Inter Bold 24–32pt (display) / Inter Regular 10–12pt (body); Segoe UI as guaranteed Power BI fallback; all KPI values in Consolas for tabular numeral alignment
- Layout pattern: 12-col × 12-row grid, margin 32px, gutter 24px, snap 8px
- Accessibility: WCAG AA contrast on dark surface; alt text on every chart; dropdown search on AHU slicer; Azure Map preferred over deprecated map visual

## Model requirements
- Existing measures (use as-is): AHU Energy (kWh), AHU Energy vs Target, AHU Power (kW), COP, Cooling Power (kW), CO₂ (ppm), Supply Temp, Return Temp, Fan Speed (%), Chill Valve Position, Inlet Damper, Outlet Damper, Recirculation Damper
- New measures needed: None confirmed — verify AHU Aggregate Power vs Target is accessible at ship grain before P3 build
- New calculated columns: None
- Relationship/sort requirements: Use Date[DateTime] (active) not LOCAL TIME (inactive) unless Time Zone calc group is applied; AHU slicer needs search enabled (high cardinality)

---

## Canonical design contract

```yaml
Design Brief:
  generated_by: powerbi-report-design
  contract_version: 1
  mode: greenfield
  design_identity:
    tone: "Industrial Cockpit — dark navy #120E2A canvas, indigo #5772D9 + cyan #8CEEEE accents, muted purple #7D77A8 chrome; geometric sans bold type; dotted low-opacity gridlines; color reserved for status"
    signature: "Status-coded KPI accent bars — every KPI card carries a conditional-format accent bar (green/amber/red) driven by the vs-target measure; the fleet status reads as a traffic-light board at a glance on every page"
  archetype: Executive Summary (landing); Analytical Canvas (exploration); Comparative Benchmark (ranking); Analytical Canvas (diagnostics)
  color_map:
    - measure: "AHU Energy (kWh)"
      color: "#5772D9"
      tint: "#2A2D5E"
    - measure: "AHU Energy vs Target"
      color: "#8CEEEE"
      tint: "#1A4040"
    - measure: "COP"
      color: "#8CEEEE"
      tint: "#1A4040"
    - measure: "Cooling Power (kW)"
      color: "#A78BFA"
      tint: "#2E2050"
    - measure: "CO₂ (ppm)"
      color: "#34D399"
      tint: "#0D3025"
    - measure: "Supply Temp"
      color: "#FCD34D"
      tint: "#3D2F00"
    - measure: "Return Temp"
      color: "#F87171"
      tint: "#3D0A0A"
    - measure: "Fan Speed (%)"
      color: "#7D77A8"
      tint: "#1E1A36"
    - measure: status_positive
      color: "#10B981"
    - measure: status_warning
      color: "#F59E0B"
    - measure: status_negative
      color: "#EF4444"

  pages:
    # ─────────────────────────────────────────────────────────────────
    - name: "Fleet HVAC Performance: Is the Fleet On Target?"
      role: landing
      archetype: Executive Summary
      layout_variant: B
      variant_rationale: "5 fleet-level KPIs of comparable importance (energy, vs-target, COP, cooling power, CO₂) with no single dominant hero metric — KPI-strip variant B best fit"
      page_background: "#120E2A"
      layout_summary: "Full-width KPI strip across the top. Below: multi-measure energy trend (left) and ships ranked by energy-vs-target delta (right). Footer bar carries refresh timestamp and drill-through navigation buttons."
      layout_contract:
        canvas:
          width: 1920
          height: 1080
          margin: 32
          gutter: 24
          snap: 8
        grid:
          columns: 12
          rows: 12
          regions:
            header:  [1,  1, 10,  2]
            filters: [10, 1, 13,  2]
            kpis:    [1,  2, 13,  4]
            trend:   [1,  4,  7, 11]
            movers:  [7,  4, 13, 11]
            footer:  [1, 11, 13, 13]
        placements:
          - id: page_title
            region: header
            kind: textbox
            text: "Fleet HVAC Performance: Is the Fleet On Target?"
            purpose: "State the page question; fleet managers orient in < 5 s"
          - id: date_slicer
            region: filters
            kind: slicer
            field_bindings: Date_Day[Date]
            slicer_type: dropdown
            insight_basis: "Users select the reporting period; default to current month"
          - id: kpi_energy
            region: kpis
            kind: cardVisual
            purpose: "What is total fleet HVAC energy consumption this period?"
            field_bindings: "AHU Energy (kWh)"
            color_strategy: measure_match
            slot: 1
            of: 5
          - id: kpi_vs_target
            region: kpis
            kind: cardVisual
            purpose: "Is fleet energy above or below the corporate target?"
            field_bindings: "AHU Energy vs Target"
            color_strategy: semantic
            slot: 2
            of: 5
          - id: kpi_cop
            region: kpis
            kind: cardVisual
            purpose: "What is the fleet coefficient of performance?"
            field_bindings: "COP"
            color_strategy: measure_match
            slot: 3
            of: 5
          - id: kpi_cooling
            region: kpis
            kind: cardVisual
            purpose: "What is total cooling power drawn across the fleet?"
            field_bindings: "Cooling Power (kW)"
            color_strategy: measure_match
            slot: 4
            of: 5
          - id: kpi_co2
            region: kpis
            kind: cardVisual
            purpose: "What is average CO₂ concentration across all AHUs?"
            field_bindings: "CO₂ (ppm)"
            color_strategy: measure_match
            slot: 5
            of: 5
          - id: energy_trend
            region: trend
            kind: lineChart
            purpose: "How is fleet HVAC energy trending over the selected period?"
            field_bindings:
              Category: Date_Day[Date]
              Y: "AHU Energy (kWh)"
              SecondaryY: "AHU Energy vs Target"
            color_strategy: measure_match
          - id: ship_movers
            region: movers
            kind: barChart
            purpose: "Which ships are furthest from their energy targets this period?"
            field_bindings:
              Category: AHU[Ship AHU]
              Y: "AHU Energy vs Target"
            sort_policy: value_desc
            color_strategy: semantic
            comparison_basis: "Corporate energy target (Targets table)"
          - id: footer_nav
            region: footer
            kind: textbox
            text: "Source: ENERGY_DATABASE · Last refreshed: [Refreshed] · Drill: Ship Ranking → Ship Detail"
            purpose: "Data provenance and drill-through navigation anchors"
        space_audit:
          content_cell_count: 132
          placed_cell_count: 132
          empty_cell_pct: 0
          unplaced_regions: []
          largest_region:
            name: trend
            pct_of_content: 32
          balance_rationale: "KPI strip (18%), energy trend (32%), ship movers (32%), footer (18%) — balanced split between temporal trend and entity ranking; no region dominates without analytical justification"

    # ─────────────────────────────────────────────────────────────────
    - name: "How Each Ship's HVAC Energy Tracks Over Time"
      role: detail
      archetype: Analytical Canvas
      layout_variant: C
      variant_rationale: "The core question is cross-ship comparison along shared energy axes — many entities (ships) plotted against the same metric over time; Small-Multiples-Grid variant C is the direct fit"
      page_background: "#120E2A"
      layout_summary: "Three inline slicers in the header band. Below: a trellis of per-ship energy line charts on a shared Y axis occupies most of the canvas. A full-width ranked bar at the bottom gives absolute current-period values for all ships."
      layout_contract:
        canvas:
          width: 1920
          height: 1080
          margin: 32
          gutter: 24
          snap: 8
        grid:
          columns: 12
          rows: 12
          regions:
            header:  [1,  1,  8,  2]
            filters: [8,  1, 13,  2]
            trellis: [1,  2, 13, 10]
            ranking: [1, 10, 13, 13]
        placements:
          - id: page_title
            region: header
            kind: textbox
            text: "How Each Ship's HVAC Energy Tracks Over Time"
            purpose: "Frame the cross-ship comparison question"
          - id: period_slicer
            region: filters
            kind: slicer
            field_bindings: Date_Day[Date]
            slicer_type: dropdown
            slot: 1
            of: 3
          - id: climate_slicer
            region: filters
            kind: slicer
            field_bindings: "Climate Zone[Zone]"
            slicer_type: dropdown
            slot: 2
            of: 3
          - id: status_slicer
            region: filters
            kind: slicer
            field_bindings: "Ship Status[Ship Status]"
            slicer_type: list
            slot: 3
            of: 3
          - id: ship_trellis
            region: trellis
            kind: smallMultiplesChart
            purpose: "How does each ship's HVAC energy trend over the selected period, on a shared scale?"
            field_bindings:
              SmallMultiple: Ship[Ship Code]
              Category: Date_Day[Date]
              Y: "AHU Energy (kWh)"
            color_strategy: measure_match
            insight_basis: "Shared Y axis mandatory — independent axes would silently distort cross-ship comparison"
          - id: ship_ranking_bar
            region: ranking
            kind: barChart
            purpose: "Which ship consumes the most HVAC energy in the current period?"
            field_bindings:
              Category: Ship[Ship Code]
              Y: "AHU Energy (kWh)"
            sort_policy: value_desc
            color_strategy: gradient
        space_audit:
          content_cell_count: 132
          placed_cell_count: 132
          empty_cell_pct: 0
          unplaced_regions: []
          largest_region:
            name: trellis
            pct_of_content: 73
          balance_rationale: "Trellis dominates (73%) because it IS the analytical tool for this page — cross-ship small multiples on shared Y require generous vertical space per panel. Ranking bar (27%) gives absolute current-period context that the trellis hides by focusing on trend shape"

    # ─────────────────────────────────────────────────────────────────
    - name: "Ships Ranked by Energy vs. Target — Find the Worst Offenders"
      role: detail
      archetype: Comparative Benchmark
      layout_variant: A
      variant_rationale: "4–8 ships to rank and compare on energy-vs-target; side-by-side variant A with headline ranked bar + derived callout + per-ship small multiples fits the entity-count and comparison framing"
      page_background: "#120E2A"
      layout_summary: "Ranked tornado bar (left) shows ships sorted by energy-vs-target delta. Derived callout (right) names the worst offender and its gap-to-target %. Small multiples below give per-ship AC vs target trend on a shared Y. Footer carries methodology note and drill-through to P4."
      layout_contract:
        canvas:
          width: 1920
          height: 1080
          margin: 32
          gutter: 24
          snap: 8
        grid:
          columns: 12
          rows: 12
          regions:
            header:    [1,  1, 10,  2]
            filters:   [10, 1, 13,  2]
            headline:  [1,  2,  8,  6]
            callout:   [8,  2, 13,  6]
            multiples: [1,  6, 13, 12]
            footer:    [1, 12, 13, 13]
        placements:
          - id: page_title
            region: header
            kind: textbox
            text: "Ships Ranked by Energy vs. Target — Find the Worst Offenders"
            purpose: "Direct the manager's attention to the ranking question"
          - id: period_slicer
            region: filters
            kind: slicer
            field_bindings: Date_Day[Date]
            slicer_type: dropdown
          - id: ranked_variance_bar
            region: headline
            kind: barChart
            purpose: "Which ships deviate most from their energy target, and in which direction?"
            field_bindings:
              Category: Ship[Ship Code]
              Y: "AHU Energy vs Target"
            sort_policy: value_desc
            color_strategy: semantic
            comparison_basis: "Corporate energy target (Targets table)"
          - id: worst_offender_callout
            region: callout
            kind: cardVisual
            purpose: "Name the single ship with the largest energy-vs-target gap and quantify the shortfall"
            field_bindings: "AHU Energy vs Target"
            color_strategy: semantic
            callout_value_basis: "Filtered to worst-performing ship via TOPN measure; shows Δ absolute + Δ% vs target — not the same absolute measure plotted in the adjacent ranked bar"
            insight_basis: "Gap-to-target % for the worst offender; drives 'drill to P4' decision"
          - id: ship_small_multiples
            region: multiples
            kind: smallMultiplesChart
            purpose: "Is each ship's energy vs target gap improving, worsening, or stable over the period?"
            field_bindings:
              SmallMultiple: Ship[Ship Code]
              Category: Date_Day[Date]
              Y: "AHU Energy (kWh)"
              ReferenceLine: "AHU Energy vs Target"
            color_strategy: measure_match
            comparison_basis: "Per-ship energy target (Targets table)"
          - id: footer_drill
            region: footer
            kind: textbox
            text: "Methodology: Energy vs Target = AHU Energy (kWh) minus corporate baseline. Drill: select a ship → AHU Sensor Diagnostics"
            purpose: "Methodology transparency and drill-through navigation anchor"
        space_audit:
          content_cell_count: 132
          placed_cell_count: 132
          empty_cell_pct: 0
          unplaced_regions: []
          largest_region:
            name: multiples
            pct_of_content: 45
          balance_rationale: "Small multiples (45%) justify their size because per-ship trend context is the second analytical question; headline bar (26%) and callout (19%) together give the top-line answer; footer (8%) provides methodology transparency and navigation"

    # ─────────────────────────────────────────────────────────────────
    - name: "AHU Sensor Diagnostics: Trace Root Causes of Energy Deviation"
      role: drillthrough
      archetype: Analytical Canvas
      layout_variant: A
      variant_rationale: "5+ slicers required (Ship, AHU, Date, Mode, Climate Zone, Time Zone) — filter-rail variant A is justified at > 50% rail fill; freed content area supports dense sensor multi-chart layout"
      page_background: "#120E2A"
      layout_summary: "Vertical filter rail on the left (5 slicers + reset). Hero area: sensor trend line chart (supply temp, return temp, fan speed over time). Two supporting charts below the hero: scatter (fan speed vs cooling power) and bar (damper/valve positions). Detail matrix at bottom shows raw AHU readings."
      layout_contract:
        canvas:
          width: 1920
          height: 1080
          margin: 32
          gutter: 24
          snap: 8
        grid:
          columns: 12
          rows: 12
          regions:
            header:  [1,  1, 13,  2]
            rail:    [1,  2,  3, 13]
            hero:    [3,  2, 13,  7]
            scatter: [3,  7,  8, 11]
            dampers: [8,  7, 13, 11]
            detail:  [3, 11, 13, 13]
        placements:
          - id: page_title
            region: header
            kind: textbox
            text: "AHU Sensor Diagnostics: Trace Root Causes of Energy Deviation"
            purpose: "Set the engineer/manager's diagnostic framing before they interact"
          - id: ship_slicer
            region: rail
            kind: slicer
            field_bindings: Ship[Ship Code]
            slicer_type: dropdown
            slot: 1
            of: 6
          - id: ahu_slicer
            region: rail
            kind: slicer
            field_bindings: AHU[Ship AHU]
            slicer_type: dropdown
            insight_basis: "High cardinality — search must be enabled"
            slot: 2
            of: 6
          - id: date_range_slicer
            region: rail
            kind: slicer
            field_bindings: Date[DateTime]
            slicer_type: between
            insight_basis: "Engineers need arbitrary date-range exploration at sub-daily grain for incident investigation"
            slot: 3
            of: 6
          - id: mode_slicer
            region: rail
            kind: slicer
            field_bindings: "AHU Mode[Mode]"
            slicer_type: list
            slot: 4
            of: 6
          - id: climate_zone_slicer
            region: rail
            kind: slicer
            field_bindings: "Climate Zone[Zone]"
            slicer_type: dropdown
            slot: 5
            of: 6
          - id: reset_button
            region: rail
            kind: actionButton
            purpose: "Clear all slicers and return to base state"
            slot: 6
            of: 6
          - id: sensor_trend
            region: hero
            kind: lineChart
            purpose: "How do supply temp, return temp, and fan speed co-vary over the selected window — and does the pattern explain energy deviation?"
            field_bindings:
              Category: Date[DateTime]
              Y:
                - "Supply Temp"
                - "Return Temp"
                - "Fan Speed (%)"
            color_strategy: measure_match
          - id: speed_vs_cooling_scatter
            region: scatter
            kind: scatterChart
            purpose: "Is there an expected relationship between fan speed and cooling power, or is an AHU working harder than it should?"
            field_bindings:
              X: "Fan Speed (%)"
              Y: "Cooling Power (kW)"
              Legend: AHU[Ship AHU]
            color_strategy: unique
            insight_basis: "Outlier points above the expected band indicate inefficient AHU operation"
          - id: damper_valve_bar
            region: dampers
            kind: barChart
            purpose: "What are the current damper and valve positions — are any stuck open or closed?"
            field_bindings:
              Category: AHU[Ship AHU]
              Y:
                - "Inlet Damper"
                - "Outlet Damper"
                - "Chill Valve Position"
            sort_policy: category_asc
            color_strategy: unique
          - id: ahu_detail_matrix
            region: detail
            kind: tableEx
            purpose: "What are the raw sensor readings per AHU row for precise investigation?"
            field_bindings:
              - Date[DateTime]
              - AHU[Ship AHU]
              - "Supply Temp"
              - "Return Temp"
              - "Fan Speed (%)"
              - "Cooling Power (kW)"
              - "Chill Valve Position"
              - "CO₂ (ppm)"
        space_audit:
          content_cell_count: 132
          placed_cell_count: 132
          empty_cell_pct: 0
          unplaced_regions: []
          largest_region:
            name: hero
            pct_of_content: 38
          balance_rationale: "Hero sensor trend (38%) dominates because temporal pattern is the primary diagnostic tool; filter rail (17%) is justified by 5+ slicers at well above 50% fill; scatter + damper bar (30%) provide two independent supporting dimensions; detail matrix (15%) gives raw-record precision for incident investigation"

  interaction_pattern:
    drill_targets:
      - "Ships Ranked by Energy vs. Target — Find the Worst Offenders"
      - "AHU Sensor Diagnostics: Trace Root Causes of Energy Deviation"
    cross_filter_rules:
      - "Within each page: all visuals cross-filter by default"
      - "ship_movers (P1) → drill-through actionButton → P3"
      - "ship_small_multiples (P3) → drill-through actionButton → P4 with Ship pre-filtered"
      - "Date slicer sync group: P1, P2, P3 share the same date filter group"
      - "P4 date slicer is independent (full between range for incident investigation)"

  accessibility:
    alt_text_strategy: "Each chart alt text follows: [chart type] showing [measure] by [dimension] — [one-sentence finding or trend direction]"
    contrast_notes: "Dark navy surface (#120E2A) requires white or near-white (#F8FAFC) text at all label sizes; cyan (#8CEEEE) on dark navy passes AA at 14pt+; amber (#F59E0B) on dark navy passes AA; verify green (#10B981) accent bars against dark card backgrounds at 11pt before shipping"

  theme:
    base: "assets/base.json adapted — preserve textbox zero padding/background/border overrides, cardVisual zero padding/card spacing, table grow-to-fit, hidden visual headers; adapt dataColors to Industrial Cockpit palette"
    user_overrides: "Do not replace base.json per-type safeguards with a wildcard visualStyles[*][*].padding override; apply page background via page.json objects.background.color #120E2A"
```

---

## Implementation notes

- **Model changes:** No new measures required before first build. Verify `AHU Aggregate Power vs Target` resolves at Ship grain; if not, create a ship-level CALCULATE wrapper via MCP before P3 build.
- **PBIR/report authoring:** Scaffold 4-page PBIP structure; apply dark theme before authoring any visuals (background contrast affects visual header visibility). Start with P1 (Executive), validate in Desktop, then proceed page by page.
- **Validation:** Each page must open in Desktop with expected visual counts; JSON must parse; `definition.pbir` must reference the HVAC EMS WIP semantic model.
- **Desktop screenshot verification:** Screenshot P1 after KPI strip is authored to verify accent bar conditional formatting renders on dark surface before building remaining pages.
- **Publishing boundary:** Local PBIP only. Do not publish to Fabric without separate approval.
- **Risks:**
  - HIGH-CARDINALITY AHU slicer on P4 must have search enabled or it will be unusable
  - LOCAL TIME inactive relationship — Time Zone calc group must be applied explicitly when using local time; default to UTC Date[DateTime]
  - Dark theme + white visual containers: verify cardVisual backgrounds don't default to white and blow out contrast against dark page surface
  - `smallMultiplesChart` shared Y axis must be explicitly set; Power BI defaults to independent axes which silently distorts cross-ship comparison

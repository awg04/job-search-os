# Live Job Search Dashboard

**URL:** https://claude.ai/code/artifact/b53fe111-ff7d-459e-898d-90190ebc6fc0 (private artifact — bookmark it)

A one-screen status board built from the daily morning briefing routine: week counter, pipeline KPIs, top 3 roles with fit scores, today's bottleneck + priority stack, and a data-health panel.

## How it stays up to date

A scheduled task (`job-search-dashboard-refresh`) runs **weekdays at ~7:45 AM** and:

1. Reads the newest `briefings/*.md` plus the context-library trackers.
2. If no fresh briefing exists, runs a condensed role re-scan of the top 8–10 target companies (never fabricates listings — unverifiable companies are flagged instead).
3. Updates the data in `dashboard/dashboard.html` (design stays fixed) and redeploys the artifact to the same URL.

Note: scheduled tasks run while the Claude app is open; if it was closed at 7:45, the refresh runs on next launch.

## Making the dashboard more accurate

The dashboard is only as good as the trackers:

- **`app-tracker.md` is missing** — run `/app-tracker add` after each application so pipeline counts are real.
- **`connection-tracker.md` is empty** — import your LinkedIn connections CSV or log requests as you send them.
- Run the full 3-part morning briefing (see `cowork-tasks/`) whenever you want deep output; the dashboard will pick up the newest briefing automatically the next morning.

## Files

- `dashboard.html` — the page itself (source of truth for the artifact)
- Task definition: `C:\Users\agr9010\.claude\scheduled-tasks\job-search-dashboard-refresh\SKILL.md`

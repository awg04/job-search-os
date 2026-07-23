# Reads context-library/dashboard-state.json and injects RUN_STATE + ARCHIVED into both
# dashboards. Run after editing the state file by hand, or it's called automatically by
# Record-DashboardRun.ps1 / Archive-Opportunity.ps1.
. "$PSScriptRoot\dashboard-state-lib.ps1"
Invoke-SyncDashboards

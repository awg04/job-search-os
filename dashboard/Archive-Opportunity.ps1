# Archives (or unarchives) one opportunity so it drops out of both dashboards, then
# re-syncs. Scan skills read dashboard-state.json's "archived" and won't re-add these.
# Called by the /archive skill and by the dashboards' Archive button (via
# archive-uri-handler.ps1).
#   .\Archive-Opportunity.ps1 -Ref 19f8091b2c1ef05f
#   .\Archive-Opportunity.ps1 -Ref 19f8091b2c1ef05f -Unarchive
#
# -Kind skipped writes to the "skipped" map instead: the dashboards' Skip disposition,
# persisted so the widgets hide the same cards the dashboard does. Skip is softer than
# archive - scans may still re-surface a skipped role - so the two are kept separate.
#   .\Archive-Opportunity.ps1 -Ref 19f8091b2c1ef05f -Kind skipped
param(
  [Parameter(Mandatory=$true)][string]$Ref,
  [switch]$Unarchive,
  [ValidateSet('archived','skipped')][string]$Kind = 'archived',
  [string]$Date = (Get-Date -Format 'yyyy-MM-dd')
)
. "$PSScriptRoot\dashboard-state-lib.ps1"
$state = Get-DashboardState
$verb  = if ($Kind -eq 'skipped') { 'skipped' } else { 'archived' }
if ($Unarchive) {
  if ($state[$Kind].ContainsKey($Ref)) {
    $state[$Kind].Remove($Ref)
    Write-Host "un$($verb): $Ref"
  } else {
    # Job-hunt refs are per-posting urls, but entries written before 2026-07-23 could be
    # keyed by the card's Gmail threadId - the caller should retry with that if this hits.
    Write-Host "un$($verb): $Ref was not in the '$Kind' map - nothing removed (legacy job-hunt entries may be keyed by the card's threadId)"
  }
} else {
  $state[$Kind][$Ref] = $Date
  Write-Host "$($verb): $Ref ($Date)"
}
Save-DashboardState $state
Invoke-SyncDashboards

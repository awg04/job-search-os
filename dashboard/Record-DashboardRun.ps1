# Records that a command ran for one opportunity, then re-syncs the dashboards so the
# button shows its green check. Called by the next-steps / recruiter-action / job-fit-inbox
# skills on completion.
#   .\Record-DashboardRun.ps1 -Ref 19f8064120818784 -Command recruiter-action
#   .\Record-DashboardRun.ps1 -Ref "https://www.linkedin.com/messaging/thread/2-abc.../" -Command job-fit-inbox
param(
  [Parameter(Mandatory=$true)][string]$Ref,
  [Parameter(Mandatory=$true)][ValidateSet('recruiter-action','next-steps','job-fit-inbox')][string]$Command,
  [string]$Date = (Get-Date -Format 'yyyy-MM-ddTHH:mm:ss')
)
. "$PSScriptRoot\dashboard-state-lib.ps1"
$state = Get-DashboardState
if (-not $state['runs'].ContainsKey($Ref) -or $state['runs'][$Ref] -isnot [hashtable]) { $state['runs'][$Ref] = @{} }
$state['runs'][$Ref][$Command] = $Date
Save-DashboardState $state
Invoke-SyncDashboards
Write-Host "recorded: $Command for $Ref ($Date)"

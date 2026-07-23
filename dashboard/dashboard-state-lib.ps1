# Shared helpers for dashboard run-state (green checkmarks) + archived opportunities.
# Source of truth: context-library/dashboard-state.json. Injected into both dashboards
# between the // DASH_STATE_START ... // DASH_STATE_END markers (the browser can't read
# the JSON at runtime). Dot-sourced by Sync-Dashboards.ps1 / Record-DashboardRun.ps1 /
# Archive-Opportunity.ps1.

$script:Root       = Split-Path -Parent $PSScriptRoot   # job-search-os/
$script:StateFile  = Join-Path $script:Root 'context-library\dashboard-state.json'
# 2026-07-22: recruiter-inbox.html was folded into job-hunt.html (Recruiter Inbox tab),
# so there is now a single dashboard file carrying one DASH_STATE block.
$script:JobHunt    = Join-Path $PSScriptRoot 'job-hunt.html'
$script:Pattern    = '(//\s*DASH_STATE_START[^\r\n]*)(\r?\n.*?)(\r?\n[ \t]*//\s*DASH_STATE_END)'

function ConvertTo-HashtableRecursive($obj) {
  if ($null -eq $obj) { return $null }
  if ($obj -is [System.Management.Automation.PSCustomObject]) {
    $h = @{}
    foreach ($p in $obj.PSObject.Properties) { $h[$p.Name] = ConvertTo-HashtableRecursive $p.Value }
    return $h
  }
  if ($obj -is [System.Collections.IEnumerable] -and $obj -isnot [string]) {
    return @($obj | ForEach-Object { ConvertTo-HashtableRecursive $_ })
  }
  return $obj
}

function Get-DashboardState {
  if (-not (Test-Path $script:StateFile)) {
    return @{ '_comment' = ''; 'runs' = @{}; 'archived' = @{}; 'skipped' = @{} }
  }
  $raw = Get-Content $script:StateFile -Raw | ConvertFrom-Json
  $state = ConvertTo-HashtableRecursive $raw
  if (-not $state.ContainsKey('runs') -or $null -eq $state['runs'])         { $state['runs'] = @{} }
  if (-not $state.ContainsKey('archived') -or $null -eq $state['archived']) { $state['archived'] = @{} }
  if (-not $state.ContainsKey('skipped') -or $null -eq $state['skipped'])   { $state['skipped'] = @{} }
  return $state
}

function Save-DashboardState($state) {
  ($state | ConvertTo-Json -Depth 8) |
    ForEach-Object { [System.IO.File]::WriteAllText($script:StateFile, $_, (New-Object System.Text.UTF8Encoding($false))) }
}

function ConvertTo-JsonObjectLiteral($ht) {
  if ($null -eq $ht -or $ht.Count -eq 0) { return '{}' }
  return ($ht | ConvertTo-Json -Compress -Depth 6)
}

function Invoke-SyncDashboards {
  $state    = Get-DashboardState
  $runsJson = ConvertTo-JsonObjectLiteral $state['runs']
  $archJson = ConvertTo-JsonObjectLiteral $state['archived']
  $skipJson = ConvertTo-JsonObjectLiteral $state['skipped']
  $enc = New-Object System.Text.UTF8Encoding($false)
  foreach ($f in @($script:JobHunt)) {
    if (-not (Test-Path $f)) { Write-Warning "missing: $f"; continue }
    $content = [System.IO.File]::ReadAllText($f)
    $evaluator = {
      param($m)
      $m.Groups[1].Value + "`r`n  const RUN_STATE = $runsJson;`r`n  const ARCHIVED = $archJson;`r`n  const SKIPPED = $skipJson;" + $m.Groups[3].Value
    }
    $new = [regex]::Replace($content, $script:Pattern, $evaluator, [System.Text.RegularExpressions.RegexOptions]::Singleline)
    if ($new -eq $content) {
      if ($content -notmatch 'DASH_STATE_START') { Write-Warning "markers not found in $([System.IO.Path]::GetFileName($f)) - add the DASH_STATE block" }
      else { Write-Host "no change: $([System.IO.Path]::GetFileName($f))" }
    } else {
      [System.IO.File]::WriteAllText($f, $new, $enc)
      Write-Host "synced: $([System.IO.Path]::GetFileName($f))"
    }
  }
}

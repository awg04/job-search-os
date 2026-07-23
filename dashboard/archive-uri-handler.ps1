# Handles a jobhunt-archive:// URI fired by a dashboard button.
# Invoked (hidden) by archive-launch.vbs.
#
#   jobhunt-archive://archive/<b64url-ref>      hide it everywhere; scans won't re-add it
#   jobhunt-archive://unarchive/<b64url-ref>    bring it back
#   jobhunt-archive://skip/<b64url-ref>         dashboard "Skip" disposition, persisted
#   jobhunt-archive://unskip/<b64url-ref>       cleared the Skip disposition
#   jobhunt-archive://import/<b64url-json>      bulk merge of browser-local state:
#                                               {"archived":[ref,...],"skipped":[ref,...]}
#
# Refs (Gmail thread id / LinkedIn URL / posting URL) and the import payload are
# base64url-encoded so no browser or OS re-encoding can mangle them. All actions land in
# dashboard-state.json and re-sync both dashboards; the widgets pick it up on their next
# refresh, which is what keeps widget counts equal to dashboard counts.
param([Parameter(Mandatory=$true)][string]$Uri)

$log = Join-Path $PSScriptRoot 'archive-uri-handler.log'

function Decode-B64Url([string]$tok) {
  $b64 = $tok.Replace('-','+').Replace('_','/')
  switch ($b64.Length % 4) { 2 { $b64 += '==' } 3 { $b64 += '=' } }
  return [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($b64))
}

try {
  $s = $Uri -replace '^[A-Za-z0-9\-]+://',''      # strip scheme
  $s = $s.Trim().Trim('/')
  $parts = $s -split '/', 2
  $action = $parts[0].ToLower()
  $tok = if ($parts.Count -gt 1) { $parts[1] } else { '' }
  if (-not $tok) { throw "no payload token in URI: $Uri" }

  $archiveScript = Join-Path $PSScriptRoot 'Archive-Opportunity.ps1'

  if ($action -eq 'import') {
    # Bulk merge. One state write + one dashboard re-sync for the whole payload, so this
    # stays fast even with a big backlog (and doesn't need N protocol launches).
    . "$PSScriptRoot\dashboard-state-lib.ps1"
    $payload = Decode-B64Url $tok | ConvertFrom-Json
    $state = Get-DashboardState
    $today = Get-Date -Format 'yyyy-MM-dd'
    $added = @{ archived = 0; skipped = 0 }
    foreach ($kind in 'archived','skipped') {
      foreach ($ref in @($payload.$kind)) {
        if ([string]::IsNullOrWhiteSpace($ref)) { continue }
        if (-not $state[$kind].ContainsKey($ref)) { $state[$kind][$ref] = $today; $added[$kind]++ }
      }
    }
    Save-DashboardState $state
    Invoke-SyncDashboards | Out-Null
    "$(Get-Date -Format o)  OK  import  +$($added.archived) archived, +$($added.skipped) skipped" |
      Out-File -FilePath $log -Append -Encoding utf8
  }
  else {
    $ref = Decode-B64Url $tok
    if (-not $ref) { throw "empty ref after decode: $Uri" }
    switch ($action) {
      'unarchive' { & $archiveScript -Ref $ref -Unarchive }
      'skip'      { & $archiveScript -Ref $ref -Kind skipped }
      'unskip'    { & $archiveScript -Ref $ref -Kind skipped -Unarchive }
      default     { & $archiveScript -Ref $ref }
    }
    "$(Get-Date -Format o)  OK  $action  $ref" | Out-File -FilePath $log -Append -Encoding utf8
  }
}
catch {
  "$(Get-Date -Format o)  ERROR  $($_.Exception.Message)  URI=$Uri" | Out-File -FilePath $log -Append -Encoding utf8
}

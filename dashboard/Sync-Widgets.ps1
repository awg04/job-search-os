# ============================================================
#  Sync-Widgets.ps1
#  Single source of truth for "dashboard HTML -> Zebar widget JSON".
#
#  Regenerates the Zebar widget data files from whatever the dashboards
#  currently say:
#    dashboard/job-hunt.html        (ALERT_DATA) -> ~/.glzr/zebar/job-hunt/jobs.json
#    dashboard/recruiter-inbox.html (DATA)       -> ~/.glzr/zebar/recruiter-inbox/recruiters.json
#
#  It is cheap (no Gmail, no model, ~1s) and is what the widgets' refresh
#  icon runs. The full model-driven scans (/job-hunt-scan, /recruiter-scan)
#  still call it as their final step, via the legacy Update-*Data.ps1 shims.
#
#  What it does beyond a dumb copy:
#   - re-injects RUN_STATE/ARCHIVED into both dashboards first, so it reads
#     the current archive state (dashboard/Sync-Dashboards.ps1 logic)
#   - drops archived opportunities, so the widget KPIs match the dashboard's
#     (the dashboards count live cards only)
#   - preserves the real last-scan stamp instead of stamping "now" on every
#     refresh; adds a separate `synced` stamp for this run
#
#  Usage:
#    powershell -ExecutionPolicy Bypass -File Sync-Widgets.ps1 [-Target job-hunt|recruiter|both]
# ============================================================

[CmdletBinding()]
param(
  [ValidateSet('job-hunt', 'recruiter', 'both')]
  [string]$Target = 'both',
  # Skip the RUN_STATE/ARCHIVED re-injection (callers that just did it themselves).
  [switch]$NoStateSync
)

$ErrorActionPreference = 'Stop'

$Root         = Split-Path -Parent $PSScriptRoot           # job-search-os/
$JobHuntHtml  = Join-Path $PSScriptRoot 'job-hunt.html'
# 2026-07-22: recruiter-inbox.html was folded into job-hunt.html (Recruiter Inbox tab).
# Both the ALERT_DATA and DATA arrays (and the scandate span) now live in the same file.
$RecruiterHtml= Join-Path $PSScriptRoot 'job-hunt.html'
# Widget packs: the consolidated job-search widget (tabbed) plus the two legacy
# single-purpose packs. Each JSON is written to every pack dir that exists, so whichever
# widget is enabled stays fed and the old packs can be deleted whenever.
$JobHuntPacks   = @('job-search','job-hunt')        | ForEach-Object { Join-Path $env:USERPROFILE ".glzr\zebar\$_" } | Where-Object { Test-Path $_ }
$RecruiterPacks = @('job-search','recruiter-inbox') | ForEach-Object { Join-Path $env:USERPROFILE ".glzr\zebar\$_" } | Where-Object { Test-Path $_ }
$JobHuntPack  = Join-Path $env:USERPROFILE '.glzr\zebar\job-hunt'
$RecruiterPack= Join-Path $env:USERPROFILE '.glzr\zebar\recruiter-inbox'
$Ascii        = New-Object System.Text.UTF8Encoding($false)

. (Join-Path $PSScriptRoot 'dashboard-state-lib.ps1')

# A dashboard can only hide a card in its own browser's localStorage; it can't write to
# disk. Its "Sync N to disk" chip therefore downloads a tiny handoff file, which we pick
# up here and merge. Chrome downloads always work - unlike the jobhunt-archive:// path,
# which needs a registered protocol AND the user to accept Chrome's launch prompt.
# The file is consumed (deleted) once merged, so this is a no-op on every other run.
function Import-DownloadedState {
  $dl = Join-Path $env:USERPROFILE 'Downloads'
  if (-not (Test-Path $dl)) { return }
  $files = @(Get-ChildItem -Path $dl -Filter 'job-search-os-state*.json' -File -ErrorAction SilentlyContinue)
  if (-not $files) { return }

  $state = Get-DashboardState
  $today = Get-Date -Format 'yyyy-MM-dd'
  # archived/skipped add; unarchived/unskipped remove - so Unarchive and clearing a Skip
  # travel through the same handoff as the hides.
  $map = @{ archived = 'archived'; skipped = 'skipped'; unarchived = 'archived'; unskipped = 'skipped' }
  $tally = @{ archived = 0; skipped = 0; unarchived = 0; unskipped = 0 }
  foreach ($f in $files) {
    try {
      $payload = Get-Content -Raw -Encoding UTF8 $f.FullName | ConvertFrom-Json
    } catch {
      Write-Host "handoff: $($f.Name) isn't valid JSON - left in place"
      continue
    }
    foreach ($field in 'archived','skipped','unarchived','unskipped') {
      $kind = $map[$field]
      $remove = $field.StartsWith('un')
      # Only plain strings, and a sane cap - this file came from a browser download folder.
      $refs = @($payload.$field) | Where-Object { $_ -is [string] -and $_.Trim() } | Select-Object -First 500
      foreach ($ref in $refs) {
        if ($remove) {
          if ($state[$kind].ContainsKey($ref)) { $state[$kind].Remove($ref); $tally[$field]++ }
        } elseif (-not $state[$kind].ContainsKey($ref)) {
          $state[$kind][$ref] = $today; $tally[$field]++
        }
      }
    }
    Remove-Item $f.FullName -Force -ErrorAction SilentlyContinue
  }
  Save-DashboardState $state
  Write-Host ("handoff: merged $($files.Count) file(s) - +{0} archived, +{1} skipped, -{2} unarchived, -{3} unskipped" -f `
    $tally.archived, $tally.skipped, $tally.unarchived, $tally.unskipped)
}


# ---------- helpers ----------

# Transliterate common non-ASCII to ASCII. Keeps the widget JSON pure-ASCII,
# same convention the Rainmeter-era data files used - immune to editors and
# linters that would re-encode high bytes into mojibake.
function ToAscii([string]$s) {
  if ($null -eq $s) { return '' }
  $s = $s -replace ([char]0x00B7), ' / '   # middle dot
  $s = $s -replace ([char]0x2013), '-'     # en dash
  $s = $s -replace ([char]0x2014), '-'     # em dash
  $s = $s -replace ([char]0x2018), "'"     # curly quotes
  $s = $s -replace ([char]0x2019), "'"
  $s = $s -replace ([char]0x201C), '"'
  $s = $s -replace ([char]0x201D), '"'
  $s = $s -replace ([char]0x2026), '...'   # ellipsis
  $sb = New-Object System.Text.StringBuilder
  foreach ($c in $s.ToCharArray()) { if ([int]$c -ge 32 -and [int]$c -lt 127) { [void]$sb.Append($c) } }
  return $sb.ToString().Trim()
}

# JSON-style quoted keys:  "key": "value"
function JsonField([string]$src, [string]$key) {
  $m = [regex]::Match($src, '"' + $key + '"\s*:\s*"((?:[^"\\]|\\.)*)"')
  if ($m.Success) { return $m.Groups[1].Value -replace '\\/', '/' -replace '\\"', '"' }
  return ''
}
# JS-object bare keys:  key:"value"
function JsField([string]$src, [string]$key) {
  $m = [regex]::Match($src, '(?<![\w"])' + $key + ':"((?:[^"\\]|\\.)*)"')
  if ($m.Success) { return $m.Groups[1].Value -replace '\\"', '"' }
  return ''
}
function IntField([string]$src, [string]$pattern) {
  $m = [regex]::Match($src, $pattern)
  if ($m.Success) { return [int]$m.Groups[1].Value }
  return 0
}
function ArrayObjects([string]$html, [string]$constName) {
  $m = [regex]::Match($html, 'const\s+' + $constName + '\s*=\s*\[(.*?)\];', 'Singleline')
  if (-not $m.Success) { throw "Could not locate the $constName array." }
  return [regex]::Matches($m.Groups[1].Value, '\{.*?\}(?=\s*,\s*(?:\{|$)|\s*$)', 'Singleline')
}

# Every ref the dashboards hide: archived + Skip-dispositioned. Straight from the state
# file, so the widget's live count equals the dashboard's live count. Anything a browser
# has only in localStorage is invisible here - that's what the dashboards' "Sync N to
# disk" chip is for.
function HiddenRefs {
  $state = Get-DashboardState
  $set = New-Object System.Collections.Generic.HashSet[string]
  foreach ($kind in 'archived','skipped') {
    if ($state[$kind]) { foreach ($k in $state[$kind].Keys) { [void]$set.Add([string]$k) } }
  }
  return $set
}

# Keep the real last-scan stamp. The dashboards record a scan DATE; the widget
# shows date + time. If the dashboard's scan date still matches the stamp already
# in a widget JSON, that stamp is the true scan time - keep it. If the dashboard
# is newer, a scan just ran and we're its final step, so stamp now.
function ScanStamp([string]$scanDate, [string[]]$packDirs, [string]$fileName) {
  if ([string]::IsNullOrWhiteSpace($scanDate)) { return '' }
  foreach ($dir in $packDirs) {
    $jsonPath = Join-Path $dir $fileName
    if (Test-Path $jsonPath) {
      try {
        $prev = (Get-Content -Raw -Encoding UTF8 $jsonPath | ConvertFrom-Json).updated
        if ($prev -and $prev.StartsWith($scanDate)) { return $prev }
      } catch { }
    }
  }
  return (Get-Date -Format 'yyyy-MM-dd h:mm tt')
}

function WritePayload([string[]]$packDirs, $fileName, $updated, $rows) {
  $payload = [ordered]@{
    updated     = ToAscii $updated
    synced      = Get-Date -Format 'h:mm tt'
    generatedAt = (Get-Date).ToString('o')
    items       = @($rows.ToArray())
  }
  $json = $payload | ConvertTo-Json -Depth 4
  foreach ($dir in $packDirs) {
    [System.IO.File]::WriteAllText((Join-Path $dir $fileName), $json, $Ascii)
  }
}

# ---------- job hunt ----------

function Sync-JobHunt {
  if (-not (Test-Path $JobHuntHtml)) { throw "Dashboard HTML not found: $JobHuntHtml" }
  if (-not $JobHuntPacks) { Write-Host 'job-hunt: no Zebar pack folder present - skipped'; return }

  $html     = Get-Content -Raw -Encoding UTF8 $JobHuntHtml
  $hidden   = HiddenRefs

  $scanDate = ''
  $um = [regex]::Match($html, 'const\s+ALERT_UPDATED\s*=\s*"([^"]*)"')
  if ($um.Success) { $scanDate = $um.Groups[1].Value }

  $rows = New-Object System.Collections.Generic.List[object]
  $skipped = 0
  foreach ($o in (ArrayObjects $html 'ALERT_DATA')) {
    $s     = $o.Value
    $url   = JsonField $s 'url'
    $gmail = JsonField $s 'threadId'
    $ref   = if ($gmail) { $gmail } else { $url }        # dashboard's refOf()
    if ($ref -and $hidden.Contains($ref)) { $skipped++; continue }

    $rows.Add([pscustomobject][ordered]@{
      title   = ToAscii (JsonField $s 'title')
      company = ToAscii (JsonField $s 'company')
      source  = ToAscii (JsonField $s 'source')
      date    = ToAscii (JsonField $s 'date')
      score   = IntField $s '"score"\s*:\s*(\d+)'
      tier    = ToAscii (JsonField $s 'tier')
      url     = ToAscii $url
      gmail   = ToAscii $gmail
      note    = ToAscii (JsonField $s 'note')
    })
  }

  WritePayload $JobHuntPacks 'jobs.json' (ScanStamp $scanDate $JobHuntPacks 'jobs.json') $rows
  Write-Host "job-hunt: wrote $($rows.Count) prospects to jobs.json in $($JobHuntPacks.Count) pack(s) ($skipped hidden: archived or skipped)"
}

# ---------- recruiter inbox ----------

function Sync-Recruiter {
  if (-not (Test-Path $RecruiterHtml)) { throw "Dashboard HTML not found: $RecruiterHtml" }
  if (-not $RecruiterPacks) { Write-Host 'recruiter-inbox: no Zebar pack folder present - skipped'; return }

  $html     = Get-Content -Raw -Encoding UTF8 $RecruiterHtml
  $hidden   = HiddenRefs

  $scanDate = ''
  $sm = [regex]::Match($html, 'id="scandate"[^>]*>([^<]*)<')
  if ($sm.Success) { $scanDate = $sm.Groups[1].Value.Trim() }

  $rows = New-Object System.Collections.Generic.List[object]
  $skipped = 0
  foreach ($o in (ArrayObjects $html 'DATA')) {
    $s      = $o.Value
    $id     = JsField $s 'id'
    $source = JsField $s 'source'          # 'linkedin', or empty for Gmail
    # dashboard's cardRefOf()
    $ref    = if ($source -eq 'linkedin') { "https://www.linkedin.com/messaging/thread/$id/" } else { $id }
    # Skip-dispositioned recruiter cards are keyed by raw id, LinkedIn or not.
    if (($ref -and $hidden.Contains($ref)) -or $hidden.Contains($id)) { $skipped++; continue }

    $client = JsField $s 'client'
    if ($client -eq 'undisclosed') { $client = '' }

    $remote = ''
    $rm = [regex]::Match($s, 'remote:\{t:"((?:[^"\\]|\\.)*)",k:"([^"]*)"\}')
    if ($rm.Success) { $remote = $rm.Groups[1].Value }

    # tags: first label of each ["label","kind"] pair, up to 3
    $tags = New-Object System.Collections.Generic.List[string]
    $tb = [regex]::Match($s, 'tags:\[(.*?)\]\s*,\s*flag', 'Singleline')
    if (-not $tb.Success) { $tb = [regex]::Match($s, 'tags:\[(.*?)\]', 'Singleline') }
    if ($tb.Success) {
      foreach ($t in [regex]::Matches($tb.Groups[1].Value, '\["((?:[^"\\]|\\.)*)"')) {
        if ($tags.Count -lt 3) { $tags.Add((ToAscii $t.Groups[1].Value)) }
      }
    }

    $rows.Add([pscustomobject][ordered]@{
      id        = ToAscii $id
      score     = IntField $s 'score:(\d+)'
      tier      = ToAscii (JsField $s 'tier')
      role      = ToAscii (JsField $s 'role')
      recruiter = ToAscii (JsField $s 'recruiter')
      firm      = ToAscii (JsField $s 'firm')
      client    = ToAscii $client
      remote    = ToAscii $remote
      comp      = ToAscii (JsField $s 'comp')
      source    = ToAscii $source
      date      = ToAscii (JsField $s 'date')
      tags      = @($tags.ToArray())
    })
  }

  WritePayload $RecruiterPacks 'recruiters.json' (ScanStamp $scanDate $RecruiterPacks 'recruiters.json') $rows
  Write-Host "recruiter-inbox: wrote $($rows.Count) roles to recruiters.json in $($RecruiterPacks.Count) pack(s) ($skipped hidden: archived or skipped)"
}

# ---------- run ----------

# Both widgets run this on their own timer, and they share dashboard-state.json and the
# two dashboard HTML files. Serialize so a write never lands under another run's read.
# Waiting is cheap (a full sync is ~1s); if the wait times out, the other run has just
# done the same work anyway, so skipping is correct rather than a failure.
$mutex = New-Object System.Threading.Mutex($false, 'Global\JobSearchOS-SyncWidgets')
$held = $false
try {
  try { $held = $mutex.WaitOne(30000) }
  catch [System.Threading.AbandonedMutexException] { $held = $true }   # prior run died holding it
  if (-not $held) { Write-Host 'another sync is running - skipped'; return }

  Import-DownloadedState

  # Re-inject the current run-state/archive/skip state into both dashboards so what we
  # parse below is current even if the state file changed since the last sync.
  if (-not $NoStateSync) { Invoke-SyncDashboards | Out-Null }

  if ($Target -eq 'job-hunt'  -or $Target -eq 'both') { Sync-JobHunt }
  if ($Target -eq 'recruiter' -or $Target -eq 'both') { Sync-Recruiter }
}
finally {
  if ($held) { $mutex.ReleaseMutex() }
  $mutex.Dispose()
}

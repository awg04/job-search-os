# Handles a jobhunt-cmd:// URI. Invoked (hidden) by cmd-launch.vbs for a protocol click, and by
# Start-JobHuntListener.ps1 for a dashboard button - Chrome here silently refuses to launch the
# protocol, so the buttons go over loopback instead and both routes land on this same script.
# URI: jobhunt-cmd://<next-steps|recruiter-action|job-fit-inbox>/<base64url-ref>
#
# Each command starts a MINIMIZED INTERACTIVE Claude session in the repo dir - not a headless
# `claude -p` run. Remote Control only attaches to interactive sessions (`--remote-control` is
# documented as "Start an interactive session..."), and settings.json has remoteControlAtStartup,
# so an interactive session shows up in the Claude sidebar where it can be watched and steered
# mid-run. A -p run has no interactive loop to attach to and never appears there. Minimized gets
# the window out of the way, which was the actual goal - "headless" was the means, not the end.
#
# The window uses powershell.exe (conhost) rather than Windows Terminal on purpose: wt.exe ignores
# STARTUPINFO's minimize request and would pop open in front of you.
param(
  [Parameter(Mandatory=$true)][string]$Uri,
  [string]$Label,  # human name for the sidebar, e.g. "Humana - Senior BI Engineer"
  [string]$Group   # prefixed to the name so these cluster together, e.g. "WIP"
)

$dash   = $PSScriptRoot
$repo   = Split-Path -Parent $dash
$claude = "C:\Users\andre\AppData\Roaming\npm\node_modules\@anthropic-ai\claude-code\bin\claude.exe"
$log    = Join-Path $dash 'cmd-uri-handler.log'
function Log($m) { "$(Get-Date -Format o)  $m" | Out-File -FilePath $log -Append -Encoding utf8 }

# Tracking the skills do not all do on their own. Kept short: an interactive session has a chat to
# report into, so it needs instructions, not the full headless briefing this file used to carry.
$TRACKING = @'

Do this automatically, never prompt: append one dated timeline line to context-library/opportunity-threads/<firm-slug>_<role-slug>.md (create it with a short header - opportunity name, ref, firm, role, remote, comp - if absent; use the SAME firm-slug_role-slug as the application folder so every skill for this opportunity threads into ONE file), and update context-library/app-tracker.md per /app-tracker conventions where the skill calls for it. Never overwrite my own notes.
'@

try {
  $s = $Uri -replace '^[A-Za-z0-9\-]+://',''
  $s = $s.Trim().Trim('/')
  $parts = $s -split '/', 2
  $cmd = $parts[0].ToLower()
  $tok = if ($parts.Count -gt 1) { $parts[1] } else { '' }
  if (-not $tok) { throw "no ref token in URI: $Uri" }
  $b64 = $tok.Replace('-','+').Replace('_','/')
  switch ($b64.Length % 4) { 2 { $b64 += '==' } 3 { $b64 += '=' } }
  $ref = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($b64))
  if (-not $ref) { throw "empty ref after decode: $Uri" }
  if (@('next-steps','recruiter-action','job-fit-inbox') -notcontains $cmd) { throw "unknown command: $cmd" }
  Log "START  $cmd  $ref"

  $prompt = "/$cmd $ref" + $TRACKING

  # Sidebar name. Without one, every session reads as the same hostname-N and the list is useless.
  # -Group is a NAME PREFIX, not a real group: the CLI carries sessionGroupingName internally but
  # exposes no flag for it (only --remote-control [name] and --remote-control-session-name-prefix),
  # so "[WIP]" up front is what makes these sort and read together in the sidebar. If a real flag
  # ever ships, swap it in here and the dashboards need no change - they already send the group.
  $name = if ($Label) { "$Label ($cmd)" } else { "$cmd $ref" }
  if ($Group) { $name = "[$Group] $name" }
  # ASCII only. An em dash in a card title came out of the sidebar as "a EUR" mojibake - the name
  # crosses a command line and a script file on the way to claude, and 5.1 does not keep UTF-8
  # intact across that. Typographic characters get folded to their plain equivalents, anything
  # else non-ASCII is dropped, so the name that shows up is the name we meant.
  $name = $name -replace '[‐-―]','-' -replace '[‘’]',"'" -replace '[“”]','' -replace '…','...'
  $name = -join ($name.ToCharArray() | ForEach-Object { if ([int]$_ -ge 32 -and [int]$_ -lt 127) { $_ } else { ' ' } })
  $name = ($name -replace '\s+',' ').Trim()
  if ($name.Length -gt 70) { $name = $name.Substring(0,67) + '...' }

  # The ref is a posting URL or thread id and the label is free text, so neither goes on a command
  # line: the launcher script carries them, with single quotes doubled.
  $launcher = Join-Path $env:TEMP ("jobhunt-run-" + [Guid]::NewGuid().ToString('N') + ".ps1")
  $body = @(
    "Set-Location -LiteralPath '$($repo.Replace("'","''"))'",
    "& '$($claude.Replace("'","''"))' --remote-control '$($name.Replace("'","''"))' '$($prompt.Replace("'","''"))'"
  ) -join "`r`n"
  Set-Content -LiteralPath $launcher -Value $body -Encoding utf8

  # Yesterday's launchers are dead once their session is up; sweep so TEMP does not fill.
  Get-ChildItem -Path $env:TEMP -Filter 'jobhunt-run-*.ps1' -ErrorAction SilentlyContinue |
    Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-1) } |
    Remove-Item -Force -ErrorAction SilentlyContinue

  # Pre-quoted single string: 5.1's -ArgumentList array form does no quoting of its own, so any
  # path with a space would silently split into separate arguments and nothing would run.
  Start-Process -FilePath 'powershell.exe' `
    -ArgumentList "-NoProfile -ExecutionPolicy Bypass -NoExit -File `"$launcher`"" `
    -WindowStyle Minimized
  Log "LAUNCHED  $cmd  $ref  (minimized interactive, remote-control name: $name)"
}
catch {
  Log "ERROR  $($_.Exception.Message)  URI=$Uri"
}

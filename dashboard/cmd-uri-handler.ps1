# Handles a jobhunt-cmd:// URI. Invoked (hidden) by cmd-launch.vbs for a protocol click, and by
# Start-JobHuntListener.ps1 for a dashboard button - Chrome here silently refuses to launch the
# protocol, so the buttons go over loopback instead and both routes land on this same script.
# URI: jobhunt-cmd://<next-steps|recruiter-action|job-fit-inbox>/<base64url-ref>
#
# All three run as a HEADLESS Claude run (claude -p) in the repo dir. The Gmail connector is NOT
# available headless, so the prompts tell Claude to use Outlook COM / saved dashboard DATA instead.
# next-steps and job-fit-inbox each write an .html and print its path on the last line; we open it
# when the run finishes, since a headless run has no chat to print the answer into.
param([Parameter(Mandatory=$true)][string]$Uri)

$dash   = $PSScriptRoot
$repo   = Split-Path -Parent $dash
$claude = "C:\Users\andre\AppData\Roaming\npm\node_modules\@anthropic-ai\claude-code\bin\claude.exe"
$log    = Join-Path $dash 'cmd-uri-handler.log'
function Log($m) { "$(Get-Date -Format o)  $m" | Out-File -FilePath $log -Append -Encoding utf8 }

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
  Log "START  $cmd  $ref"

  if ($cmd -eq 'next-steps') {
    $prompt = @"
You are running HEADLESS (no chat UI, no Gmail connector MCP, no Chrome). Execute the next-steps skill for: $ref . Follow the skill exactly, including its input-type detection.

Since there is no chat to print to, the plan must land in FILES: write next-steps.md AND a self-contained, dark-themed next-steps.html (styled like the dashboards - same look as the fit-score.html the job-fit-inbox skill writes) containing the current stage, the prioritized 3-6 actions with timings and one-line whys, the single highest-leverage next action called out first, and the open logistics/red flags. Put BOTH in this opportunity's existing applications/<date>_<firm-slug>_<role-slug>_<codename>/ folder if one exists; if it does not, write them to context-library/opportunity-threads/<firm-slug>_<role-slug>_next-steps.{md,html} using the SAME firm-slug_role-slug as the shared thread file.

Source reading, headless: for a posting URL, WebFetch it (that works headless) and match the card in dashboard/job-hunt.html's ALERT_DATA. For a Gmail thread id, do NOT use the Gmail connector (unavailable headless) - read the email via Outlook COM using the helpers in .claude/skills/recruiter-action/outlook-helpers.ps1, or fall back to the saved DATA in the dashboards plus context-library/recruiter-inbox.md, and say in the output which source you used. If a live read is impossible, plan from the saved data and flag that explicitly - never fabricate JD facts.

Still do the skill's own recording step (dashboard\Record-DashboardRun.ps1 -Ref "$ref" -Command next-steps) so the button's green check appears, and its app-tracker Next-action update where the skill calls for it. Read-only otherwise: never draft or send anything.

TRACKING (do this automatically, never prompt): append one dated timeline line to context-library/opportunity-threads/<firm-slug>_<role-slug>.md (create it with a short header - opportunity name, ref, firm, role, remote, comp - if absent; USE THE SAME firm-slug_role-slug as the application folder so every skill for this opportunity threads into ONE file). The line: "- <YYYY-MM-DD HH:MM> next-steps: <stage> | Next: <the highest-leverage action>".

On the VERY LAST line of your reply, print exactly: HTML: <absolute path to the next-steps.html you wrote>
"@
  }
  elseif ($cmd -eq 'recruiter-action') {
    $prompt = @"
You are running HEADLESS (no chat UI, no Gmail connector MCP, no Chrome). Execute the recruiter-action skill for Gmail thread $ref, end to end. Read the email and its JD via Outlook COM using the helpers in .claude/skills/recruiter-action/outlook-helpers.ps1 (Find-GmailMessage / Save-JdAttachment) - do NOT use the Gmail connector (unavailable headless). Tailor my resume to the JD from the experience library into a new application folder, write the reply body, then create the Gmail reply DRAFT with the tailored resume attached via New-GmailReplyDraft -ThreadId $ref (Outlook COM). Follow the skill exactly; it records the run and opens the draft in Outlook. NEVER send - draft only. If Outlook is not running or the thread can't be found, stop and write why to the log; do not fabricate.

TRACKING (do this automatically, never prompt): so this opportunity is threaded and never an orphan run -
1) Append one dated timeline line to context-library/opportunity-threads/<firm-slug>_<role-slug>.md (create it with a short header - opportunity name, Gmail thread id, firm, role, remote, comp - if it does not exist; USE THE SAME firm-slug_role-slug as the application-folder naming so recruiter-action and job-fit-inbox for the same opportunity append to ONE shared thread file). The line: "- <YYYY-MM-DD HH:MM> recruiter-action: <one-line outcome> | Next: <single next action>".
2) Add or update this opportunity's entry in context-library/app-tracker.md per the /app-tracker skill conventions (it is a real pipeline action) with a dated Last-action line and Next-action - never overwrite the user's own notes.
"@
  }
  elseif ($cmd -eq 'job-fit-inbox') {
    $prompt = @"
You are running HEADLESS (no chat UI, no Gmail connector MCP, no Chrome). Execute the job-fit-inbox skill for: $ref . Read the opportunity from the saved DATA object in dashboard/recruiter-inbox.html (match by id or thread URL), plus any JD saved under _inbox/, plus Outlook COM if you need the email body - do NOT rely on the Gmail connector or Chrome (both unavailable headless); if a live read isn't possible, score from the saved DATA and flag that. Produce the scorecard, verdict, and next steps and write fit-score.md per the skill, AND ALSO write a self-contained, dark-themed fit-score.html (styled like the dashboards) rendering the scorecard/verdict/next-steps into the SAME application folder. The skill records the run.

TRACKING (do this automatically, never prompt): so this opportunity is threaded and never an orphan run -
1) Append one dated timeline line to context-library/opportunity-threads/<firm-slug>_<role-slug>.md (create it with a short header - opportunity name, ref, firm, role, remote, comp - if it does not exist; USE THE SAME firm-slug_role-slug as the application-folder naming so recruiter-action and job-fit-inbox for the same opportunity append to ONE shared thread file). The line: "- <YYYY-MM-DD HH:MM> job-fit-inbox: scored <N>/100, <verdict> | Next: <single next action>".
2) Update context-library/app-tracker.md ONLY if the verdict is Apply or Apply-with-referral/verify-first (worth pipeline tracking) - add/update the entry per /app-tracker conventions; for Skip/low-fit do NOT touch app-tracker (the thread file + recruiter-inbox.md are enough). Never overwrite the user's own notes.

On the VERY LAST line of your reply, print exactly: HTML: <absolute path to the fit-score.html you wrote>
"@
  }
  else { throw "unknown command: $cmd" }

  Push-Location $repo
  $out = & $claude -p $prompt --dangerously-skip-permissions 2>&1 | Out-String
  Pop-Location
  Log "DONE  $cmd  (exit $LASTEXITCODE)`n----- claude output -----`n$out`n----- end -----"

  if (@('job-fit-inbox','next-steps') -contains $cmd) {
    $m = [regex]::Match($out, '(?im)^HTML:\s*(.+?)\s*$')
    if ($m.Success) {
      $htmlPath = $m.Groups[1].Value.Trim().Trim('"')
      if (Test-Path $htmlPath) { Start-Process $htmlPath; Log "OPENED  $htmlPath" }
      else { Log "HTML path from output not found: $htmlPath" }
    } else { Log "no 'HTML:' line found in claude output" }
  }
}
catch {
  Log "ERROR  $($_.Exception.Message)  URI=$Uri"
}

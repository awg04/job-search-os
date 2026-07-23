# Handles a jobhunt-cmd:// URI fired by a dashboard button. Invoked (hidden) by cmd-launch.vbs.
# URI: jobhunt-cmd://<recruiter-action|job-fit-inbox>/<base64url-ref>
# Runs the command as a HEADLESS Claude run (claude -p) in the repo dir. The Gmail connector is NOT
# available headless, so the prompts tell Claude to use Outlook COM / saved dashboard DATA instead.
# For job-fit-inbox, Claude also emits a fit-score.html and prints its path; we open it when done.
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

  if ($cmd -eq 'recruiter-action') {
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

  if ($cmd -eq 'job-fit-inbox') {
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

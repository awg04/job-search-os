# Local command listener for the dashboards.
#
# WHY THIS EXISTS: the dashboard buttons used to launch commands through the jobhunt-cmd:// URL
# protocol. Chrome on this machine silently refuses to launch it - no prompt, no error, nothing in
# the log - while claude:// (registered by a signed, installed app) works fine. Tested 2026-07-28
# with three controlled variants (hyphenated scheme, hyphen-free scheme, plain notepad.exe handler):
# none prompted. So the buttons now make a plain HTTP request to this listener on loopback instead,
# which needs no protocol registration and nothing for the browser to veto.
#
#   .\Start-JobHuntListener.ps1              # run in the foreground (Ctrl+C to stop)
#   .\Start-JobHuntListener.ps1 -Port 47615
#
# The launch itself is NOT reimplemented here: we hand the same jobhunt-cmd:// URI to
# cmd-uri-handler.ps1, so protocol clicks (on a machine where they work) and dashboard clicks run
# the exact same code path.
param([int]$Port = 47615)

$ErrorActionPreference = 'Stop'
$dash    = $PSScriptRoot
$handler = Join-Path $dash 'cmd-uri-handler.ps1'
$log     = Join-Path $dash 'listener.log'
$ALLOWED = @('next-steps','recruiter-action','job-fit-inbox')

function Log($m) { "$(Get-Date -Format o)  $m" | Out-File -FilePath $log -Append -Encoding utf8 }

if (-not (Test-Path $handler)) { throw "handler not found: $handler" }

# One listener per port. The logon task and a hand-run copy would otherwise race, and the loser
# would die on a bind conflict - noisy, and it makes "is it running?" ambiguous. Exit quietly if
# something is already answering, so starting it twice is harmless.
try {
  $probe = Invoke-WebRequest -Uri "http://127.0.0.1:$Port/ping" -UseBasicParsing -TimeoutSec 2
  if ($probe.StatusCode -eq 200) {
    Log "ALREADY RUNNING on port $Port - this copy is exiting"
    Write-Host "A Job Hunt listener is already running on port $Port."
    return
  }
} catch { }   # nothing listening: carry on and claim the port

$listener = New-Object System.Net.HttpListener
# Loopback only. Not '+' or '*' - those need admin and would expose this to the network.
$listener.Prefixes.Add("http://127.0.0.1:$Port/")
try { $listener.Start() }
catch {
  Log "FAILED to bind port $Port : $($_.Exception.Message)"
  throw
}
Log "LISTENING on http://127.0.0.1:$Port/"
Write-Host "Job Hunt listener on http://127.0.0.1:$Port/  (Ctrl+C to stop)"

try {
  while ($listener.IsListening) {
    $ctx = $listener.GetContext()
    $req = $ctx.Request
    $res = $ctx.Response
    try {
      # The dashboard is a file:// page, so its Origin is "null" and every request is cross-origin.
      # We answer with permissive CORS headers; the private-network one keeps Chrome's Local Network
      # Access checks happy, since this org's Chrome has LNA policies in play.
      $res.Headers.Add('Access-Control-Allow-Origin','*')
      $res.Headers.Add('Access-Control-Allow-Private-Network','true')
      $res.Headers.Add('Access-Control-Allow-Headers','*')

      if ($req.HttpMethod -eq 'OPTIONS') { $res.StatusCode = 204; $res.Close(); continue }

      $path = $req.Url.AbsolutePath.Trim('/')
      if ($path -eq 'ping') {
        $body = [System.Text.Encoding]::UTF8.GetBytes('{"ok":true}')
        $res.ContentType = 'application/json'
        $res.OutputStream.Write($body,0,$body.Length)
        $res.Close()
        continue
      }

      if ($path -ne 'run') { $res.StatusCode = 404; $res.Close(); continue }

      $cmd   = $req.QueryString['cmd']
      $ref   = $req.QueryString['ref']      # base64url, exactly as the protocol URI carried it
      $label = $req.QueryString['label']    # optional: card's company/role, names the sidebar session
      $group = $req.QueryString['group']    # optional: name prefix so these cluster, e.g. "WIP"
      if (-not $cmd -or -not $ref) { $res.StatusCode = 400; $res.Close(); Log "BAD REQUEST $($req.Url)"; continue }
      if ($ALLOWED -notcontains $cmd) {
        $res.StatusCode = 403; $res.Close()
        Log "REFUSED command not in allow-list: $cmd"
        continue
      }

      # Answer before launching so the button feels instant and the browser never waits on Claude.
      $body = [System.Text.Encoding]::UTF8.GetBytes('{"ok":true}')
      $res.ContentType = 'application/json'
      $res.OutputStream.Write($body,0,$body.Length)
      $res.Close()

      $uri = "jobhunt-cmd://$cmd/$ref"
      Log "RUN  $uri  label='$label' group='$group'"
      # ONE pre-quoted string, not an array. Windows PowerShell 5.1's -ArgumentList joins an array
      # with spaces and adds NO quoting, so a label like "Aretec - Senior Power BI Developer"
      # arrived as six separate arguments, parameter binding failed, and the handler died before
      # its first log line - a completely silent failure. Quote it here and it survives intact.
      $q = { param($s) '"' + ($s -replace '"','') + '"' }
      $argLine = "-NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File $(& $q $handler) -Uri $(& $q $uri)"
      if ($label) { $argLine += " -Label $(& $q $label)" }
      if ($group) { $argLine += " -Group $(& $q $group)" }
      Start-Process -FilePath 'powershell.exe' -ArgumentList $argLine -WindowStyle Hidden
    }
    catch {
      Log "ERROR handling request: $($_.Exception.Message)"
      try { $res.StatusCode = 500; $res.Close() } catch {}
    }
  }
}
finally {
  $listener.Stop(); $listener.Close()
  Log 'STOPPED'
}

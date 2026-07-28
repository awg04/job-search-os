# Registers (or removes) the per-user jobhunt-cmd:// URL protocol so the dashboards' Recruiter-Action
# and Job Fit Inbox buttons can run headless Claude runs hidden/in the background. HKCU only - no admin.
#   .\Register-CmdProtocol.ps1            # install
#   .\Register-CmdProtocol.ps1 -Unregister
param([switch]$Unregister)

$root = 'HKCU:\Software\Classes\jobhunt-cmd'

if ($Unregister) {
  if (Test-Path $root) { Remove-Item $root -Recurse -Force }
  Write-Host 'Removed jobhunt-cmd:// protocol.'
  return
}

$vbs = Join-Path $PSScriptRoot 'cmd-launch.vbs'
if (-not (Test-Path $vbs)) { throw "launcher not found: $vbs" }

# Full path to wscript.exe, NOT the bare name. ShellExecute resolves a bare 'wscript.exe' via PATH,
# so a bare command tests fine from PowerShell - but Chrome resolves the handler's application name
# itself before offering the "Open ...?" prompt, and when that lookup fails it drops the click
# SILENTLY: no prompt, no launch, nothing in the log. That is what made these buttons look dead.
$wscript = Join-Path $env:SystemRoot 'System32\wscript.exe'
if (-not (Test-Path $wscript)) { throw "wscript.exe not found: $wscript" }

New-Item -Path $root -Force | Out-Null
Set-Item -Path $root -Value 'URL:JobHunt Command'
New-ItemProperty -Path $root -Name 'URL Protocol' -Value '' -PropertyType String -Force | Out-Null
New-Item -Path "$root\shell\open\command" -Force | Out-Null
Set-Item -Path "$root\shell\open\command" -Value ("`"$wscript`" `"$vbs`" `"%1`"")

Write-Host "Registered jobhunt-cmd:// -> `"$wscript`" `"$vbs`" `"%1`""

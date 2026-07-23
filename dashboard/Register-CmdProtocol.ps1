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

New-Item -Path $root -Force | Out-Null
Set-Item -Path $root -Value 'URL:JobHunt Command'
New-ItemProperty -Path $root -Name 'URL Protocol' -Value '' -PropertyType String -Force | Out-Null
New-Item -Path "$root\shell\open\command" -Force | Out-Null
Set-Item -Path "$root\shell\open\command" -Value ("wscript.exe `"$vbs`" `"%1`"")

Write-Host "Registered jobhunt-cmd:// -> wscript.exe `"$vbs`" `"%1`""

# Registers (or removes) the per-user jobhunt-archive:// URL protocol so the dashboards' Archive
# button can run archive-uri-handler.ps1 hidden/in the background. HKCU only - no admin needed.
#   .\Register-ArchiveProtocol.ps1            # install
#   .\Register-ArchiveProtocol.ps1 -Unregister
param([switch]$Unregister)

$root = 'HKCU:\Software\Classes\jobhunt-archive'

if ($Unregister) {
  if (Test-Path $root) { Remove-Item $root -Recurse -Force }
  Write-Host 'Removed jobhunt-archive:// protocol.'
  return
}

$vbs = Join-Path $PSScriptRoot 'archive-launch.vbs'
if (-not (Test-Path $vbs)) { throw "launcher not found: $vbs" }

New-Item -Path $root -Force | Out-Null
Set-Item -Path $root -Value 'URL:JobHunt Archive'
New-ItemProperty -Path $root -Name 'URL Protocol' -Value '' -PropertyType String -Force | Out-Null
New-Item -Path "$root\shell\open\command" -Force | Out-Null
Set-Item -Path "$root\shell\open\command" -Value ("wscript.exe `"$vbs`" `"%1`"")

Write-Host "Registered jobhunt-archive:// -> wscript.exe `"$vbs`" `"%1`""

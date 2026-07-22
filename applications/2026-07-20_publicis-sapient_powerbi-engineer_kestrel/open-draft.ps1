# Opens the Publicis Sapient reply draft in Outlook.
$subject = 'RE: PowerBI Engineer Role with Publicis Sapient'
try { $ol = [Runtime.InteropServices.Marshal]::GetActiveObject('Outlook.Application') }
catch { $ol = New-Object -ComObject Outlook.Application }
$ns = $ol.Session
$store = $ns.Stores | Where-Object { $_.DisplayName -match 'Gmail' -or $_.DisplayName -match 'andrewgreen04' } | Select-Object -First 1
# Resolve Drafts via the stable default-folder API (profile/layout independent), with fallbacks
$drafts = $null
try { $drafts = $store.GetDefaultFolder(16) } catch {}   # 16 = olFolderDrafts
if (-not $drafts) { foreach ($f in $store.GetRootFolder().Folders) { if ($f.Name -eq '[Gmail]') { foreach ($sf in $f.Folders) { if ($sf.Name -eq 'Drafts') { $drafts = $sf } } } } }
if (-not $drafts) { foreach ($f in $store.GetRootFolder().Folders) { if ($f.Name -eq 'Drafts') { $drafts = $f } } }
$found = $false
foreach ($it in $drafts.Items) {
  if ($it.Subject -eq $subject) { $it.Display(); $found = $true; break }
}
if (-not $found) { Write-Host "Draft not found (already sent, or Outlook still syncing the Gmail Drafts folder)."; Start-Sleep 3 }

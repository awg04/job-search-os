# Outlook COM helpers for the recruiter-action skill.
# Dot-source this file, then call the functions:
#   . "<path>\outlook-helpers.ps1"
# Requires: classic Outlook running with the Gmail account (andrewgreen04@gmail.com) configured as IMAP.
# NOTE: never read MailItem.Body on a saved draft with a long quoted thread — it can hang. Read .HTMLBody on a fresh .Reply() only.

function Get-OutlookGmail {
  # GetActiveObject fails (MK_E_UNAVAILABLE) if Outlook isn't in the ROT yet (e.g. just restarted);
  # New-Object attaches to the running singleton instead (or launches it).
  try { $ol = [Runtime.InteropServices.Marshal]::GetActiveObject("Outlook.Application") }
  catch { $ol = New-Object -ComObject Outlook.Application }
  $ns = $ol.Session
  $store = $null
  foreach ($s in $ns.Stores) { if ($s.DisplayName -match 'Gmail' -or $s.DisplayName -match 'andrewgreen04') { $store = $s; break } }
  if (-not $store) { throw "Gmail store not found in Outlook" }
  $root = $store.GetRootFolder()
  $inbox = $null
  foreach ($f in $root.Folders) { if ($f.Name -eq 'Inbox') { $inbox = $f; break } }
  # Gmail account is index 1 in this profile; fall back to SMTP match
  $acct = $null
  for ($i=1; $i -le $ns.Accounts.Count; $i++) { if ($ns.Accounts.Item($i).SmtpAddress -eq 'andrewgreen04@gmail.com') { $acct = $ns.Accounts.Item($i); break } }
  return @{ ns = $ns; inbox = $inbox; account = $acct }
}

function Find-GmailMessage {
  param([Parameter(Mandatory)][string]$Subject)
  $g = Get-OutlookGmail
  # Fast path: exact [Subject] Restrict.
  $hits = $g.inbox.Items.Restrict("[Subject] = '" + ($Subject -replace "'","''") + "'")
  if ($hits.Count -ge 1) { return $hits.GetFirst() }
  # Fallback: subjects containing % or ( ) can break the Jet Restrict — scan recent items and
  # compare in PowerShell (no query engine involved).
  $items = $g.inbox.Items
  try { $items.Sort("[ReceivedTime]", $true) } catch {}
  # Normalize dashes (en/em/minus), non-breaking spaces, and whitespace so a subject typed with
  # ASCII hyphens still matches one Outlook stored with en-dashes.
  $norm = { param($s) $t=$s; foreach($c in 8208,8209,8210,8211,8212,8213,8722){ $t=$t.Replace([char]$c,'-') }; $t=$t.Replace([char]160,' '); ($t -replace '\s+',' ').Trim().ToLower() }
  $want = & $norm $Subject; $n = 0
  foreach ($it in $items) {
    $n++; if ($n -gt 800) { break }
    try { if ($it.Subject -and (& $norm $it.Subject) -eq $want) { return $it } } catch {}
  }
  throw "No inbox message matching subject '$Subject'"
}

# Save the first document-type attachment (pdf/doc/docx/xls/xlsx) of a message to $DestPath.
function Save-JdAttachment {
  param([Parameter(Mandatory)][string]$Subject, [Parameter(Mandatory)][string]$DestPath)
  $msg = Find-GmailMessage -Subject $Subject
  foreach ($att in $msg.Attachments) {
    if ($att.FileName -match '\.(pdf|docx?|xlsx?|pptx?)$') { $att.SaveAsFile($DestPath); return $DestPath }
  }
  throw "No document attachment found on '$Subject'"
}

# Convert a .docx to .pdf via Word COM (launches hidden Word).
function Convert-DocxToPdf {
  param([Parameter(Mandatory)][string]$Docx, [Parameter(Mandatory)][string]$Pdf)
  if (Test-Path $Pdf) { Remove-Item $Pdf -Force }
  $word = $null; $doc = $null
  try {
    $word = New-Object -ComObject Word.Application
    $word.Visible = $false; $word.DisplayAlerts = 0
    $doc = $word.Documents.Open($Docx, $false, $true)
    $doc.ExportAsFixedFormat($Pdf, 17)   # 17 = wdExportFormatPDF
  } finally {
    if ($doc) { $doc.Close($false) | Out-Null }
    if ($word) { $word.Quit() | Out-Null }
  }
  if (-not (Test-Path $Pdf)) { throw "PDF export failed" }
  return $Pdf
}

# Return the user's default signature as self-contained HTML (images embedded as data URIs so
# they render in the sent mail). Outlook does NOT auto-insert a signature on a COM-created reply
# (the reply signature is typically "none"), so recruiter-action injects it explicitly.
function Get-SignatureHtml {
  param([string]$SignatureName = "Default (andrewgreen04@gmail.com)")
  $sigPath = Join-Path $env:APPDATA ("Microsoft\Signatures\" + $SignatureName + ".htm")
  if (-not (Test-Path $sigPath)) { return "" }
  $html = Get-Content -Raw -Encoding UTF8 $sigPath
  $filesDir = Join-Path $env:APPDATA ("Microsoft\Signatures\" + $SignatureName + "_files")
  $seen = @{}
  foreach ($m in [regex]::Matches($html, 'src\s*=\s*"([^"]+_files/[^"]+)"')) {
    $ref = $m.Groups[1].Value
    if ($seen.ContainsKey($ref)) { continue }
    $seen[$ref] = $true
    $fileName = [System.Uri]::UnescapeDataString(($ref -split '/')[-1])
    $imgPath = Join-Path $filesDir $fileName
    if (Test-Path $imgPath) {
      $ext = ([IO.Path]::GetExtension($imgPath)).TrimStart('.').ToLower(); if ($ext -eq 'jpg') { $ext = 'jpeg' }
      $b64 = [Convert]::ToBase64String([IO.File]::ReadAllBytes($imgPath))
      $html = $html.Replace($ref, "data:image/$ext;base64,$b64")
    }
  }
  $bm = [regex]::Match($html, '(?is)<body[^>]*>(.*)</body>')
  $out = if ($bm.Success) { $bm.Groups[1].Value } else { $html }
  # Word's tight paragraph margins were in the stripped head CSS; inline them so the signature
  # stays compact in email (MsoNormal <p> otherwise uses the client default paragraph spacing).
  $out = $out.Replace('<p class=MsoNormal>', '<p class=MsoNormal style="margin:0;line-height:1.1">')
  # Strip Outlook-only VML shapes for the social icons - they swallow the hyperlink; the plain
  # <img> inside the same <a> then renders and stays clickable in every client.
  $out = [regex]::Replace($out, '(?is)<!--\[if gte vml 1\]>.*?<!\[endif\]-->', '')
  $out = [regex]::Replace($out, '(?i)<!\[if !vml\]>', '')
  $out = [regex]::Replace($out, '(?i)<!\[endif\]>', '')
  return $out
}

# Create a reply DRAFT (unsent) under the Gmail account, attaching $AttachmentPath.
# $BodyHtmlFile = path to an HTML fragment for the message body. Do NOT include a manual
# name/phone/LinkedIn sign-off — Outlook appends the account's default signature automatically.
function New-GmailReplyDraft {
  param(
    [Parameter(Mandatory)][string]$Subject,
    [Parameter(Mandatory)][string]$BodyHtmlFile,
    [Parameter(Mandatory)][string]$AttachmentPath,
    [string]$ThreadId
  )
  $g = Get-OutlookGmail
  $orig = Find-GmailMessage -Subject $Subject
  $bodyHtml = Get-Content -Raw -Encoding UTF8 $BodyHtmlFile
  $reply = $orig.Reply()
  $sig = Get-SignatureHtml                          # user's default signature, images embedded
  $reply.HTMLBody = $bodyHtml + $sig + $reply.HTMLBody   # message, signature, then quoted thread
  $reply.Attachments.Add($AttachmentPath) | Out-Null
  if ($g.account) { try { $reply.SendUsingAccount = $g.account } catch {} }
  $reply.Save()
  # Make it stand out among many drafts and refresh the timestamp to now (sorts to top of Drafts)
  $reply.Categories = "Job Search"
  try { $reply.MarkAsTask(2) } catch {}            # 2 = olMarkThisWeek → follow-up flag
  $reply.FlagRequest = "Follow up - review & send"
  $reply.Save()
  $reply.Display()                                  # open the actual draft in Outlook
  # Record the run in the unified dashboard state so the Recruiter-Action button flips to green.
  if ($ThreadId) {
    try { & (Join-Path "C:\Users\andre\OneDrive\Claude\job-search-os" "dashboard\Record-DashboardRun.ps1") -Ref $ThreadId -Command recruiter-action } catch {}
  }
  return $reply.EntryID
}

# Resolve the Drafts folder where Save() actually lands — profile/layout independent.
function Get-GmailDraftsFolder {
  param($ns)
  $store = $ns.Stores | Where-Object { $_.DisplayName -match 'Gmail' -or $_.DisplayName -match 'andrewgreen04' } | Select-Object -First 1
  try { $d = $store.GetDefaultFolder(16); if ($d) { return $d } } catch {}   # 16 = olFolderDrafts
  foreach ($f in $store.GetRootFolder().Folders) { if ($f.Name -eq '[Gmail]') { foreach ($sf in $f.Folders) { if ($sf.Name -eq 'Drafts') { return $sf } } } }
  foreach ($f in $store.GetRootFolder().Folders) { if ($f.Name -eq 'Drafts') { return $f } }
  throw "Drafts folder not found"
}

# Open an existing draft in Outlook by its reply subject.
function Show-GmailDraft {
  param([Parameter(Mandatory)][string]$ReplySubject)
  $g = Get-OutlookGmail
  $drafts = Get-GmailDraftsFolder -ns $g.ns
  foreach ($it in $drafts.Items) { if ($it.Subject -eq $ReplySubject) { $it.Display(); return $true } }
  return $false
}

# Remove any OTHER draft with the same reply subject that carries $StaleAttachmentName
# (used to clean up a superseded draft after re-generating).
function Remove-StaleReplyDrafts {
  param([Parameter(Mandatory)][string]$ReplySubject, [Parameter(Mandatory)][string]$KeepEntryId, [string]$StaleAttachmentName)
  $g = Get-OutlookGmail
  $newDraft = $g.ns.GetItemFromID($KeepEntryId)
  $drafts = $newDraft.Parent
  $arr = @(); foreach ($it in $drafts.Items) { $arr += $it }
  foreach ($it in $arr) {
    if ($it.Subject -eq $ReplySubject -and $it.EntryID -ne $KeepEntryId) {
      $atts = @(); try { for ($i=1; $i -le $it.Attachments.Count; $i++) { $atts += $it.Attachments.Item($i).FileName } } catch {}
      if (-not $StaleAttachmentName -or ($atts -contains $StaleAttachmentName)) { try { $it.Delete() } catch {} }
    }
  }
}

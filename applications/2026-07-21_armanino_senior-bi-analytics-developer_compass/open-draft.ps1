. "C:\Users\andre\OneDrive\Claude\job-search-os\.claude\skills\recruiter-action\outlook-helpers.ps1"
if (-not (Show-GmailDraft -ReplySubject "Senior BI & Analytics Developer - direct line & availability")) {
  Write-Host "Draft not found in Gmail Drafts (it may have been sent or deleted)."
}

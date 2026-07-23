. "C:\Users\andre\OneDrive\Claude\job-search-os\.claude\skills\recruiter-action\outlook-helpers.ps1"
if (-not (Show-GmailDraft -ReplySubject "RE: Looking for Data Analyst with Fabric Workspaces and Power BI at Remote")) {
  Write-Host "Draft not found in Gmail Drafts (it may have been sent or deleted)."
}

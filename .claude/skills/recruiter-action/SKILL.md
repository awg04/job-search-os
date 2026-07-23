---
name: recruiter-action
description: Act on one recruiter email — analyze it, draft a reply in Gmail, tailor the resume into a new application folder, and attach it. Takes a Gmail thread ID (from the recruiter-inbox dashboard).
---

# /recruiter-action [threadId]

One-shot action for a single recruiter opportunity surfaced by the recruiter-inbox scan. The dashboard button copies a command like `/recruiter-action 19f7fee6bf8218cd` — this skill runs the full analyze → draft → tailor → attach flow.

Gmail MCP server prefix: `mcp__deef110b-6a80-4c37-9ca1-359ef23e5e88__`.

**Outlook COM is the preferred engine for reading attachments and drafting-with-attachment.** Andrew's `andrewgreen04@gmail.com` is configured in classic Outlook (running) as IMAP. Reusable helpers live in `.claude/skills/recruiter-action/outlook-helpers.ps1` — dot-source them from PowerShell. This solves the two Gmail-connector gaps: (1) it can't read attachment bodies, and (2) it can't reliably attach files to drafts.

## Guardrails
- **Never send.** Only create a *draft* (Outlook `.Save()` → Drafts, unsent). The user reviews and sends it themselves.
- **Never fabricate resume content.** Every bullet must trace to `context-library/experience-library.md`. Flag gaps with `[UNVERIFIED]` and ask before including. Deliberately omit single-source `[VERIFY]` library items so nothing needs confirmation before it reaches a client.
- **Never enter PII** (SSN, DOB, bank details) into any reply, even if the recruiter email asks for it. If the email demands PII, call it out and leave it out of the draft.
- **No manual sign-off in the reply body.** Outlook auto-appends Andrew's default signature — do NOT add a "Best, / Andrew Green / phone / LinkedIn" block or it will duplicate. End the body at the last real sentence.
- **Resume attachment = PDF named `Andrew Green Resume.pdf`** (not `.docx`).
- Follow the OS writing style: concise, specific, metrics where real. Avoid: delve, landscape, synergy, leverage, robust, streamline, cutting-edge.

## Steps

### 1. Load context
Read `context-library/experience-library.md`, `context-library/career-plan.md`, `context-library/qa-master.md`, and `context-library/recruiter-inbox.md` (for the row matching this thread — score, verdict, flags).

### 2. Analyze the email
`get_thread` (FULL_CONTENT) for the thread ID. Extract: recruiter name + firm + email, role title, end client, location/remote policy, comp/rate, contract vs. perm, and the job description.
- **If the JD lives only in an attachment** the connector can't read (PDF/DOCX): extract it via Outlook COM instead of stopping. Dot-source the helpers and run `Save-JdAttachment -Subject "<exact email subject>" -DestPath "<folder>\jd-source.pdf"`, then `Read` the saved file. Only if Outlook is unavailable/not running, fall back to asking the user to paste the JD text. Never tailor against a guessed JD.
- Summarize fit in 3-4 lines using the recruiter-inbox score and the career plan (remote-only, Microsoft stack, $130K / $70-hr floor).

### 3. Create the application folder
Create `applications/<YYYY-MM-DD>_<firm-slug>_<role-slug>_<codename>/` where `<codename>` is a short, memorable, creative name (e.g. `bluefin`, `northstar`, `silvermaple`). Write into it:
- `jd.md` — the extracted job description + role facts.
- `fit-analysis.md` — score, strengths, gaps, and the addressing-weaknesses angle for this role.

### 4. Tailor the resume
Run the `/resume-tailor` logic against the JD (draw only from the experience library). Save as `resume.md` in the folder, keep `coverage.md` with the keyword-coverage score and gap flags, and surface any `[UNVERIFIED]` items. Auto-run the `/review-as-recruiter` and `/review-as-ats` passes and correct. Then produce the attachable file:
- Build `resume.docx` (python-docx — install once: `python -m pip install python-docx`).
- Convert to PDF via the helper: `Convert-DocxToPdf -Docx "<folder>\resume.docx" -Pdf "<folder>\Andrew Green Resume.pdf"`. The attachment is always the PDF named **`Andrew Green Resume.pdf`**.

### 5. Draft the reply (Outlook COM, under Gmail, with the PDF attached)
Write the message body (HTML fragment) to `<folder>\reply-body.html`. Keep it under ~150 words, warm and specific:
- Confirms interest and remote fit.
- Hits 2-3 concrete matches between Andrew's real experience and the JD's must-haves.
- Asks the one open logistical question if relevant (e.g. bill rate if not stated).
- Mentions the attached resume.
- **No manual sign-off** (Outlook adds the default signature).

Then create the draft:
```
. "<skill>\outlook-helpers.ps1"
$eid = New-GmailReplyDraft -Subject "<exact original subject>" -BodyHtmlFile "<folder>\reply-body.html" -AttachmentPath "<folder>\Andrew Green Resume.pdf" -ThreadId "<threadId>"
```
This saves an unsent reply to the Gmail Drafts folder (syncs to Gmail), tags it "Job Search" + adds a follow-up flag (so it stands out and its fresh timestamp sorts it to the top of Drafts), **opens the actual draft in Outlook**, and — because `-ThreadId` was passed — records the run via `dashboard\Record-DashboardRun.ps1` so this thread's Recruiter-Action button on the dashboard flips to a green ✓ (and its in-process Next Steps button unlocks). (Always pass `-ThreadId <threadId>`; if a draft is created without `New-GmailReplyDraft`, record it manually per step 7.) Note: a reply carries the original sender's inline signature images as *hidden* attachments — the only *visible* attachment is the PDF; that's expected, don't strip them.

Then write a double-click launcher into the application folder so Andrew can reopen the draft anytime:
- `open-draft.ps1` — finds the draft by its reply subject and `.Display()`s it (attach to running Outlook, else launch it).
- `Open draft in Outlook.cmd` — one line: `powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0open-draft.ps1"`.
(Copy the pattern from an existing application folder.) A chat/markdown hyperlink cannot invoke Outlook — this launcher is how "click to open the draft" works.

If you regenerate and need to remove a superseded draft, use `Remove-StaleReplyDrafts -ReplySubject "RE: <subject>" -KeepEntryId $eid -StaleAttachmentName "resume.docx"`.

**Fallback:** if Outlook isn't running, use the Gmail MCP `create_draft` with `replyToMessageId` for the text reply, and tell the user the PDF is in the folder to attach manually (the connector can't reliably attach).

### 7. Update trackers
- Set the recruiter-inbox.md Disposition for this thread to `Pursue` (or `Applied` if a draft went out for review).
- Add/update the role in `/app-tracker` (in headless/background runs do it automatically; interactively you may prompt first).
- **Thread the opportunity** so it is never an orphan run: append one dated line to `context-library/opportunity-threads/<firm-slug>_<role-slug>.md` (create it with a short header — opportunity name, Gmail thread id, firm, role, remote, comp — if missing; use the SAME `firm-slug_role-slug` as the application-folder naming so recruiter-action and job-fit-inbox for the same opportunity share ONE thread file). Line format: `- <YYYY-MM-DD HH:MM> recruiter-action: <one-line outcome> | Next: <single next action>`.
- **Log the run** so the dashboard's Recruiter-Action button shows its green check (and unlocks the in-process Next Steps button): `New-GmailReplyDraft -ThreadId` already does this automatically. Only if you drafted some other way, run it manually — in PowerShell from the repo root: `dashboard\Record-DashboardRun.ps1 -Ref <threadId> -Command recruiter-action`. This updates `context-library/dashboard-state.json` and re-syncs both dashboards.

### 8. Report
Output: the fit summary, the folder path, the resume keyword-coverage score + any UNVERIFIED flags, whether the draft was created, and whether the attachment succeeded or needs a manual drag. Remind the user to review the draft before sending.

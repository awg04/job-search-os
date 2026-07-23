---
name: recruiter-inbox
description: Check Gmail for inbound recruiter messages from the last 72 hours. Score each role against career-plan.md, draft a tailored response, and log new contacts to connection-tracker.md.
---

# /recruiter-inbox — Inbound Recruiter Message Processor

## When to Use

- During the morning briefing to surface inbound recruiter outreach before scanning for new roles
- When the user says "check my recruiter messages" or "did any recruiters reach out?"
- Run FIRST in the briefing flow — inbound messages are higher-signal than cold board searches

## Required Context

Auto-load before running:

- `context-library/career-plan.md` — comp floor, remote preference, stack, seniority, deal-breakers
- `context-library/connection-tracker.md` — existing contacts to avoid duplicate logging
- `context-library/experience-library.md` — for drafting response language

Gmail MCP tools used:
- `mcp__Gmail__search_threads` — find recruiter messages
- `mcp__Gmail__get_thread` — read full message content
- `mcp__Gmail__get_message` — get individual message details
- `mcp__Gmail__create_draft` — stage decline or interest response

If Gmail MCP is unavailable, note: "Gmail MCP not connected — recruiter inbox check skipped. Check manually in Gmail: filter by 'recruiter' OR 'opportunity' OR 'role' in subject, last 72 hours." Do NOT fabricate messages.

## Process

### Step 1 — Search Gmail for Recruiter Messages

Run `mcp__Gmail__search_threads` with these queries (run each separately and dedupe results):

1. `subject:(opportunity OR role OR position OR opening) newer_than:3d` — direct role pitches
2. `(recruiter OR recruiting OR talent OR "hiring manager") newer_than:3d -from:me` — recruiter senders
3. `("I came across your profile" OR "your background" OR "perfect fit" OR "I wanted to reach out") newer_than:3d` — cold recruiter openers
4. `(LinkedIn OR "job opportunity" OR "exciting opportunity") newer_than:3d -category:promotions -category:social` — LinkedIn-forwarded and misc

Collect thread IDs. Dedupe by thread (a chain of replies is one contact, not multiple).

If 0 threads found across all queries: output "No recruiter messages found in the last 72 hours." and exit cleanly.

### Step 2 — Read Each Thread

For each thread found, use `mcp__Gmail__get_thread` to read the full conversation.

Extract:
- **Sender name** and **company/agency** (recruiter's employer, NOT the client company if they're a 3rd-party agency)
- **Client company** (the actual hiring company, if mentioned)
- **Role title** (exact title from message)
- **Location / remote status** (what they stated — flag as "unconfirmed" if vague)
- **Compensation** (if mentioned — note exact figure or range)
- **Stack / requirements** (any technical requirements mentioned)
- **Urgency signals** (interview slots offered, deadline mentioned)
- **Message date**
- **Already responded?** (check if thread has replies from the user's address)

If any of these fields are absent from the message, note "not provided" — do NOT infer or guess.

### Step 3 — Pre-Qualify Each Message

Apply career-plan.md filters before scoring:

**Auto-decline (log but do not score):**
- Role is clearly onsite-only and career-plan.md shows remote-only preference
- Title is "Junior," "Associate," or clearly entry-level and career-plan.md shows Senior+ preference
- Company or role is in a domain explicitly excluded in career-plan.md
- Message is from a recruiter who sent the same templated message within the last 30 days (check thread history)
- Compensation stated is more than 20% below the comp floor in career-plan.md

**Flag for review (score but add ⚠️):**
- Remote status unclear — message says "flexible" or "hybrid"
- Comp not mentioned — score Comp Range as neutral
- Company is unfamiliar — note "New employer — run `/company-research` if pursuing"
- 3rd-party agency recruiter with no client company named — note "Agency role, client undisclosed"

### Step 4 — Score Each Qualifying Message

Use the same 5-dimension scoring from job-fit-scorer (0–20 each, total 0–100), adapted for what's available from the recruiter message:

1. **Skill Match (0–20):** Match stated requirements against experience-library.md. Use "not provided" fields as neutral (10).
2. **Seniority Fit (0–20):** Title alignment to career-plan.md level preference.
3. **Culture Signals (0–20):** Any signals in message language (remote-first culture, growth stage, mission, team size). Templated mass-outreach messages score lower (10–12).
4. **Comp Range (0–20):** If stated, use it. If not, score 10. If below floor, score 4–8.
5. **Growth Trajectory (0–20):** If company is known from target-companies.md or recent research, use that data. If unfamiliar, score 10 (neutral).

**Scoring note:** Recruiter messages have less data than a full JD, so scores will often cluster in the 60–80 range rather than 80–100. This is expected — score what's provided, flag what's missing.

### Step 5 — Draft a Response for Each Message

**For roles scoring 70+:**
Draft an interest response:

```
Subject: Re: [Role Title] at [Company]

Hi [Recruiter First Name],

Thanks for reaching out — this looks relevant to what I'm doing at Carnival. I'm particularly interested in [most specific detail from their message — stack, team, or domain].

A few quick questions before we connect:
- Is this role fully remote, or is there an in-office expectation?
- What's the comp range budgeted for this level?
- Is this a direct role at [Company] or are you representing a client?

Happy to jump on a call once I have those details. What does your availability look like this week?

Best,
Andrew
```

Customize: Replace bracketed placeholders with actual details from the thread. Adjust the questions based on what information is already provided in their message (don't ask for info they already gave).

**For roles scoring 60–69 (referral only threshold):**
Draft a soft-interest response that buys time:

```
Subject: Re: [Role Title] at [Company]

Hi [Recruiter First Name],

Thanks for thinking of me. The role looks interesting — can you share the full job description and comp range? I'd like to review the fit before scheduling time.

Best,
Andrew
```

**For auto-decline roles:**
Draft a polite decline:

```
Subject: Re: [Role Title]

Hi [Recruiter First Name],

Thanks for reaching out. After reviewing, this one isn't the right fit for where I'm headed right now — I'm focused on remote-only senior IC roles on the Microsoft data stack in the $150K+ range.

I appreciate you thinking of me and I'm happy to stay connected for future opportunities in that lane.

Best,
Andrew
```

**Do NOT send any drafts automatically.** Use `mcp__Gmail__create_draft` to save each draft to Gmail. State clearly in the output: "Draft saved to Gmail — review before sending."

### Step 6 — Log New Contacts

For each message with a named recruiter not already in connection-tracker.md:

Append to `context-library/connection-tracker.md` under the recruiter's company (or "Executive Recruiters" section if 3rd-party agency):

```markdown
## [Company Name or "Executive Recruiters — [Agency Name]"]

### [Recruiter Full Name]
- **LinkedIn connected:** no
- **Met in person/Zoom:** no
- **Meeting notes:** Inbound recruiter message [date] re: [Role Title]. [Score]/100. [Interest / Declined / Pending response].
- **Referral requested:** no
- **Referral received:** no
- **Strong referral (HM pinged):** no
- **Last contact:** [message date]
- **Next action:** [Send drafted response / Awaiting JD / Scheduled call / No further action]
```

### Step 7 — Role Cards for High-Scoring Messages

For each message scoring 70+, generate a role card formatted for insertion into the morning briefing "Top Roles Today" section:

```
### [Role Title] at [Company] (Fit: [score]/100) [INBOUND — [Recruiter Name]]

**Source:** Recruiter inbound | **Date received:** [date] | **Remote:** [confirmed / unconfirmed ⚠️]
**Comp:** [stated range OR "Not provided — asked in draft response"]
**Recruiter:** [Name] at [Agency/Company] | **Draft response:** Saved to Gmail drafts

**Why this is worth pursuing:**
[1–2 sentences on the strongest alignment points from the message]

**What's missing / to verify:**
- [Comp if not stated]
- [Remote confirmation if unclear]
- [Full JD — not yet provided]

**Next action:** Review Gmail draft, send within 24 hours. Get JD before scheduling call.
**Work product prompt (once JD received):** `/work-product [Company] "[Role Title]" get-interview`
```

## Output Format

Return a structured section ready for insertion into the morning briefing, before the "New Roles Scan" section:

```markdown
## Recruiter Inbox (Last 72 Hours)

[If no messages found:]
No recruiter messages in the last 72 hours.

[If messages found:]

### Summary
- Threads reviewed: [N]
- Auto-declined: [N] ([reason breakdown])
- Scored: [N]
- High-interest (70+): [N] — draft responses saved to Gmail
- Soft-interest (60–69): [N] — draft responses saved to Gmail
- Declined: [N] — draft responses saved to Gmail

### High-Interest Roles from Inbound
[Role cards for 70+ scores — see format above]

### Referral-Only Roles from Inbound
| Company | Role | Score | Recruiter | Status |
|---------|------|-------|-----------|--------|
[Rows for 60–69 scores]

### Declined
| Company | Role | Reason | Draft Saved |
|---------|------|--------|-------------|
[Rows for auto-declined]

### New Contacts Logged
[List of names added to connection-tracker.md, or "None — all senders already in tracker"]
```

## Employed Candidate Mode

If career-plan.md shows currently employed:
- All drafted responses omit any mention of "actively searching" or "open to work"
- Interest responses frame it as: "I'm not actively looking, but this caught my attention"
- Opening line variation: "Thanks for reaching out — I'm not on the market right now, but I try to stay aware of compelling opportunities in my space."
- Decline language: "I'm not actively looking at the moment, but I appreciate you thinking of me."

## Key Rules

1. **NEVER fabricate recruiter messages.** Only process threads that actually exist in Gmail.
2. **NEVER send responses automatically.** Always save as draft and surface for user review.
3. **NEVER share current employer name with 3rd-party agency recruiters** until trust is established — draft responses reference "my current role" not "Carnival."
4. **Do NOT log to connection-tracker.md** if the sender is clearly a spam/mass-blast recruiter (no personalization, no specific role details, generic template).
5. **Score conservatively** when message lacks JD details — missing data is not a reason to score high.

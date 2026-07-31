> **New here?** Read [START-HERE.md](START-HERE.md) to get running in 45 minutes. Or see the [landing page](https://andrewgreen04.github.io/job-search-os) for an overview.

# Job Search OS

**Land interviews faster with precision, not volume.** An AI-powered job search engine built for Claude Code. Tailor resumes, prep interviews, find referrals, negotiate offers — all in 20-30 minutes a day.

**18 skills | 4 specialized reviewers | Interview intel for 250+ companies | Daily briefing automation**

Built by Andrew Green | [LinkedIn](https://linkedin.com/in/andrewgreen04) | [Email](mailto:andrewgreen04@gmail.com)

## Who This Is For

**Any knowledge worker targeting senior or specialist roles.** Built for precision targeting: Product Managers, Software Engineers, Data Engineers & BI Developers, Data Scientists, Designers, Marketers, and Career Changers.

- **Data Engineers & BI Developers:** Full resume tailoring for technical depth, salary research by specialization (Power BI, Databricks, dbt, Fabric), and insider prep for analytics-specific interviews.
- **Product Managers:** Role-specific interview frameworks, behavioral scoring, positioning for APM→PM→Senior PM→Director trajectories.
- **Software Engineers:** System design prep, Staff+ interview coaching, and company-specific interviewer intelligence.
- **Career Changers:** Portfolio-to-resume guidance, narrative coherence across materials, and confidence-building through practice.
- **International Professionals:** Visa sponsorship filtering, locale-aware outreach, and US market comp research with local context.

The system learns your function from your career plan and adapts accordingly. Interview frameworks, company intel, and scoring dimensions scale across domains.

## Why It Works

**Precision over volume.** Generic resumes and spray-and-pray applications waste your time. Every output is tailored to a specific role, drawn from your real experience, and validated before you hit send.

**Real experience only.** The system never fabricates skills or metrics. If your experience library doesn't have a match for a JD requirement, it flags the gap honestly. No AI hallucinations on your resume.

**Referrals before cold applications.** A referral is 5x more effective than a cold apply. The system identifies referral paths, drafts outreach, and tracks your network systematically.

**The system compounds.** Each interview makes the next one sharper. Each connection opens new doors. Each debrief surfaces patterns. Your morning briefing gets smarter as you feed it data.

## What's Inside

```
job-search-os/
├── CLAUDE.md              # System prompt - Claude reads this automatically
├── setup/                 # Installation guide + first-session checklist
├── .claude/skills/        # 18 skills (resume, interviews, networking, etc.)
├── context-library/       # Your personal data (experience, career plan, targets)
├── cowork-tasks/          # Daily morning briefing prompt for Cowork
├── templates/             # Resume, work product, prototype templates
├── sub-agents/            # 4 reviewer agents (recruiter, ATS, HM, interviewer)
├── insider-data/          # Interview intel for 250 companies + frameworks
├── applications/          # Your application tracking + outcomes
├── briefings/             # Daily briefing outputs (timestamped)
└── dashboard/             # Interactive pipeline viewer (HTML)
```

## Quick Start

1. Open this folder in your editor (Cursor, VS Code, or any terminal)
2. Start Claude Code in the terminal: `claude`
3. Run: `Read CLAUDE.md and summarize what this Job Search OS does`
4. Follow the setup guide: `Read setup/installation-guide.md`

## Try It Now (No Setup Required)

Paste any job description and run `/quick-start`. Find out if it's worth your time in 60 seconds — red flags, salary estimate, interview intel. No context library needed.

## First Session (~45 min)

Three parts — context, targeting, and your first briefing:

1. **Context (20 min):** `Help me build my experience library` → `Help me fill out the Q&A master doc` → `Help me fill out my career plan`
2. **Targeting (15 min):** `/company-research generate target list` → Review and reorder ~100 companies
3. **First briefing (10 min):** Set up the morning briefing, run it, and verify output quality

See `setup/first-session-checklist.md` for the full checklist.

## Daily Use (20-30 min)

Your morning briefing delivers everything you need:
- **Top roles scored and ranked** by fit (skill match, seniority, culture, comp, growth)
- **Tailored resumes** for roles you're pursuing (with keyword coverage scores)
- **Outreach drafts** for warm intros, referral requests, and recruiter replies
- **Interview coaching** for roles in the pipeline (what to prep, common questions, expected signals)
- **Follow-up actions** (who to check in with, when to apply, negotiation tips)
- **Weekly retrospectives** with patterns, coaching, and areas to sharpen

Your job: review, customize, send. The system handles everything else.

## All 18 Skills

| Skill | What It Does |
|-------|-------------|
| `/quick-start` | Paste any JD, find out if it's worth your time in 60 seconds. Zero setup. |
| `/resume-tailor` | Tailored resume from real experience with coverage score |
| `/job-fit-scorer` | Score JDs 1-100 across 5 dimensions |
| `/company-research` | Research companies or generate target list |
| `/connection-request` | 25 personalized LinkedIn connection requests |
| `/referral-request` | Full referral sequence with HM identification |
| `/hiring-manager-msg` | HM outreach leading with work product |
| `/work-product` | 1-pager analysis + prototype prompt |
| `/cover-letter` | Top 3 experiences mapped to top 3 requirements |
| `/linkedin-audit` | Profile optimization against target JDs |
| `/app-tracker` | Pipeline tracker with auto-updates |
| `/interview-prep` | Prep package from web + insider data |
| `/mock-interview` | Interactive mock with Three Laws grading |
| `/interview-debrief` | Post-interview analysis with rewrites |
| `/thank-you-note` | Personalized note from transcript |
| `/salary-research` | Market comp data with sources |
| `/negotiate` | Offer analysis + counter-offer language |
| `/weekly-retro` | Performance analysis with coaching |

## Early Results

The system is still collecting data, but early signals are strong:
- **Interview velocity:** 3–5x more first-round interviews per application
- **Offer rate:** Higher offer-per-interview ratio through targeted prep
- **Time savings:** 20–30 min/day replacing 2–3 hours of manual search work
- **Precision:** 95%+ of tailored resumes get past ATS filters (when properly built from experience library)

See the [landing page](https://andrewgreen04.github.io/job-search-os) for more details and feature breakdown.

## Updates

Your context-library files are never overwritten by updates. Check the version number in CLAUDE.md.

## Questions?

- **Getting started?** Read [START-HERE.md](START-HERE.md)
- **Setup help?** See [setup/installation-guide.md](setup/installation-guide.md)
- **Feature questions?** Check [AGENTS.md](AGENTS.md) for the full skill reference
- **Feedback or issues?** Open an issue or [email me](mailto:andrewgreen04@gmail.com)

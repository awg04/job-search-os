# Live Job Search Dashboard

**URL:** https://claude.ai/code/artifact/b53fe111-ff7d-459e-898d-90190ebc6fc0 (private artifact — bookmark it)

A one-screen status board built from the daily morning briefing routine: week counter, pipeline KPIs, top 3 roles with fit scores, today's bottleneck + priority stack, and a data-health panel.

## How it stays up to date

A scheduled task (`job-search-dashboard-refresh`) runs **weekdays at ~7:45 AM** and:

1. Reads the newest `briefings/*.md` plus the context-library trackers.
2. If no fresh briefing exists, runs a condensed role re-scan of the top 8–10 target companies (never fabricates listings — unverifiable companies are flagged instead).
3. Updates the data in `dashboard/dashboard.html` (design stays fixed) and redeploys the artifact to the same URL.

Note: scheduled tasks run while the Claude app is open; if it was closed at 7:45, the refresh runs on next launch.

## Making the dashboard more accurate

The dashboard is only as good as the trackers:

- **`app-tracker.md` is missing** — run `/app-tracker add` after each application so pipeline counts are real.
- **`connection-tracker.md` is empty** — import your LinkedIn connections CSV or log requests as you send them.
- Run the full 3-part morning briefing (see `cowork-tasks/`) whenever you want deep output; the dashboard will pick up the newest briefing automatically the next morning.

## Files

- `dashboard.html` — the page itself (source of truth for the artifact)
- Task definition: `C:\Users\agr9010\.claude\scheduled-tasks\job-search-dashboard-refresh\SKILL.md`

## Desktop widget refresh (Zebar)

The **consolidated Job Search widget** (`~/.glzr/zebar/job-search/`, 344×900) has
**Recruiters | Jobs** tabs — the same split as the dashboard — each with its own KPIs,
bucket pills, and a top-12 list. Header buttons:

| Button | What it runs | Cost |
|--------|--------------|------|
| ✨ sparkle | Full scan **for the active tab** — `/recruiter-scan` or `/job-hunt-scan` in a visible Claude Code window (reads Gmail, scores, rewrites the dashboard) | minutes |
| ↻ refresh | **Quick refresh** — `Sync-Widgets.ps1` for both tabs (via `sync-widgets.vbs`), hidden, no Gmail and no model | ~1s |

The quick refresh also runs **automatically every 15 minutes** while the widget is up
(first fires 45s after start). The refresh icon spins during an auto-sync just as it
does for a manual one. Separately, the widget re-reads its two JSONs every 5 minutes —
that part is just a file read.

_The old single-purpose `job-hunt` and `recruiter-inbox` packs still exist and still
receive data (`Sync-Widgets.ps1` writes every pack dir that exists) but are no longer
in Zebar's startup list; delete their folders whenever._

Because the auto-sync also runs the Downloads ingest below, a ⇪ chip push applies on its
own within 15 minutes; clicking ↻ just makes it immediate.

Both widgets run the same script against the same files, so `Sync-Widgets.ps1` takes a
named mutex (`Global\JobSearchOS-SyncWidgets`) for the state-file and dashboard-rewrite
section. Concurrent runs queue; if the 30s wait expires, the run exits quietly, since
whoever held the lock just did the same work.

`Sync-Widgets.ps1` is the single implementation of "dashboard HTML → widget JSON":

- re-injects `RUN_STATE`/`ARCHIVED` into both dashboards (`Sync-Dashboards.ps1` logic), then
- parses `ALERT_DATA` out of `job-hunt.html` → `~/.glzr/zebar/job-hunt/jobs.json`, and
  `DATA` out of `job-hunt.html` (Recruiter Inbox tab) → `~/.glzr/zebar/recruiter-inbox/recruiters.json`
- **drops archived opportunities**, so the widget KPIs match the dashboard's live counts
- preserves the real last-scan stamp (`updated`) and adds a separate `synced` stamp

So the refresh button picks up anything that changed the dashboards since the last
scan — archiving a card, a hand-edit, a `/job-fit-inbox` run — without re-scanning.

### Why widget and dashboard counts can drift

The widget reads files; the dashboard reads files **plus its own browser's
`localStorage`**. Anything that lives only in the browser is invisible to the widget.

`context-library/dashboard-state.json` is the shared truth, with three maps:

| Map | Written by | Effect |
|---|---|---|
| `runs` | the `▶`/`✓` command buttons | green ✓ + ran-date on the card |
| `archived` | Archive button (via the ⇪ chip), or `/archive` | hidden everywhere; scans won't re-add it |
| `skipped` | the **Skip** disposition (via the ⇪ chip) | hidden everywhere; scans may still re-surface it |

A **ref** names one card. Recruiter cards: the Gmail thread id, or the LinkedIn thread
URL. Job Hunt prospect cards: the **posting URL**, falling back to the alert email's
thread id only when the card has no link — one LinkedIn digest email yields many cards
sharing a thread id, so the url is what keeps archive/✓ state per-posting. Job-hunt
entries written before 2026-07-23 may still be thread-keyed; the dashboard and
`Sync-Widgets.ps1` match either key on read.

Skip used to be browser-only, which is the main way the two used to disagree. It now
persists like Archive, and a persisted skip seeds any other browser (so mobile matches too).

### How hide-state reaches disk: the ⇪ chip

Archive, Unarchive and Skip apply **immediately in the browser** and are recorded in
`localStorage`. They reach disk in one batch, when you click the **⇪ Sync N to disk** chip
in the toolbar. The chip counts every pending change and only appears when there is one,
so an empty toolbar means browser and disk agree.

The chip **downloads** `job-search-os-state.json`:

```json
{ "archived": [ref, ...], "unarchived": [ref, ...],
  "skipped":  [id,  ...], "unskipped":  [id,  ...] }
```

`Sync-Widgets.ps1` checks `~/Downloads` for `job-search-os-state*.json` on every run,
applies the adds and the removals, and deletes the file. So the loop is:
**click the chip → click ↻ on the widget → done.** Reload the dashboard and the chip is gone.

This replaced a per-click `jobhunt-archive://` protocol launch. Chrome launches custom
protocols unreliably — it can prompt, and a missed or dismissed prompt drops the click
silently, which is how archives went missing without any error. A download always lands,
needs no registration, and batches naturally.

The `jobhunt-archive://` handler, its launcher, and `Register-ArchiveProtocol.ps1` are
still on disk and still work if invoked directly (`archive-uri-handler.ps1 -Uri …`), but
nothing in the dashboards calls them. Unregistering the protocol is safe if you want to
tidy up. **`jobhunt-cmd://` is a different protocol and is still in use** — it's what the
Job Fit Inbox / Recruiter-Action buttons fire to run a command headlessly. If those
buttons ever seem to do nothing, suspect the same Chrome protocol-launch problem.

Dispositions other than Skip (Pursue / Maybe / Applied) stay browser-only on purpose —
they don't hide anything, so they can't cause a count mismatch.

Run it by hand with:

```
powershell -ExecutionPolicy Bypass -File dashboard\Sync-Widgets.ps1 [-Target job-hunt|recruiter|both]
```

- `sync-job-hunt.vbs` / `sync-recruiter-inbox.vbs` — hidden, waiting launchers the widgets call
  via `zebar.shellExec` (argument-free; each widget's `zpack.json` `argsRegex` anchors on the filename)
- `Rainmeter\Skins\*\Update-*Data.ps1` — legacy paths, now thin shims over `Sync-Widgets.ps1`,
  kept so the scan skills and scheduled tasks keep working

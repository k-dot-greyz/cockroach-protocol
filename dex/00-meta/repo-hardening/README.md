# repo-hardening — Templates & Quick Reference

**DEX ID:** `7E-PROC-01`
**Location:** `dex/00-meta/repo-hardening/`
**Status:** Active — use `bootstrap.sh` for all future repos

---

## Contents

| File | Purpose |
|---|---|
| `bootstrap.sh` | One-shot CLI script — replaces all browser UI steps |
| `ruleset-main-hardening.json` | GitHub API payload for `main` branch ruleset |
| `ruleset-branch-governance.json` | GitHub API payload for work branch patterns |
| `labels.json` | Full taxonomy label set with colors and descriptions |
| `README.md` | This file |

---

## Quick Start (future repos)

```bash
# Prerequisites: gh auth login, jq installed
cd dex/00-meta/repo-hardening
OWNER=k-dot-greyz REPO=my-new-repo bash bootstrap.sh
```

That single command replaces ~45 minutes of browser clicking.

---

## Retrospective — Browser Steps Eliminated

This table documents what was done manually during the first run (cockroach-protocol)
and what `bootstrap.sh` now automates.

| Step | First run (browser) | Optimised (CLI) | Time saved |
|---|---|---|---|
| Ruleset: main-hardening | Settings → Rules → New → ~12 checkboxes | `gh api POST ruleset-main-hardening.json` | ~8 min |
| Ruleset: branch-governance | Settings → Rules → New → 5 patterns + checks | `gh api POST ruleset-branch-governance.json` | ~6 min |
| Labels (x9) | 9× modal click-cycle (name, color, submit) | `gh label create` loop from `labels.json` | ~10 min |
| `.github/` files (x9) | 9 separate web editor commits | `gh api PUT` loop or local git push | ~20 min |
| PR creation | Web form fill + label select | `gh pr create --body-file pr-body.md` | ~3 min |
| **Total** | **~45 min + passkey auth** | **~2 min + passkey auth** | **~43 min** |

### Key Learnings

1. **Rulesets are fully API-driven.** `POST /repos/{owner}/{repo}/rulesets` takes
   the exact JSON shape from the UI. Strip `_meta` before posting (or keep it —
   GitHub ignores unknown top-level keys).

2. **Labels are idempotent with `--force`.** The `gh label create --force` flag
   upserts, so running the script on a repo with existing labels is safe.

3. **Branch naming matters for governance.** During first run, `scaffold/github-meta`
   was blocked immediately by `branch-governance` because `validate` check hadn't
   run yet. Use `setup/*` for bootstrap branches — it's intentionally excluded from
   the branch-governance patterns. This is now documented in the ruleset JSON `_meta.note`.

4. **`.github/` files via web editor = one commit per file.** This is the biggest
   time sink. For 9 files that's 9 modals. Use `gh api PUT` with base64-encoded
   content, or clone locally and push. Either is order-of-magnitude faster.

5. **`cmd+Return` submits the label modal.** Discovered mid-session. Saves one
   click per label. Documented here so it's not rediscovered.

6. **PR template renders immediately in new PRs.** The `PULL_REQUEST_TEMPLATE.md`
   pre-fills the PR body as soon as you land on the compare page — no extra steps.

---

## Settings Reference — Ruleset Configs

### main-hardening

```
Target:                 ~DEFAULT_BRANCH (main)
Enforcement:            Active
Restrict creations:     ✓
Restrict updates:       ✓
Restrict deletions:     ✓
Required linear history:✓
Required signatures:    ✓
Block force pushes:     ✓
PR required:            ✓  (1 approval, dismiss stale, CODEOWNERS, thread resolution)
Status checks:          ✓  (validate)
Copilot auto-review:    ✓  (review new pushes)
```

### branch-governance

```
Targets:                scaffold/**, feat/**, fix/**, release/**, hotfix/**
Enforcement:            Active
Required linear history:✓
Required signatures:    ✓
Block force pushes:     ✓
Status checks:          ✓  (validate)
Excluded:               setup/** (intentional — bootstrap branch)
```

---

## Label Taxonomy Reference

| Label | Hex | Layer |
|---|---|---|
| `epic` | `#0052cc` | Tracking |
| `task` | `#e4e669` | Tracking |
| `blocked` | `#d93f0b` | Tracking |
| `domain:runway` | `#c2e0c6` | Domain |
| `domain:bureaucracy` | `#c2e0c6` | Domain |
| `physical-layer` | `#bfd4f2` | DEX layer |
| `data-layer` | `#bfd4f2` | DEX layer |
| `devops` | `#f9d0c4` | Ops |
| `content` | `#f9d0c4` | Ops |

---

## Related

- `7E-PROC-01_repo-hardening.md` (dev-master full SOP)
- `.github/workflows/validate-dex.yml`
- `.github/workflows/tasks-sync.yml`
- `.github/scripts/tasks_sync.py`
- `dex/03-reserved/README.md`

#!/usr/bin/env bash
# bootstrap.sh — 7E-PROC-01 Repo Hardening Bootstrap
# Replaces all browser-based setup steps with a single CLI run.
# Prerequisites: gh CLI authed, jq installed, run from repo-hardening/ dir.
#
# Usage:
#   OWNER=k-dot-greyz REPO=my-new-repo bash bootstrap.sh
#
# What this replaces (browser steps eliminated):
#   - Settings > Rules > New ruleset (x2)  → gh api POST
#   - Labels UI click-cycle (x9)           → gh label create loop
#   - .github/ file-by-file web editor     → gh api PUT per file from templates
#   - PR creation via web form             → gh pr create

set -euo pipefail

OWNER="${OWNER:-k-dot-greyz}"
REPO="${REPO:-}"
TEMPLATE_DIR="$(cd "$(dirname "$0")" && pwd)"
GITHUB_META_DIR="$(cd "${TEMPLATE_DIR}/../../../../.github" && pwd 2>/dev/null || echo '')"

if [[ -z "$REPO" ]]; then
  echo "Error: set REPO env var before running."
  exit 1
fi

echo ">> [1/4] Applying rulesets to ${OWNER}/${REPO}..."

# Strip _meta key before posting (GitHub API ignores unknown keys, but cleaner)
for ruleset_file in ruleset-main-hardening.json ruleset-branch-governance.json; do
  jq 'del(._meta)' "${TEMPLATE_DIR}/${ruleset_file}" \
    | gh api "repos/${OWNER}/${REPO}/rulesets" \
        --method POST \
        --input - \
    && echo "  Applied: ${ruleset_file}"
done

echo ">> [2/4] Creating labels on ${OWNER}/${REPO}..."

jq -c '._labels[]' "${TEMPLATE_DIR}/labels.json" | while IFS= read -r label; do
  name=$(echo "$label" | jq -r '.name')
  color=$(echo "$label" | jq -r '.color')
  description=$(echo "$label" | jq -r '.description')
  gh label create "$name" \
    --color "$color" \
    --description "$description" \
    --repo "${OWNER}/${REPO}" \
    --force \
  && echo "  Label: $name"
done

echo ">> [3/4] Pushing .github/ scaffold via API..."

if [[ -n "$GITHUB_META_DIR" && -d "$GITHUB_META_DIR" ]]; then
  # Encode and push each file in .github/ tree
  find "$GITHUB_META_DIR" -type f | while IFS= read -r filepath; do
    rel_path=".github/${filepath#${GITHUB_META_DIR}/}"
    encoded=$(base64 -i "$filepath")
    gh api "repos/${OWNER}/${REPO}/contents/${rel_path}" \
      --method PUT \
      --field message="scaffold: add ${rel_path}" \
      --field content="$encoded" \
      --field branch="setup/github-meta" \
    && echo "  Pushed: ${rel_path}"
  done
else
  echo "  Skipping .github/ push — GITHUB_META_DIR not found. Push manually."
fi

echo ">> [4/4] Opening PR..."

gh pr create \
  --repo "${OWNER}/${REPO}" \
  --base main \
  --head setup/github-meta \
  --title "scaffold: add .github/ layer, dex/03-reserved stub, and governance setup" \
  --body-file "${TEMPLATE_DIR}/pr-body.md" \
  --label devops \
|| echo "  PR already exists or setup/github-meta not pushed yet."

echo ""
echo "Bootstrap complete for ${OWNER}/${REPO}."
echo "Review open PR and merge after Copilot review passes."

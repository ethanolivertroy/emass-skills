#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

required_files=(
  "AGENTS.md"
  "CLAUDE.md"
  "README.md"
  ".claude/skills/emasser-setup/SKILL.md"
  ".claude/skills/emasser-get/SKILL.md"
  ".claude/skills/emasser-post/SKILL.md"
  ".claude/skills/emasser-artifacts/SKILL.md"
  ".claude/skills/emasser-put/SKILL.md"
  ".claude/skills/emasser-delete/SKILL.md"
)

for file in "${required_files[@]}"; do
  if [[ ! -f "$file" ]]; then
    echo "Missing required file: $file" >&2
    exit 1
  fi
done

blocked_name="co""pilot"
blocked_title="Co""pilot"
blocked_file=".github/${blocked_name}-instructions.md"

if [[ -e "$blocked_file" ]]; then
  echo "Blocked assistant-specific instructions should not be present: $blocked_file" >&2
  exit 1
fi

if grep -RIn --exclude-dir=.git -E "${blocked_title}|${blocked_name}" .; then
  echo "Unexpected blocked assistant-specific reference found" >&2
  exit 1
fi

git diff --check

echo "Repository validation passed."

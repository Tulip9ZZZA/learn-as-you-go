#!/usr/bin/env bash
# setup-learn-as-you-go.sh
# Scaffolds the learn-as-you-go skill into a target repository (or global ~/.claude/skills)
# and idempotently wires the context pointer into CLAUDE.md or AGENTS.md.

set -euo pipefail

SCOPE="project"
TARGET_DIR="$(pwd)"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SOURCE_SKILL="$REPO_ROOT/skills/learn-as-you-go/SKILL.md"

usage() {
  cat <<'EOF'
Usage: bash scripts/setup-learn-as-you-go.sh [--global | --target <dir>]

Options:
  --global        Install globally into ~/.claude/skills/learn-as-you-go/SKILL.md
  --target <dir>  Install into <dir>/.claude/skills/learn-as-you-go/SKILL.md (default: current directory)
  -h, --help      Show this help message
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --global|-g)
      SCOPE="global"
      shift
      ;;
    --target|-t)
      [[ $# -ge 2 ]] || { echo "Error: --target requires a directory path" >&2; exit 1; }
      TARGET_DIR="$(cd "$2" && pwd)"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Error: Unknown argument: $1" >&2
      usage >&2
      exit 1
      ;;
  esac
done

if [[ ! -f "$SOURCE_SKILL" ]]; then
  echo "Error: Source skill not found at $SOURCE_SKILL" >&2
  exit 1
fi

if [[ "$SCOPE" == "global" ]]; then
  DEST_DIR="$HOME/.claude/skills/learn-as-you-go"
  mkdir -p "$DEST_DIR"
  cp "$SOURCE_SKILL" "$DEST_DIR/SKILL.md"
  echo "ok Installed global skill: $DEST_DIR/SKILL.md"
  exit 0
fi

DEST_DIR="$TARGET_DIR/.claude/skills/learn-as-you-go"
mkdir -p "$DEST_DIR"
cp "$SOURCE_SKILL" "$DEST_DIR/SKILL.md"
echo "ok Installed project skill: $DEST_DIR/SKILL.md"

STEERING_FILE="$TARGET_DIR/AGENTS.md"
if [[ -f "$TARGET_DIR/CLAUDE.md" ]]; then
  STEERING_FILE="$TARGET_DIR/CLAUDE.md"
fi

POINTER_LINE='- **Side-answers (`learn-as-you-go`)**: Answer mid-build tangent questions in under a screen, ground new terms in the current task, cite one pointer, and end with `Back to <task>. <next step>`. See `.claude/skills/learn-as-you-go/SKILL.md`.'

if [[ -f "$STEERING_FILE" ]]; then
  if grep -qF "learn-as-you-go" "$STEERING_FILE"; then
    echo "ok Context pointer already present in $STEERING_FILE"
  else
    printf '\n## Side-Answer Skill\n\n%s\n' "$POINTER_LINE" >> "$STEERING_FILE"
    echo "ok Appended context pointer to $STEERING_FILE"
  fi
else
  cat <<EOF > "$STEERING_FILE"
# AGENTS.md

## Agent skills

$POINTER_LINE
EOF
  echo "ok Created $STEERING_FILE with learn-as-you-go context pointer"
fi

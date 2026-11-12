#!/usr/bin/env bash
# Validate SKILL.md frontmatter, marketplace manifest, README SVG integrity,
# shell script syntax, and the strict no-em-dash / no-en-dash invariant.
set -euo pipefail
cd "$(dirname "$0")/.."

fail=0

echo "-> 1. Validating skills/*/SKILL.md and root learn-as-you-go/SKILL.md"
for f in skills/learn-as-you-go/SKILL.md learn-as-you-go/SKILL.md; do
  if [[ ! -f "$f" ]]; then
    echo "  x Missing $f"; fail=1; continue
  fi
  grep -qE '^name:[[:space:]]*learn-as-you-go$' "$f" || { echo "  x $f: missing 'name: learn-as-you-go'"; fail=1; }
  grep -qE '^description:[[:space:]]*.+' "$f" || { echo "  x $f: missing 'description:'"; fail=1; }
  if grep -qE '^disable-model-invocation:[[:space:]]*true' "$f"; then
    echo "  x $f: must be model-invoked (do not set disable-model-invocation: true)"; fail=1
  fi
  echo "  ok $f"
done

if ! cmp -s skills/learn-as-you-go/SKILL.md learn-as-you-go/SKILL.md; then
  echo "  x skills/learn-as-you-go/SKILL.md and learn-as-you-go/SKILL.md differ"; fail=1
fi

echo "-> 2. Validating .claude-plugin/marketplace.json and brand/brand.yaml"
manifest=".claude-plugin/marketplace.json"
[[ -f "$manifest" ]] || { echo "  x missing $manifest"; fail=1; }
grep -qE '"strict"[[:space:]]*:[[:space:]]*true' "$manifest" || { echo "  x $manifest: strict must be true"; fail=1; }
[[ -f "brand/brand.yaml" ]] || { echo "  x missing brand/brand.yaml"; fail=1; }
echo "  ok manifests"

echo "-> 3. Auditing README.md and SVG assets (no unsafe tags, valid viewBox & <title>)"
python3 scripts/audit_readme.py README.md

echo "-> 4. Checking shell scripts with bash -n"
for sh_file in scripts/*.sh; do
  bash -n "$sh_file"
  echo "  ok $sh_file"
done

echo "-> 5. Enforcing no-em-dash / no-en-dash policy across docs and skill files"
if python3 -c '
import pathlib, sys
bad = []
for p in pathlib.Path(".").rglob("*"):
    if p.is_file() and p.suffix in {".md", ".yaml", ".yml", ".json", ".sh"} and ".git" not in p.parts:
        txt = p.read_text(encoding="utf-8")
        if chr(0x2014) in txt or chr(0x2013) in txt:
            bad.append(str(p))
if bad:
    print("Found em-dash or en-dash in:", ", ".join(bad))
    sys.exit(1)
'; then
  echo "  ok zero em-dashes or en-dashes"
else
  fail=1
fi

[[ $fail -eq 0 ]] && echo "ok all checks passed" || { echo "x validation failed"; exit 1; }

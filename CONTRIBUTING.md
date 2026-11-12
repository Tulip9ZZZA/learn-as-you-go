# Contributing to `learn-as-you-go`

Contributions that sharpen trigger precision, reduce token footprint, or improve cross-agent compatibility are welcome.

## Ground Rules

1. **Keep `SKILL.md` tight**: Every token in the frontmatter `description` is loaded on every turn. Any change must earn its context load.
2. **Keep root and `skills/` in sync**: `learn-as-you-go/SKILL.md` and `skills/learn-as-you-go/SKILL.md` must remain byte-for-byte identical.
3. **No em-dashes or en-dashes**: Use colons, commas, parentheses, or hyphens (`-`).
4. **Run the check suite before opening a PR**:

```bash
bash scripts/validate-skills.sh
```

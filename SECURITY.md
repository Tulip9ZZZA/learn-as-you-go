# Security Policy

## Scope & Architecture Guarantees

`learn-as-you-go` is a pure declarative Markdown Agent Skill accompanied by static SVG/PNG brand assets and an offline POSIX bash installer (`scripts/setup-learn-as-you-go.sh`).

- **Zero network calls or telemetry**: Neither the skill nor the setup script performs outbound HTTP requests, downloads remote code, or collects telemetry.
- **Safe SVG guarantee**: Every SVG in `assets/` is validated in CI via `scripts/audit_readme.py` to forbid `<script>` and `<foreignObject>` elements.
- **Least-privilege CI**: GitHub Actions workflows run with `permissions: contents: read`.
- **No credential access**: The skill never requests, reads, or echoes environment secrets or `.env` files.

## Supported Versions

| Version | Supported |
| :--- | :--- |
| `1.0.x` | Yes |

## Reporting a Vulnerability

If you discover a security issue in the skill prompt, setup script, or SVG assets, please report it privately via [GitHub Security Advisories](https://github.com/Tulip9ZZZA/learn-as-you-go/security/advisories/new) rather than opening a public issue.

# Provenance

This directory is a vendored copy of **Cyber Neo**, a Claude Code security-analysis skill.

| | |
|---|---|
| Upstream | https://github.com/Hainrixz/cyber-neo |
| Version | 0.1.0 |
| Commit | `dcac0a8f111954e543e1e66e02a222c0c489ca74` (2026-07-17) |
| Author | mhenry |
| License | MIT — see `LICENSE` |

## Changes from upstream

**None.** `SKILL.md`, `references/` and `scripts/` are byte-identical to upstream's
`skills/cyber-neo/`. Only the repo's `LICENSE` was copied in alongside them, and this file added.

Unlike The Architect, Cyber Neo needed no path rewriting: it resolves its own resources through
`${CLAUDE_SKILL_DIR}`, which Claude Code sets for a plain skill install. Upstream wraps it in a
plugin manifest, but the skill underneath is already portable.

## What was left behind

The upstream repo root (`README.md`, `CLAUDE.md`, `assets/`, `.claude-plugin/`) is packaging, not
skill content. The installable unit is the `skills/cyber-neo/` subdirectory, which is what this is.

## Note on installing it yourself

Cloning the upstream repo straight into a skills directory does **not** work:

```bash
# WRONG — lands SKILL.md two levels too deep, so Claude Code never finds it
git clone https://github.com/Hainrixz/cyber-neo.git ~/.claude/skills/cyber-neo
#   => ~/.claude/skills/cyber-neo/skills/cyber-neo/SKILL.md
```

Claude Code discovers a skill at `<skills-root>/<name>/SKILL.md` and does not recurse. The repo's
own `skills/` wrapper has to be unwrapped — which is what `install.sh` in this repo does.

## Optional external tools

The skill degrades gracefully without them, but `semgrep` and `trivy` on `PATH` deepen the SAST and
dependency-CVE passes. Its own `scripts/` need only `python3`.

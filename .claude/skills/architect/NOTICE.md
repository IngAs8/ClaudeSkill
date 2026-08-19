# Provenance

This directory is a vendored copy of **The Architect**, a Claude Code plugin.

| | |
|---|---|
| Upstream | https://github.com/Hainrixz/the-architect |
| Version | 2.5.0 |
| Commit | `774a02278f4fa99cc44d484911007d1ba29318ab` (2026-07-28) |
| Author | Enrique Henry — https://tododeia.com |
| License | MIT — see `LICENSE` |

## Why it was vendored

Upstream ships as a Claude Code **plugin**, so every internal resource path is written as
`${CLAUDE_PLUGIN_ROOT}/…` — a variable only the plugin loader sets. Installed as a plain skill
(user scope, so it is available in every project without a marketplace), that variable is never
defined and every `knowledge/`, `questions/` and `templates/` read would resolve to nothing.

## Changes from upstream

Content is byte-identical except for path resolution and the wording that describes it:

1. `${CLAUDE_PLUGIN_ROOT}/<path>` → `<path>`, now resolved against **this skill's own directory**.
2. `${CLAUDE_PLUGIN_ROOT}/skills/architect/SKILL.md` → `SKILL.md` (the skill root *is* the plugin
   root here).
3. The "Path resolution" paragraphs in `SKILL.md`, `templates/blueprint-template.md` and
   `templates/claude-md-template.md` restate the base as the skill directory.
4. Prose that called the install location a read-only "plugin cache" now says "skill directory";
   the standing rule is unchanged — **never write there, blueprints go to `./blueprints/` in the
   user's cwd**.
5. The `commands/` mode files point at the skill (`Skill` tool, `skill: architect`) instead of at
   a plugin root or a clone-mode `CLAUDE.md`.
6. Files not needed to run the skill were dropped: `README.md`, `CHANGELOG.md`, `CONTRIBUTING.md`,
   `SECURITY.md`, `VERSIONING.md`, `CLAUDE.md` (the clone-mode mirror of `SKILL.md`), `assets/`,
   `.github/` and `.claude-plugin/`.

`knowledge/` — the runtime tracks, shapes, capabilities and version pins — is untouched.

## Updating

Upstream pins package versions with a `Last verified` date per file. Re-vendor by re-running the
same three substitutions against a fresh clone, or drop this copy and install the plugin instead:

```
/plugin marketplace add Hainrixz/the-architect
/plugin install the-architect@soyenriquerocha
```

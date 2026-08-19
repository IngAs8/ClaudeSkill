# ClaudeSkill

A collection of Claude Code skills, checked in under `.claude/skills/`.

Skills here load automatically whenever Claude Code runs **inside this repo**. To use them from any
other project, install them into user scope (`~/.claude/`):

```bash
./install.sh                      # everything below
./install.sh architect            # or just one
./install.sh --dry-run            # show what it would do, change nothing
./install.sh --uninstall [names]  # remove what it installed
```

Restart Claude Code afterwards. The script honours `CLAUDE_CONFIG_DIR`, and warns before
overwriting a same-named agent or command.

## The Architect

[github.com/Hainrixz/the-architect](https://github.com/Hainrixz/the-architect) — a meta-agent that
interviews you about what you want to build and writes a self-contained blueprint another Claude
Code instance can build from with zero prior context: acceptance criteria and a runnable verify
command on every step. It does not write application code; it designs systems.

Vendored at [`.claude/skills/architect/`](.claude/skills/architect/) (v2.5.0, MIT).
`install.sh` also puts its 3 subagents in `~/.claude/agents/` and its 6 slash commands in
`~/.claude/commands/`. Blueprints land in `./blueprints/` in whatever project you are in.

| | `/architect-quick` | `/architect` |
|---|---|---|
| Questions | 3, in one message | 12–16, across 6–7 messages |
| Time | ~10 min | ~40–60 min |
| Use when | you already know the stack | you will hand the result to an autonomous builder and walk away |

Also `/architect-brownfield` (design a change against an existing repo), `/architect-audit`
(validate a finished blueprint), `/architect-next` (resume a build from `tasks.json`),
`/architect-refresh` (re-verify pinned versions against live registries). The skill also
auto-activates on things like *"design my app"*, *"qué stack uso"*, *"hazme un blueprint"* — the
commands are optional.

## Cyber Neo

[github.com/Hainrixz/cyber-neo](https://github.com/Hainrixz/cyber-neo) — security analysis of a
local project: dependency CVEs (SCA), code patterns (SAST), leaked secrets, auth/authz flaws,
crypto weaknesses, misconfigurations, supply chain and CI/CD risks. Covers OWASP 2025 Top 10 and
CWE Top 25, and emits a prioritized report with remediation guidance.

Vendored at [`.claude/skills/cyber-neo/`](.claude/skills/cyber-neo/) (v0.1.0, MIT), byte-identical
to upstream. Activates on *"security audit"*, *"vulnerability scan"*, *"revisa la seguridad"*.
Needs `python3`; `semgrep` and `trivy` on `PATH` deepen the scan but are optional.

## Installing these upstream instead

Both also ship as Claude Code plugins — two commands inside any session, no clone and no script:

```
/plugin marketplace add Hainrixz/the-architect
/plugin install the-architect@soyenriquerocha
```

That tracks upstream releases; the vendored copies here are pinned and do not. Note that neither
repo can be cloned straight into a skills directory — both wrap their skill in a `skills/`
subdirectory, so `git clone … ~/.claude/skills/<name>` lands `SKILL.md` a level too deep and Claude
Code never finds it. Use the plugin or `install.sh`.

## The other skills

The remaining skills in `.claude/skills/` are single-file with no bundled resources, so making them
global is a copy:

```bash
mkdir -p ~/.claude/skills && cp -R .claude/skills/. ~/.claude/skills/
```

## Licenses

Each vendored skill keeps its upstream license and a `NOTICE.md` recording provenance, the exact
upstream commit, and any modification made.

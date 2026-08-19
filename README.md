# ClaudeSkill

A collection of Claude Code skills, checked in under `.claude/skills/`.

Skills in this directory load automatically whenever Claude Code runs **inside this repo**. To use
them from any other project, install them into user scope (`~/.claude/`) — see below.

## The Architect

[The Architect](https://github.com/Hainrixz/the-architect) is a meta-agent that interviews you about
what you want to build and writes a self-contained blueprint another Claude Code instance can build
from with zero prior context — acceptance criteria and a runnable verify command on every step.
It does not write application code; it designs systems.

It is vendored here at [`.claude/skills/architect/`](.claude/skills/architect/) (v2.5.0, MIT — see
[`NOTICE.md`](.claude/skills/architect/NOTICE.md) for provenance and the changes made).

### Use it in every project

```bash
./install-architect.sh
```

Installs into `~/.claude/`: the skill at `~/.claude/skills/architect/`, its three subagents in
`~/.claude/agents/`, and its six slash commands in `~/.claude/commands/`. Restart Claude Code and
`/architect` works from any directory. Blueprints land in `./blueprints/` in whatever project you
are in — never inside the skill.

```bash
./install-architect.sh --dry-run     # show what it would do, change nothing
./install-architect.sh --uninstall   # remove everything it installed
```

The script overwrites same-named files in `~/.claude/agents/` and `~/.claude/commands/`, warning as
it goes. It honours `CLAUDE_CONFIG_DIR` if you have set it.

### Or install upstream directly

Two commands inside any Claude Code session, no clone and no script:

```
/plugin marketplace add Hainrixz/the-architect
/plugin install the-architect@soyenriquerocha
```

That tracks upstream releases. The vendored copy in this repo does not — re-vendor it when you want
newer version pins, or use the plugin.

### Entry points

| | `/architect-quick` | `/architect` |
|---|---|---|
| Questions | 3, in one message | 12–16, across 6–7 messages |
| Time | ~10 min | ~40–60 min |
| Use when | you already know the stack | you will hand the result to an autonomous builder and walk away |

Also: `/architect-brownfield` (design a change against an existing repo), `/architect-audit`
(validate a finished blueprint), `/architect-next` (resume a build from `tasks.json`),
`/architect-refresh` (re-verify pinned versions against live registries).

You can skip the commands entirely — the skill auto-activates on things like *"design my app"*,
*"qué stack uso"*, *"hazme un blueprint"*.

## The other skills

The remaining skills in `.claude/skills/` are plain single-file skills with no bundled resources, so
making them global is a copy:

```bash
mkdir -p ~/.claude/skills && cp -R .claude/skills/. ~/.claude/skills/
```

## Licenses

Each vendored skill keeps its upstream license. The Architect is MIT
([`LICENSE`](.claude/skills/architect/LICENSE)).

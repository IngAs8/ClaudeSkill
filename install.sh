#!/usr/bin/env bash
# Install this repo's bundled skills into Claude Code's *user* scope (~/.claude),
# so they are available in every project on this machine — not just inside this repo.
#
#   ./install.sh                      install everything below
#   ./install.sh architect            install just one (repeatable)
#   ./install.sh --dry-run            print what would happen, touch nothing
#   ./install.sh --uninstall [names]  remove what this script installed
#
# Skills installed by this script:
#   architect   github.com/Hainrixz/the-architect  — designs blueprints. Also installs 3
#               subagents and 6 slash commands (/architect, /architect-quick, ...).
#   cyber-neo   github.com/Hainrixz/cyber-neo      — security audit of a local project.
#
# Both also exist upstream as Claude Code plugins, which need no script at all. Use this
# when you want the pinned copies that live in this repo. See README.md.

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_SRC="$REPO_DIR/.claude/skills"
CLAUDE_HOME="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
DEST_SKILLS="$CLAUDE_HOME/skills"
DEST_AGENTS="$CLAUDE_HOME/agents"
DEST_COMMANDS="$CLAUDE_HOME/commands"

ALL_SKILLS=(architect cyber-neo)
# Extras that ship with `architect`, which are directories Claude Code loads with the
# *project* as cwd rather than from inside the skill.
ARCHITECT_AGENTS=(stack-researcher blueprint-writer blueprint-validator)
ARCHITECT_COMMANDS=(architect architect-quick architect-brownfield architect-audit architect-next architect-refresh)

DRY_RUN=0
UNINSTALL=0
SELECTED=()

for arg in "$@"; do
  case "$arg" in
    --dry-run)   DRY_RUN=1 ;;
    --uninstall) UNINSTALL=1 ;;
    -h|--help)   sed -n '2,18p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//'; exit 0 ;;
    -*)          echo "unknown option: $arg" >&2; exit 2 ;;
    *)
      found=0
      for s in "${ALL_SKILLS[@]}"; do if [ "$s" = "$arg" ]; then found=1; fi; done
      if [ "$found" = 0 ]; then
        echo "unknown skill: $arg (known: ${ALL_SKILLS[*]})" >&2; exit 2
      fi
      SELECTED+=("$arg")
      ;;
  esac
done
if [ ${#SELECTED[@]} -eq 0 ]; then SELECTED=("${ALL_SKILLS[@]}"); fi

say() { printf '%s\n' "$*"; }
run() { if [ "$DRY_RUN" = 1 ]; then say "  would: $*"; else "$@"; fi; }
selected() { for s in "${SELECTED[@]}"; do [ "$s" = "$1" ] && return 0; done; return 1; }

# ---------------------------------------------------------------------------
# uninstall
# ---------------------------------------------------------------------------
if [ "$UNINSTALL" = 1 ]; then
  say "Removing from $CLAUDE_HOME: ${SELECTED[*]}"
  for s in "${SELECTED[@]}"; do
    if [ -e "$DEST_SKILLS/$s" ]; then run rm -rf "$DEST_SKILLS/$s"; fi
  done
  if selected architect; then
    for a in "${ARCHITECT_AGENTS[@]}";   do if [ -e "$DEST_AGENTS/$a.md" ];   then run rm -f "$DEST_AGENTS/$a.md";   fi; done
    for c in "${ARCHITECT_COMMANDS[@]}"; do if [ -e "$DEST_COMMANDS/$c.md" ]; then run rm -f "$DEST_COMMANDS/$c.md"; fi; done
  fi
  say "Done. Restart Claude Code to pick up the change."
  exit 0
fi

# ---------------------------------------------------------------------------
# install
# ---------------------------------------------------------------------------
# The architect agent and command files live inside its skill and reference its resources
# by bare relative path (knowledge/..., questions/..., templates/...). Claude Code loads
# ~/.claude/agents and ~/.claude/commands with the *project* as the working directory, so
# those bare paths would miss. Rather than rewrite prose, each installed copy gets a header
# stating the resource root explicitly, right after its YAML frontmatter.
emit_with_root() {  # emit_with_root <src-file> <dest-file> <resource-root>
  local src="$1" dest="$2" root="$3"
  if [ "$DRY_RUN" = 1 ]; then say "  would: write $dest"; return; fi
  awk -v root="$root" '
    BEGIN { fm = 0; done = 0 }
    { print }
    /^---[[:space:]]*$/ {
      fm++
      if (fm == 2 && !done) {
        done = 1
        print ""
        print "> **Resource root.** Every bare path below that names a file in `knowledge/`,"
        print "> `questions/`, `templates/`, `agents/` or `commands/`, and every reference to"
        print "> `SKILL.md`, resolves under `" root "/`."
        print "> The one exception is `./blueprints/`, which is always relative to the user'"'"'s"
        print "> current working directory — never write anywhere else."
      }
    }
  ' "$src" > "$dest"
}

say "Installing into $CLAUDE_HOME: ${SELECTED[*]}"
run mkdir -p "$DEST_SKILLS"

for s in "${SELECTED[@]}"; do
  src="$SKILL_SRC/$s"
  [ -d "$src" ] || { echo "missing $src — run this from a checkout of this repo" >&2; exit 1; }
  [ -f "$src/SKILL.md" ] || { echo "$src has no SKILL.md" >&2; exit 1; }
  say "skill    -> $DEST_SKILLS/$s"
  run rm -rf "$DEST_SKILLS/$s"
  run cp -R "$src" "$DEST_SKILLS/$s"
done

if selected architect; then
  root="$DEST_SKILLS/architect"
  say "agents   -> $DEST_AGENTS"
  run mkdir -p "$DEST_AGENTS"
  for a in "${ARCHITECT_AGENTS[@]}"; do
    if [ -f "$DEST_AGENTS/$a.md" ]; then say "  note: overwriting existing agent $a.md"; fi
    emit_with_root "$SKILL_SRC/architect/agents/$a.md" "$DEST_AGENTS/$a.md" "$root"
  done
  say "commands -> $DEST_COMMANDS"
  run mkdir -p "$DEST_COMMANDS"
  for c in "${ARCHITECT_COMMANDS[@]}"; do
    if [ -f "$DEST_COMMANDS/$c.md" ]; then say "  note: overwriting existing command $c.md"; fi
    emit_with_root "$SKILL_SRC/architect/commands/$c.md" "$DEST_COMMANDS/$c.md" "$root"
  done
fi

say ""
say "Done. Restart Claude Code. From any directory:"
if selected architect; then say "  /architect  /architect-quick   design a project — blueprints go to ./blueprints/"; fi
if selected cyber-neo; then say "  \"security audit of this project\"  — cyber-neo activates on its own"; fi
exit 0

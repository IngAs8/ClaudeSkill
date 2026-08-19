#!/usr/bin/env bash
# Install The Architect into Claude Code's *user* scope (~/.claude), so `/architect`
# and the `architect` skill are available in every project on this machine.
#
#   ./install-architect.sh              install (or re-install over an existing copy)
#   ./install-architect.sh --dry-run    print what would happen, touch nothing
#   ./install-architect.sh --uninstall  remove everything this script installed
#
# Upstream also ships as a plugin, which is two commands inside Claude Code and needs
# no script at all:
#   /plugin marketplace add Hainrixz/the-architect
#   /plugin install the-architect@soyenriquerocha
# Use this script when you want the copy that lives in this repo instead.

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$REPO_DIR/.claude/skills/architect"
CLAUDE_HOME="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
DEST_SKILL="$CLAUDE_HOME/skills/architect"
DEST_AGENTS="$CLAUDE_HOME/agents"
DEST_COMMANDS="$CLAUDE_HOME/commands"

DRY_RUN=0
UNINSTALL=0
for arg in "$@"; do
  case "$arg" in
    --dry-run)   DRY_RUN=1 ;;
    --uninstall) UNINSTALL=1 ;;
    -h|--help)   sed -n '2,15p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//'; exit 0 ;;
    *)           echo "unknown option: $arg" >&2; exit 2 ;;
  esac
done

say() { printf '%s\n' "$*"; }
run() { if [ "$DRY_RUN" = 1 ]; then say "  would: $*"; else "$@"; fi; }

AGENTS=(stack-researcher blueprint-writer blueprint-validator)
COMMANDS=(architect architect-quick architect-brownfield architect-audit architect-next architect-refresh)

if [ "$UNINSTALL" = 1 ]; then
  say "Removing The Architect from $CLAUDE_HOME"
  run rm -rf "$DEST_SKILL"
  for a in "${AGENTS[@]}";   do if [ -e "$DEST_AGENTS/$a.md" ];   then run rm -f "$DEST_AGENTS/$a.md";   fi; done
  for c in "${COMMANDS[@]}"; do if [ -e "$DEST_COMMANDS/$c.md" ]; then run rm -f "$DEST_COMMANDS/$c.md"; fi; done
  say "Done. Restart Claude Code (or run /reload) to pick up the change."
  exit 0
fi

[ -d "$SRC" ] || { echo "missing $SRC — run this from a checkout of this repo" >&2; exit 1; }

# The agent and command files live inside the skill and reference its resources by bare
# relative path (knowledge/…, questions/…, templates/…). Claude Code loads ~/.claude/agents
# and ~/.claude/commands with the *project* as the working directory, so those bare paths
# would miss. Rather than rewrite prose, each installed copy gets a header that states the
# resource root explicitly, right after its YAML frontmatter.
emit_with_root() {  # emit_with_root <src-file> <dest-file>
  local src="$1" dest="$2"
  if [ "$DRY_RUN" = 1 ]; then say "  would: write $dest"; return; fi
  awk -v root="$DEST_SKILL" '
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

say "Installing The Architect into $CLAUDE_HOME"

say "skill    -> $DEST_SKILL"
run mkdir -p "$(dirname "$DEST_SKILL")"
run rm -rf "$DEST_SKILL"
run cp -R "$SRC" "$DEST_SKILL"

say "agents   -> $DEST_AGENTS"
run mkdir -p "$DEST_AGENTS"
for a in "${AGENTS[@]}"; do
  if [ -f "$DEST_AGENTS/$a.md" ]; then say "  note: overwriting existing agent $a.md"; fi
  emit_with_root "$SRC/agents/$a.md" "$DEST_AGENTS/$a.md"
done

say "commands -> $DEST_COMMANDS"
run mkdir -p "$DEST_COMMANDS"
for c in "${COMMANDS[@]}"; do
  if [ -f "$DEST_COMMANDS/$c.md" ]; then say "  note: overwriting existing command $c.md"; fi
  emit_with_root "$SRC/commands/$c.md" "$DEST_COMMANDS/$c.md"
done

say ""
say "Done. Restart Claude Code, then from any directory:"
say "  /architect          full interview, ~40-60 min"
say "  /architect-quick    three questions, ~10 min"
say "Blueprints are written to ./blueprints/ in whatever project you are in."

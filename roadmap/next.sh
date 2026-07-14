#!/usr/bin/env bash

set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
readonly ROADMAP_FILE="$SCRIPT_DIR/README.md"

# shellcheck source=search.sh
source "$SCRIPT_DIR/search.sh"

usage() {
  printf '%s\n' \
    'Usage: ./roadmap/next.sh [--prompt-only]' \
    '' \
    'Validates the master roadmap and prints the canonical side-chat prompt for the' \
    'single Ready project. This command is read-only.'
}

case "${1-}" in
  '') prompt_only=false ;;
  --prompt-only) prompt_only=true ;;
  -h | --help)
    usage
    exit 0
    ;;
  *)
    usage >&2
    exit 2
    ;;
esac

validation_output=$("$SCRIPT_DIR/validate.sh")
ready_row=$(roadmap_search_regex '^\| [0-9]{2} \|.*\| Ready \|$' "$ROADMAP_FILE" || true)

if [[ -z "$ready_row" ]]; then
  if [[ "$prompt_only" == false ]]; then
    printf '%s\n' "$validation_output" 'No project is Ready: the validated roadmap is complete.'
  else
    printf '%s\n' 'The validated Rust roadmap is complete; no side-chat prompt remains.'
  fi
  exit 0
fi

IFS='|' read -r _ number project_cell _ _ _ _ <<<"$ready_row"
number=$(printf '%s' "$number" | sed -E 's/^[[:space:]]+|[[:space:]]+$//g')
brief_link=$(printf '%s' "$project_cell" | sed -E 's/^.*\]\(([^)]+)\).*$/\1/')
brief_path=$(realpath -m "$SCRIPT_DIR/$brief_link")

if [[ ! -f "$brief_path" ]]; then
  printf 'Ready project brief is missing: %s\n' "$brief_path" >&2
  exit 1
fi

title=$(sed -n "s/^# Mini-Project $number — //p" "$brief_path")
if [[ -z "$title" ]]; then
  printf 'Could not read Project %s title from %s\n' "$number" "$brief_path" >&2
  exit 1
fi

project_directory=$(dirname "$brief_path")
evidence_path="$project_directory/EVIDENCE.md"
relative_brief=${brief_path#"$ROOT_DIR/"}
relative_evidence=${evidence_path#"$ROOT_DIR/"}

if [[ -f "$evidence_path" ]]; then
  action='Resume'
  evidence_instruction="Resume $relative_evidence; inspect its current evidence and invalidated checks."
  evidence_state='existing evidence record'
else
  action='Start'
  evidence_instruction="Create $relative_evidence from roadmap/EVIDENCE_TEMPLATE.md before implementation."
  evidence_state='evidence record not created yet'
fi

if [[ "$prompt_only" == false ]]; then
  printf '%s\n' \
    "$validation_output" \
    "Current: Project $number — $title ($evidence_state)" \
    "Brief: $relative_brief" \
    '' \
    'Copy the prompt below into a new side chat:' \
    ''
fi

printf '%s\n' \
  "$action Rust Mini-Project $number: $title in workspace $ROOT_DIR." \
  '' \
  "This is the single Ready project. Read $relative_brief, roadmap/WORKFLOW.md," \
  'roadmap/TEACHING_CONTRACT.md, roadmap/STUDY_MAP.md, roadmap/ENVIRONMENT.md,' \
  'roadmap/DEPENDENCIES.md, roadmap/PROGRESS.md, and roadmap/RETRIEVAL_QUEUE.md first.' \
  "$evidence_instruction" \
  '' \
  'Teach interactively and step by step. Begin with at most two due retrieval prompts,' \
  'then ask this project’s study-map diagnostic before assigning reading. Give me one' \
  'meaningful implementation task at a time and let me attempt concept-bearing code first.' \
  'Use the teaching contract’s hint ladder; do not provide a worked solution unless I ask' \
  'or explicitly agree after lower hint levels fail. Review compiler/test output with me and' \
  'explain ownership, types, errors, invariants, and relevant async/concurrency decisions.' \
  '' \
  'Follow the project’s exact stages, non-goals, dependency policy, and environment gate.' \
  'Record current criterion-matched evidence as we work. Log focused minutes, stage outcome,' \
  'and highest hint level; use them at reflection to choose the next project’s pace.' \
  'Before completion, run every exact locked quality and project-specific runtime/target' \
  'command, complete the intentional failure, independent transfer challenge, learner' \
  'explanation, reflection, and retrieval prompts. Complete any following phase checkpoint' \
  'in this same side chat.' \
  '' \
  'Do not modify another numbered project. Update master progress/status only after every' \
  'gate passes, then run ./roadmap/validate.sh and show its result.'

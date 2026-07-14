#!/usr/bin/env bash

set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
readonly ROADMAP_FILE="$SCRIPT_DIR/README.md"
readonly PROGRESS_FILE="$SCRIPT_DIR/PROGRESS.md"
readonly EXPECTED_PROJECTS=27
readonly EXPECTED_CHECKPOINTS=6

# shellcheck source=search.sh
source "$SCRIPT_DIR/search.sh"

usage() {
  printf '%s\n' \
    'Usage: ./roadmap/audit.sh [--require-complete | --help]' \
    '' \
    'Reports live master-goal evidence. With --require-complete, exits non-zero unless' \
    'all projects, evidence records, checkpoints, and final progress state prove mastery.'
}

if (( $# > 1 )); then
  usage >&2
  exit 2
fi

case "${1-}" in
  '') require_complete=false ;;
  --require-complete) require_complete=true ;;
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

completed_projects=$(awk -F'|' '
  /^\| [0-9][0-9] \|/ {
    status = $6
    gsub(/^[[:space:]]+|[[:space:]]+$/, "", status)
    if (status == "Completed") count++
  }
  END { print count + 0 }
' "$ROADMAP_FILE")

ready_projects=$(awk -F'|' '
  /^\| [0-9][0-9] \|/ {
    status = $6
    gsub(/^[[:space:]]+|[[:space:]]+$/, "", status)
    if (status == "Ready") count++
  }
  END { print count + 0 }
' "$ROADMAP_FILE")

evidence_files=0
passed_evidence=0
while IFS= read -r evidence_file; do
  [[ -n "$evidence_file" ]] || continue
  evidence_files=$((evidence_files + 1))
  if roadmap_has_regex '^- Result: \*\*Passed\*\*$' "$evidence_file"; then
    passed_evidence=$((passed_evidence + 1))
  fi
done < <(find "$ROOT_DIR/projects" -mindepth 2 -maxdepth 2 -type f -name EVIDENCE.md -print | sort)

passed_checkpoints=$(awk -F'|' '
  /^\| C[1-6] / {
    status = $4
    gsub(/^[[:space:]]+|[[:space:]]+$/, "", status)
    if (status == "Passed") count++
  }
  END { print count + 0 }
' "$PROGRESS_FILE")

current_position=$(sed -n 's/^- Current project: \*\*\(.*\)\*\*$/\1/p' "$PROGRESS_FILE")
progress_status=$(sed -n 's/^- Status: \*\*\(.*\)\*\*$/\1/p' "$PROGRESS_FILE")

completion_proven=false
if [[ "$completed_projects" -eq "$EXPECTED_PROJECTS" \
   && "$passed_evidence" -eq "$EXPECTED_PROJECTS" \
   && "$passed_checkpoints" -eq "$EXPECTED_CHECKPOINTS" \
   && "$ready_projects" -eq 0 \
   && "$current_position" == 'none — roadmap complete' \
   && "$progress_status" == 'complete' ]]; then
  completion_proven=true
fi

remaining_projects=$((EXPECTED_PROJECTS - completed_projects))
remaining_evidence=$((EXPECTED_PROJECTS - passed_evidence))
remaining_checkpoints=$((EXPECTED_CHECKPOINTS - passed_checkpoints))

printf '%s\n' \
  'Rust master-goal audit' \
  "$validation_output" \
  'Planned coverage: mapped and structurally validated (not mastery evidence).' \
  "Projects mastered: $completed_projects/$EXPECTED_PROJECTS" \
  "Evidence records present: $evidence_files/$EXPECTED_PROJECTS" \
  "Evidence records passed: $passed_evidence/$EXPECTED_PROJECTS" \
  "Cumulative checkpoints passed: $passed_checkpoints/$EXPECTED_CHECKPOINTS" \
  "Current position: ${current_position:-unrecorded}" \
  "Progress status: ${progress_status:-unrecorded}"

if [[ "$completion_proven" == true ]]; then
  printf '%s\n' \
    'Goal completion: PROVEN by the validated current workspace.' \
    'No numbered project, evidence record, or cumulative checkpoint remains.'
  exit 0
fi

printf '%s\n' \
  'Goal completion: NOT YET PROVEN.' \
  "Remaining project mastery records: $remaining_projects" \
  "Remaining passing evidence records: $remaining_evidence" \
  "Remaining cumulative checkpoints: $remaining_checkpoints" \
  'Next handoff: run ./roadmap/next.sh and use the generated separate side-chat prompt.'

if [[ "$require_complete" == true ]]; then
  exit 1
fi

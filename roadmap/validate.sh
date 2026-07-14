#!/usr/bin/env bash

set -u
set -o pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
readonly PROJECTS_DIR="$ROOT_DIR/projects"
readonly ROADMAP_FILE="$SCRIPT_DIR/README.md"
readonly PROGRESS_FILE="$SCRIPT_DIR/PROGRESS.md"
readonly EXPECTED_PROJECTS=27

# shellcheck source=search.sh
source "$SCRIPT_DIR/search.sh"

failures=0

fail() {
  printf 'ERROR: %s\n' "$*" >&2
  failures=$((failures + 1))
}

require_tool() {
  if ! command -v "$1" >/dev/null 2>&1; then
    printf 'ERROR: required tool not found: %s\n' "$1" >&2
    exit 2
  fi
}

trim() {
  local value=$1
  value="${value#"${value%%[![:space:]]*}"}"
  value="${value%"${value##*[![:space:]]}"}"
  printf '%s' "$value"
}

require_tool find
require_tool realpath
require_tool sed
require_tool seq
require_tool sort
require_tool wc

if [[ ! -d "$PROJECTS_DIR" ]]; then
  printf 'ERROR: projects directory not found: %s\n' "$PROJECTS_DIR" >&2
  exit 2
fi

for required_file in \
  "$ROOT_DIR/README.md" \
  "$SCRIPT_DIR/audit.sh" \
  "$SCRIPT_DIR/CAPSTONE_SCORECARD.md" \
  "$SCRIPT_DIR/COVERAGE.md" \
  "$SCRIPT_DIR/DEPENDENCIES.md" \
  "$SCRIPT_DIR/EVIDENCE_TEMPLATE.md" \
  "$SCRIPT_DIR/ENVIRONMENT.md" \
  "$SCRIPT_DIR/MASTERY_CHECKPOINTS.md" \
  "$SCRIPT_DIR/next.sh" \
  "$SCRIPT_DIR/PROGRESS.md" \
  "$SCRIPT_DIR/PROJECT_TEMPLATE.md" \
  "$SCRIPT_DIR/RETRIEVAL_QUEUE.md" \
  "$SCRIPT_DIR/search.sh" \
  "$SCRIPT_DIR/STUDY_MAP.md" \
  "$SCRIPT_DIR/TEACHING_CONTRACT.md" \
  "$SCRIPT_DIR/WORKFLOW.md"; do
  [[ -f "$required_file" ]] || fail "missing supporting file: ${required_file#"$ROOT_DIR/"}"
done

if ! bash -n "$SCRIPT_DIR/search.sh"; then
  fail 'roadmap/search.sh has invalid Bash syntax'
fi

for script_name in audit.sh next.sh validate.sh; do
  if roadmap_has_regex '(^|[;&|[:space:]])rg([[:space:]]|$)' "$SCRIPT_DIR/$script_name"; then
    fail "roadmap/$script_name bypasses the shared search layer"
  fi
done

for script_name in audit.sh next.sh; do
  if [[ ! -x "$SCRIPT_DIR/$script_name" ]]; then
    fail "roadmap/$script_name must be executable"
  fi

  if ! bash -n "$SCRIPT_DIR/$script_name"; then
    fail "roadmap/$script_name has invalid Bash syntax"
  fi
done

for criterion in \
  'Toolchain, rustup, Cargo, rustfmt, Clippy, rustdoc' \
  'Ownership, borrowing, moves, slices' \
  'Lifetimes' \
  '`Option`, `Result`, `?`, typed errors' \
  'Modules and visibility' \
  'Generics, traits, associated types, bounds' \
  'Testing and documentation' \
  'Serde and structured data' \
  'Benchmarking, profiling, performance mindset' \
  'Threads, channels, `Arc`, `Mutex`, `Send`/`Sync`' \
  'Async/await and Tokio' \
  'Structured logging/tracing' \
  'Declarative macros' \
  'Unsafe Rust and FFI' \
  'Static versus dynamic dispatch' \
  'Workspaces, CI, packaging, release operation' \
  'CLI and utilities' \
  'Web backend/API' \
  'Browser WASM frontend' \
  'Systems and embedded' \
  'Game development' \
  'Desktop GUI' \
  'Mobile application' \
  'Networking' \
  'Data engineering' \
  'ML/inference' \
  'Blockchain/crypto ecosystem' \
  'Architecture/integration'; do
  roadmap_has_fixed "$criterion" "$SCRIPT_DIR/COVERAGE.md" || \
    fail "COVERAGE.md is missing criterion: $criterion"
done

for heading in \
  '## Scope boundary' \
  '## Start or resume protocol' \
  '## Learner-first implementation loop' \
  '## Hint ladder' \
  '## Explanation standard' \
  '## Rust review rubric' \
  '## Acceleration without skipping mastery' \
  '## Commands, edits, and evidence integrity' \
  '## Session handoff'; do
  roadmap_has_fixed "$heading" "$SCRIPT_DIR/TEACHING_CONTRACT.md" || \
    fail "TEACHING_CONTRACT.md is missing $heading"
done

for heading in \
  '## One side chat per project' \
  '## Learning loop' \
  '## Adaptive pace loop' \
  '## Default quality gates' \
  '## Mastery gate'; do
  roadmap_has_fixed "$heading" "$SCRIPT_DIR/WORKFLOW.md" || \
    fail "WORKFLOW.md is missing $heading"
done

for marker in \
  '## Session and pace log' \
  '- Next-project pace decision: compress mechanical steps / normal pace / targeted remediation:'; do
  roadmap_has_fixed "$marker" "$SCRIPT_DIR/EVIDENCE_TEMPLATE.md" || \
    fail "EVIDENCE_TEMPLATE.md is missing pace marker: $marker"
done

roadmap_has_fixed 'Session pace data and the next-project pace decision are recorded.' \
  "$SCRIPT_DIR/PROJECT_TEMPLATE.md" || \
  fail 'PROJECT_TEMPLATE.md is missing the adaptive-pace completion item'

for heading in \
  '## Core Rust and workspace' \
  '## Native build, database, network, and diagnostics' \
  '## Web and WASM' \
  '## Embedded and systems' \
  '## Game development' \
  '## Tauri desktop' \
  '## Tauri Android' \
  '## Project setup queue' \
  '## Recheck protocol'; do
  roadmap_has_fixed "$heading" "$SCRIPT_DIR/ENVIRONMENT.md" || \
    fail "ENVIRONMENT.md is missing $heading"
done

project_readme_count=$(find "$PROJECTS_DIR" -mindepth 2 -maxdepth 2 -name README.md -type f | wc -l)
if [[ "$project_readme_count" -ne "$EXPECTED_PROJECTS" ]]; then
  fail "expected $EXPECTED_PROJECTS project README files, found $project_readme_count"
fi

mapfile -t study_rows < <(roadmap_search_regex '^\| (0[1-9]|1[0-9]|2[0-7]) \|' "$SCRIPT_DIR/STUDY_MAP.md")
if [[ "${#study_rows[@]}" -ne "$EXPECTED_PROJECTS" ]]; then
  fail "STUDY_MAP.md must contain $EXPECTED_PROJECTS project rows; found ${#study_rows[@]}"
fi

for number in $(seq -w 1 "$EXPECTED_PROJECTS"); do
  study_row_count=$(roadmap_count_regex "^\| $number \|" "$SCRIPT_DIR/STUDY_MAP.md")
  [[ "$study_row_count" -eq 1 ]] || \
    fail "STUDY_MAP.md must contain exactly one row for Project $number; found $study_row_count"
done

declare -A project_directories=()

for number in $(seq -w 1 "$EXPECTED_PROJECTS"); do
  mapfile -t matching_directories < <(
    find "$PROJECTS_DIR" -mindepth 1 -maxdepth 1 -type d -name "$number-*" -print | sort
  )

  if [[ "${#matching_directories[@]}" -ne 1 ]]; then
    fail "project $number must have exactly one directory; found ${#matching_directories[@]}"
    continue
  fi

  project_directories["$number"]=${matching_directories[0]}
  readme="${matching_directories[0]}/README.md"
  if [[ ! -f "$readme" ]]; then
    fail "project $number is missing README.md"
    continue
  fi

  if ! roadmap_has_regex "^# Mini-Project $number — " "$readme"; then
    fail "project $number heading does not match its directory number"
  fi

  for heading in \
    '## Outcome' \
    '## Required verification' \
    '## Transfer challenge' \
    '## Completion checklist'; do
    roadmap_has_fixed "$heading" "$readme" || fail "${readme#"$ROOT_DIR/"} is missing $heading"
  done

  if ! roadmap_has_regex '^## (Stages|Build stages|Architecture and implementation gates)$' "$readme"; then
    fail "${readme#"$ROOT_DIR/"} is missing an explicit staged implementation section"
  fi

  if [[ "$number" != '01' ]] && ! roadmap_has_regex '^## Unlock condition$' "$readme"; then
    fail "${readme#"$ROOT_DIR/"} is missing ## Unlock condition"
  fi
done

mapfile -t roadmap_rows < <(roadmap_search_regex '^\| [0-9]{2} \|' "$ROADMAP_FILE")
if [[ "${#roadmap_rows[@]}" -ne "$EXPECTED_PROJECTS" ]]; then
  fail "roadmap table must contain $EXPECTED_PROJECTS project rows; found ${#roadmap_rows[@]}"
fi

ready_count=0
completed_count=0
locked_count=0
ready_project=''
progression_state='completed'
declare -A project_statuses=()

for index in "${!roadmap_rows[@]}"; do
  row="${roadmap_rows[$index]}"
  IFS='|' read -r _ number _ _ _ status _ <<<"$row"
  number=$(trim "$number")
  status=$(trim "$status")
  expected_number=$(printf '%02d' "$((index + 1))")
  project_statuses["$number"]=$status

  [[ "$number" == "$expected_number" ]] || \
    fail "roadmap row $((index + 1)) has project $number; expected $expected_number"

  case "$status" in
    Completed)
      completed_count=$((completed_count + 1))
      if [[ "$progression_state" != 'completed' ]]; then
        fail "Completed project $number appears after a Ready or Locked project"
      fi
      ;;
    Ready)
      ready_count=$((ready_count + 1))
      ready_project=$number
      if [[ "$progression_state" != 'completed' ]]; then
        fail "Ready project $number is not the single boundary after completed projects"
      fi
      progression_state='ready'
      ;;
    Locked)
      locked_count=$((locked_count + 1))
      progression_state='locked'
      ;;
    *)
      fail "project $number has unsupported roadmap status '$status'"
      ;;
  esac
done

for number in $(seq -w 1 "$EXPECTED_PROJECTS"); do
  [[ "${project_statuses[$number]-}" == 'Completed' ]] || continue

  project_directory=${project_directories[$number]-}
  [[ -n "$project_directory" ]] || continue
  evidence_file="$project_directory/EVIDENCE.md"
  relative_evidence=${evidence_file#"$ROOT_DIR/"}

  if [[ ! -f "$evidence_file" ]]; then
    fail "Completed project $number is missing $relative_evidence"
    continue
  fi

  roadmap_has_regex "^# Project $number — .+ Evidence$" "$evidence_file" || \
    fail "$relative_evidence heading does not match Project $number"
  roadmap_has_regex '^- Result: \*\*Passed\*\*$' "$evidence_file" || \
    fail "$relative_evidence is not marked Passed"

  for heading in \
    '## Completion state' \
    '## Session and pace log' \
    '## Environment' \
    '## Implementation summary' \
    '## Targeted study and drills' \
    '## Acceptance criteria' \
    '## Verification' \
    '## Test design' \
    '## Intentional failure' \
    '## Transfer challenge' \
    '## Learner explanation' \
    '## Dependency and toolchain decisions' \
    '## Reflection' \
    '## Remaining gaps'; do
    roadmap_has_fixed "$heading" "$evidence_file" || fail "$relative_evidence is missing $heading"
  done

  if roadmap_has_regex '(YYYY-MM-DD|\*\*In progress\*\*|^- Completed: —$|\bTBD\b)' "$evidence_file"; then
    fail "$relative_evidence still contains completion-template placeholders"
  fi

  for command_name in 'cargo fmt' 'cargo test' 'cargo clippy' 'cargo doc'; do
    roadmap_has_fixed "$command_name" "$evidence_file" || \
      fail "$relative_evidence does not record $command_name verification"
  done

  mapfile -t completion_rows < <(roadmap_search_regex "^\| $number — " "$PROGRESS_FILE")
  if [[ "${#completion_rows[@]}" -ne 1 ]]; then
    fail "PROGRESS.md must contain exactly one completion-log row for Project $number"
  elif [[ "${completion_rows[0]}" != *"../$relative_evidence"* ]]; then
    fail "PROGRESS.md Project $number row does not link to ../$relative_evidence"
  fi
done

if [[ "$completed_count" -eq "$EXPECTED_PROJECTS" ]]; then
  [[ "$ready_count" -eq 0 && "$locked_count" -eq 0 ]] || \
    fail 'an all-completed roadmap cannot contain Ready or Locked projects'
else
  [[ "$ready_count" -eq 1 ]] || fail "an active roadmap must have exactly one Ready project; found $ready_count"
fi

current_project=$(sed -n 's/^- Current project: \*\*\([0-9][0-9]\).*/\1/p' "$PROGRESS_FILE")
if [[ "$completed_count" -eq "$EXPECTED_PROJECTS" ]]; then
  roadmap_has_regex '^- Current project: \*\*none — roadmap complete\*\*$' "$PROGRESS_FILE" || \
    fail 'an all-completed roadmap must set PROGRESS.md current project to none — roadmap complete'
  roadmap_has_regex '^- Status: \*\*complete\*\*$' "$PROGRESS_FILE" || \
    fail 'an all-completed roadmap must set PROGRESS.md status to complete'
elif [[ "$ready_count" -eq 1 ]]; then
  [[ -n "$current_project" ]] || fail 'PROGRESS.md does not contain a numbered current project'
  [[ "$current_project" == "$ready_project" ]] || \
    fail "PROGRESS.md current project $current_project does not match roadmap Ready project $ready_project"
fi

mapfile -t checkpoint_rows < <(roadmap_search_regex '^\| C[1-6] ' "$PROGRESS_FILE")
if [[ "${#checkpoint_rows[@]}" -ne 6 ]]; then
  fail "PROGRESS.md must contain six cumulative checkpoint rows; found ${#checkpoint_rows[@]}"
fi

declare -A checkpoint_statuses=()
expected_checkpoint_projects=(07 13 19 22 26 27)
for index in "${!checkpoint_rows[@]}"; do
  row="${checkpoint_rows[$index]}"
  IFS='|' read -r _ gate required_after status _ _ <<<"$row"
  gate=$(trim "$gate")
  required_after=$(trim "$required_after")
  status=$(trim "$status")
  expected_gate="C$((index + 1))"

  [[ "$gate" == "$expected_gate "* ]] || \
    fail "checkpoint row $((index + 1)) is '$gate'; expected $expected_gate"
  [[ "$required_after" == "${expected_checkpoint_projects[$index]}" ]] || \
    fail "$expected_gate must be required after Project ${expected_checkpoint_projects[$index]}"

  case "$status" in
    Locked | Ready | Passed | 'Targeted retry' | Revisit) ;;
    *) fail "$expected_gate has unsupported status '$status'" ;;
  esac
  checkpoint_statuses["$expected_gate"]=$status
done

phase_gate_next_projects=(08 14 20 23 27)
for index in "${!phase_gate_next_projects[@]}"; do
  gate="C$((index + 1))"
  next_project=${phase_gate_next_projects[$index]}
  next_status=${project_statuses["$next_project"]-}
  if [[ "$next_status" == 'Ready' || "$next_status" == 'Completed' ]]; then
    [[ "${checkpoint_statuses[$gate]-}" == 'Passed' ]] || \
      fail "$next_project cannot be $next_status until $gate is Passed"
  fi
done

if [[ "$completed_count" -eq "$EXPECTED_PROJECTS" && "${checkpoint_statuses[C6]-}" != 'Passed' ]]; then
  fail 'an all-completed roadmap requires C6 — Final synthesis to be Passed'
fi

phase_gate_specs=(
  '08:c1--foundation-checkpoint-after-project-07-before-project-08'
  '14:c2--practical-and-concurrency-checkpoint-after-project-13-before-project-14'
  '20:c3--specialization-checkpoint-after-project-19-before-project-20'
  '23:c4--advanced-language-checkpoint-after-project-22-before-project-23'
  '27:c5--breadth-checkpoint-after-project-26-before-project-27'
)

for spec in "${phase_gate_specs[@]}"; do
  number=${spec%%:*}
  anchor=${spec#*:}
  project_readme=$(find "$PROJECTS_DIR" -mindepth 2 -maxdepth 2 -path "*/$number-*/README.md" -print)
  if [[ -n "$project_readme" ]] && ! roadmap_has_regex "MASTERY_CHECKPOINTS.md#$anchor" "$project_readme"; then
    fail "project $number does not reference its cumulative checkpoint gate"
  fi
done

mapfile -t markdown_files < <(
  {
    printf '%s\n' "$ROOT_DIR/README.md"
    find "$SCRIPT_DIR" -maxdepth 1 -type f -name '*.md' -print
    find "$PROJECTS_DIR" -mindepth 2 -maxdepth 2 -type f \( -name README.md -o -name EVIDENCE.md \) -print
  } | sort -u
)

for markdown_file in "${markdown_files[@]}"; do
  link_output=$(roadmap_only_regex '\[[^]]+\]\([^)]+\)' "$markdown_file")
  link_status=$?
  if [[ "$link_status" -ne 0 && "$link_status" -ne 1 ]]; then
    fail "could not scan Markdown links in ${markdown_file#"$ROOT_DIR/"}"
    continue
  fi

  while IFS= read -r link_target; do
    [[ -n "$link_target" ]] || continue
    case "$link_target" in
      http://* | https://* | mailto:* | \#*) continue ;;
    esac

    clean_target=${link_target%%#*}
    [[ -n "$clean_target" ]] || continue
    resolved=$(realpath -m "$(dirname "$markdown_file")/$clean_target")
    if [[ ! -e "$resolved" ]]; then
      fail "broken local link in ${markdown_file#"$ROOT_DIR/"}: $link_target"
    fi
  done < <(printf '%s\n' "$link_output" | sed -E 's/^.*\]\(([^)]+)\)$/\1/')
done

while IFS= read -r unlocked_command; do
  fail "explicit Cargo quality/build command is missing --locked: $unlocked_command"
done < <(
  roadmap_find_unlocked_cargo_commands "$SCRIPT_DIR" "$PROJECTS_DIR" || true
)

if [[ "$failures" -ne 0 ]]; then
  printf 'Roadmap validation failed with %d error(s).\n' "$failures" >&2
  exit 1
fi

printf 'Roadmap validation passed: %d projects (%d Completed, %d Ready, %d Locked).\n' \
  "$EXPECTED_PROJECTS" "$completed_count" "$ready_count" "$locked_count"

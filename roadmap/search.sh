#!/usr/bin/env bash

# Shared read-only text-search helpers for roadmap scripts.
# Set ROADMAP_SEARCH_BACKEND=grep or =rg to force a backend during diagnostics/tests.

if [[ -n "${ROADMAP_SEARCH_SH_LOADED-}" ]]; then
  return 0
fi
readonly ROADMAP_SEARCH_SH_LOADED=1

case "${ROADMAP_SEARCH_BACKEND-auto}" in
  auto)
    if command -v rg >/dev/null 2>&1; then
      readonly ROADMAP_SEARCH_BACKEND_SELECTED=rg
    elif command -v grep >/dev/null 2>&1; then
      readonly ROADMAP_SEARCH_BACKEND_SELECTED=grep
    else
      printf '%s\n' 'ERROR: required text-search tool not found: install grep or ripgrep (rg)' >&2
      return 2
    fi
    ;;
  rg)
    if ! command -v rg >/dev/null 2>&1; then
      printf '%s\n' 'ERROR: ROADMAP_SEARCH_BACKEND=rg requested, but rg was not found' >&2
      return 2
    fi
    readonly ROADMAP_SEARCH_BACKEND_SELECTED=rg
    ;;
  grep)
    if ! command -v grep >/dev/null 2>&1; then
      printf '%s\n' 'ERROR: ROADMAP_SEARCH_BACKEND=grep requested, but grep was not found' >&2
      return 2
    fi
    readonly ROADMAP_SEARCH_BACKEND_SELECTED=grep
    ;;
  *)
    printf 'ERROR: unsupported ROADMAP_SEARCH_BACKEND: %s\n' \
      "$ROADMAP_SEARCH_BACKEND" >&2
    return 2
    ;;
esac

roadmap_search_regex() {
  local pattern=$1
  shift
  if [[ "$ROADMAP_SEARCH_BACKEND_SELECTED" == rg ]]; then
    rg -- "$pattern" "$@"
  else
    grep -E -- "$pattern" "$@"
  fi
}

roadmap_has_regex() {
  local pattern=$1
  shift
  if [[ "$ROADMAP_SEARCH_BACKEND_SELECTED" == rg ]]; then
    rg -q -- "$pattern" "$@"
  else
    grep -Eq -- "$pattern" "$@"
  fi
}

roadmap_has_fixed() {
  local pattern=$1
  shift
  if [[ "$ROADMAP_SEARCH_BACKEND_SELECTED" == rg ]]; then
    rg -q -F -- "$pattern" "$@"
  else
    grep -Fq -- "$pattern" "$@"
  fi
}

roadmap_count_regex() {
  local pattern=$1
  shift
  if [[ "$ROADMAP_SEARCH_BACKEND_SELECTED" == rg ]]; then
    rg -c -- "$pattern" "$@"
  else
    grep -Ec -- "$pattern" "$@"
  fi
}

roadmap_only_regex() {
  local pattern=$1
  shift
  if [[ "$ROADMAP_SEARCH_BACKEND_SELECTED" == rg ]]; then
    rg -o -- "$pattern" "$@"
  else
    grep -Eo -- "$pattern" "$@"
  fi
}

roadmap_find_unlocked_cargo_commands() {
  local pattern='^cargo (run|test|clippy|doc|check|build|bench|tree|metadata)([[:space:]]|$)'
  if [[ "$ROADMAP_SEARCH_BACKEND_SELECTED" == rg ]]; then
    rg -n --glob '*.md' -- "$pattern" "$@" | rg -v -F -- '--locked'
  else
    grep -RInE --include='*.md' -- "$pattern" "$@" | grep -vF -- '--locked'
  fi
}

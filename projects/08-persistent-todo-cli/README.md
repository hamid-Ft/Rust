# Mini-Project 08 — Persistent Todo CLI

## Unlock condition

Complete the fundamentals phase through Project 07, including its reflection, then
pass [C1 — Foundation](../../roadmap/MASTERY_CHECKPOINTS.md#c1--foundation-checkpoint-after-project-07-before-project-08).

## Outcome

Build the first genuinely useful application in the roadmap: a command-line task
manager with typed subcommands and durable JSON storage. Integrate Clap, Serde,
filesystem APIs, library errors, and binary-level context.

## Non-goals

No database, synchronization service, TUI, or async runtime. This project is about a
clean CLI boundary and reliable local persistence.

## Artifact and behavior

- `add`, `list`, `show`, `complete`, `remove`, and `clear-completed` subcommands.
- Validated task IDs, non-empty descriptions, completion state, and created time.
- Filters for open/completed tasks with explicit, stable output ordering.
- A configurable data-file path so tests never touch the learner's real data.
- Human-readable default output and machine-readable JSON output.
- Atomic writes using a sibling temporary file followed by replacement/rename.
- Useful errors for missing files, malformed JSON, invalid IDs, and failed writes.

Keep domain and repository logic in the library. Clap parsing, output formatting, and
`anyhow::Context` belong at the binary boundary. Library APIs retain typed errors.

## Concept checklist

- [ ] Clap derive types model subcommands and arguments.
- [ ] Serde derives map explicit domain/storage types to JSON.
- [ ] Domain types are not weakened merely to make serialization convenient.
- [ ] Paths use `Path`/`PathBuf`, not string concatenation.
- [ ] Atomic persistence protects the old file from partial writes.
- [ ] `anyhow` does not leak into the reusable library API.
- [ ] Process exit status distinguishes success from failure.

## Build stages

1. Model task entities, validated IDs, commands, and repository errors.
2. Implement the in-memory command behavior with unit tests.
3. Add JSON load/save and first-run behavior.
4. Make saving atomic and define failure cleanup behavior.
5. Add Clap subcommands and render human/JSON output.
6. Add process-level integration tests using isolated temporary directories.
7. Intentionally corrupt a fixture and trace the error from storage to CLI output.

## Required verification

Run the default quality commands, plus process-level tests covering every subcommand,
non-zero exits, `--help`, JSON output, persistence across invocations, corrupt input,
and an unwritable destination where the platform permits it. Inspect the data file
after each mutation and confirm no temporary file remains after success.

## Transfer challenge

Add `edit ID` with optional description and completion changes. Reject an edit that
changes nothing, preserve the task's creation time, and write only after all requested
changes validate. Add process-level tests proving an invalid edit leaves the file
byte-for-byte unchanged.

## Completion checklist

- [ ] All subcommands and error exits work across separate invocations.
- [ ] Library and binary error responsibilities are separated.
- [ ] Persistent writes are atomic within the documented platform assumptions.
- [ ] Integration tests are isolated from real user state.
- [ ] Default quality commands pass.
- [ ] Transfer challenge and reflection are complete.

## Primary references

- [Clap derive reference](https://docs.rs/clap/latest/clap/_derive/)
- [Serde derive guide](https://serde.rs/derive.html)

## Related Rustlings drills

- `10_modules`
- `13_error_handling`
- `15_traits`
- `17_tests`
- `23_conversions`

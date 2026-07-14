# Mini-Project 01 — Toolchain Health Check

## Outcome

Create a tiny, well-structured Rust crate and learn the development feedback loop:
edit, format, compile, test, lint, document, and run. This is intentionally small;
the artifact is the verified workflow rather than a feature-heavy application.

## Prerequisites

- A stable Rust toolchain installed through `rustup`.
- Cargo, rustfmt, and Clippy available.
- An editor with rust-analyzer recommended.

The workspace baseline already confirms all command-line prerequisites.

## Artifact

Initialize this directory itself as a binary package named `toolchain_health`; do not
create a nested crate. `Cargo.toml`, `Cargo.lock`, `src/`, and this brief must remain at
the same project root. Keep calculation and validation logic in `src/lib.rs` and
terminal input/output in `src/main.rs`.

The program accepts a user name and a number of completed study sessions, validates
them, and prints a small progress message. The deliberately simple behavior gives us
room to focus on crate structure and tooling.

## Acceptance contract

- The initial command shape is `toolchain_health <NAME> <SESSIONS>` using positional
  arguments. Decide and record the exact success text before implementing it.
- `NAME` must contain at least one non-whitespace character.
- `SESSIONS` must parse as a non-negative integer.
- Valid input writes the progress message to standard output and exits successfully.
- Missing, extra, blank, or malformed input writes a useful diagnostic to standard
  error and exits non-zero without panicking.
- Use the standard library only. Argument-parsing crates arrive in Project 08, where
  their added abstraction is part of the lesson.
- The transfer challenge extends the shape to
  `toolchain_health <NAME> <SESSIONS> [WEEKLY_GOAL]`; it must preserve the original
  two-argument behavior.

## Non-goals

- Interactive prompts, persistence, configuration files, networking, or a terminal UI.
- `clap`, `anyhow`, `thiserror`, test-helper crates, or any other external dependency.
- A generalized CLI framework or elaborate error hierarchy for this small program.

## Stages

### 1. Initialize and inspect

- Initialize the crate at this project root without overwriting this brief.
- Explain `Cargo.toml`, `Cargo.lock`, `src/main.rs`, and the target directory.
- Run the initial application.

### 2. Separate logic from I/O

- Add a library module containing the progress-message logic.
- Call the library from the binary.
- Explain why testable logic should not depend on terminal I/O.

### 3. Validate inputs

- Reject a blank or whitespace-only name.
- Accept a session count as a non-negative integer.
- Represent expected failures with `Result`, not panic.
- Do not use `unwrap` or `expect` in production code.

### 4. Test and document

- Test a valid learner name and session count.
- Test the blank-name error.
- Test malformed numeric input at the appropriate boundary.
- Add standard-library integration tests that execute the compiled binary and prove at
  least one successful and one failing CLI case, including exit status and output stream.
- Add a doc-tested example for the public progress-message API.

### 5. Experience the feedback loop

- Intentionally introduce a formatting issue, predict the formatter check, observe it,
  and fix it with rustfmt.
- Intentionally introduce a type error, predict the compiler diagnostic, observe it with
  `cargo check`, and fix it.
- Intentionally introduce a failing assertion, predict the test output, observe it with
  the narrowest relevant test command, and fix it.
- Record the prediction and diagnostic for each failure, then explain why the responsible
  tool catches a different class of problem.

## Required verification

```sh
cargo run --locked -- "Ferris" 3
cargo fmt --all -- --check
cargo check --all-targets --all-features --locked
cargo test --all-targets --all-features --locked
cargo clippy --all-targets --all-features --locked -- -D warnings
cargo doc --no-deps --locked
```

Also confirm that invalid input returns a useful message and a non-zero process exit
status with both of these commands:

```sh
cargo run --locked -- "" 3
cargo run --locked -- "Ferris" not-a-number
```

## Transfer challenge

Without a worked solution, add an optional weekly goal. When supplied, the output
must report completed sessions, the goal, and remaining sessions using saturating
arithmetic so progress above the goal never produces a negative result. Add tests for
progress below, equal to, and above the goal.

## Completion checklist

- [ ] Crate structure is understood.
- [ ] Domain logic and terminal I/O are separated.
- [ ] Expected failures use `Result`.
- [ ] Production code contains no `unwrap` or `expect`.
- [ ] Unit and doc tests pass.
- [ ] Binary integration tests prove stdout/stderr and exit-status behavior.
- [ ] Formatting, compiler check, Clippy, and documentation commands pass.
- [ ] Invalid input behavior is manually verified.
- [ ] Transfer challenge is complete.
- [ ] Reflection and evidence are added to `roadmap/PROGRESS.md`.

## Related Rustlings drills

Use these only when the project exposes a gap:

- `00_intro`
- `01_variables`
- `02_functions`
- `03_if`
- `17_tests`
- `22_clippy`

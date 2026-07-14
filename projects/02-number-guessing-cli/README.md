# Mini-Project 02 — Number Guessing CLI

## Unlock condition

Complete Mini-Project 01, including its transfer challenge and progress entry.

## Outcome

Build a replayable number-guessing game while learning variables, mutability,
functions, loops, parsing, ranges, pattern matching, and use of an external crate.

## Non-goals

No persistent scores, GUI, async work, or elaborate CLI framework. The focus is
control flow and separating nondeterministic I/O from deterministic game logic.

## Artifact and behavior

- Generate a secret integer inside an inclusive range using a random-number crate.
- Repeatedly read guesses until the player wins or explicitly quits.
- Treat malformed and out-of-range guesses as recoverable user errors.
- Report too low, too high, or correct using `Ordering` and exhaustive `match`.
- Count valid attempts; malformed input must not increase the count.
- Allow another round without restarting the process.

Keep comparison and validation logic in the library. Keep randomness and terminal
I/O at the binary boundary so tests are deterministic.

## Concept checklist

- [ ] Immutable bindings versus `mut` are used deliberately.
- [ ] Numeric types and inclusive ranges are understood.
- [ ] `loop`, `break`, and `continue` have clear jobs.
- [ ] `str::parse` errors are handled without panic.
- [ ] `match` is exhaustive and guards are used only when they improve clarity.
- [ ] The random crate's API is read from its current documentation.

## Build stages

1. Model a pure `compare_guess(secret, guess)` operation.
2. Add range validation and tests for boundary values.
3. Implement one terminal round with a fixed secret.
4. Replace the fixed secret with injected/generated randomness.
5. Add quitting, attempt counting, and replay.
6. Intentionally trigger and explain a type mismatch involving parsed input.

## Required verification

Run the default commands in `roadmap/WORKFLOW.md`, plus manual sessions proving:

- low, high, and winning guesses;
- malformed and out-of-range input;
- quitting and replay;
- deterministic library tests that never depend on random output.

## Transfer challenge

Add selectable difficulty levels with different inclusive ranges and maximum valid
attempts. Model difficulty as an enum, not magic strings scattered through the game.
When attempts are exhausted, reveal the secret and offer another round.

## Completion checklist

- [ ] Game behavior and recoverable input errors work.
- [ ] Pure logic is separate from randomness and terminal I/O.
- [ ] No production `unwrap` or `expect` is present.
- [ ] Tests cover range boundaries and all comparison results.
- [ ] Default quality commands pass.
- [ ] The transfer challenge and reflection are complete.

## Related Rustlings drills

- `01_variables`
- `02_functions`
- `03_if`
- `04_primitive_types`
- `08_enums`
- `13_error_handling`


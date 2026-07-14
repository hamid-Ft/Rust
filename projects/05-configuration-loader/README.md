# Mini-Project 05 — Validated Configuration Loader

## Unlock condition

Complete Mini-Project 04 and explain how its types prevented at least two invalid
inventory states.

## Outcome

Build a layered configuration loader while mastering modules, `Option`, `Result`,
the `?` operator, conversions, and precise error types.

## Non-goals

No Serde or general TOML parser yet. Parse a deliberately small `key=value` format so
the project exposes Rust error design rather than hiding it behind a framework.

## Artifact and behavior

Load an application configuration with a required host and port plus optional log
level, worker count, and timeout. Values come from defaults, then a file, then a
provided environment-like map, with later sources taking precedence.

Separate modules for sources, parsing, validation, domain types, and errors. Library
callers must be able to distinguish I/O, syntax, unknown-key, parse, and validation
failures. Error messages should include useful key and line context.

## Concept checklist

- [ ] `Option` represents absence; `Result` represents failure.
- [ ] `?` propagates errors with appropriate `From` conversions.
- [ ] `map`, `and_then`, `ok_or_else`, and `transpose` are used when clearer.
- [ ] Library errors remain concrete and inspectable.
- [ ] `thiserror` may derive reusable errors; `anyhow` stays at the binary boundary.
- [ ] Module visibility exposes only the intended public API.

## Build stages

1. Model validated config value types and their errors.
2. Parse one line into a key/value pair with line-aware syntax errors.
3. Parse a complete source and reject unknown or duplicate keys deliberately.
4. Merge default, file, and environment-like sources.
5. Validate the final configuration and add binary error context.
6. Replace one verbose error `match` chain with clear `?` propagation.

## Required verification

Run the default quality commands. Tests must cover missing required values, malformed
lines, unknown and duplicate keys, invalid numbers, validation boundaries, source
precedence, and an I/O failure. Public fallible APIs need `# Errors` documentation.

## Transfer challenge

Add an optional `include=path` directive with a maximum nesting depth and cycle
detection. Preserve the complete include path in errors. Tests must avoid relying on
machine-specific absolute paths.

## Completion checklist

- [ ] Absence and failure are modeled differently.
- [ ] Error variants retain actionable context and sources.
- [ ] Source precedence is documented and tested.
- [ ] Production code has no `unwrap`, `expect`, or indiscriminate boxed errors.
- [ ] Default quality commands pass.
- [ ] The transfer challenge and reflection are complete.

## Related Rustlings drills

- `10_modules`
- `12_options`
- `13_error_handling`
- `23_conversions`


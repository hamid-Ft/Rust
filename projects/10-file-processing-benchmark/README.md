# Mini-Project 10 — File-Processing Benchmark

## Unlock condition

Complete Project 09 and explain which behaviors belong in unit, integration, doc,
property, and regression tests.

## Outcome

Build and optimize a structured log-file analyzer using evidence rather than guesses.
Learn release profiles, representative workloads, Criterion, black-boxing, allocation
awareness, profiling, and honest performance reporting.

## Non-goals

No parallelism yet; that is Project 11. No optimization target is assumed in advance,
and no rewrite is accepted without measurement and correctness evidence.

## Artifact and behavior

Parse a documented line-oriented log format and report counts by level/service plus
latency summary statistics. Provide a clear baseline implementation first. Generate
deterministic small, medium, and large fixtures outside timed benchmark loops.

Create `BENCHMARKS.md` recording environment, input sizes, commands, hypotheses,
measurements, uncertainty/noise, changes attempted, and whether each was retained.

## Concept checklist

- [ ] Correctness tests pass before and after every optimization.
- [ ] Benchmarks run optimized code and isolate the intended operation.
- [ ] Inputs and outputs are black-boxed where required by the current API.
- [ ] Setup/allocation time is included or excluded intentionally and documented.
- [ ] Throughput is reported for representative input sizes.
- [ ] Clones and intermediate collections are inspected, not automatically condemned.
- [ ] A slower or inconclusive optimization may be reverted and documented honestly.

## Build stages

1. Specify the format and implement a readable baseline.
2. Add deterministic correctness and malformed-line tests.
3. Add Criterion benchmark groups by input size and operation.
4. Record a baseline before inspecting profiles or changing code.
5. Form one hypothesis from allocation counts, Clippy, or a profiler.
6. Implement one change, re-run correctness checks, and compare distributions.
7. Repeat only while measurements identify a meaningful bottleneck.

## Required verification

```sh
cargo fmt --all -- --check
cargo test --all-targets --all-features --locked
cargo clippy --all-targets --all-features --locked -- -D warnings
cargo clippy --all-targets --all-features --locked -- -D clippy::perf
cargo bench --locked
cargo doc --no-deps --locked
```

Benchmark evidence must come from release-mode execution on an otherwise reasonably
idle machine. Do not use a single wall-clock run as proof of improvement.

## Transfer challenge

Add a streaming analyzer accepting `impl BufRead` and benchmark it against the
whole-file approach at multiple sizes. Compare elapsed time and peak-memory reasoning;
recommend one API for small files and one for unbounded inputs using collected evidence.

## Completion checklist

- [ ] Baseline behavior and representative fixtures are reproducible.
- [ ] Benchmarks measure the intended work without obvious setup distortion.
- [ ] At least one hypothesis is accepted or rejected using evidence.
- [ ] `BENCHMARKS.md` contains enough context to reproduce the conclusion.
- [ ] Correctness and quality commands still pass.
- [ ] Transfer challenge and reflection are complete.

## Primary reference

- [Criterion.rs documentation](https://bheisler.github.io/criterion.rs/book/)

## Related Rustlings drills

- `09_strings`
- `18_iterators`
- `19_smart_pointers`
- `22_clippy`

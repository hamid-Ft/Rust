# Mini-Project Workflow

## One side chat per project

The preferred entry point is `./roadmap/next.sh`, which produces the filled prompt for
the validated Ready project. The template below documents the same contract manually.

Start each side chat with this prompt, replacing the number and name:

> Start Rust Mini-Project 01: Toolchain Health Check from this workspace. Teach it
> interactively and step by step under `roadmap/TEACHING_CONTRACT.md`. First inspect
> the project brief, evidence, progress, study-map row, and current files.
> Compare this project's requirements with `roadmap/ENVIRONMENT.md`, re-check current
> primary prerequisites, and record an environment delta instead of trusting the snapshot.
> Create or resume this project's `EVIDENCE.md` from the master evidence template;
> record evidence as we work instead of reconstructing it at completion.
> Use only this project's section of `roadmap/STUDY_MAP.md`: ask the diagnostic first,
> timebox reading, and assign Rustlings only for a demonstrated gap.
> If this is after Project 01, begin with at most two due retrieval prompts from the
> master queue and stop that warm-up after ten minutes.
> Before adding or updating a crate/toolchain, follow `roadmap/DEPENDENCIES.md` and
> explain the dependency's responsibility and selected Cargo features.
> Give me one meaningful implementation task at a time, let me attempt it, review my
> code and compiler errors, and keep the project completion gates visible. Explain
> the relevant ownership and type-system decisions. Do not complete learning
> exercises for me unless I ask for a worked solution; use the contract's hint ladder.
> Before declaring completion,
> run formatting, tests, Clippy with warnings denied, and documentation checks. End
> with the transfer challenge, reflection, and three retrieval prompts. Update the
> master progress tracker only after every mastery gate passes, then run the roadmap
> validator and fix any inconsistency before unlocking the next project.

## Learning loop

Every project follows these stages:

1. **Diagnose** — Check prerequisites and explain the desired behavior.
2. **Model** — Identify inputs, outputs, types, errors, and ownership boundaries.
3. **Build** — Implement the smallest useful vertical slice.
4. **Exercise** — The learner changes or extends it without copying a solution.
5. **Break** — Explore at least one compiler error or failing test intentionally.
6. **Harden** — Add error cases, tests, docs, and appropriate observability.
7. **Verify** — Run the project's exact quality commands.
8. **Transfer** — Solve a small variation independently.
9. **Reflect** — Record what was learned and what remains confusing.
10. **Retain** — Add one explain, debug, and transfer prompt to the retrieval queue.

The Diagnose stage uses [`STUDY_MAP.md`](STUDY_MAP.md): capture the pre-study answer,
route to the smallest relevant official section/drill, then record the revised answer
and compiler/test evidence. Reading completion by itself is never a mastery gate.
All stages follow [`TEACHING_CONTRACT.md`](TEACHING_CONTRACT.md), including its
learner-first loop, feedback classification, review order, and session handoff.
It also uses [`ENVIRONMENT.md`](ENVIRONMENT.md) as a dated lead, not proof: re-run the
current project's preflight and install only the newly required target/tool.

Evidence is collected throughout these stages in the project's `EVIDENCE.md` using
[`EVIDENCE_TEMPLATE.md`](EVIDENCE_TEMPLATE.md). A checkbox, chat statement, old command
run, or successful compile is not a substitute for criterion-matched current evidence.

Starting with Project 02, begin a session with the ten-minute review described in
[`MASTERY_CHECKPOINTS.md`](MASTERY_CHECKPOINTS.md). At phase boundaries, complete the
named cumulative checkpoint before unlocking the next project.

## Adaptive pace loop

Record focused minutes, the current stage, outcome, and highest hint level in the
project evidence after each session. Exclude breaks and separate environment/tooling
delay from Rust learning time. The numbers diagnose bottlenecks; they are not targets
and never prove mastery.

At project reflection, choose the next project's starting pace from evidence:

- **Compress mechanical steps** when the diagnostic was accurate, concept-bearing work
  and transfer were independent, hints stayed at Levels 0–2, and final gates were clean.
  Combine scaffolding or repetitive substeps, then move to a harder prediction or edge
  case; retain every mastery gate.
- **Normal pace** when the project passed with ordinary correction and the learner can
  explain the final design independently.
- **Targeted remediation** when the same concept caused repeated failures across two
  focused attempts, required Level 4–5 help, or remains incorrect in explanation or
  transfer. Start the next session with one small official reading, Rustlings drill, or
  compiler experiment aimed only at that named gap.

If environment setup dominates, repair or defer that platform prerequisite according
to `ENVIRONMENT.md`; do not incorrectly slow the Rust curriculum. Never compress the
intentional failure, independent transfer, exact verification commands, retrieval
prompts, or cumulative checkpoints. Reassess after every project rather than locking
the learner into a permanent “fast” or “slow” track.

## Default quality gates

Run these from the current project's crate directory:

```sh
cargo fmt --all -- --check
cargo test --all-targets --all-features --locked
cargo clippy --all-targets --all-features --locked -- -D warnings
cargo doc --no-deps --locked
```

Additional gates are added when appropriate: Criterion benchmarks in release mode,
property tests, database migrations, WASM builds, target checks, or end-to-end tests.
Dependency and toolchain changes follow [`DEPENDENCIES.md`](DEPENDENCIES.md); record
the resolved direct versions/features and keep the reviewed `Cargo.lock` committed.

### Code standards

- Prefer borrowing (`&str`, `&[T]`, `&T`) when ownership is unnecessary.
- Use `Result` for fallible behavior; avoid `unwrap` and `expect` outside tests.
- Use `thiserror` for reusable library errors and `anyhow` at binary boundaries.
- Keep domain logic in `lib.rs` or modules so it can be tested independently of CLI/UI.
- Write descriptive test names and cover errors as well as happy paths.
- Document public APIs and explain `Errors`, `Panics`, and `Safety` where relevant.
- Comment non-obvious reasons and invariants, not syntax already visible in the code.
- Optimize only after measurement; benchmark performance work with `--release`.

## Mastery gate

A project is complete only when all of the following are true:

- The required behavior works and the quality commands pass.
- The learner can explain the important types and ownership flow.
- The learner can predict one relevant compiler or runtime failure.
- The transfer challenge is completed without copying the walkthrough.
- The reflection and evidence are recorded in `roadmap/PROGRESS.md`.
- The project's `EVIDENCE.md` is marked Passed and maps every required criterion.
- Three useful prompts are added to `roadmap/RETRIEVAL_QUEUE.md`.
- Any checkpoint required before the next phase is passed or has a targeted retry plan.
- `./roadmap/validate.sh` passes after progress/status changes.
- `./roadmap/audit.sh` reports the new evidence counts without overstating completion.

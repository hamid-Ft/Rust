# Mini-Project NN — Name

## Unlock condition

State which earlier project, mastery gate, and cumulative checkpoint must be complete.

## Environment gate

Use [`ENVIRONMENT.md`](ENVIRONMENT.md) only as a dated lead. List required tools,
targets, native packages, services/devices, and authoritative runtime proof. Re-check at
unlock; install only what this project needs and record the delta in `EVIDENCE.md`.

## Outcome

Describe one concrete artifact and the primary Rust concept it teaches.

## Non-goals

List tempting features that would distract from the primary concept.

## Artifact and behavior

Describe inputs, outputs, expected errors, and important constraints without giving
away the implementation.

## Concept checklist

- [ ] One language or ecosystem concept per item.
- [ ] Ownership and borrowing decisions are explicit.
- [ ] Error behavior is explicit.
- [ ] Testing expectations are explicit.

## Build stages

1. Diagnose prerequisites and model the behavior.
2. Implement the smallest vertical slice.
3. Add expected failures and edge cases.
4. Refactor into testable modules.
5. Add tests and public documentation.
6. Explore one intentional compiler or test failure.

## Dependency and toolchain gate

Follow [`DEPENDENCIES.md`](DEPENDENCIES.md). List every direct crate's responsibility,
required features, target/MSRV constraints, and why the standard library is not the
right boundary. Commit the reviewed lockfile and record intentional updates.

## Evidence record

Create `EVIDENCE.md` from [`EVIDENCE_TEMPLATE.md`](EVIDENCE_TEMPLATE.md) when work
starts. Map every required behavior/checklist item to current direct evidence; record
exact locked commands, the intentional failure, independent transfer, learner
explanation, reflection, and remaining gaps.
Use its session ledger to separate focused Rust learning from tooling delay and make an
evidence-backed next-project pace decision at reflection.

## Targeted study

Use only the current row in [`STUDY_MAP.md`](STUDY_MAP.md). Ask its diagnostic before
reading, timebox the official section, and select individual Rustlings exercises only
for an observed gap. Record the pre/post answer and evidence; do not gate progress on
passively finishing unrelated chapters.

## Teaching interaction

Follow [`TEACHING_CONTRACT.md`](TEACHING_CONTRACT.md). Identify which code carries the
learning objective so the learner attempts it first, define the likely hint progression,
and keep mentor-written scaffolding mechanical and visible.

## Required verification

```sh
cargo fmt --all -- --check
cargo test --all-targets --all-features --locked
cargo clippy --all-targets --all-features --locked -- -D warnings
cargo doc --no-deps --locked
```

Add project-specific runtime, benchmark, target, or integration commands here.

## Transfer challenge

Specify a small variation that uses the same concepts but cannot be completed by
renaming the walkthrough code.

## Completion checklist

- [ ] Required behavior and error cases work.
- [ ] Quality commands pass.
- [ ] Direct dependencies/features/toolchain and lockfile changes are justified.
- [ ] Important types and ownership flow can be explained.
- [ ] One relevant failure can be predicted and explained.
- [ ] Transfer challenge passes.
- [ ] Session pace data and the next-project pace decision are recorded.
- [ ] Explain/debug/transfer prompts are added to the retrieval queue.
- [ ] `EVIDENCE.md` contains current criterion-matched evidence and is marked Passed.
- [ ] Evidence and reflection are recorded in `roadmap/PROGRESS.md`.

## Retention prompts

Do not pre-fill answers. At reflection time, add one project-specific explain prompt,
one prediction/debug prompt, and one transfer prompt to `roadmap/RETRIEVAL_QUEUE.md`.

## Related Rustlings drills

List only exercise groups that address gaps exposed by this project.

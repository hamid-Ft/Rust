# Project NN — Name Evidence

Create `projects/NN-name/EVIDENCE.md` from this template when the project begins.
Update it during the side chat; do not reconstruct evidence from memory at the end.

## Completion state

- Result: **In progress**
- Started: YYYY-MM-DD
- Completed: —
- Project brief: `projects/NN-name/README.md`
- Side-chat reference: optional local/user reference; do not depend on it as evidence

Change the result to `**Passed**` only after every brief checklist item, locked quality
command, independent transfer challenge, retrieval prompt, and required checkpoint has
current evidence.

## Session and pace log

Record focused work, excluding breaks and unrelated setup. Approximate minutes are
enough; this is feedback for adapting the next project, not a productivity score.

| Session | Date | Focused minutes | Stage or task | Outcome/evidence | Highest hint level |
|---:|---|---:|---|---|---:|
| 1 | YYYY-MM-DD | — | Replace | Replace | — |

At project completion, summarize:

- Total focused minutes and session count:
- Approximate split: targeted study / implementation-debugging / verification-transfer:
- Main learning bottleneck, if any:
- Time lost to environment/tooling rather than Rust learning:
- Next-project pace decision: compress mechanical steps / normal pace / targeted remediation:
- Evidence supporting that decision:

Elapsed time is never pass/fail evidence. Do not rush a transfer or quality gate to
improve these numbers, and do not mistake slow package builds for a concept gap.

## Environment

Record the exact output or concise identifying line for:

- `rustc --version`
- `cargo --version`
- `rustup show active-toolchain`
- host and exercised target(s)
- project-specific tools/runtimes/devices and their versions

Environment readiness delta from `roadmap/ENVIRONMENT.md`:

- Snapshot item re-checked and current primary source/date:
- Required installation/change and approval, if any:
- Smallest compile/runtime readiness proof:
- Assumptions still unverified:

State what was not available or not tested. A host build is not mobile, embedded,
browser, or cross-target runtime evidence.

## Implementation summary

Describe the final artifact and important module/crate boundaries in a few sentences.
Link to local source/docs by relative path when that makes the evidence easier to audit.

## Targeted study and drills

- Diagnostic question and pre-study answer:
- Rust Book/Rust By Example sections actually used:
- Rustlings exercise names attempted, or why no drill was needed:
- Specific question each resource resolved:
- Revised answer plus compiler/test evidence:

Reading time or chapter completion is not mastery evidence. Record how the resource
changed a prediction, implementation decision, or independently verified explanation.

## Acceptance criteria

Map every required behavior and completion-checklist item from the brief to direct
evidence. Do not treat one happy-path demonstration as proof of unrelated requirements.

| Criterion | Evidence: test, command, file, or observation | Status |
|---|---|---|
| Replace with the first brief criterion | Replace with direct evidence | Pending |

Allowed statuses are `Passed`, `Failed`, and `Not run`. Explain every non-passing item;
the project result cannot be Passed while any required criterion is not Passed.

## Verification

Run the final commands against the same current files being marked complete. Record
the exact command, working directory/target, date, exit status, and a concise result
such as test counts or the important output line.

| Command | Working directory/target | Date | Exit | Evidence summary |
|---|---|---|---:|---|
| `cargo fmt --all -- --check` | Replace | YYYY-MM-DD | — | Not run |
| `cargo test … --locked` | Replace | YYYY-MM-DD | — | Not run |
| `cargo clippy … --locked -- -D warnings` | Replace | YYYY-MM-DD | — | Not run |
| `cargo doc … --locked` | Replace | YYYY-MM-DD | — | Not run |

Add every project-specific runtime, integration, property, benchmark, target, migration,
browser, device, packaging, or manual command required by the brief. Preserve useful
logs/screenshots/reports as local artifacts and link them; avoid pasting huge output.

## Test design

- Unit behaviors and error cases:
- Integration/contract boundaries:
- Property/invariant or compile tests, when required:
- Manual/platform checks that cannot be automated yet:
- Known test blind spots:

Tests should have descriptive names, isolate one behavior where practical, and prove
both expected success and relevant failure. Explain why each test level is authoritative
for its claimed requirement.

## Intentional failure

- Change/failure introduced:
- Prediction before running:
- Compiler/test/runtime result:
- Tool that caught it:
- What the diagnostic taught me:
- Evidence that the intentional break was reverted:

## Transfer challenge

- Challenge from the brief:
- Learner's approach before review:
- Files/tests added or changed:
- Verification result:
- Reviewer feedback and learner correction, if any:
- Why this demonstrates transfer rather than copied repetition:

## Learner explanation

Write this in the learner's own words before review:

- Main types and invariants:
- Ownership/borrowing flow:
- Error model and propagation:
- Concurrency/async/lifetime/unsafe boundary, when relevant:
- One failure I can now predict:
- One design alternative and why I rejected it:

Corrections from review should remain visible as corrections, not silently replace the
original understanding.

- Hint level(s) used and why:
- Mentor feedback classified as Must fix / Learning question / Optional:
- Learner corrections and re-verification:

## Dependency and toolchain decisions

- Stable/pinned/nightly policy and reason:
- Direct dependencies and each responsibility:
- Enabled/disabled features and targets:
- Intentional lockfile changes:
- License/provenance/native-build/advisory constraints:

## Reflection

- What became clearer:
- What was difficult and why:
- Where I used compiler/test feedback effectively:
- What I would improve without expanding the project scope:
- Retrieval prompts added to `roadmap/RETRIEVAL_QUEUE.md`:

## Remaining gaps

List limitations, untested environments, deferred risks, and concepts still requiring
practice. `None known` is acceptable only after actively checking the brief; it does
not mean the software has no defects.

## Evidence integrity rules

- Never mark a command passed unless it was run successfully against the recorded state.
- Never infer runtime/platform behavior from compilation alone.
- Use dates, exit statuses, test names/counts, artifact hashes, and paths where relevant.
- Redact tokens, private keys, personal data, machine secrets, and sensitive paths.
- Distinguish observed facts, tool output, learner explanation, and reviewer inference.
- If code changes after final verification, invalidate affected evidence and rerun it.

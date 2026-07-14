# Retention and Mastery Checkpoints

## Purpose

Project completion proves a concept worked once. This review loop checks that it can
still be explained, debugged, and transferred later. It is deliberately small so
retention supports speed instead of turning into a second curriculum.

## Ten-minute retrieval warm-up

At the beginning of every project side-chat session after Project 01:

1. Select at most two due prompts from [`RETRIEVAL_QUEUE.md`](RETRIEVAL_QUEUE.md).
2. Answer without opening the old implementation or notes.
3. Check the answer against code, compiler behavior, tests, or authoritative docs.
4. Record `recalled`, `partial`, or `missed` plus one sentence of evidence.
5. For a partial/missed answer, do one targeted correction and retry next session.

Stop after ten minutes. Retrieval should expose gaps, not delay the current vertical
slice. A dangerous misconception that affects the current project is the exception:
correct it before building on top of it.

## Creating useful prompts

At each project's reflection, the learner adds three short prompts:

- **Explain:** why an ownership, type, error, concurrency, or architecture decision
  was made—not merely the syntax used.
- **Predict/debug:** predict a compiler, test, or runtime failure from a small change.
- **Transfer:** describe or implement how the concept applies to a different input,
  boundary, or domain.

New prompts are due in the next project. A correctly recalled prompt moves two
projects forward, then to the next cumulative checkpoint, then retires. A partial or
missed prompt is due next session. Keep the queue small by retiring prompts that have
three evidence-backed recalls; replace them only when a later project exposes a gap.

## Cumulative checkpoint gates

These are short assessment sessions in the side chat for the project just completed.
They do not become extra applications. Each should normally take 60–120 focused
minutes and must be recorded in `PROGRESS.md` before the next phase unlocks.
Keep the preceding project marked `Ready` while its checkpoint is attempted; mark the
checkpoint `Passed`, then atomically mark that project `Completed` and the next one
`Ready`. Use `Targeted retry` or `Revisit` while correcting gaps. This preserves one
unambiguous current position in the master table.

### C1 — Foundation checkpoint (after Project 07, before Project 08)

- Explain move, immutable/mutable borrow, slice, lifetime, `Option`, `Result`, trait,
  generic bound, and iterator using examples from Projects 03–07.
- Given an unseen ownership/lifetime compiler error, predict the cause before fixing it.
- Design a small borrowed API from a written input/output specification and justify
  every owned versus borrowed parameter/return value.
- Re-run one earlier crate's full quality gate after making a harmless API extension.

### C2 — Practical and concurrency checkpoint (after Project 13, before Project 14)

- Trace ownership across a thread/task, channel, `Arc`, mutex guard, and `.await` point.
- Explain backpressure, framing, cancellation, timeout, and graceful shutdown and name
  a failure that occurs when each is omitted.
- Add one bounded/cancellable behavior to an earlier program without introducing an
  unbounded queue, detached task, or production `unwrap`.
- Select unit versus integration versus property testing for three unseen requirements.

### C3 — Specialization checkpoint (after Project 19, before Project 20)

- Compare web, WASM, embedded, game, desktop, and data paths by runtime model, state
  ownership, test boundary, deployment artifact, and dominant failure modes.
- Move one small pure domain module between two interfaces without coupling it to
  either framework; keep its tests unchanged.
- Identify which specialization deserves depth later and support the choice with
  project evidence rather than preference alone.

### C4 — Advanced-language checkpoint (after Project 22, before Project 23)

- Explain when a generic, trait object, macro, FFI boundary, or unsafe block is and is
  not justified.
- Audit one earlier public API for clone pressure, error erasure, invalid states,
  documentation gaps, and unnecessary dynamic dispatch.
- For one unsafe operation, state its safety invariant and show which safe API/test
  preserves it; if no invariant is needed, explain why safe Rust is sufficient.

### C5 — Breadth checkpoint (after Project 26, before Project 27)

- Compare TCP and QUIC semantics, dataframe and tensor workloads, and desktop/mobile
  lifecycle constraints without consulting the project briefs.
- State the trust boundaries and non-goals for the Bitcoin, QUIC, inference, and mobile
  surveys; distinguish demonstrated evidence from production readiness.
- Complete `CAPSTONE_SCORECARD.md` and select a cohesive capstone based on demonstrated
  strengths, gaps, constraints, and a measurable user problem.

### C6 — Final synthesis (after Project 27)

- Re-answer a representative prompt from every phase without notes.
- Diagnose and fix one unfamiliar Rust defect using compiler output and tests.
- Explain the capstone's ownership, error, concurrency, trust, performance, and release
  model to another engineer, including unresolved risks.
- Create the next depth roadmap from evidence: one specialization, explicit gaps, and
  measurable projects—not a repeat of the breadth survey.

## Checkpoint result

Record one of these outcomes with links or command evidence:

- **Pass:** explanations and transfer are independent and technically correct.
- **Targeted retry:** one or two named gaps require drills/retry; completed projects are
  not rebuilt from scratch.
- **Revisit:** a foundational misconception makes the next phase unsafe or confusing;
  return only to the smallest project/stage that can correct it.

Time spent is not evidence. Passing means the learner can retrieve and transfer the
ideas without copying the original walkthrough.

Checkpoint tracker statuses are `Locked`, `Ready`, `Targeted retry`, `Revisit`, and
`Passed`. After C6 passes, mark Project 27 `Completed`, set the current project to
`none — roadmap complete`, and set progress status to `complete`.

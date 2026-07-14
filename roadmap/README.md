# Master Rust Roadmap

## Goal

Learn Rust quickly and thoroughly through small, progressively harder projects.
Each project has one primary concept, a concrete artifact, explicit quality gates,
and a transfer challenge that must be completed without copying the walkthrough.

This is a breadth-first roadmap. Projects 01–13 build a strong common foundation.
Projects 14–19 survey major Rust specializations. Projects 20–22 cover advanced
language design and integration. Projects 23–26 close the ecosystem breadth survey,
then Project 27 is a larger capstone. Surveying every area is not the same as deep
specialization; choose one or two areas to deepen in the capstone.

The [coverage map](COVERAGE.md) traces the original learning criteria to evidence and
keeps ecosystem breadth status visible as the roadmap evolves.
The [mastery checkpoints](MASTERY_CHECKPOINTS.md) and
[retrieval queue](RETRIEVAL_QUEUE.md) keep earlier concepts available as projects grow.
The [dependency and toolchain policy](DEPENDENCIES.md) keeps crate choices current,
minimal, explicit, and reproducible.
The [evidence template](EVIDENCE_TEMPLATE.md) prevents completion from relying on
memory, unchecked boxes, or claims unsupported by current command/runtime results.
The [just-in-time study map](STUDY_MAP.md) routes each project to only the relevant
Rust Book, Rust By Example, local Rustlings, and primary ecosystem material.
The [side-chat teaching contract](TEACHING_CONTRACT.md) keeps the learner writing and
reasoning first while making hints, reviews, acceleration, and handoffs predictable.
The dated [environment matrix](ENVIRONMENT.md) exposes target/tool prerequisites early
without installing an entire ecosystem before its project unlocks.

## Sequence

| # | Mini-project | Main learning criteria | Proof of completion | Status |
|---:|---|---|---|---|
| 01 | [Toolchain health check](../projects/01-toolchain-health-check/README.md) | `rustup`, Cargo, rustfmt, Clippy, tests, docs | A clean crate passes every local quality command | Ready |
| 02 | [Number guessing CLI](../projects/02-number-guessing-cli/README.md) | Variables, parsing, loops, functions, `match`, crates | Robust input loop with tested comparison logic | Locked |
| 03 | [Text statistics tool](../projects/03-text-statistics/README.md) | Ownership, moves, borrowing, slices, `String`/`&str` | Processes multiple inputs without needless clones | Locked |
| 04 | [Inventory manager](../projects/04-inventory-manager/README.md) | Structs, enums, methods, pattern matching, collections | In-memory domain model with validated operations | Locked |
| 05 | [Configuration loader](../projects/05-configuration-loader/README.md) | Modules, `Option`, `Result`, `?`, typed errors | Loads valid config and explains invalid config errors | Locked |
| 06 | [Generic data store](../projects/06-generic-data-store/README.md) | Generics, traits, bounds, iterators | Reusable store supporting multiple entity types | Locked |
| 07 | [Borrowed search index](../projects/07-borrowed-search-index/README.md) | Lifetimes and lifetime elision | Index returns borrowed matches safely | Locked |
| 08 | [Persistent todo CLI](../projects/08-persistent-todo-cli/README.md) | Clap, Serde, JSON, filesystem, `anyhow` | Usable CLI with persistence and integration tests | Locked |
| 09 | [Expression evaluator](../projects/09-expression-evaluator/README.md) | Unit, integration, doc, property tests | Parser/evaluator has edge-case and invariant coverage | Locked |
| 10 | [File-processing benchmark](../projects/10-file-processing-benchmark/README.md) | Criterion, profiling, allocation awareness | Evidence-based optimization with before/after results | Locked |
| 11 | [Parallel file search](../projects/11-parallel-file-search/README.md) | Threads, channels, `Arc`, `Mutex`, `Send`/`Sync` | Correct bounded parallel search without data races | Locked |
| 12 | [Async website checker](../projects/12-async-website-checker/README.md) | Tokio, futures, reqwest, tracing | Concurrent requests with timeout and cancellation | Locked |
| 13 | [TCP chat server](../projects/13-tcp-chat-server/README.md) | Async networking, framing, graceful shutdown | Multiple clients exchange framed messages reliably | Locked |
| 14 | [Axum REST API](../projects/14-axum-rest-api/README.md) | Axum, Tower, SQLx, validation, auth | Tested CRUD API with migrations and observability | Locked |
| 15 | [Rust WASM client](../projects/15-leptos-wasm-client/README.md) | Components, browser state, API consumption | Browser UI consumes the REST API | Locked |
| 16 | [Embedded state simulator](../projects/16-embedded-state-simulator/README.md) | `no_std`, `embedded-hal`, type-state | Host-tested driver logic with invalid states excluded | Locked |
| 17 | [Bevy Snake](../projects/17-bevy-snake/README.md) | ECS, systems, resources, events, assets | Playable game with separated game logic | Locked |
| 18 | [Tauri desktop app](../projects/18-tauri-desktop-library/README.md) | Commands, IPC, capabilities, persistence | Desktop UI invokes a safe Rust backend | Locked |
| 19 | [Polars data pipeline](../projects/19-polars-data-pipeline/README.md) | DataFrames, lazy queries, CSV/JSON | Reproducible transformation with validation | Locked |
| 20 | [Macro toolkit](../projects/20-macro-toolkit/README.md) | `macro_rules!`, expansion, diagnostics | Tested macro removes real repetition | Locked |
| 21 | [Safe unsafe wrapper](../projects/21-safe-ffi-wrapper/README.md) | Raw pointers, invariants, FFI, safety docs | Small safe API around reviewed unsafe boundary | Locked |
| 22 | [Plugin application](../projects/22-plugin-application/README.md) | Trait objects, static/dynamic dispatch, architecture | Multiple implementations selected at runtime | Locked |
| 23 | [Offline Bitcoin inspector](../projects/23-offline-bitcoin-inspector/README.md) | Transactions, PSBTs, bounded untrusted parsing | Offline structural reports without keys or network access | Locked |
| 24 | [Quinn QUIC service](../projects/24-quinn-quic-service/README.md) | QUIC, TLS, streams, datagrams, backpressure | Local verified client/server survives transport failures | Locked |
| 25 | [Local ONNX inference](../projects/25-local-onnx-inference/README.md) | `ndarray`, tensors, Tract, model validation | Reproducible local inference matches golden fixtures | Locked |
| 26 | [Tauri Android companion](../projects/26-tauri-android-companion/README.md) | Mobile target, lifecycle, IPC, capabilities | Real Android build runs Rust-backed workflows | Locked |
| 27 | [Production capstone](../projects/27-production-capstone/README.md) | Design, CI, packaging, profiling, deployment | Deployable project combining chosen specializations | Locked |

`Completed` means all project mastery evidence and any immediately following phase
checkpoint are passed. `Ready` marks the single current project, including while its
following checkpoint is being attempted. `Locked` means “do not start yet,” not
“files are inaccessible.” Unlock the next project only after the current mastery gate.

Cumulative checkpoints C1–C5 are phase gates before Projects 08, 14, 20, 23, and 27.
They are compact retrieval/transfer assessments, not additional feature projects.

Projects 14–19 and 23–26 are breadth surveys. Projects 14–19 reuse earlier artifacts
but may be reordered after Project 13 if platform constraints require it. Record any
reordering and its reason in the progress tracker. Projects 23–26 retain their stated
prerequisites; all surveys remain required for the “all areas” goal.

## Supporting study

Use references just in time, immediately before or during a project:

- The Rust Book for the concept being used now.
- Rust By Example for a second representation of syntax.
- Rustlings for short drills tied to the current project.
- Crate documentation on docs.rs when adding a dependency.
- The shared dependency policy before changing a manifest or toolchain.
- The just-in-time study map for the current project and no future project.
- Comprehensive Rust when a topic needs another explanation.

Avoid reading every resource front-to-back before building. Reading should answer a
question raised by the current project.

## Recommended pace

- Fundamentals (01–07): approximately 2–4 focused sessions per project.
- Practical Rust (08–13): approximately 3–7 sessions per project.
- Specialization surveys (14–19): approximately 1–2 weeks per project.
- Advanced language design (20–22): approximately 1–2 weeks per project.
- Ecosystem extension surveys (23–26): approximately 1–2 weeks per project.
- Production capstone (27): driven by mastery, not calendar time.

Speed comes from short feedback loops, not skipping ownership, error handling, or
testing. If a project feels easy, complete its transfer challenge sooner instead of
removing its quality gates.

## Roadmap integrity check

After changing a project brief, status, checkpoint, or supporting roadmap file, run:

```sh
./roadmap/validate.sh
```

The validator checks the 01–27 sequence, required learning sections, staged builds,
phase-gate links, local Markdown links, locked Cargo commands, completion evidence,
and the relationship between the single `Ready` row and `PROGRESS.md`.

To start or resume the correct project without manually editing the generic prompt:

```sh
./roadmap/next.sh
```

This launcher is read-only. It validates first, identifies the single Ready project,
detects whether its evidence record exists, and prints the complete side-chat handoff.

## Master-goal audit

Planning breadth is not learning completion. At any time, inspect the authoritative
current counts with:

```sh
./roadmap/audit.sh
```

The final completion gate is deliberately fail-closed:

```sh
./roadmap/audit.sh --require-complete
```

It succeeds only when all 27 roadmap rows are Completed, all 27 project evidence files
are Passed, C1–C6 are Passed, no project remains Ready, and `PROGRESS.md` records the
final complete state. A fully written roadmap alone cannot satisfy this audit.

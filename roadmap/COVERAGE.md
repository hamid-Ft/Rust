# Rust Learning Criteria Coverage

This matrix maps the original learning criteria to the project briefs that teach and
verify them. A brief is only planned coverage; completion requires the evidence in
`PROGRESS.md`.

## General and core Rust

| Criterion | Primary projects | Reinforcement/evidence |
|---|---|---|
| Toolchain, rustup, Cargo, rustfmt, Clippy, rustdoc | 01 | Every project's quality gate |
| Syntax, variables, functions, control flow, matching | 02 | 04, 09 |
| Ownership, borrowing, moves, slices | 03 | 06, 07, 11–13 |
| Lifetimes | 07 | 12, 21, 22 |
| Structs, enums, methods, collections | 04 | 05–27 |
| `Option`, `Result`, `?`, typed errors | 05 | Every fallible project |
| Modules and visibility | 05 | 08, 14, 18, 27 |
| Generics, traits, associated types, bounds | 06 | 16, 21, 22 |
| Iterators and conversions | 03, 06 | 09, 10, 19 |
| Testing and documentation | 01, 09 | Every project's completion gate |
| Serde and structured data | 08 | 12–15, 18, 19 |
| Benchmarking, profiling, performance mindset | 10 | 19, 22, 25, 27 |
| Threads, channels, `Arc`, `Mutex`, `Send`/`Sync` | 11 | 12, 13, 18, 22 |
| Async/await and Tokio | 12 | 13, 14, 24 |
| Structured logging/tracing | 12 | 13, 14, 24, 27 |
| Declarative macros | 20 | Generated APIs and compile tests |
| Unsafe Rust and FFI | 21 | Safety dossier and boundary tests |
| Static versus dynamic dispatch | 22 | 06 and registry comparison |
| Workspaces, CI, packaging, release operation | 27 | Capstone scorecard and artifact |

## Specialized paths

| Path | Primary projects | Coverage boundary |
|---|---|---|
| CLI and utilities | 02, 08 | Clap, files, JSON, process-level tests |
| Web backend/API | 14 | Axum, Tower, SQLx, auth, migrations |
| Browser WASM frontend | 15 | Leptos CSR, Trunk, accessible UI |
| Systems and embedded | 16, 21 | `no_std`, HAL traits, type-state, C FFI |
| Game development | 17 | Bevy ECS and testable fixed-step rules |
| Desktop GUI | 18 | Tauri v2 IPC, capabilities, packaging |
| Mobile application | 26 | Actual Android build, lifecycle, mobile IPC/capabilities |
| Networking | 12, 13, 24 | HTTP, framed TCP, QUIC streams and datagrams |
| Data engineering | 19 | Polars lazy pipeline and query plans |
| ML/inference | 25 | `ndarray` tensors and validated local ONNX inference |
| Blockchain/crypto ecosystem | 23 | Offline transaction/PSBT structures; no custody or trading |
| Architecture/integration | 22, 27 | Runtime registry and production capstone |

## Ecosystem extension surveys

These projects close the four explicit breadth gaps from the original roadmap. They
are intentionally bounded surveys, not claims of professional specialization:

| Criterion | Why earlier projects were insufficient | Direct survey evidence |
|---|---|---|
| Blockchain/crypto ecosystem | Auth and hashing do not teach transaction/ledger APIs | 23: offline transaction/PSBT parsing; no real funds, keys, or broadcast |
| QUIC/advanced transport | HTTP and TCP do not demonstrate QUIC streams/datagrams | 24: local Quinn client/server with TLS, loss, cancellation, and backpressure tests |
| ML/inference | Polars teaches dataframes, not tensors or model inference | 25: `ndarray` preprocessing plus validated local Tract/ONNX inference |
| Mobile target | Tauri desktop packaging does not prove Android/iOS behavior | 26: one actually built and exercised Android target |

Projects 23–26 follow `PROJECT_TEMPLATE.md`, use primary crate/platform references,
remain locally testable, and state safety or hardware/SDK constraints explicitly.

## Completion interpretation

- **Planned:** a linked brief exists.
- **Implemented:** required behavior exists in the corresponding project directory.
- **Verified:** all listed commands and transfer challenge have current evidence.
- **Mastered:** the learner's explanation/reflection demonstrates independent transfer.

The roadmap specification is now planned through Project 27 with direct briefs for
all original breadth criteria. Learner progress remains at Project 01; planned
coverage becomes mastery only after the required implementation, evidence, transfer
challenge, and reflection are complete.

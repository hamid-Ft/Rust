# Just-in-Time Rust Study Map

## How to use this map

This is a routing guide, not a second linear course. For each project:

1. Answer its diagnostic question aloud or in the evidence record before reading.
2. Read the listed Rust Book sections until the question and project types make sense.
3. Use Rust By Example for a runnable second representation when syntax is unclear.
4. Attempt only the listed local Rustlings group(s) that address an observed gap.
5. Return to the smallest project vertical slice; consult crate/platform primary docs
   from the project brief at the moment their API boundary is introduced.

Timebox concept reading to roughly 20–40 minutes before the first coding attempt.
Security-, unsafe-, protocol-, and platform-specific primary documentation may need a
longer focused pass. If the timebox expires without clarity, write the exact question
and build the smallest compiler/test experiment that can answer it. Do not continue
passive reading without a question.

Checked on 2026-07-14: the online Rust Book targets Rust 1.90+ and Edition 2024; this
workspace records Rust 1.96.0. The local Rustlings installation is 6.5.0. Side chats
must still re-check current primary crate/platform documentation under
[`DEPENDENCIES.md`](DEPENDENCIES.md) rather than freezing this date as an API promise.

## Local Rustlings protocol

The checkout lives at `rustlings/`. Its own
[exercise mapping](../rustlings/exercises/README.md) relates groups to Book chapters.
Run one named exercise at a time:

```sh
cd rustlings
rustlings run exercise_name
```

Predict the compiler result before running. Do not open `solutions/` until after a
real attempt and a specific question. Rustlings is targeted remediation, not a gate to
finish every exercise before Project 01. Record attempted exercise names and what gap
they resolved in the project's evidence.

## Foundation: Projects 01–07

| Project | Read before/during the first slice | Targeted local Rustlings | Diagnostic exit question |
|---:|---|---|---|
| 01 | [Book Ch. 1: toolchain/Cargo](https://doc.rust-lang.org/book/ch01-00-getting-started.html), [Ch. 11 tests](https://doc.rust-lang.org/book/ch11-00-testing.html), [Appendix D tools](https://doc.rust-lang.org/book/appendix-04-useful-development-tools.html) | [00_intro](../rustlings/exercises/00_intro/README.md), [17_tests](../rustlings/exercises/17_tests/README.md), [22_clippy](../rustlings/exercises/22_clippy/README.md) | What different defect does `cargo check`, test, rustfmt, Clippy, and rustdoc expose? |
| 02 | [Book Ch. 2 guessing game](https://doc.rust-lang.org/book/ch02-00-guessing-game-tutorial.html), [Ch. 3 concepts](https://doc.rust-lang.org/book/ch03-00-common-programming-concepts.html), [§6.2 `match`](https://doc.rust-lang.org/book/ch06-02-match.html) | [01_variables](../rustlings/exercises/01_variables/README.md), [02_functions](../rustlings/exercises/02_functions/README.md), [03_if](../rustlings/exercises/03_if/README.md), [04_primitive_types](../rustlings/exercises/04_primitive_types/README.md), [08_enums](../rustlings/exercises/08_enums/README.md) | Where should parse failure, range failure, and guess comparison be represented? |
| 03 | [Book Ch. 4 ownership](https://doc.rust-lang.org/book/ch04-00-understanding-ownership.html), [§8.2 strings](https://doc.rust-lang.org/book/ch08-02-strings.html), [§13.2 iterators](https://doc.rust-lang.org/book/ch13-02-iterators.html) | [06_move_semantics](../rustlings/exercises/06_move_semantics/README.md), [09_strings](../rustlings/exercises/09_strings/README.md), [18_iterators](../rustlings/exercises/18_iterators/README.md) | Which value owns each byte buffer, and how long can every returned slice live? |
| 04 | [Book Ch. 5 structs](https://doc.rust-lang.org/book/ch05-00-structs.html), [Ch. 6 enums/matching](https://doc.rust-lang.org/book/ch06-00-enums.html), [Ch. 8 collections](https://doc.rust-lang.org/book/ch08-00-common-collections.html), [Ch. 19 patterns](https://doc.rust-lang.org/book/ch19-00-patterns.html) | [05_vecs](../rustlings/exercises/05_vecs/README.md), [07_structs](../rustlings/exercises/07_structs/README.md), [08_enums](../rustlings/exercises/08_enums/README.md), [11_hashmaps](../rustlings/exercises/11_hashmaps/README.md) | Which invalid inventory states can the types prevent rather than validate later? |
| 05 | [Book Ch. 7 modules](https://doc.rust-lang.org/book/ch07-00-managing-growing-projects-with-packages-crates-and-modules.html), [Ch. 9 errors](https://doc.rust-lang.org/book/ch09-00-error-handling.html), [§6.1 `Option`](https://doc.rust-lang.org/book/ch06-01-defining-an-enum.html) | [10_modules](../rustlings/exercises/10_modules/README.md), [12_options](../rustlings/exercises/12_options/README.md), [13_error_handling](../rustlings/exercises/13_error_handling/README.md) | Is each missing value normal absence, invalid input, I/O failure, or a programmer bug? |
| 06 | [Book Ch. 10 generics/traits](https://doc.rust-lang.org/book/ch10-00-generics.html), [§13.2 iterators](https://doc.rust-lang.org/book/ch13-02-iterators.html), [§20.2 advanced traits](https://doc.rust-lang.org/book/ch20-02-advanced-traits.html) | [14_generics](../rustlings/exercises/14_generics/README.md), [15_traits](../rustlings/exercises/15_traits/README.md), [18_iterators](../rustlings/exercises/18_iterators/README.md), [23_conversions](../rustlings/exercises/23_conversions/README.md) | What behavior requires a trait bound, and what should remain generic data? |
| 07 | [§4.2 borrowing](https://doc.rust-lang.org/book/ch04-02-references-and-borrowing.html), [§10.3 lifetimes](https://doc.rust-lang.org/book/ch10-03-lifetime-syntax.html), [§8.2 strings](https://doc.rust-lang.org/book/ch08-02-strings.html) | [06_move_semantics](../rustlings/exercises/06_move_semantics/README.md), [09_strings](../rustlings/exercises/09_strings/README.md), [16_lifetimes](../rustlings/exercises/16_lifetimes/README.md) | Which input lifetime is each borrowed search result tied to, and why? |

After Project 07, use C1 in [`MASTERY_CHECKPOINTS.md`](MASTERY_CHECKPOINTS.md) to
retrieve these concepts without the table.

## Practical Rust and concurrency: Projects 08–13

| Project | Read before/during the first slice | Targeted local Rustlings | Diagnostic exit question |
|---:|---|---|---|
| 08 | [Book Ch. 12 CLI project](https://doc.rust-lang.org/book/ch12-00-an-io-project.html), [Ch. 9 errors](https://doc.rust-lang.org/book/ch09-00-error-handling.html), [Ch. 14 Cargo](https://doc.rust-lang.org/book/ch14-00-more-about-cargo.html) | [10_modules](../rustlings/exercises/10_modules/README.md), [13_error_handling](../rustlings/exercises/13_error_handling/README.md), [23_conversions](../rustlings/exercises/23_conversions/README.md) | Which behavior belongs in the library, storage adapter, and CLI boundary? |
| 09 | [Book Ch. 11 testing](https://doc.rust-lang.org/book/ch11-00-testing.html), [Ch. 19 patterns](https://doc.rust-lang.org/book/ch19-00-patterns.html) | [17_tests](../rustlings/exercises/17_tests/README.md), [quizzes](../rustlings/exercises/quizzes/README.md) | Which parser claims need unit, integration, doc, property, or compile-fail evidence? |
| 10 | [§13.4 loops versus iterators](https://doc.rust-lang.org/book/ch13-04-performance.html), [§14.1 release profiles](https://doc.rust-lang.org/book/ch14-01-release-profiles.html) | [18_iterators](../rustlings/exercises/18_iterators/README.md) | What measurement would falsify the proposed optimization? |
| 11 | [Book Ch. 15 smart pointers](https://doc.rust-lang.org/book/ch15-00-smart-pointers.html), [Ch. 16 concurrency](https://doc.rust-lang.org/book/ch16-00-concurrency.html) | [19_smart_pointers](../rustlings/exercises/19_smart_pointers/README.md), [20_threads](../rustlings/exercises/20_threads/README.md) | What crosses a thread boundary by ownership, message, or synchronized sharing? |
| 12 | [Book Ch. 17 async](https://doc.rust-lang.org/book/ch17-00-async-await.html), especially [§17.6 tasks/threads](https://doc.rust-lang.org/book/ch17-06-futures-tasks-threads.html) | [20_threads](../rustlings/exercises/20_threads/README.md) only for contrast | What owns each future, and what happens to work when timeout/cancellation wins? |
| 13 | [Ch. 17 async](https://doc.rust-lang.org/book/ch17-00-async-await.html), [Ch. 21 server/shutdown](https://doc.rust-lang.org/book/ch21-00-final-project-a-web-server.html), [§16.2 message passing](https://doc.rust-lang.org/book/ch16-02-message-passing.html) | [20_threads](../rustlings/exercises/20_threads/README.md) when task ownership is unclear | Why are socket read boundaries not message boundaries, and where is backpressure enforced? |

After Project 13, C2 tests transfer across sync threads, async tasks, channels,
framing, cancellation, and testing boundaries.

## Specialization surveys: Projects 14–19

Read the project's primary framework/platform references as authoritative API material.
The Book entries below refresh the Rust mechanism underneath each ecosystem.

| Project | Rust mechanism refresher | Rustlings only if the mechanism is weak | Diagnostic exit question |
|---:|---|---|---|
| 14 | [Ch. 17 async](https://doc.rust-lang.org/book/ch17-00-async-await.html), [Ch. 9 errors](https://doc.rust-lang.org/book/ch09-00-error-handling.html), [§18.2 trait objects](https://doc.rust-lang.org/book/ch18-02-trait-objects.html) | [13_error_handling](../rustlings/exercises/13_error_handling/README.md), [15_traits](../rustlings/exercises/15_traits/README.md) | At which boundary are input, authentication, authorization, transaction, and HTTP errors decided? |
| 15 | [Ch. 4 ownership](https://doc.rust-lang.org/book/ch04-00-understanding-ownership.html), [Ch. 17 async](https://doc.rust-lang.org/book/ch17-00-async-await.html) | [06_move_semantics](../rustlings/exercises/06_move_semantics/README.md) | Which state is browser-owned, Rust-owned, server-owned, borrowed, or cloned into a callback? |
| 16 | [Ch. 10 traits](https://doc.rust-lang.org/book/ch10-02-traits.html), [Ch. 20 advanced features](https://doc.rust-lang.org/book/ch20-00-advanced-features.html), [Rust By Example attributes](https://doc.rust-lang.org/rust-by-example/attribute.html) | [14_generics](../rustlings/exercises/14_generics/README.md), [15_traits](../rustlings/exercises/15_traits/README.md) | What remains testable on the host while the target path stays `no_std`? |
| 17 | [§18.2 trait objects](https://doc.rust-lang.org/book/ch18-02-trait-objects.html), [Ch. 13 iteration](https://doc.rust-lang.org/book/ch13-00-functional-features.html) | [15_traits](../rustlings/exercises/15_traits/README.md), [18_iterators](../rustlings/exercises/18_iterators/README.md) | Which data is component state, which behavior is a system, and what must be deterministic? |
| 18 | [Ch. 12 boundary separation](https://doc.rust-lang.org/book/ch12-03-improving-error-handling-and-modularity.html), [Ch. 17 async](https://doc.rust-lang.org/book/ch17-00-async-await.html) | [10_modules](../rustlings/exercises/10_modules/README.md), [13_error_handling](../rustlings/exercises/13_error_handling/README.md) | Which IPC inputs are untrusted and which capabilities make each command reachable? |
| 19 | [Ch. 8 collections](https://doc.rust-lang.org/book/ch08-00-common-collections.html), [Ch. 13 iterators](https://doc.rust-lang.org/book/ch13-02-iterators.html), [§14.1 release profiles](https://doc.rust-lang.org/book/ch14-01-release-profiles.html) | [18_iterators](../rustlings/exercises/18_iterators/README.md) | Which transformations are lazy, what schema is assumed, and what validates the final rows? |

## Advanced language design: Projects 20–22

| Project | Read before/during the first slice | Targeted local Rustlings | Diagnostic exit question |
|---:|---|---|---|
| 20 | [§20.5 macros](https://doc.rust-lang.org/book/ch20-05-macros.html), [Rust By Example macros](https://doc.rust-lang.org/rust-by-example/macros.html) | [21_macros](../rustlings/exercises/21_macros/README.md) | What proven repetition does the macro remove, and what diagnostic should invalid input receive? |
| 21 | [§20.1 unsafe Rust](https://doc.rust-lang.org/book/ch20-01-unsafe-rust.html), [§20.3 advanced types](https://doc.rust-lang.org/book/ch20-03-advanced-types.html), [Rust By Example unsafe](https://doc.rust-lang.org/rust-by-example/unsafe.html) | No local unsafe drill; Rustlings intentionally forbids unsafe | What invariant makes each unsafe operation valid for every safe caller? |
| 22 | [§10.2 traits](https://doc.rust-lang.org/book/ch10-02-traits.html), [§18.2 trait objects](https://doc.rust-lang.org/book/ch18-02-trait-objects.html), [§20.2 advanced traits](https://doc.rust-lang.org/book/ch20-02-advanced-traits.html) | [15_traits](../rustlings/exercises/15_traits/README.md), [19_smart_pointers](../rustlings/exercises/19_smart_pointers/README.md) | Which variability needs static dispatch, dynamic dispatch, or a different architecture? |

## Ecosystem extensions and capstone: Projects 23–27

| Project | Rust mechanism refresher | Primary study boundary | Diagnostic exit question |
|---:|---|---|---|
| 23 | [Ch. 9 errors](https://doc.rust-lang.org/book/ch09-00-error-handling.html), [Ch. 12 CLI boundaries](https://doc.rust-lang.org/book/ch12-00-an-io-project.html), [Rustlings conversions](../rustlings/exercises/23_conversions/README.md) | BIP 174 and `rust-bitcoin` references in the brief | What can structural parsing prove, and what consensus/wallet facts must remain unknown? |
| 24 | [Ch. 17 async](https://doc.rust-lang.org/book/ch17-00-async-await.html), [§16.2 channels](https://doc.rust-lang.org/book/ch16-02-message-passing.html) | Quinn and RFC references in the brief | Which message needs a bidi stream, uni stream, or datagram, and what reliability follows? |
| 25 | [Ch. 8 collections](https://doc.rust-lang.org/book/ch08-00-common-collections.html), [Ch. 13 iteration](https://doc.rust-lang.org/book/ch13-02-iterators.html) | `ndarray`, Tract, ONNX, and model-card references in the brief | What shape, axis, dtype, normalization, and provenance must be true before inference? |
| 26 | [Ch. 17 async](https://doc.rust-lang.org/book/ch17-00-async-await.html), [Ch. 12 boundary separation](https://doc.rust-lang.org/book/ch12-03-improving-error-handling-and-modularity.html) | Current Tauri Android/lifecycle/capability references in the brief | Which behavior was actually observed on Android versus inferred from host compilation? |
| 27 | [§14.1 profiles](https://doc.rust-lang.org/book/ch14-01-release-profiles.html), [§14.3 workspaces](https://doc.rust-lang.org/book/ch14-03-cargo-workspaces.html), [Ch. 11 testing](https://doc.rust-lang.org/book/ch11-00-testing.html), then selected earlier sections | Current primary docs for the chosen cohesive architecture | What user problem, evidence, ownership/error model, and operational risk make this one product? |

## Evidence rule

In `EVIDENCE.md`, record the diagnostic answer before study, the exact sections or
exercise names used, the question they resolved, and the revised answer. “Read a
chapter” is activity, not mastery evidence; the compiler/test experiment and later
independent explanation are what demonstrate understanding.

## Primary resource entry points

- [The Rust Programming Language](https://doc.rust-lang.org/book/)
- [Rust By Example](https://doc.rust-lang.org/rust-by-example/)
- [Rustlings](https://rustlings.rust-lang.org/)
- [Standard library documentation](https://doc.rust-lang.org/std/)

# Mini-Project 21 — Safe Foreign Buffer Wrapper

## Unlock condition

Complete Project 20 and explain why its problem required syntax generation rather
than a generic function or trait.

## Outcome

Build a tiny C buffer library and expose it through a safe Rust ownership API. Learn
raw pointers, `NonNull`, allocation/layout contracts, `Drop`, C ABI declarations,
build scripts, integer conversions, unsafe invariants, `unsafe_op_in_unsafe_fn`, FFI
errors, unwinding boundaries, and evidence required before implementing `Send`/`Sync`.

## Non-goals

No C++, bindgen, dynamic loading, callbacks, hand-written allocator, or clever unsafe
collection. The unsafe surface remains small enough for a line-by-line audit.

## Artifact and boundary

A bundled C library exposes allocation/free, fill, copy, checksum, and fallible
operation status functions over a byte buffer. A private Rust `sys` module declares
the exact C ABI. The public `ForeignBuffer` type:

- owns exactly one foreign allocation and frees it exactly once in `Drop`;
- handles zero length without assuming `malloc(0)` returns non-null;
- rejects lengths that cannot cross the ABI without truncation/overflow;
- converts nullable results to `Option`/typed `Result` before creating references;
- exposes safe borrowed slice views only while pointer, alignment, initialization,
  allocation size, aliasing, and lifetime invariants are proven;
- never permits Rust panic/unwind to cross a non-unwind C ABI boundary;
- does not implement/claim `Send` or `Sync` without a written proof from both Rust and
  C contracts.

Place `#![deny(unsafe_op_in_unsafe_fn)]` in the wrapper crate. Every unsafe block has
a nearby `SAFETY:` explanation tied to named invariants, not a generic assertion.

## Safety dossier

Create `SAFETY.md` containing:

- authoritative C declarations and Rust equivalents;
- ownership/allocation/deallocation provenance;
- valid pointer, length, alignment, and initialization states;
- aliasing and mutation rules for every returned reference;
- zero-length representation;
- thread-safety analysis;
- panic/unwind and error-code behavior;
- an inventory mapping each unsafe block to the invariants it relies on;
- known limitations and what a future API change must re-audit.

## Build stages

1. Specify the C header and ABI contract before implementing either side.
2. Compile/link the tiny C source through Cargo's build-script path.
3. Add a private raw `sys` layer with no safe claims.
4. Define `ForeignBuffer` invariants and fallible constructor.
5. Add `Drop`, safe slice access, fill/copy/checksum, and typed errors one at a time.
6. Test allocation/status failures through a deterministic C test hook or injected API.
7. Audit every unsafe block against `SAFETY.md` and remove unnecessary unsafe scope.

## Required verification

Run default quality commands plus C compiler warnings-as-errors for the bundled code,
boundary tests for zero/one/large lengths, allocation failure, invalid conversions,
mutation/aliasing behavior through the safe API, exactly-once destruction, error
mapping, and repeated create/drop cycles. Run available platform memory/address
sanitizers when practical and record their limits. Do not claim Miri verified foreign
C execution; use it only for Rust-only paths it actually supports.

## Transfer challenge

Add fallible deep cloning through a new C copy operation and Rust `try_clone` method.
Prove source and clone have independent ownership, make partial failure leak-free, and
test mutation independence, zero length, failure injection, and exact destructor
counts. Update the safety dossier before writing the unsafe call.

## Completion checklist

- [ ] Raw bindings are private and the public API is safe for every safe input.
- [ ] Allocation provenance and exactly-once destruction are tested.
- [ ] Every unsafe block is minimal and justified by named invariants.
- [ ] Thread/unwind claims are conservative and documented.
- [ ] Rust, C-warning, boundary, and available sanitizer checks pass.
- [ ] Transfer challenge and reflection are complete.

## Primary references

- [The Rust Book: Unsafe Rust](https://doc.rust-lang.org/book/ch20-01-unsafe-rust.html)
- [The Rustonomicon: Foreign Function Interface](https://doc.rust-lang.org/nomicon/ffi.html)
- [Cargo build scripts](https://doc.rust-lang.org/cargo/reference/build-scripts.html)


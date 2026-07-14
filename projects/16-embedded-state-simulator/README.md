# Mini-Project 16 — `no_std` Traffic Controller

## Unlock condition

Complete Project 13. In the default breadth sequence, also complete Project 15; this
project itself does not depend on the web artifacts.

## Outcome

Build a platform-independent `#![no_std]` traffic-light controller using
`embedded-hal` traits and type-state transitions. Run exhaustive logic tests on the
host, then compile-check the library for a bare-metal target.

## Non-goals

No specific development board, RTOS, allocator, interrupts, or unsafe register
access. Hardware deployment can follow later without coupling core logic to one MCU.

## Artifact and behavior

- A `no_std` library drives red, amber, and green output pins through generic HAL
  traits; device-specific details never enter the controller API.
- Valid phases and safe transitions are explicit, including startup/fault behavior.
- Type-state ensures operations available only in initialized/running states cannot
  be called before initialization or after entering the terminal fault state.
- Durations and policies use fixed-size value types; normal operation performs no
  heap allocation.
- Pin failures propagate through a concrete generic/typed controller error.
- Host-only fake pins record transitions for deterministic tests.

Use type-state only for transitions that gain real compile-time safety. Traffic phases
that vary dynamically may remain an enum; document why both techniques coexist.

## Concept checklist

- [ ] `core` versus `std` availability is understood.
- [ ] The crate compiles without an allocator in normal library code.
- [ ] HAL traits invert the dependency on concrete hardware.
- [ ] Generic pin errors are propagated without boxing.
- [ ] `PhantomData` carries state relationships without runtime flags.
- [ ] Compile-fail tests demonstrate at least one impossible operation.
- [ ] Host fakes are confined to test/support configuration.

## Build stages

1. Create a `no_std` library and prove a host test can coexist with it.
2. Specify phase/fault invariants and choose enum versus type-state responsibilities.
3. Implement a generic three-pin output adapter.
4. Add initialized/running/fault controller transitions.
5. Build fake pins and exhaustive state/output tests.
6. Add compile-fail examples for illegal type-state usage.
7. Add and check one suitable bare-metal compilation target.

## Required verification

```sh
cargo fmt --all -- --check
cargo test --all-targets --all-features --locked
cargo clippy --all-targets --all-features --locked -- -D warnings
cargo doc --no-deps --locked
cargo check --target thumbv7em-none-eabihf --no-default-features --locked
```

Install the chosen target explicitly before the last command, or document an
equivalent available bare-metal target. Inspect the dependency tree to ensure the
target build does not pull in `std` accidentally.

## Transfer challenge

Add a pedestrian request button using an `embedded-hal` input trait and a fixed-size
debounce state machine. Requests are serviced only at a safe transition point and
cannot shorten minimum vehicle-green time. Test bounce sequences, held input, repeated
requests, pin errors, and the compile-time lifecycle constraints.

## Completion checklist

- [ ] Host tests cover every phase, transition, output, and pin-error path.
- [ ] Type-state excludes meaningful lifecycle misuse at compile time.
- [ ] No heap allocation or `std` dependency enters the target library path.
- [ ] The bare-metal target check passes.
- [ ] Default quality commands pass.
- [ ] Transfer challenge and reflection are complete.

## Primary reference

- [`embedded-hal` documentation](https://docs.rs/embedded-hal/latest/embedded_hal/)

# Mini-Project 11 — Parallel File Search

## Unlock condition

Complete Project 10 and defend one performance decision using benchmark evidence,
including an explanation of noise and what the benchmark did not prove.

## Outcome

Build a bounded parallel recursive text searcher using standard-library threads and
channels. Learn thread ownership, `move` closures, message passing, `Arc`, `Mutex`,
`Send`, `Sync`, scoped lifetimes, shutdown, and deterministic result assembly.

## Non-goals

No async runtime, filesystem watcher, regex engine, or attempt to outperform mature
search tools. The goal is correct concurrency with understandable ownership.

## Artifact and behavior

- Discover regular files under a root while handling inaccessible paths as errors.
- Search text files using a configurable non-zero worker count and bounded queue.
- Return path, one-based line number, and matching line for every hit.
- Support case-sensitive/insensitive matching and a maximum file-size policy.
- Produce deterministic sorted output independent of thread completion order.
- Stop accepting work after cancellation or the first fatal coordinator error.
- Join every worker and report worker panic/failure without hanging.

Prefer message passing for work ownership. Use `Arc` for genuinely shared immutable
configuration. Introduce `Mutex` only where shared mutation is justified, and never
hold a lock while performing filesystem I/O or blocking channel sends.

## Concept checklist

- [ ] `Send` versus `Sync` can be explained with concrete project types.
- [ ] Ownership moved into every thread is explicit.
- [ ] Bounded queues provide backpressure.
- [ ] Channel closure participates in worker shutdown.
- [ ] `Arc` cloning shares ownership rather than deep-copying the value.
- [ ] Poisoning, worker panic, and join failures have deliberate handling.
- [ ] Determinism is established after concurrency, not assumed from scheduling.

## Build stages

1. Implement and test a single-threaded search baseline.
2. Draw coordinator, worker, and result-channel ownership before spawning threads.
3. Add a fixed worker set and bounded work distribution.
4. Aggregate, sort, and render deterministic results.
5. Add cancellation and explicit shutdown/join behavior.
6. Trigger an `Rc`/`Send` compiler error and explain why `Arc` changes the guarantee.
7. Compare correctness and throughput against the baseline without promising speedup.

## Required verification

Run the default quality commands. Integration tests use generated temporary trees and
cover empty trees, Unicode, unreadable/oversized files where portable, cancellation,
more workers than files, deterministic ordering, and injected worker failure. Run a
stress test repeatedly to look for hangs; repetition is evidence, not a proof of races.

## Transfer challenge

Add ordered early termination after the first `N` results. Define “first” by sorted
path/line order rather than scheduler timing, avoid unbounded buffering, and prove all
threads terminate. Explain the inherent trade-off between deterministic global order
and immediate cancellation.

## Completion checklist

- [ ] Worker count and queues are bounded.
- [ ] All success, error, cancellation, and panic paths join workers.
- [ ] Shared state and every synchronization primitive are justified.
- [ ] Output is deterministic across repeated executions.
- [ ] Default quality and stress commands pass.
- [ ] Transfer challenge and reflection are complete.

## Related Rustlings drills

- `19_smart_pointers`
- `20_threads`
- `13_error_handling`


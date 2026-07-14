# Mini-Project 12 — Async Website Checker

## Unlock condition

Complete Project 11 and explain ownership, shutdown, backpressure, and `Send`/`Sync`
in its coordinator/worker design.

## Outcome

Build a bounded concurrent HTTP health checker with Tokio, Reqwest, and tracing.
Learn futures, `.await`, spawned tasks, structured concurrency, semaphores, timeouts,
cancellation, reusable clients, and async-safe observability.

## Non-goals

No crawler, browser automation, distributed scheduler, or production monitoring
service. Tests must not depend on public internet availability.

## Artifact and behavior

- Read and validate a list of HTTP/HTTPS targets.
- Reuse one configured Reqwest client and connection pool.
- Check targets concurrently with a configurable non-zero concurrency limit.
- Apply per-request timeout and an overall run deadline.
- Record status, latency, final URL, response class, and typed failure category.
- Preserve input order in the final report despite out-of-order completion.
- Cancel outstanding work on Ctrl-C or overall deadline and await task termination.
- Emit structured tracing spans/events without holding entered span guards across
  `.await` points.

## Concept checklist

- [ ] Calling an `async fn` creates a future; `.await` drives dependency progress.
- [ ] Concurrency is bounded independently of the number of inputs.
- [ ] Spawned task data satisfies required ownership and `Send + 'static` bounds.
- [ ] One HTTP client is cheaply shared/reused rather than rebuilt per request.
- [ ] Timeouts and cancellation are different outcomes.
- [ ] Join errors, HTTP errors, and status failures remain distinguishable.
- [ ] Tracing fields capture target/outcome without secrets or entire response bodies.

## Build stages

1. Implement one async request against a local test server.
2. Add typed outcomes and request/client timeouts.
3. Introduce bounded concurrent checks and ordered aggregation.
4. Add an overall deadline and cooperative cancellation.
5. Track spawned work and await every task on all exits.
6. Instrument checks with spans and structured events.
7. Trigger a non-`Send`-across-`.await` compiler error and explain the saved future state.

## Required verification

Run default quality commands and async integration tests against local ephemeral
servers covering success, redirect, HTTP failure status, delayed timeout, malformed
URL, dropped connection, concurrency limit, input ordering, and cancellation. Pause
Tokio time where appropriate, but keep at least one real socket integration path.

## Transfer challenge

Add bounded retries with exponential backoff for explicitly retryable failures only.
Respect the overall deadline, do not retry most client errors, record attempt count,
and make backoff tests deterministic using controlled time.

## Completion checklist

- [ ] Tests are independent of external network services.
- [ ] Concurrency and retries are bounded.
- [ ] Client, task, timeout, cancellation, and tracing behavior is explained.
- [ ] Every spawned task is observed or deliberately cancelled and joined.
- [ ] Default quality and async integration tests pass.
- [ ] Transfer challenge and reflection are complete.

## Primary references

- [Tokio tutorial](https://tokio.rs/tokio/tutorial)
- [Reqwest client documentation](https://docs.rs/reqwest/latest/reqwest/struct.Client.html)
- [Tracing documentation](https://docs.rs/tracing/latest/tracing/)

## Related Rustlings drills

- `13_error_handling`
- `19_smart_pointers`
- `20_threads` (contrast threads with tasks)


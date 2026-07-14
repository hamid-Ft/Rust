# Mini-Project 24 — Quinn QUIC Telemetry Service

## Unlock condition

Complete Project 23 with evidence and reflection.

## Outcome

Build a local Quinn client/server that deliberately uses QUIC's different transport
primitives: a bidirectional control stream, unidirectional telemetry streams, and
loss-tolerant datagrams. The protocol must be framed, bounded, observable, cancellable,
and able to shut down without abandoned tasks.

Use only loopback and test certificates in the required project. Do not invent
cryptography, disable certificate verification, expose the service publicly, or
claim that datagrams are reliable. Keep 0-RTT disabled until its replay semantics are
understood and explicitly tested.

## Non-goals

- Public deployment, production PKI, custom cryptography, HTTP/3, or NAT traversal.
- Disabling verification to make local TLS setup easier.
- Treating datagrams as ordered/reliable or testing them as if they were.
- Unbounded connections, streams, tasks, queues, frames, or file buffers.

## Required behavior

- Define versioned request, response, telemetry, and datagram message types with
  documented maximum encoded sizes.
- Frame every stream message; a QUIC stream is still a byte stream and read boundaries
  must not be treated as message boundaries.
- Generate or commit a non-secret test CA/certificate for localhost and configure the
  client to trust only that test identity. A mismatched identity must fail closed.
- Bound connections, concurrent streams, queued work, frame sizes, and per-connection
  memory. Apply backpressure instead of spawning without limit.
- Distinguish connection, stream, protocol, timeout, cancellation, and application
  errors and attach useful `tracing` fields without logging payload secrets.
- Coordinate Ctrl-C/server shutdown, connection close reasons, task cancellation, and
  join completion so tests do not leak tasks or ports.

## Build stages

1. Model the versioned protocol, transport choice per message, limits, and error types.
2. Establish one verified loopback connection using an explicit test trust root.
3. Add one framed bidirectional request/response vertical slice.
4. Add unidirectional telemetry and loss-tolerant datagrams with bounded concurrency.
5. Introduce slow-peer, malformed-frame, cancellation, and shutdown behavior.
6. Add deterministic integration tests, structured tracing, and protocol docs.
7. Verify the base service before implementing resumable transfer independently.

## Required verification

Run integration tests on loopback with ephemeral ports:

```sh
cargo fmt --all -- --check
cargo test --all-targets --all-features --locked
cargo clippy --all-targets --all-features --locked -- -D warnings
cargo doc --no-deps --locked
```

Cover fragmented/coalesced frames, oversized and malformed messages, certificate and
server-name mismatch, concurrent streams, a slow consumer, cancellation, peer close,
and graceful server shutdown. Datagram tests may assert successful handling when a
datagram arrives, but must never require delivery or ordering. Use deterministic
timeouts and provide failure diagnostics rather than relying on arbitrary sleeps.

## Transfer challenge

Add resumable file transfer over unidirectional streams with a bounded chunk size,
content checksum, explicit cancellation, and an atomic final rename. Demonstrate
interruption and resume without retaining the full file in memory. Datagrams may
announce progress, but correctness must not depend on receiving them.

## Completion checklist

- [ ] Bidi streams, uni streams, and datagrams each have a justified role.
- [ ] TLS identity is verified using an explicit local trust root.
- [ ] Framing and all resource limits are enforced at untrusted boundaries.
- [ ] Backpressure, cancellation, and graceful shutdown have integration evidence.
- [ ] Tests respect datagram loss and avoid timing-only correctness assumptions.
- [ ] Transfer challenge resumes safely and verifies final content.
- [ ] Reflection compares QUIC streams/datagrams with the earlier TCP protocol.

## Primary references

- [Quinn crate documentation](https://quinn-rs.github.io/quinn/quinn.html)
- [QUIC transport specification (RFC 9000)](https://www.rfc-editor.org/rfc/rfc9000)

# Mini-Project 13 — Async TCP Chat Server

## Unlock condition

Complete Project 12 and explain the difference between concurrency, parallelism,
timeouts, cancellation, and dropping a future.

## Outcome

Build a multi-client Tokio chat server with an explicit framed protocol, connection
tasks, channels, backpressure, structured tracing, and graceful shutdown. This closes
the common foundation before specialization projects begin.

## Non-goals

No TLS, database, web sockets, federation, or production authentication. The protocol
is intentionally small enough to reason about byte-by-byte.

## Protocol and behavior

- Use a documented length-prefixed binary envelope with UTF-8 message payloads.
- Enforce maximum frame, name, and message sizes before allocation where possible.
- Require a unique validated display name before joining chat.
- Broadcast join, chat, leave, and server-shutdown events.
- Handle partial reads/writes, multiple buffered frames, invalid UTF-8, oversized
  frames, clean EOF, and EOF during a partial frame distinctly.
- Define a slow-client policy so one receiver cannot stall the server or grow memory
  without bound.
- Stop accepting connections on Ctrl-C, notify clients, finish/abort within a bounded
  grace period, and await all tracked connection tasks.

Separate protocol codec, connection state, chat coordination, and server lifecycle.
Do not hold synchronous locks across `.await`; prefer ownership plus channels for the
coordinator's mutable state.

## Concept checklist

- [ ] TCP is a byte stream, not a message transport.
- [ ] Framing handles fragmentation and coalescing.
- [ ] Read and write halves have clear task ownership.
- [ ] Channel capacity and lag/slow-consumer behavior are explicit.
- [ ] Cancellation is cooperative and all tasks are tracked.
- [ ] Errors implement required `Send + Sync + 'static` bounds where spawned.
- [ ] Spans/events correlate connections without logging message contents by default.

## Build stages

1. Specify frame layout, limits, and error cases before networking.
2. Implement incremental encode/decode tests using fragmented byte chunks.
3. Build a single-connection echo server over the codec.
4. Add registration and coordinator-owned client state via channels.
5. Add bounded broadcast delivery and a documented slow-client policy.
6. Track connection tasks and implement graceful server shutdown.
7. Add structured tracing and inspect concurrent connection spans.

## Required verification

Run default quality commands plus local socket integration tests for fragmentation,
coalesced frames, maximum boundaries, malformed data, duplicate names, two-way chat,
abrupt disconnect, slow client, Ctrl-C-equivalent cancellation, and shutdown grace
expiry. Tests must use ephemeral ports and bounded timeouts so failures cannot hang.

## Transfer challenge

Add private messages addressed to a validated connected user. Extend the protocol
without breaking existing broadcast frames, return a typed delivery failure when the
recipient is absent, preserve backpressure policy, and test concurrent disconnect
during delivery.

## Completion checklist

- [ ] Codec tests prove stream framing across arbitrary chunk boundaries.
- [ ] Server state has a clear owner and bounded communication channels.
- [ ] Slow, malformed, and disconnected clients cannot hang global progress.
- [ ] Shutdown stops acceptance and accounts for every connection task.
- [ ] Default quality and socket integration tests pass.
- [ ] Transfer challenge and common-foundation reflection are complete.

## Primary references

- [Tokio framing tutorial](https://tokio.rs/tokio/tutorial/framing)
- [Tokio channels tutorial](https://tokio.rs/tokio/tutorial/channels)
- [Tokio graceful shutdown guide](https://tokio.rs/tokio/topics/shutdown)

## Related Rustlings drills

- `13_error_handling`
- `19_smart_pointers`
- `20_threads` (compare runtime tasks and OS threads)


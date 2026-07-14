# Mini-Project 18 — Tauri Desktop Markdown Library

## Unlock condition

Complete Project 13. In the default breadth sequence, complete Project 17 first.

## Outcome

Build a Tauri v2 desktop application with a web frontend and a safe Rust backend that
indexes a user-selected Markdown library. Learn commands, typed IPC, channels/events,
managed state, path APIs, capabilities, scoped permissions, background work,
persistence, and desktop packaging.

## Non-goals

No arbitrary shell execution, remote webview content, mobile release, updater, or
full Markdown editor. The app deliberately limits native authority.

## Artifact and behavior

- Select and persist one library root through a native directory dialog.
- Index Markdown metadata/content in a local SQLite database under app data.
- Search and open document details through request/response commands.
- Reindex in background with a per-invocation typed channel for progress/cancellation.
- Emit low-frequency library-change notifications only when global broadcast is useful.
- Detect changed/deleted files and update the index transactionally.
- Show typed, serialized backend errors in recoverable frontend states.
- Package a release build for the current desktop platform.

## Tauri architecture and security criteria

- `src-tauri/src/main.rs` is a thin passthrough; commands, builder setup, and shared
  application logic live in `lib.rs`/modules.
- Every `#[tauri::command]` is registered with `generate_handler!` and returns an
  appropriate value or `Result`.
- Async commands take owned deserializable arguments and never block the runtime with
  long synchronous I/O/CPU work.
- Commands provide request/response, channels provide command-scoped progress, and
  events are reserved for global fire-and-forget notifications.
- App state type used by `State<T>` exactly matches the type passed to `.manage()`;
  locks are short-lived and never held across `.await`.
- `app.path()` APIs locate app data; no platform path is hard-coded.
- Capability files target only the main window and grant only required core/dialog
  permissions. Plugin installation alone is never treated as permission.
- Because capabilities do not sandbox arbitrary Rust backend code, every requested
  path is canonicalized and checked to remain under the selected root before access.
- Frontend and Rust IPC types have one reviewed serialized contract.

## Build stages

1. Scaffold Tauri v2 and verify config, dev URL, thin `main.rs`, and capability schema.
2. Define IPC DTOs/errors and one registered health/info command.
3. Add directory selection, app-data configuration, and root-path validation.
4. Implement testable indexing/storage outside command functions.
5. Add query commands and frontend loading/error/empty states.
6. Add cancellable reindexing with a typed progress channel.
7. Add narrowly scoped change events and listener cleanup.
8. Audit permissions, run desktop tests, and build a package.

## Required verification

Run Rust default quality commands from `src-tauri`, frontend tests/build/lint, Tauri
configuration checks, IPC serialization tests, database/indexer tests with temporary
roots, and at least one desktop smoke run. Verify unknown commands fail, backend
errors serialize predictably, path traversal/symlink escape is rejected, progress
listeners are cleaned up, cancellation terminates work, only declared permissions are
present, and a current-platform release package builds.

## Transfer challenge

Add an opt-in filesystem watch mode. Debounce bursts, canonicalize every changed path,
send low-frequency summary events rather than unbounded per-file chatter, stop the
watcher when the root changes or app exits, and recover from overflow/rescan signals.
Prove watcher events outside the root cannot enter the index.

## Completion checklist

- [ ] IPC primitive choice is justified for every cross-boundary interaction.
- [ ] All commands are registered, typed, and tested outside UI where possible.
- [ ] Capabilities are least-privilege and backend paths are independently validated.
- [ ] State locks and long work cannot block the main/runtime thread improperly.
- [ ] Rust/frontend checks and current-platform packaging pass.
- [ ] Transfer challenge and reflection are complete.

## Primary references

- [Tauri: calling Rust from the frontend](https://v2.tauri.app/develop/calling-rust/)
- [Tauri capabilities](https://v2.tauri.app/security/capabilities/)
- [Tauri configuration](https://v2.tauri.app/reference/config/)


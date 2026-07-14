# Mini-Project 26 — Tauri Android Field Companion

## Unlock condition

Complete Project 25 with evidence and reflection. Project 18's Tauri desktop concepts
are prerequisites; this project must produce mobile evidence rather than another
desktop build.

## Outcome

Build, install, and run a Tauri v2 Android application whose touch UI invokes a real
Rust backend and persists offline annotations in the platform app-data directory.
Reuse a small domain crate from an earlier project where useful, but keep the Tauri
builder in `lib.rs`, expose the mobile entry point, and keep `main.rs` thin.

Android is the authoritative target for this Linux-based survey. iOS is explicitly
out of scope because it requires Apple tooling. A host build, generated Android
folder, screenshot-only mock, or browser PWA does not satisfy this project's outcome.

## Non-goals

- iOS evidence, store publication, cloud sync, accounts, analytics, or push messaging.
- Custom mobile plugins unless the deep-link transfer cannot use a maintained plugin.
- Broad shell/filesystem permissions or desktop-only APIs hidden behind a mobile UI.
- Treating a host build, generated project, or screenshot as runtime proof.

## Environment gate

Before implementation, record `rustc`, Cargo, Tauri CLI, Java, Android SDK/NDK, ADB,
installed Rust Android targets, and emulator/physical-device availability. Initialize
with the current Tauri v2 Android command. If a device/emulator or required SDK package
is unavailable, stop and resolve that prerequisite openly; do not substitute desktop
evidence.

## Required behavior

- Provide touch-friendly note browsing/search plus create/edit/delete annotations,
  all usable offline and persisted atomically under an app-specific path.
- Register every command explicitly. Async commands use owned inputs and move blocking
  filesystem work off the async runtime where necessary.
- Use a dedicated Android capability with least privilege and only plugins whose
  current documentation declares Android support. Never grant broad filesystem or
  shell access as a shortcut.
- Configure the Rust crate for mobile library outputs and the Tauri mobile entry point;
  isolate any platform-specific code behind clear modules/configuration.
- Handle Android back navigation, pause/resume, process restart, orientation changes,
  soft keyboard, touch targets, screen-reader labels, and safe-area layout without
  losing committed data or duplicating writes.
- Show recoverable errors in the UI without exposing paths, stack traces, or sensitive
  content. Use app path APIs rather than hard-coded host/device paths.

## Build stages

1. Record the environment gate and prove an emulator/device is visible before coding.
2. Initialize Android support and run the smallest generated app on that target.
3. Move domain behavior into a host-testable Rust library and expose one safe command.
4. Build one touch UI vertical slice that invokes Rust and persists one annotation.
5. Add full CRUD/search, least-privilege capabilities, errors, and atomic recovery.
6. Exercise restart, rotation, pause/resume, back, keyboard, accessibility, and offline
   behavior on the recorded Android target.
7. Produce/checksum a release artifact, then implement deep links independently.

## Required verification

Host-side domain tests and Rust quality checks:

```sh
cargo fmt --all -- --check
cargo test --workspace --all-targets --locked
cargo clippy --workspace --all-targets --locked -- -D warnings
cargo doc --workspace --no-deps --locked
```

Mobile verification must include the current equivalents of:

```sh
cargo tauri android init
cargo tauri android dev
cargo tauri android build
```

Capture the exact device/emulator identity, Android/API version, commands, dated log,
release artifact path and checksum. Demonstrate Rust IPC, create/edit/delete, search,
restart persistence, rotate/background/resume, back behavior, offline startup, denied
capability behavior, and one corrupted/interrupted-state recovery. Automated mobile
tests are encouraged, but a documented hands-on smoke script is still required.

## Transfer challenge

Add an Android deep link that opens a specific note or search query. Validate and
length-limit the URI, handle cold start and already-running delivery, reject unknown
schemes/actions, and prove that lifecycle delivery does not duplicate an annotation.
Use a maintained mobile-capable Tauri plugin or a narrowly reviewed native boundary.

## Completion checklist

- [ ] Tool/SDK/device readiness is recorded without hiding missing prerequisites.
- [ ] A real Android app invokes Rust and persists state through process restart.
- [ ] Capabilities/plugins are mobile-supported, minimal, and denial-tested.
- [ ] Lifecycle, rotation, keyboard, back, touch, and accessibility checks pass.
- [ ] Release APK/AAB build evidence and checksum are recorded.
- [ ] Deep links work for cold/warm lifecycle paths and reject malformed input.
- [ ] Reflection contrasts desktop and mobile constraints and names untested devices.

## Primary references

- [Tauri prerequisites and mobile targets](https://v2.tauri.app/start/prerequisites/)
- [Developing Tauri mobile applications](https://v2.tauri.app/develop/)
- [Tauri distribution and mobile builds](https://v2.tauri.app/distribute/)
- [Tauri capabilities](https://v2.tauri.app/security/capabilities/)

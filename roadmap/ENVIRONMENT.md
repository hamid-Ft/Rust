# Environment Readiness Matrix

## Snapshot and interpretation

Read-only preflight recorded on 2026-07-14 in the Linux workspace. It proves only that
the named command/package/target was visible during the check. It does not prove a GUI,
GPU, browser, device, daemon, cross-target binary, or packaged application runs.

Statuses:

- **Ready:** required host prerequisite is visible; the project still verifies it.
- **Partial:** useful prerequisites exist, but a required target/tool/runtime is missing
  or unverified.
- **Optional missing:** not a project blocker; install only if its optional workflow is
  selected and justified.
- **At-unlock setup:** deliberately deferred to avoid stale versions and unused tools.

Do not install the entire matrix now. At each project unlock, re-read current primary
documentation, verify only that project's rows, request approval for required downloads
or system changes, and record the resulting version/delta in `EVIDENCE.md`.

## Core Rust and workspace

| Capability | Observed state | Classification / consequence |
|---|---|---|
| Rust compiler/Cargo | `rustc 1.96.0`, `cargo 1.96.0`, stable host | Ready for Projects 01–14 and host logic elsewhere |
| rustup | 1.29.0 | Ready; install targets/components only at unlock |
| Formatting/lint/docs/source | rustfmt, Clippy, rust-docs, and rust-src installed | Ready |
| rust-analyzer | rustup proxy exists, component unavailable for active toolchain | Partial; editor analysis must be installed or independently provided by the editor before relying on it |
| Rustlings | 6.5.0; current state recorded in `PROGRESS.md` | Ready for targeted drills |
| Root version control | Git 2.43.0 installed, but this workspace root is not a Git repository | Partial; do not claim commits/CI/clean checkout until a project explicitly establishes version-control evidence |
| Roadmap validation | `./roadmap/validate.sh` passes | Ready; rerun after progress changes |

The VS Code command is installed through Snap but could not execute in the managed
environment because Snap confinement refused to start. Editor version/extensions are
therefore **unverified**, not absent. This does not affect command-line Project 01.

## Native build, database, network, and diagnostics

| Capability | Observed state | Classification / consequence |
|---|---|---|
| C/C++ toolchain | GCC/G++/`cc` 13.3, GNU Make 4.3, `build-essential` installed | Ready for native dependencies and Project 21's C boundary |
| Clang/CMake/Ninja | Not found | Optional missing unless a selected crate/build path requires them |
| pkg-config | 1.8.1 | Ready |
| SQLite | CLI 3.50.6; development library 3.45.1 | Ready for SQLx/SQLite work; migrations/runtime still require project evidence |
| OpenSSL | CLI 3.6.1; development library 3.0.13 | Ready as a native dependency; prefer rustls where the brief chooses it |
| Docker | CLI 28.5.1; daemon access not proven in sandbox | Partial/optional; no required test may assume it without a successful project-local check |
| Python | 3.14.3 | Ready for an independent inference fixture if Project 25 justifies it; not a runtime dependency by default |
| `perf` | 6.17.13 | Ready for Linux profiling when permissions/workload allow it |
| GDB | 15.1 | Ready for native/FFI diagnostics |
| cargo-flamegraph, Valgrind, LLDB | Not found | Optional missing; install only for a measurement/debugging question |
| cargo-audit, cargo-deny | Not found | At-unlock/optional according to project security/license gates; tool absence proves nothing about advisories |
| cargo-nextest, cargo-watch | Not found | Optional missing; default Cargo workflow remains authoritative |

Projects 01–14, 19, and 21–25 have their basic host prerequisites. Their crates,
services, ports, certificates, databases, models, and runtime behavior are intentionally
created and verified in their own side chats rather than pre-installed here.

## Web and WASM

| Capability | Observed state | Classification / consequence |
|---|---|---|
| Node/npm | Node 25.7.0, npm 11.10.1 | Partial: Node 25 is EOL; use a current LTS for Tauri/frontend evidence |
| pnpm | 11.5.1 | Ready if the project selects it; do not mix package managers |
| Yarn/Bun/Deno | Not found | Optional missing |
| `wasm32-unknown-unknown` Rust target | Not installed | Project 15 at-unlock setup |
| Trunk | Not found | Project 15 at-unlock setup |
| wasm-pack/wasm-bindgen CLI/wasm-opt | Not found | Optional unless the selected WASM workflow requires them; Trunk CSR is the planned path |
| Browser runtime | Not exercised by this preflight | Project 15 must capture real browser and accessibility evidence |

Current Leptos CSR guidance requires the WASM target and Trunk, so Project 15 cannot
claim browser readiness until both are installed from current instructions and a real
browser build runs. Node is not required for the planned pure Trunk CSR slice unless a
chosen frontend tool introduces it.

## Embedded and systems

| Capability | Observed state | Classification / consequence |
|---|---|---|
| Host-tested `no_std` design | rust-src installed | Ready for initial Project 16 library work |
| `thumbv7em-none-eabihf` target | Not installed | Project 16 at-unlock setup; its required target check cannot pass yet |
| QEMU/probe-rs/ARM GDB | Not found | Optional missing because Project 16 is a host-tested simulator, not a hardware-flashing claim |
| Physical board/debug probe | Not checked and not required by the brief | No hardware claim is permitted |
| Native C compiler/GDB | Present | Ready for Project 21's small reviewed FFI boundary |

Official embedded setup confirms that a target such as `thumbv7em-none-eabihf` must be
installed before compiling for that microcontroller class. Install only the target used
by the final Project 16 brief and document any substitution.

## Game development

| Capability | Observed state | Classification / consequence |
|---|---|---|
| Window/input development libraries | X11, XCursor, Xi, XRandR, xkbcommon, and Wayland client libraries visible | Partial host readiness |
| ALSA and libudev development packages | Not installed | Partial: Bevy default audio/gamepad features may require them; either install current prerequisites or deliberately select/test a minimal feature set |
| GPU/Vulkan/GL inspection | `vulkaninfo` and `glxinfo` absent; no window opened | Unverified; Project 17 needs an actual rendered-game run |
| Fast linker tools | Clang/LLD/Mold not checked in as ready | Optional optimization only; never required before measuring compile iteration pain |

Project 17 must inspect the current Bevy release and features. It may install the native
audio/input packages or omit unused features under the dependency policy, but it cannot
silently weaken required keyboard/window/render behavior.

## Tauri desktop

| Capability | Observed state | Classification / consequence |
|---|---|---|
| Debian/Ubuntu native prerequisites | build-essential, WebKitGTK 4.1, libxdo, OpenSSL, Ayatana AppIndicator, librsvg development packages installed | Ready according to current Tauri Linux prerequisites |
| GTK/WebKit stack | GTK 3.24.41, WebKitGTK/JavaScriptCoreGTK 2.52.3, libsoup 3.4.4 visible | Ready at package level; actual app window/package remains unverified |
| Tauri CLI | `cargo-tauri` not found | Project 18 at-unlock setup |
| JavaScript runtime | Node 25 is EOL; pnpm present | Partial; select/install current Node LTS before using a JS frontend toolchain |
| Desktop GUI/package execution | Not attempted | Project 18 must run IPC/capability checks and build/install its selected artifact |

The Tauri skill's architectural gates still apply after setup: builder/commands in
`lib.rs`, thin `main.rs`, registered handlers, owned async inputs, app-path APIs, and
least-privilege capabilities. Installed libraries are not evidence those gates pass.

## Tauri Android

| Capability | Observed state | Classification / consequence |
|---|---|---|
| Java | OpenJDK 21.0.11; `JAVA_HOME` set | Ready at version/path level |
| Android environment | `ANDROID_HOME` and `NDK_HOME` set | Ready at environment level; paths were not recorded to avoid unnecessary machine detail |
| SDK pieces | platform-tools, command-line tools, emulator, NDK, build-tools, and platforms present | Partial; compatibility still needs a real Tauri build |
| Android platforms | API directories 35, 36, and 37.0 present | Available; project chooses current supported target explicitly |
| Android NDK | 30.0.14904198 present | Available; current Tauri compatibility must be verified at unlock |
| Rust Android targets | aarch64, armv7, i686, x86_64 all installed | Ready according to current Tauri target list |
| ADB | 1.0.41 | Ready; no connected physical device was queried during this preflight |
| Emulator | 36.6.11 installed outside PATH; version query emitted a sandbox socket warning | Partial; do not infer runtime failure outside the managed sandbox |
| Android Virtual Devices | No AVD listed | Required Project 26 setup unless a physical device is explicitly available |
| sdkmanager | 20.0; warns it encountered newer SDK XML schema | Partial/risk: update/compatibility decision belongs to Project 26 setup |
| Android Studio | Found in a common installation path | Available; version/runtime not exercised |
| Tauri CLI/mobile project | CLI absent; Android project not initialized | Project 26 at-unlock setup |

Project 26 remains intentionally unready for runtime evidence: it needs a current Tauri
CLI, compatible SDK/NDK confirmation, and one real emulator or physical device. It must
record `cargo tauri android dev/build` evidence rather than treating the installed four
Rust targets as completion.

## Project setup queue

Install or resolve items only when the preceding mastery gates unlock the project:

| Earliest project | Required action before its target-specific gate | Deferred/optional actions |
|---:|---|---|
| 01 | Confirm editor support or proceed with command-line tools | Install rust-analyzer component/extension if desired |
| 10 | None for Criterion itself; use existing `perf` if suitable | cargo-flamegraph/Valgrind only for a measured question |
| 15 | Add `wasm32-unknown-unknown`; install current Trunk; run a browser smoke test | wasm-pack/wasm-opt only if workflow changes |
| 16 | Add the documented bare-metal Rust target | probe-rs/QEMU only if scope expands with explicit evidence rules |
| 17 | Resolve Bevy native features/packages and prove a GPU/window runtime | faster linker only after measuring build pain |
| 18 | Select current Node LTS/frontend manager; install current Tauri v2 CLI | packaging helpers dictated by chosen Linux artifact |
| 20 | None | cargo-expand if its current installation is justified for expansion evidence |
| 26 | Reconcile SDK tools, create/select AVD or device, confirm Tauri mobile CLI/build | Android Studio GUI workflow if CLI diagnostics are insufficient |
| 27 | Derive from selected product/deployment scorecard | audit/license/release tools only when their evidence boundary is specified |

## Recheck protocol

At project start, append an environment delta to `EVIDENCE.md`:

1. Required tool/target/package and why the brief needs it.
2. Current primary setup source and date checked.
3. Observed version and exact readiness command.
4. Installation/change performed, with user approval where required.
5. Smallest compile/runtime smoke test that proves readiness.
6. Remaining unverified platform/device/daemon assumptions.

Never convert `Partial` to `Ready` merely because an installer exited successfully.
The project's target-specific smoke test is the proof.

## Primary setup references

- [Tauri v2 prerequisites](https://v2.tauri.app/start/prerequisites/)
- [Leptos CSR getting started](https://book.leptos.dev/getting_started/index.html)
- [Bevy setup](https://bevy.org/learn/quick-start/getting-started/setup/)
- [Embedded Rust target verification](https://docs.rust-embedded.org/discovery/microbit/03-setup/verify.html)
- [Node.js release status](https://nodejs.org/en/about/previous-releases)

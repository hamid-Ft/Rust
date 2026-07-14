# Dependency and Toolchain Policy

## Goal

Every project should use current, justified crates while remaining reproducible after
the side chat ends. A passing build today is not enough if its dependency choices are
accidental, oversized, unreviewed, or impossible to recreate.

## Before adding a dependency

1. Confirm the standard library does not already teach or provide the concept. Do not
   replace a language-learning exercise with a crate that hides it.
2. Read the current official crate documentation and the relevant feature list. Check
   platform support, MSRV/toolchain requirements, maintenance status, source repository,
   license, and any native build/runtime prerequisites relevant to this project.
3. State the exact responsibility the dependency owns and the boundary our code keeps.
4. Prefer a registry release. Use a Git dependency only for a documented necessity;
   pin it to an immutable revision and record the exit plan.
5. Ask before any networked install/download that requires permission. Never work
   around a failed download with an unreviewed vendored binary or random mirror.

## Adding and configuring crates

- Use `cargo add` so Cargo writes valid manifest syntax and reports selected features.
  Do not copy an old tutorial's version blindly. If compatibility requires an older
  version, record the API/toolchain reason.
- Enable only features used by the artifact. Decide explicitly whether dependency
  default features are appropriate; do not disable them reflexively or accept them
  without inspection.
- Use `cargo tree -e features` when feature provenance is unclear and `cargo tree -d`
  when duplicate versions materially affect build time, size, or behavior.
- Keep development/test-only crates under `[dev-dependencies]` and platform-only crates
  under target-specific dependency tables.
- Avoid exposing third-party types in a reusable public API unless that coupling is a
  deliberate design decision.
- Do not add a crate merely to avoid writing a small, clear standard-library function.
  Conversely, do not reimplement cryptography, protocols, parsers, or security-sensitive
  primitives that the project brief assigns to a reviewed ecosystem crate.

## Toolchain policy

- Learning projects use the recorded current stable toolchain by default. Record
  `rustc --version`, `cargo --version`, and active toolchain in project evidence.
- Add `rust-toolchain.toml` only when a target/component, platform build, reproducible
  release, or known compatibility constraint justifies it; document why and how it is
  updated.
- Set `package.rust-version` only when it expresses a real support policy that is
  actually tested. It is not a substitute for a toolchain pin and must not claim an
  unverified MSRV.
- Nightly requires a project-specific reason, the smallest necessary unstable feature,
  and an explicit removal/migration note. Stable remains the default.

## Lockfile and update policy

- Commit `Cargo.lock` for every numbered learning artifact, including library-focused
  exercises, so the exact reviewed environment can be reproduced during learning.
- Never edit `Cargo.lock` manually. Cargo owns it.
- Use ordinary unlocked Cargo commands while intentionally adding/updating dependencies;
  review manifest and lockfile changes, then return to `--locked` verification.
- Run `cargo update <package>` for a deliberate focused update when possible. A full
  `cargo update` is a separate maintenance action, not a casual fix for compilation.
- `--locked` proves the lockfile did not need resolution changes. `--offline`/`--frozen`
  additionally require a populated local cache; do not confuse cache availability with
  reproducibility.

## Feature and target verification

The default quality gate checks all targets and all features because most roadmap
projects have additive features. If a project has mutually exclusive features or a
cross-target dependency that makes `--all-features` invalid, replace it with a named
feature/target matrix in that project's brief. Never silently remove coverage merely
to obtain a green command.

For a crate with meaningful optional behavior, verify at least:

```sh
cargo test --all-targets --locked
cargo test --all-targets --all-features --locked
cargo clippy --all-targets --all-features --locked -- -D warnings
cargo tree -e features --locked
```

Add `--no-default-features`, platform targets, WASM/mobile/embedded checks, or package
selection when those configurations are part of the promised artifact. Only claim a
target that was built or exercised with evidence appropriate to that target.

## Security, provenance, and licenses

- Treat dependency names, install scripts, build scripts, proc macros, native libraries,
  downloaded models/assets, and generated bindings as executable or supply-chain input.
- For ecosystem surveys and the capstone, record direct dependency purpose, resolved
  version, enabled features, license, source, and relevant advisories/limitations.
- Use an advisory/license tool when the project gate calls for it, but first record its
  version and installation method. Tool absence is not evidence that no issue exists.
- Checksums and provenance are required for committed binary/model/data artifacts.
- Never claim “secure” or “safe” solely because an audit command returned no findings.

## Evidence recorded at completion

Each project reflection should include:

- Rust/Cargo version and any toolchain override;
- every direct crate and why it is present;
- important enabled/disabled features and target-specific dependencies;
- whether `Cargo.lock` changed intentionally;
- exact locked verification commands;
- known platform, license, native-build, advisory, or upgrade constraints.

## Primary references

- [`cargo add`](https://doc.rust-lang.org/cargo/commands/cargo-add.html)
- [Cargo features](https://doc.rust-lang.org/cargo/reference/features.html)
- [`Cargo.toml` versus `Cargo.lock`](https://doc.rust-lang.org/cargo/guide/cargo-toml-vs-cargo-lock.html)
- [`cargo tree`](https://doc.rust-lang.org/cargo/commands/cargo-tree.html)
- [Cargo `rust-version`](https://doc.rust-lang.org/cargo/reference/rust-version.html)

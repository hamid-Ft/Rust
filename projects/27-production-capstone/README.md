# Mini-Project 27 — Production Capstone

## Unlock condition

Complete Projects 01–26 with evidence and reflections. Select the capstone only after
passing [C5 — Breadth/capstone readiness](../../roadmap/MASTERY_CHECKPOINTS.md#c5--breadth-checkpoint-after-project-26-before-project-27);
preference without evidence is not enough.

## Outcome

Design, build, test, profile, package, release, and operate one coherent Rust product
that deepens one primary specialization and integrates at least two supporting skills
from earlier projects. This proves independent engineering judgment rather than the
ability to follow another tutorial.

## Scope-selection gate

Before implementation, complete the [capstone scorecard](../../roadmap/CAPSTONE_SCORECARD.md)
and choose:

- one primary user/problem statement and measurable success criterion;
- one anchor specialization from Projects 14–19;
- at least two supporting competencies from Projects 08–26;
- explicit non-goals that keep a first release achievable;
- target platform, deployment/package form, and operating assumptions;
- risks requiring prototypes before architecture is committed.

Candidate directions—not mandatory choices—include:

- local data workbench: Tauri + Polars + CLI/import plugins;
- embedded telemetry lab: `no_std` simulator + TCP/Axum + Polars reports;
- game operations dashboard: Bevy client + Axum service + tracing/data analysis;
- offline developer monitor: async/network checks + Tauri + local analytics;
- accessible issue product: Axum + Leptos WASM + desktop packaging.

The breadth goal was satisfied by surveys; the capstone should not combine every
framework. Depth, cohesion, reliability, and finish matter more than feature count.

## Required engineering artifacts

- `README.md`: problem, screenshots/examples, quick start, configuration, limitations.
- `docs/architecture.md`: boundaries, ownership/data flow, deployment view.
- `docs/adr/`: dated decisions and rejected alternatives for consequential choices.
- `docs/threat-model.md`: assets, trust boundaries, abuse/failure cases, mitigations.
- `docs/runbook.md`: startup, health, backup/restore, troubleshooting, shutdown/recovery.
- `CHANGELOG.md`, license decision, pinned toolchain policy, and committed lockfile.
- repeatable local quality command and CI workflow using the same underlying checks.
- release/package instructions and at least one reproducible release artifact.
- benchmark/profile report for one measured risk, including rejected optimizations.
- test strategy mapping requirements/risks to unit, integration, contract, end-to-end,
  property, compile, or platform tests as appropriate.

## Architecture and implementation gates

1. Write user journeys, acceptance criteria, non-goals, and risk register.
2. Prototype the highest technical risk with throwaway or isolated code.
3. Choose workspace/crate boundaries and record why each exists.
4. Build one end-to-end vertical slice before expanding feature breadth.
5. Add observability and failure handling while features are introduced.
6. Automate migrations/assets/configuration and fresh-environment setup.
7. Measure the stated performance/resource goal in a release profile.
8. Complete accessibility, security, data-integrity, and platform checks relevant to
   the chosen product rather than copying irrelevant gates mechanically.
9. Package, install/deploy, upgrade, back up, restore, and remove/recover in a clean
   environment according to the documented lifecycle.

## Required verification

The baseline quality verification is:

```sh
cargo fmt --all -- --check
cargo test --workspace --all-targets --all-features --locked
cargo clippy --workspace --all-targets --all-features --locked -- -D warnings
cargo doc --workspace --no-deps --locked
cargo build --workspace --release --locked
```

Add target-specific frontend, WASM, migration, package, benchmark, security, embedded,
desktop, browser, or socket checks dictated by the selected architecture. CI must run
on a clean checkout and must not depend on developer-machine state or public services
that are outside the test's control.

## Transfer challenge

The capstone transfer challenge is a production-style failure exercise.

Run a planned failure drill against a release-like environment: choose a credible
failure such as corrupt input, unavailable database/service, interrupted write,
expired credential, slow client, disk exhaustion simulation, or failed upgrade.
Observe detection, user impact, safe degradation, recovery, and data integrity. Write
a concise postmortem with timeline, evidence, contributing conditions, and one tested
improvement; do not invent certainty beyond what the drill demonstrates.

## Completion checklist

- [ ] Scorecard proves a coherent, bounded problem and selected architecture.
- [ ] Acceptance criteria map to passing authoritative evidence.
- [ ] Fresh setup, quality checks, and CI pass from documented commands.
- [ ] Security/accessibility/data/platform gates match actual product risks.
- [ ] Release artifact installs/deploys and core workflow succeeds cleanly.
- [ ] Backup/restore or equivalent state-recovery path is demonstrated where relevant.
- [ ] Release benchmark/profile supports the stated performance claim.
- [ ] Failure drill and tested remediation are documented.
- [ ] Independent retrospective explains trade-offs and remaining limitations.

## Primary references

- [Cargo workspaces](https://doc.rust-lang.org/cargo/reference/workspaces.html)
- [Cargo profiles](https://doc.rust-lang.org/cargo/reference/profiles.html)
- [`cargo package`](https://doc.rust-lang.org/cargo/commands/cargo-package.html)

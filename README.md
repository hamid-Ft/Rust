# Rust Learning Lab

This workspace is a project-first path from Rust fundamentals to production-oriented
Rust. The learning strategy is simple: build one focused mini-project at a time,
prove mastery with a small challenge, and only then move forward.

## Start here

1. Open the [master roadmap](roadmap/README.md).
2. Check the [learning-criteria coverage map](roadmap/COVERAGE.md).
3. Read the [project workflow](roadmap/WORKFLOW.md).
4. Use the learner-first [side-chat teaching contract](roadmap/TEACHING_CONTRACT.md).
5. Check the dated [environment readiness matrix](roadmap/ENVIRONMENT.md).
6. Follow the shared [dependency and toolchain policy](roadmap/DEPENDENCIES.md).
7. Review the [mastery checkpoints](roadmap/MASTERY_CHECKPOINTS.md).
8. Use the [just-in-time study map](roadmap/STUDY_MAP.md) for the current project only.
9. Start [Mini-Project 01](projects/01-toolchain-health-check/README.md) in a side chat.
10. Record authoritative results with the [evidence template](roadmap/EVIDENCE_TEMPLATE.md).
11. Record completed gates in [progress tracking](roadmap/PROGRESS.md).

Run `./roadmap/validate.sh` after any roadmap or progress change.

Run `./roadmap/next.sh` to validate the roadmap and print the canonical prompt for the
single current side chat. Use `./roadmap/next.sh --prompt-only` for copy-ready output.
Ripgrep is optional: roadmap scripts use it when available and otherwise fall back to
standard `grep`. Set `ROADMAP_SEARCH_BACKEND=grep` only when diagnosing that fallback.

Run `./roadmap/audit.sh` for the live master-goal evidence summary. The stricter
`./roadmap/audit.sh --require-complete` fails until all 27 projects and six checkpoints
are genuinely proven.

The existing `rustlings/` checkout is used for targeted drills. The existing
`my_project/` directory is preserved as an earlier sandbox and is not part of the
numbered project sequence.

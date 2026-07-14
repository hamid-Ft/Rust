# Capstone Selection and Completion Scorecard

Complete this document during Project 27. Replace prompts with evidence; do not award
points for planned work.

## Selection

- User and painful problem:
- Primary user journey:
- Measurable success criterion:
- Anchor specialization and evidence from its survey:
- Supporting competency 1 and why it is necessary:
- Supporting competency 2 and why it is necessary:
- Target platform and release form:
- Explicit non-goals:
- Highest-risk assumption and prototype needed:

## Candidate comparison

Score each candidate 0–3 and explain every non-zero score.

| Criterion | Weight | Candidate A | Candidate B | Candidate C |
|---|---:|---:|---:|---:|
| Real user value | 3 |  |  |  |
| Deepens chosen Rust path | 3 |  |  |  |
| Integrates prior skills coherently | 2 |  |  |  |
| Testable without uncontrolled services | 2 |  |  |  |
| Releaseable on available hardware/platform | 2 |  |  |  |
| Achievable first-release scope | 3 |  |  |  |
| Teaches a new, relevant risk | 1 |  |  |  |

Weighted total is a decision aid, not an automatic decision. Record the selected
candidate, rejected alternatives, and qualitative reason in an ADR.

## Requirement-to-evidence matrix

Every acceptance criterion needs authoritative evidence. Add rows as scope evolves.

| Requirement or invariant | Evidence artifact/command | Current result | Gap/action |
|---|---|---|---|
| Core user journey | End-to-end test + clean release smoke run | Missing | Define journey |
| Data integrity | Property/integration tests + recovery drill | Missing | Define state model |
| Error behavior | Failure-path tests + runbook | Missing | Enumerate failures |
| Performance goal | Release benchmark/profile report | Missing | Set measurable target |
| Security boundary | Threat model + targeted tests | Missing | Identify assets/trust |
| Accessibility (if UI) | Automated + keyboard/screen-reader evidence | N/A or missing | Decide applicability |
| Packaging/deployment | Clean-environment install/deploy evidence | Missing | Choose target |
| Operations/recovery | Health/backup/restore/failure-drill evidence | Missing | Define lifecycle |

## Release readiness

- [ ] Scope and non-goals are unchanged or deliberately re-approved in an ADR.
- [ ] No acceptance criterion lacks direct evidence.
- [ ] CI and documented local checks agree.
- [ ] Dependency/toolchain/license decisions are recorded.
- [ ] Logs/errors contain useful context without secrets or sensitive payloads.
- [ ] Configuration and state locations are explicit and portable where required.
- [ ] Upgrade/migration and rollback/recovery behavior are tested where applicable.
- [ ] Known limitations are visible to users.
- [ ] Release artifact and checksum/version are recorded.

## Final retrospective

- Strongest Rust concept demonstrated:
- Most valuable compiler/test failure:
- Ownership/concurrency design that changed during implementation:
- Rejected abstraction or optimization and its evidence:
- Failure drill result and remediation:
- What is genuinely production-ready:
- What remains experimental or incomplete:
- Which Rust specialization to deepen next:

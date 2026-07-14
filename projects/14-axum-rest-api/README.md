# Mini-Project 14 — Axum Issue-Tracker REST API

## Unlock condition

Complete the common foundation through Project 13 and its reflection, then pass
[C2 — Practical and concurrency](../../roadmap/MASTERY_CHECKPOINTS.md#c2--practical-and-concurrency-checkpoint-after-project-13-before-project-14).

## Outcome

Build a production-shaped JSON API with Axum, Tower middleware, Tokio, SQLx, SQLite,
Serde, tracing, validation, migrations, authentication, and graceful shutdown.

## Non-goals

No microservices, GraphQL, third-party OAuth, cloud deployment, or claim of
production-ready security. The project teaches defensible structure and boundaries.

## Artifact and behavior

- Users can register, sign in/out, and inspect their session.
- Auth uses Argon2id with reviewed current parameters and random opaque sessions; raw session
  tokens are never stored in the database or logs.
- Projects contain issues with title, description, status, assignee, and version.
- CRUD endpoints use consistent JSON, status codes, validation errors, and pagination.
- Mutations require authentication and enforce resource ownership/authorization.
- SQLx migrations build a fresh database; constraints reinforce domain invariants.
- Optimistic version checks prevent silently overwriting concurrent issue edits.
- `/health/live` and `/health/ready` have distinct meanings.
- Request IDs, structured tracing, body limits, timeouts, and narrowly scoped CORS are
  applied through Tower/Tower HTTP with documented ordering.

Use layered modules for domain types, application services, repository/database,
HTTP transport, authentication, configuration, and startup. HTTP concepts must not
infect domain rules, and SQL rows are not automatically the public response model.

## Security and error criteria

- Password hashing runs off the async executor when CPU-bound.
- Authentication cookies/tokens use explicit expiry and revocation behavior.
- Browser sessions use `HttpOnly`, `Secure` (outside explicit local development), and
  explicit `SameSite` cookie attributes. State-changing requests use a real CSRF
  defense such as a session-bound token/custom header plus origin validation; the
  project does not rely on `SameSite` alone.
- Secrets and credentials never appear in `Debug`, tracing fields, or error responses.
- Database/internal errors become stable public error codes, not raw implementation
  details; full context remains in server-side traces.
- SQL is parameterized; authorization is checked for the target resource, not merely
  inferred from a valid login.

## Build stages

1. Specify resources, invariants, endpoint contract, and threat assumptions.
2. Create migrations, SQLx pool setup, repositories, and transaction boundaries.
3. Implement domain/application services with repository integration tests.
4. Add Axum extractors, handlers, response errors, and router state.
5. Add registration/session authentication and authorization checks.
6. Compose Tower middleware and verify ordering with tests/traces.
7. Add graceful startup/shutdown and readiness behavior.
8. Run the complete API suite against a fresh temporary database.

## Required verification

Run default quality commands plus migration checks and HTTP integration tests through
the actual router/service. Cover successful CRUD, every validation class, uniqueness
and foreign-key constraints, unauthorized versus forbidden access, expired/revoked
sessions, pagination boundaries, concurrent-version conflict, body/timeout limits,
request IDs, and shutdown. Tests never share mutable database state.

## Transfer challenge

Add append-only issue comments with author attribution and deletion tombstones. A
comment may be edited only by its author for a limited window; inject a clock so tests
are deterministic. Extend migrations, authorization, pagination, API contract, and
integration tests without weakening existing session or ownership rules.

## Completion checklist

- [ ] Fresh migrations create a working, constrained schema.
- [ ] Domain, application, database, and HTTP responsibilities are separated.
- [ ] Authentication and resource authorization are tested independently.
- [ ] Middleware order and error conversion are understood.
- [ ] No secret or raw internal error crosses the public/logging boundary.
- [ ] Default quality, migration, and HTTP integration tests pass.
- [ ] Transfer challenge and reflection are complete.

## Primary references

- [Axum router documentation](https://docs.rs/axum/latest/axum/struct.Router.html)
- [Axum middleware documentation](https://docs.rs/axum/latest/axum/middleware/)
- [SQLx documentation](https://docs.rs/sqlx/latest/sqlx/)
- [OWASP password storage guidance](https://cheatsheetseries.owasp.org/cheatsheets/Password_Storage_Cheat_Sheet.html)
- [OWASP session management guidance](https://cheatsheetseries.owasp.org/cheatsheets/Session_Management_Cheat_Sheet.html)
- [OWASP CSRF prevention guidance](https://cheatsheetseries.owasp.org/cheatsheets/Cross-Site_Request_Forgery_Prevention_Cheat_Sheet.html)

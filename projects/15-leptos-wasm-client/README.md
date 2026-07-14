# Mini-Project 15 — Leptos WASM Issue-Tracker Client

## Unlock condition

Complete Project 14 with its API contract and integration suite. The client consumes
that API rather than replacing it with a second backend.

## Outcome

Build a client-side-rendered Rust application compiled to WebAssembly with Leptos and
Trunk. Learn reactive components, signals/resources/actions, browser routing, forms,
typed HTTP boundaries, asynchronous UI state, accessibility, and release builds.

## Non-goals

No SSR/hydration, offline-first cache, component framework wrapper, or pixel-perfect
design system. CSR is chosen deliberately to focus on browser-side Rust and an
existing REST API; document its initial-load and SEO trade-offs.

## Artifact and behavior

- Sign in/out and restore the server-managed `HttpOnly` session without exposing its
  credential to JS or browser web storage.
- List projects/issues with pagination and stable URL query state.
- View, create, edit, transition, assign, and delete authorized issues.
- Handle loading, empty, success, validation, authorization, conflict, network, and
  retry states explicitly; stale requests must not overwrite newer navigation state.
- Share API DTOs only where coupling is beneficial; keep UI state separate.
- Use same-origin development proxying or a narrowly configured API CORS policy.
- Produce a static release bundle with `trunk build --release`.

## Accessibility acceptance criteria

- Semantic landmarks, logical headings, native buttons/links, and labeled controls.
- Every function works with keyboard alone and has a visible focus indicator.
- Validation errors are associated with fields and summarized without relying on color.
- Route changes and async success/error updates have appropriate focus/live-region
  behavior without noisy repeated announcements.
- Touch targets are at least 44×44 CSS pixels; text works at 200% zoom.
- Normal text contrast is at least 4.5:1 and reduced-motion preferences are respected.
- Automated checks are supplemented by keyboard and screen-reader smoke testing.

## Concept checklist

- [ ] Reactive dependencies and ownership of captured values are understood.
- [ ] Server state, local form state, and derived display state remain distinct.
- [ ] Fallible async work has cancellation/staleness behavior.
- [ ] Browser-facing errors are useful without leaking secrets.
- [ ] Native semantics are preferred over unnecessary ARIA.
- [ ] The WASM boundary and generated loader are understood at a high level.

## Build stages

1. Establish CSR/Trunk build and an accessible application shell.
2. Create a typed API client and model transport/API errors.
3. Add session bootstrap and authenticated routing.
4. Implement issue list/detail with loading, empty, and error states.
5. Add validated create/edit forms and conflict recovery.
6. Add route/query synchronization and stale-request protection.
7. Run accessibility, browser, and release-bundle verification.

## Required verification

Run Rust formatting, tests, Clippy, and docs for host-compatible code; compile the
WASM target and run `trunk build --release`. Browser tests use a controlled API or
stub and cover routing, session loss, loading/empty/error states, validation,
conflict recovery, and stale responses. Manually test keyboard-only navigation,
visible focus, 200% zoom, reduced motion, and one available screen reader. Automated
accessibility scans must have no critical or serious findings.

## Transfer challenge

Add an accessible issue-status board with drag-and-drop as an enhancement, not the
only interaction. Provide keyboard controls that expose the same moves, announce
successful changes, preserve focus, handle API conflicts, and work with reduced
motion. Test the underlying move operation independently of pointer events.

## Completion checklist

- [ ] The client consumes the Project 14 contract with typed error handling.
- [ ] Reactive state and stale async completion behavior are explainable.
- [ ] All essential workflows are keyboard and screen-reader operable.
- [ ] No auth secret is persisted in browser-readable storage.
- [ ] Host checks, WASM compilation, browser tests, and release build pass.
- [ ] Transfer challenge and reflection are complete.

## Primary references

- [Leptos Book: CSR with Trunk](https://book.leptos.dev/getting_started/index.html)
- [Leptos CSR deployment](https://book.leptos.dev/deployment/csr.html)

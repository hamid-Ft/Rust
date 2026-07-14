# Mini-Project 07 — Borrowed Search Index

## Unlock condition

Complete Mini-Project 06 and explain static dispatch, monomorphization, associated
types, and why each bound on the generic store exists.

## Outcome

Build a zero-copy search index whose results borrow from source documents. Learn
lifetime elision, explicit lifetime relationships, structs containing references,
and when returning owned data is the better design.

## Non-goals

No full-text ranking library, persistence, concurrency, or self-referential structs.
The project is about expressing valid borrowing relationships clearly.

## Artifact and behavior

- Accept a borrowed slice of document records that own titles and bodies.
- Build an index view borrowing those documents without cloning their text.
- Search by a borrowed query and return matching borrowed document references.
- Return borrowed snippets aligned to valid UTF-8 boundaries.
- Support title-only, body-only, and all-field search modes.
- Make it impossible for index results to outlive their source documents.

Do not add lifetime annotations where elision already expresses the relationship.
Add explicit lifetimes only when the compiler needs help or documentation benefits.

## Concept checklist

- [ ] Lifetimes describe relationships; they do not extend runtime lifetime.
- [ ] Input/output lifetime elision rules can be explained.
- [ ] A struct borrowing data declares the necessary lifetime parameter.
- [ ] Multiple input references may require an explicit output relationship.
- [ ] `'static` is not used as a shortcut for borrow-checker errors.
- [ ] Owned output is selected when borrowing would make the API brittle.

## Build stages

1. Implement a search function whose elided output borrows one input.
2. Store document references in an `Index<'docs>` view.
3. Return borrowed hits and explain why they cannot escape the document scope.
4. Add snippets while preserving UTF-8 boundaries.
5. Compare a borrowed-results API with an owned-results alternative.
6. Trigger a dangling-reference compiler error and explain it before redesigning.

## Required verification

Run the default quality commands. Tests must cover empty queries, multiple documents,
search modes, Unicode snippets, and source reuse after searching. Include at least
one `compile_fail` doc test showing that a result cannot outlive its source.

## Transfer challenge

Add a `SearchSession<'index, 'query>` that retains a borrowed index and query while
allowing multiple search modes without reallocating normalized query data. Decide
which data should remain borrowed and which should be owned, justify the design, and
test repeated searches.

## Completion checklist

- [ ] Every explicit lifetime has an explained relationship.
- [ ] No clone, leak, or `'static` workaround hides a design problem.
- [ ] Unicode snippet boundaries are safe.
- [ ] The compile-fail example proves the key lifetime invariant.
- [ ] Default quality commands pass.
- [ ] The transfer challenge and phase reflection are complete.

## Related Rustlings drills

- `06_move_semantics`
- `09_strings`
- `16_lifetimes`
- `18_iterators`
- `19_smart_pointers` (contrast only)


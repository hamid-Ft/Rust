# Mini-Project 09 — Tested Expression Evaluator

## Unlock condition

Complete Project 08 and explain how a CLI invocation travels through parsing, domain
logic, storage, rendering, and exit-status handling.

## Outcome

Build an integer arithmetic expression tokenizer, parser, and evaluator designed to
teach test architecture: focused unit tests, public integration tests, doc tests,
compile-fail examples, and property-based testing with shrinking.

## Non-goals

No parser-generator crate, floating-point arithmetic, variables, or optimizer. A
small grammar makes test design—not parsing machinery—the central lesson.

## Artifact and behavior

Support integer literals, whitespace, parentheses, unary minus, and `+ - * /` with
documented precedence and associativity. Return a typed AST and checked evaluation
errors for invalid syntax, division by zero, and integer overflow. Errors include a
byte span into the original expression when applicable.

## Test layers

- Unit tests: tokenizer, precedence parser, and evaluator edge cases.
- Integration tests: public `parse` and `evaluate` workflows.
- Doc tests: representative public API usage and error handling.
- `compile_fail`: one intentional misuse of a typed API, if the design supports it.
- Property tests: algebraic or parser invariants over bounded generated inputs.

Properties must account for overflow and division rules rather than assuming all
mathematical identities hold for finite machine integers.

## Concept checklist

- [ ] Tests have descriptive behavior-oriented names.
- [ ] Each test targets one behavior whenever practical.
- [ ] Fixtures and helpers do not hide the behavior under test.
- [ ] Strategies generate valid, bounded cases with useful shrinking.
- [ ] Example-based tests cover precise regressions; properties cover invariants.
- [ ] Failed property cases are persisted/reproducible as supported by the tool.

## Build stages

1. Write the grammar and error taxonomy before implementation.
2. Tokenize with byte spans and focused unit tests.
3. Parse precedence and parentheses into an AST.
4. Evaluate with checked arithmetic and typed errors.
5. Add public integration and doc tests.
6. Add properties such as whitespace invariance and redundant-parentheses equivalence.
7. Seed a bug, observe shrinking find a minimal case, then record the regression test.

## Required verification

Run the default quality commands and the property suite with its normal and an
explicitly increased case count. Demonstrate useful diagnostics for malformed input.
No generated test may use unrestricted recursion or overflow-prone assumptions.

## Transfer challenge

Add exponentiation with clearly documented precedence, right associativity, and
checked evaluation. Before implementation, write examples and at least one property
that distinguish right from left associativity. Preserve old regression cases.

## Completion checklist

- [ ] Grammar, AST, and errors are documented.
- [ ] Unit, integration, doc, and property tests serve distinct purposes.
- [ ] A shrunk failure became a deterministic regression test.
- [ ] Overflow and division errors never panic in production code.
- [ ] Default quality commands and property suite pass.
- [ ] Transfer challenge and reflection are complete.

## Primary reference

- [Proptest book](https://proptest-rs.github.io/proptest/proptest/index.html)

## Related Rustlings drills

- `08_enums`
- `13_error_handling`
- `17_tests`
- `18_iterators`
- `21_macros` (test macro observation only)


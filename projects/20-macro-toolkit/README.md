# Mini-Project 20 — Declarative Enum Toolkit

## Unlock condition

Complete the specialization survey through Project 19 and record which one or two
paths deserve deeper capstone work. Then pass
[C3 — Specialization](../../roadmap/MASTERY_CHECKPOINTS.md#c3--specialization-checkpoint-after-project-19-before-project-20).

## Outcome

Build a small library macro that defines string-backed enums and generates repetitive
implementations. Learn `macro_rules!` matching/transcription, fragment specifiers,
repetition, optional syntax, hygiene, `$crate`, expansion, diagnostics, compile-pass
and compile-fail testing, and when a macro is the wrong abstraction.

## Non-goals

No procedural macro, token-stream parser, attribute derive, or general-purpose DSL.
Declarative macros are mastered before a later optional procedural-macro extension.

## Artifact and behavior

First hand-write two enums that need the same boilerplate. Then replace only the
proven duplication with `string_enum!`, which accepts visibility, attributes/docs,
an enum name, variants, canonical string values, and optional aliases. It generates:

- the enum with requested attributes and derives;
- `Display` and a typed `FromStr` error;
- a canonical `as_str` method;
- a static slice of all variants;
- case-sensitive canonical parsing plus explicitly declared aliases;
- useful documentation and errors for valid invocations.

The invocation should allow a trailing comma and work correctly from another crate.
Generated code must refer to the defining crate through `$crate` where appropriate
and avoid capturing or colliding with caller identifiers.

## Concept checklist

- [ ] Macro input is token trees, not strings or a full Rust AST.
- [ ] `ident`, `expr`, `literal`, `meta`, `path`, `ty`, and `vis` roles are understood.
- [ ] `*`, `+`, and `?` repetition are used only where grammar requires them.
- [ ] Multiple arms have intentional ordering and unambiguous syntax.
- [ ] Hygiene and `$crate` behavior are demonstrated across a crate boundary.
- [ ] Runtime validation is not used where macro syntax can reject input at compile time.
- [ ] A normal function/generic is preferred for behavior not requiring code generation.

## Build stages

1. Implement two concrete enums and identify exact repeated tokens/behavior.
2. Write the smallest macro arm generating one enum and `as_str`.
3. Add repetition, attributes/docs, visibility, and trailing-comma support.
4. Generate `Display`, `FromStr`, variants, aliases, and a typed parse error.
5. Exercise hygiene from an integration-test crate/module.
6. Add compile-pass, compile-fail, doc, and runtime behavior tests.
7. Inspect expansion with a current expansion tool when available and simplify output.

## Required verification

Run default quality commands plus compile tests covering minimal/full invocation,
external-module use, attributes/docs, visibility, aliases, trailing comma, unknown
input, duplicate/invalid syntax chosen by the grammar, and hygiene against shadowed
names. Public generated APIs must appear correctly in rustdoc. If `cargo expand` is
installed, save one reviewed expansion excerpt; it is diagnostic evidence, not a
required dependency of library users.

## Transfer challenge

Add optional per-variant numeric codes and generate checked two-way conversions
without changing invocations that omit codes. Reject malformed code syntax at compile
time and duplicate codes either at compile time or through a clearly documented
const/runtime boundary. Add compatibility and diagnostic tests before implementation.

## Completion checklist

- [ ] The macro replaces demonstrated repetition rather than hypothetical boilerplate.
- [ ] Fragment/repetition choices and hygiene behavior can be explained.
- [ ] Generated public APIs, errors, and docs are stable and tested externally.
- [ ] Invalid invocations fail with reviewed diagnostics.
- [ ] Default quality and compile-test suites pass.
- [ ] Transfer challenge and reflection are complete.

## Primary references

- [Rust Reference: macros by example](https://doc.rust-lang.org/reference/macros-by-example.html)
- [Rust By Example: `macro_rules!`](https://doc.rust-lang.org/rust-by-example/macros.html)

## Related Rustlings drills

- `21_macros`
- `23_conversions`

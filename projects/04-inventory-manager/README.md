# Mini-Project 04 — Inventory Manager

## Unlock condition

Complete Mini-Project 03 and explain when an API should accept `&str`, `String`,
`&[T]`, and `Vec<T>`.

## Outcome

Build an in-memory inventory domain model using structs, enums, methods, pattern
matching, newtypes, and collections. Encode business rules in types and methods
rather than distributing them through terminal code.

## Non-goals

No database, serialization, networking, or async work. Persistence arrives in later
projects; this one focuses on expressive domain modeling.

## Artifact and behavior

- Products have a validated SKU, name, category, unit price, and stock quantity.
- Operations include adding a product, receiving stock, selling stock, and querying.
- Duplicate SKUs, zero quantities, invalid prices, and insufficient stock are errors.
- An inventory event enum records successful stock changes.
- Reports group products by category and identify low-stock items.

Use a newtype for SKU so arbitrary strings cannot masquerade as validated IDs. Use
small `Copy` value types only when their semantics and size justify it.

## Concept checklist

- [ ] Named structs, tuple structs/newtypes, and enums serve distinct purposes.
- [ ] Constructors protect invariants.
- [ ] Methods choose `self`, `&self`, or `&mut self` deliberately.
- [ ] Pattern matching destructures useful data exhaustively.
- [ ] `HashMap` entry and lookup APIs are used without redundant cloning.
- [ ] Invalid domain states are rejected at the boundary.

## Build stages

1. Write invariants before defining `Sku`, `Product`, and `Category`.
2. Construct and query products without mutation.
3. Add inventory mutation methods returning typed outcomes.
4. Record successful events and keep failed operations atomic.
5. Add category and low-stock reports.
6. Refactor one stringly typed state into an enum or newtype.

## Required verification

Run the default quality commands. Tests must prove every constructor invariant,
duplicate detection, stock arithmetic boundaries, atomic failure, event creation,
and report ordering. Arithmetic must not silently overflow or underflow.

## Transfer challenge

Add reservations: stock can be reserved, released, or converted into a completed
sale. Model reservation state explicitly and ensure available stock never exceeds
physical stock or becomes negative. Test invalid state transitions.

## Completion checklist

- [ ] Types and constructors protect the documented invariants.
- [ ] Mutation requires `&mut self`; read operations borrow immutably.
- [ ] Failed operations leave inventory unchanged.
- [ ] Tests cover enum variants and numeric boundaries.
- [ ] Default quality commands pass.
- [ ] The transfer challenge and reflection are complete.

## Related Rustlings drills

- `07_structs`
- `08_enums`
- `10_modules`
- `11_hashmaps`
- `23_conversions`


# Mini-Project 06 — Generic Data Store

## Unlock condition

Complete Mini-Project 05 and explain the error path from a malformed source line to
the binary's user-facing message.

## Outcome

Build a reusable in-memory repository using generics, traits, associated types,
trait bounds, iterators, and static dispatch.

## Non-goals

No database and no `dyn Trait` plugin system. Dynamic dispatch is reserved for
Project 22, after static dispatch and its trade-offs are understood.

## Artifact and behavior

- Define an `Entity` trait with an associated identifier type.
- Implement distinct entities such as notes and contacts.
- Store, retrieve, update, remove, and iterate entities generically.
- Reject duplicate IDs and report missing IDs with concrete errors.
- Support generic filtering without allocating intermediate collections.
- Provide a generic summary function constrained by a separate display trait.

The store owns entities. Lookups and iteration should borrow them. Identifier bounds
must be the minimum required by the selected collection and API.

## Concept checklist

- [ ] Generic structs, functions, and `impl` blocks are understood.
- [ ] Trait bounds express capabilities rather than concrete types.
- [ ] Associated types are chosen over unnecessary extra type parameters.
- [ ] `impl Trait` and named generic parameters are selected deliberately.
- [ ] Static dispatch and monomorphization can be explained.
- [ ] Iterator-returning APIs avoid premature `collect`.

## Build stages

1. Implement the same tiny operation for two concrete entity types.
2. Extract shared behavior into `Entity` and a generic store.
3. Add mutation and typed duplicate/missing errors.
4. Expose borrowed lookup and iterator APIs.
5. Add generic filtering and summarization traits.
6. Inspect a compiler error caused by a missing trait bound, then add only that bound.

## Required verification

Run the default quality commands. Exercise the complete API with at least two entity
types. Tests must verify ownership after insertion, borrowed lookup, update/remove
errors, iterator behavior, and filtering without depending on map iteration order.

## Transfer challenge

Add a generic secondary index that extracts a borrowed key from each entity and can
return all matching entities. The design must prevent the index from containing
references that outlive the store or becoming stale after mutation; document the
chosen trade-off and test it with both entity types.

## Completion checklist

- [ ] Store logic is genuinely reused across two entity types.
- [ ] Trait bounds are justified and not broader than necessary.
- [ ] Read APIs borrow; ownership transfer happens at explicit boundaries.
- [ ] Filtering does not create needless intermediate collections.
- [ ] Default quality commands pass.
- [ ] The transfer challenge and reflection are complete.

## Related Rustlings drills

- `14_generics`
- `15_traits`
- `18_iterators`
- `23_conversions`


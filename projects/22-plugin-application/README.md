# Mini-Project 22 — Runtime Document Renderer Registry

## Unlock condition

Complete Project 21 and defend every unsafe block using its documented invariants.

## Outcome

Build a document-processing application that uses generics for its stable hot path
and trait objects only at a runtime-selected renderer boundary. Learn static dispatch,
monomorphization, dyn compatibility, fat pointers/vtables, object lifetimes, boxing,
heterogeneous registries, erased errors, and architecture trade-offs.

## Non-goals

No shared-library loading, ABI-stable Rust plugin interface, unsafe code, or remote
plugin execution. “Plugin” means separately implemented components registered into
one compiled application; dynamic libraries are a different advanced project.

## Artifact and behavior

- Parse and validate a typed intermediate document using generic/static components.
- Register Markdown, JSON, plain-text, and one custom renderer at runtime.
- Select a renderer by stable name/configuration without matching on concrete types.
- Store heterogeneous owned implementations behind `Box<dyn Renderer + Send + Sync>`
  only where ownership and cross-thread use require those bounds.
- Borrow as `&dyn Renderer` for calls that do not transfer ownership.
- Return typed boundary errors retaining renderer name and source where possible.
- Reject duplicate names and unknown renderers deterministically.
- Allow registry listing/help without downcasting to concrete implementations.

Design `Renderer` to be dyn-compatible deliberately. Generic helper methods that do
not belong in the vtable should use `where Self: Sized`, extension traits, or free
functions. Do not contort the entire core around object safety.

## Concept checklist

- [ ] Generic/static and `dyn`/dynamic dispatch can be traced at a call site.
- [ ] Monomorphization, binary-size trade-offs, fat pointers, and vtable calls are understood.
- [ ] `dyn Trait` is unsized and therefore used behind a pointer/reference.
- [ ] Every `Send`, `Sync`, and `'static` bound comes from an actual storage/task need.
- [ ] Boxing happens at the registry boundary, not throughout internal algorithms.
- [ ] Associated types/generic methods and dyn compatibility trade-offs are explainable.
- [ ] Enum dispatch remains an explicit alternative when the implementation set is closed.

## Build stages

1. Implement one renderer through a generic pipeline and benchmark only if needed.
2. Add a second concrete renderer and identify the runtime-selection requirement.
3. Design a minimal dyn-compatible `Renderer` contract and compile-fail examples.
4. Add the heterogeneous registry, duplicate handling, and borrowed lookup.
5. Add multiple renderers, typed context/errors, and CLI selection.
6. Implement the same closed set with enum dispatch and compare ergonomics/binary design.
7. Document why the final boundary is static, enum, or dynamic at each layer.

## Required verification

Run default quality commands plus tests for each implementation, registry order/name
rules, duplicate/unknown selection, renderer failure context, concurrent calls if
`Send + Sync` is claimed, and compile-fail dyn-incompatible examples. Record release
binary size for generic/enum/dyn experiments if making a size claim; benchmark before
making a speed claim.

## Transfer challenge

Add a runtime-ordered transformation pipeline (`Transform`) before rendering. Multiple
heterogeneous transforms may be chained, configured, and reused concurrently. Keep
the typed document invariant between stages, attach the failing transform's identity
to errors, and justify whether transforms need `dyn`, generics, enums, or a mixture.

## Completion checklist

- [ ] Runtime heterogeneity exists only where required.
- [ ] `Renderer` is intentionally dyn-compatible and externally documented.
- [ ] Pointer/lifetime/auto-trait bounds are justified by actual ownership and use.
- [ ] Static, enum, and dynamic alternatives are compared with honest evidence.
- [ ] Default quality and compile-fail suites pass.
- [ ] Transfer challenge and reflection are complete.

## Primary references

- [Rust Reference: trait objects](https://doc.rust-lang.org/reference/types/trait-object.html)
- [Rust Reference: dyn compatibility](https://doc.rust-lang.org/reference/items/traits.html#dyn-compatibility)


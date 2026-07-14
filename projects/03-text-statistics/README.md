# Mini-Project 03 — Text Statistics Tool

## Unlock condition

Complete Mini-Project 02 and explain why its deterministic logic was kept separate
from terminal I/O and randomness.

## Outcome

Build a Unicode-aware text report that makes ownership, moves, immutable borrowing,
mutable borrowing, slices, and the distinction between `String` and `&str` tangible.

## Non-goals

No regular expressions, parallel processing, or full linguistic tokenization. This
project is about data ownership rather than perfect natural-language analysis.

## Artifact and behavior

Given owned text loaded by the binary, the library reports:

- byte length and Unicode scalar-value (`char`) count;
- non-empty line count and whitespace-delimited word count;
- the longest word as a borrowed `&str` when possible;
- normalized word frequencies in an owned map;
- a preview containing the first configurable number of characters.

Function parameters should borrow (`&str`) unless ownership is genuinely required.
Returning owned and borrowed results must be a conscious API decision.

## Concept checklist

- [ ] Move, copy, immutable borrow, and mutable borrow can be demonstrated.
- [ ] `String`, `&String`, and `&str` are distinguished.
- [ ] String slicing is not performed at arbitrary byte indexes.
- [ ] Collection parameters use slices where appropriate.
- [ ] Cloning is justified rather than used to silence the borrow checker.
- [ ] Iterator chains remain readable and avoid needless intermediate collections.

## Build stages

1. Draw the ownership flow from binary input to borrowed library functions.
2. Implement simple counts without cloning the input.
3. Return the longest borrowed word and explain its lifetime informally.
4. Build the owned frequency map using iterator or loop APIs deliberately.
5. Add Unicode cases that distinguish bytes from characters.
6. Introduce a move/borrow compiler error, predict it, then fix the design.

## Required verification

Run the default quality commands and test empty, ASCII, multi-line, and non-ASCII
input. Inspect the implementation for unjustified `.clone()` calls and unsafe string
indexing. The CLI must accept direct text and a file path, with filesystem errors
handled as `Result`.

## Transfer challenge

Add `top_words(report, limit)` returning borrowed word/count views sorted by count
descending and word ascending for ties. Do not clone the words solely for sorting.
Test zero, smaller-than-map, and larger-than-map limits.

## Completion checklist

- [ ] The ownership diagram matches the implemented APIs.
- [ ] Unicode tests distinguish byte and character counts.
- [ ] Borrowed results never outlive their source.
- [ ] No unjustified clone or production panic shortcut remains.
- [ ] Default quality commands pass.
- [ ] The transfer challenge and reflection are complete.

## Related Rustlings drills

- `05_vecs`
- `06_move_semantics`
- `09_strings`
- `11_hashmaps`
- `18_iterators`


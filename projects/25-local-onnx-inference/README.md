# Mini-Project 25 — Validated Local ONNX Inference

## Unlock condition

Complete Project 24 with evidence and reflection.

## Outcome

Build a deterministic CPU-only CLI that uses `ndarray` for numeric preprocessing and
Tract to load and run a small committed ONNX model. The project teaches tensor shape,
axis, dtype, normalization, model execution, and honest output interpretation—not
model training or claims of real-world intelligence.

Choose a tiny, non-sensitive classifier or regression model with an open license.
Do not use medical, biometric, credit, employment, safety-control, or other high-impact
decisions. Runtime tests must never download a model or dataset.

## Non-goals

- Training, fine-tuning, scraping datasets, GPU acceleration, or distributed serving.
- High-impact decision making or claims about general model accuracy/intelligence.
- Downloading mutable model/data artifacts during builds or tests.
- Optimizing before correctness, provenance, and a release-mode baseline exist.

## Required behavior

- Separate input parsing, feature validation, `ndarray` preprocessing, tensor
  conversion, model loading, execution, and output interpretation.
- Validate feature count, axes, shape, dtype, normalization constants, labels, output
  count, and finite numeric values before indexing or ranking results.
- Load and optimize the model once for a batch/session rather than once per row.
- Return typed errors for corrupt models, unsupported operators, shape/dtype mismatch,
  non-finite data, and invalid labels; do not panic on user-controlled input.
- Commit `MODEL_CARD.md` with origin URL, author/license, checksum, input/output schema,
  preprocessing formula, expected use, limitations, and known validation fixtures.
- Keep golden expected outputs produced by an independent trusted implementation and
  compare floats with documented tolerances rather than exact equality.

## Build stages

1. Select and document a tiny licensed model, checksum, schema, and golden fixtures.
2. Model validated scalar input and implement `ndarray` preprocessing in isolation.
3. Load the ONNX model once and run one known inference end to end.
4. Separate tensor conversion/runtime/output interpretation behind typed boundaries.
5. Add corrupt/shape/dtype/non-finite tests and independently generated golden checks.
6. Record release-mode warm-up and steady-state measurements with limitations.
7. Pass verification before independently adding bounded batch inference.

## Required verification

```sh
cargo fmt --all -- --check
cargo test --all-targets --all-features --locked
cargo clippy --all-targets --all-features --locked -- -D warnings
cargo doc --no-deps --locked
cargo test --release --test inference_golden --locked
```

Test `ndarray` shape/axis transformations independently from Tract. Cover known
predictions, boundary values, NaN/infinity, wrong feature counts, corrupt model bytes,
label mismatch, batch ordering, and deterministic repeated execution. Record model
load/warm-up separately from steady-state inference; benchmark only release builds and
state the machine/configuration without generalizing beyond the evidence.

## Transfer challenge

Add bounded batch inference. Prove that batch results preserve input order and match
single-item inference within the chosen tolerance. Reject a batch before allocation
when its declared size exceeds the limit, and report throughput plus tail latency
without hiding preprocessing time.

## Completion checklist

- [ ] Preprocessing has explicit shapes, axes, dtype, and normalization rules.
- [ ] The ONNX model is local, checksummed, licensed, and documented.
- [ ] Golden fixtures independently validate outputs within justified tolerances.
- [ ] Invalid/non-finite input and incompatible model metadata fail cleanly.
- [ ] Warm-up and steady-state measurements are reported separately.
- [ ] Batches are bounded and equivalent to single-item execution.
- [ ] Reflection distinguishes tensor mechanics, inference, and model quality.

## Primary references

- [`ndarray` crate documentation](https://docs.rs/ndarray/latest/ndarray/)
- [`tract-onnx` crate documentation](https://docs.rs/tract-onnx/latest/tract_onnx/)
- [Tract project](https://github.com/sonos/tract)
- [ONNX specification](https://onnx.ai/onnx/intro/)

# Mini-Project 23 — Offline Bitcoin and PSBT Inspector

## Unlock condition

Complete Projects 01–22 with evidence and reflections, then pass
[C4 — Advanced language](../../roadmap/MASTERY_CHECKPOINTS.md#c4--advanced-language-checkpoint-after-project-22-before-project-23).

## Outcome

Build an offline CLI that accepts bounded raw transaction hex or a PSBT file/base64
string and produces a deterministic structural report using `rust-bitcoin`. Report
transaction identifiers, weight/virtual size, version, lock time, inputs, outputs,
scripts, and available PSBT metadata. Decode an address only when the user supplies
an explicit network; never infer a network from an ambiguous payload.

This is an educational parser, not a wallet or financial tool. It must not generate
or import private keys, sign, combine/finalize for spending, connect to a node, fetch
UTXOs, recommend fees, broadcast, or handle real funds. Parsing a structure does not
prove consensus validity, ownership, spendability, or acceptance by a network.

## Non-goals

- Wallet creation, key custody, signing, PSBT finalization, or broadcasting.
- Live chain data, exchange prices, trading, fee recommendations, or financial advice.
- Reimplementing Bitcoin consensus serialization or cryptography.
- Claiming a parsed transaction is valid, confirmed, owned, or spendable.

## Required behavior

- Provide separate `tx` and `psbt` subcommands with file/stdin input and JSON/text
  output selected through Clap.
- Reject input over a documented byte limit before allocating for full decoding.
- Use domain error types for invalid encoding, invalid consensus data, unsupported
  data, ambiguous network context, and incomplete metadata.
- Display fee only when every required previous-output amount is present; otherwise
  report `unknown` instead of estimating it.
- Redact secret-looking extended-private-key or proprietary values and never log raw
  user payloads. Summarize unknown/proprietary PSBT keys by type and length.
- Keep decoding, validation policy, reporting, and CLI formatting in separate modules.
- Include a short threat model covering malicious sizes, parser failures, terminal
  injection, sensitive metadata, and misleading interpretations.

## Build stages

1. Inspect the BIP/rust-bitcoin types and model bounded input plus report/error types.
2. Implement raw-transaction parsing for one committed public vector.
3. Add PSBT parsing and represent absent metadata explicitly.
4. Separate decoding, read-only policy checks, presentation, and CLI boundaries.
5. Add negative/redaction tests, stable JSON output, docs, and the threat model.
6. Intentionally exercise an ownership/type error and one malicious-input failure.
7. Run all verification before beginning the independent policy-linter transfer.

## Required verification

Use small, committed public test vectors, including BIP 174 examples where suitable;
tests must remain offline and deterministic.

```sh
cargo fmt --all -- --check
cargo test --all-targets --all-features --locked
cargo clippy --all-targets --all-features --locked -- -D warnings
cargo doc --no-deps --locked
```

Tests must cover valid legacy and witness transactions, valid PSBT input, malformed
hex/base64, truncation, trailing bytes, oversized input, missing UTXO information,
network-sensitive address reporting, redaction, and stable machine-readable output.
Fuzz/property-test the bounded decode boundary if practical. No test may contact a
public service or use a valuable key or transaction under the learner's control.

## Transfer challenge

Add a read-only PSBT policy linter that reports missing UTXO data, unexpected
proprietary fields, inconsistent metadata, and what prevents fee calculation or
finalization analysis. Each finding must cite the structural evidence that triggered
it. Do not add signing, broadcasting, or claims that the PSBT is safe to spend.

## Completion checklist

- [ ] Both raw transactions and PSBTs produce useful bounded reports.
- [ ] Unknown information stays unknown; the CLI does not invent financial facts.
- [ ] No private-key, signing, wallet, network, or broadcast path exists.
- [ ] Untrusted input and terminal/log output have documented safety controls.
- [ ] Fixed offline vectors and negative cases pass every quality command.
- [ ] Transfer linter distinguishes structural findings from network validity.
- [ ] Reflection explains transaction versus PSBT data and remaining trust limits.

## Primary references

- [BIP 174: Partially Signed Bitcoin Transaction Format](https://bips.dev/174/)
- [Programming Bitcoin with Rust](https://rust-bitcoin.org/book/)
- [`bitcoin::Psbt`](https://docs.rs/bitcoin/latest/bitcoin/struct.Psbt.html)
- [`bitcoin::Transaction`](https://docs.rs/bitcoin/latest/bitcoin/transaction/struct.Transaction.html)

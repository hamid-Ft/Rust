# Mini-Project 19 — Polars Commerce Data Pipeline

## Unlock condition

Complete Project 13. In the default breadth sequence, complete Project 18 first.

## Outcome

Build a reproducible analytical pipeline using Polars' Rust API. Learn schemas,
columns/series, expressions, lazy scans, joins, grouping, null handling, query-plan
inspection, streaming considerations, CSV/JSON/Parquet I/O, and deterministic output.

## Non-goals

No machine learning, distributed compute cluster, notebook-only exploration, or claim
that DataFrames replace typed domain models. The pipeline remains runnable as a CLI.

## Artifact and behavior

Given local orders, customers, and products datasets:

- validate required columns and expected types before expensive execution;
- parse timestamps, normalize categories/currency units, and classify invalid rows;
- join datasets with explicit key/cardinality assumptions;
- compute revenue, order count, average basket, retention cohort, and top products;
- write deterministic clean data and summary outputs in selected formats;
- produce a data-quality report for missing, malformed, duplicate, and orphan rows;
- start with lazy scans, inspect optimized plans, and collect only at output boundaries;
- support filters/date ranges without loading unrelated columns where the optimizer can
  apply predicate/projection pushdown.

Pin a minimal Polars feature set required by the project to control compile time and
binary size. Keep path/config/error handling outside expression construction.

## Concept checklist

- [ ] Series, DataFrame, expression, LazyFrame, schema, and collect are distinguished.
- [ ] Lazy execution and query optimization can be explained from `explain` output.
- [ ] Join cardinality assumptions are validated, not guessed.
- [ ] Null is not silently treated as zero or empty text.
- [ ] Money uses an integer minor-unit or documented decimal-safe representation.
- [ ] Deterministic ordering is applied before persisted/reported output.
- [ ] Polars errors gain pipeline-stage context at the binary boundary.

## Build stages

1. Define fixture schemas, quality rules, and expected summary tables.
2. Load tiny eager fixtures to learn core DataFrame/Series operations.
3. Rebuild the production pipeline from lazy file scans and expressions.
4. Add validation/quarantine outputs and join-cardinality checks.
5. Add aggregations, deterministic sorting, and output writers.
6. Inspect optimized versus unoptimized plans and record observed pushdowns.
7. Test larger deterministic fixtures and document memory/streaming limitations.

## Required verification

Run default quality commands and fixture-based integration tests covering valid data,
schema/type mismatch, nulls, duplicates, orphan joins, malformed time/money values,
empty inputs, deterministic ordering, and output round trips. Save an optimized query
plan excerpt and explain which filters/projections moved. Build once with only the
documented Cargo features to prove feature assumptions.

## Transfer challenge

Accept a directory of date-partitioned order files and produce the same results while
processing only partitions intersecting the requested range. Add a reconciliation
table proving partition totals equal the combined output, handle schema drift with a
clear policy, and compare the optimized plan and resource behavior with the single-file
pipeline.

## Completion checklist

- [ ] Schemas, nulls, money, joins, and quality rules are explicit.
- [ ] Production transformations remain lazy until justified collection boundaries.
- [ ] Query-plan observations are recorded from actual output.
- [ ] Persisted results are deterministically ordered and round-trip tested.
- [ ] Default quality and pipeline integration tests pass with minimal features.
- [ ] Transfer challenge and specialization-phase reflection are complete.

## Primary references

- [Polars Rust getting started](https://docs.pola.rs/user-guide/getting-started/)
- [Polars lazy API](https://docs.pola.rs/user-guide/concepts/lazy-api/)
- [Polars Rust crate documentation](https://docs.rs/polars/latest/polars/)


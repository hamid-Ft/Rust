# Mini-Project 17 — Bevy Snake

## Unlock condition

Complete Project 13. In the default breadth sequence, complete Project 16 first.

## Outcome

Build a polished but compact Snake game with Bevy while learning ECS decomposition,
entities, components, resources, queries, systems, schedules, state transitions,
input, assets, fixed-step simulation, event/message flow, and plugin organization.

## Non-goals

No custom shaders, networking, physics engine, level editor, or premature rendering
optimization. The game must remain small enough to inspect the ECS data flow.

## Artifact and behavior

- Menu, playing, paused, and game-over application states.
- Grid-based snake movement at a fixed simulation rate, independent of render FPS.
- Buffered direction input that rejects immediate reversal.
- Food spawning only on unoccupied cells with deterministic injectable randomness.
- Growth, score, self/wall collision, restart, and increasing difficulty.
- Rendering/UI reacts to gameplay state but does not own core rules.
- Audio/assets load through Bevy's asset system with a visible loading state.

Keep a small pure grid model or clearly isolated rule layer so collision, movement,
growth, and spawning can be tested without creating a window or GPU context. Use ECS
for integration and game orchestration rather than forcing every calculation into it.

## Concept checklist

- [ ] Entity identity, component data, resources, and systems have distinct roles.
- [ ] Queries request only the data each system needs.
- [ ] System ordering and ambiguity are intentional and documented.
- [ ] Fixed-step gameplay does not multiply movement at variable frame rates.
- [ ] Commands/deferred changes and event/message timing are understood.
- [ ] State entry/exit systems create and clean up state-owned entities.
- [ ] Randomness and time are controllable in tests.

## Build stages

1. Implement and test the pure grid rules.
2. Create a Bevy app/plugin structure and spawn grid entities.
3. Add fixed-step movement and buffered input.
4. Add deterministic food, growth, score, and collision.
5. Add application states, UI, restart, and cleanup.
6. Add loading/audio assets and controlled difficulty changes.
7. Inspect ECS diagnostics and verify system behavior at different render rates.

## Required verification

Run default quality commands and headless rule/ECS tests. Manually verify input,
pause/restart, state cleanup, asset-loading failure behavior, and stable gameplay at
different frame rates. Avoid asserting performance from debug builds. Record the
Bevy version used because schedule/event APIs evolve between releases.

## Transfer challenge

Add obstacles generated from a deterministic seed and a level number. Guarantee the
initial snake and food remain reachable; if generation cannot satisfy constraints
within a bounded number of attempts, return a typed generation failure and fall back
cleanly. Test reproducibility, occupancy, reachability, and state cleanup.

## Completion checklist

- [ ] Core grid rules are tested without graphics.
- [ ] ECS components/resources/systems have justified responsibilities.
- [ ] Gameplay timing is fixed-step and render-rate independent.
- [ ] State transitions clean up owned entities and resources.
- [ ] Default quality and headless tests pass; manual game checks are recorded.
- [ ] Transfer challenge and reflection are complete.

## Primary reference

- [Bevy ECS quick start](https://bevy.org/learn/quick-start/getting-started/ecs/)


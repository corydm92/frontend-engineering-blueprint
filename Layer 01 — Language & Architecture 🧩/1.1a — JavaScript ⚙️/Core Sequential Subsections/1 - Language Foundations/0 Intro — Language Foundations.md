# Language Foundations — Summary

This directory builds the mental model for how JavaScript behaves before you ever reach
promises or frameworks. If you understand scope, closures, hoisting, `this`, and prototypes,
most “weird” behavior becomes predictable.

The goal is to reason about **what the engine does** rather than memorize one-off rules.
These foundations show up in every codebase, regardless of framework.

## Outcomes

- Explain how lexical scope creates predictable name resolution.
- Use closures intentionally without leaking memory or state.
- Predict hoisting and TDZ behavior without guesswork.
- Understand `this` binding across call sites.
- Describe how property lookup works via prototypes.

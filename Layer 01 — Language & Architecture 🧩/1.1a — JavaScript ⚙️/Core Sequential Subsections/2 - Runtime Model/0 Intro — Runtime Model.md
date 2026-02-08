# Runtime Model — Summary

JavaScript is single-threaded _per event loop_, but real apps handle user input, network
callbacks, timers, and rendering all at once. The runtime model explains **when** work runs
and why ordering surprises happen.

This directory focuses on tasks, microtasks, rendering timing, and where platform APIs run
outside the JS engine. It’s the foundation for debugging “race conditions” that feel random.

## Outcomes

- Predict ordering between timers, promises, and rendering.
- Explain why long tasks cause UI jank.
- Use platform APIs without assuming they run “inside JS”.

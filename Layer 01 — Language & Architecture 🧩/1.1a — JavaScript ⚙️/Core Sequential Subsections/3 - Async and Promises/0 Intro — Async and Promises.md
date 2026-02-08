# Async and Promises — Summary

Promises are the core abstraction for JavaScript concurrency. They make async flows read
linearly, but real work still runs concurrently and finishes in unexpected orders.

This directory teaches practical promise patterns, error propagation, and cancellation
so you can build robust async flows without race conditions.

## Outcomes

- Use chaining and `async`/`await` correctly.
- Control concurrency explicitly.
- Handle errors without swallowing context.
- Cancel stale requests safely.

Promise Chaining Quick Example

Example:
new Promise(resolve => resolve())
.then(() => console.log("first"))
.then(() => console.log("second"))
.then(() => console.log("third"))

──────────
INITIAL PROMISE CREATION
──────────
Promise A = new Promise(resolve => resolve())
Promise B = A.then(() => console.log("first"))
Promise C = B.then(() => console.log("second"))
Promise D = C.then(() => console.log("third"))

- All four promise contexts (A–D) are created synchronously during this single expression.
- Each .then() constructs a new pending promise and registers a reaction on the previous one.
- State transitions (pending → fulfilled) happen asynchronously once reactions run.

[Call Stack] → evaluating chained .then() calls (now empty)
[Reaction List]
A → [console.log("first")]
B → [console.log("second")]
C → [console.log("third")]
[Microtask Queue] → (empty)
[Promise States] → A: fulfilled, B: pending, C: pending, D: pending

──────────
STEP 1 — EXECUTOR RUNS
──────────
- The Promise constructor executes synchronously.
- resolve() is called immediately → Promise A transitions to fulfilled.
- No microtasks yet since no .then() handlers existed at that moment.

[Call Stack] → new Promise()
[Reaction List] → (empty)
[Microtask Queue] → (empty)
[Promise States] → A: fulfilled, B: undefined, C: undefined, D: undefined

──────────
STEP 2 — .then() REGISTRATION
──────────
- Each .then() attaches its handler and returns a new pending promise.
- All promises (A–D) now exist in memory; only A is fulfilled.
- Handlers are stored in the Reaction List.
- Because A is already fulfilled, its handler (console.log("first")) will be enqueued next.

[Call Stack] → .then() registration
[Reaction List]
A → [console.log("first")]
B → [console.log("second")]
C → [console.log("third")]
[Microtask Queue] → (empty)
[Promise States] → A: fulfilled, B: pending, C: pending, D: pending

──────────
STEP 3 — MICROTASK QUEUE STARTS
──────────
- The runtime moves A’s reaction (console.log("first")) from the Reaction List to the Microtask Queue.

[Call Stack] → (empty)
[Reaction List]
A: (empty)
B → [console.log("second")]
C → [console.log("third")]
[Microtask Queue] → console.log("first")
[Promise States] → A: fulfilled, B: pending, C: pending, D: pending

──────────
STEP 4 — FIRST MICROTASK RUNS
──────────
- console.log("first") executes on the call stack.
- Promise B transitions from pending → fulfilled.
- Its reaction (console.log("second")) is promoted to the Microtask Queue.

[Call Stack] → console.log("first")
[Reaction List]
A: (empty)
B: (empty)
C → [console.log("third")]
[Microtask Queue] → console.log("second")
[Promise States] → A: fulfilled, B: fulfilled, C: pending, D: pending

──────────
STEP 5 — SECOND MICROTASK RUNS
──────────
- console.log("second") executes.
- Promise C transitions from pending → fulfilled.
- Its reaction (console.log("third")) moves from the Reaction List → Microtask Queue.

[Call Stack] → console.log("second")
[Reaction List]
A: (empty)
B: (empty)
C: (empty)
[Microtask Queue] → console.log("third")
[Promise States] → A: fulfilled, B: fulfilled, C: fulfilled, D: pending

──────────
STEP 6 — THIRD MICROTASK RUNS
──────────
- console.log("third") executes.
- Promise D transitions from pending → fulfilled.
- The chain is now complete.

[Call Stack] → console.log("third")
[Reaction List]
A: (empty)
B: (empty)
C: (empty)
D: (empty)
[Microtask Queue] → (empty)
[Promise States] → A: fulfilled, B: fulfilled, C: fulfilled, D: fulfilled

──────────
STEP 7 — EVENT LOOP RETURNS
──────────
- No pending reactions or microtasks remain.
- Control returns to the macrotask queue (timers, I/O, etc.).

[Call Stack] → (empty)
[Reaction List] → (empty)
[Microtask Queue] → (empty)
[Promise States] → A: fulfilled, B: fulfilled, C: fulfilled, D: fulfilled
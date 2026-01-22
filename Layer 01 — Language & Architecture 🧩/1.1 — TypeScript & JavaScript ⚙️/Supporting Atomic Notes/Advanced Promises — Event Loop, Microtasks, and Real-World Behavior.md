Advanced Promises — Event Loop, Microtasks, and Real-World Behavior

1. Mental Model

A Promise is a tiny state machine inside the JavaScript engine.

It has:
- [[PromiseState]]: "pending" → "fulfilled" | "rejected"
- [[PromiseResult]]: holds the resolved value or error
- [[PromiseFulfillReactions]]: list of .then() callbacks
- [[PromiseRejectReactions]]: list of .catch() callbacks

.then() doesn’t make the promise run — it registers a reaction for when it finishes.
resolve() or reject() settles the promise and queues those reactions as microtasks.

------------------------------------------------------------

2. The Call Stack and Event Loop

The JavaScript runtime is single-threaded — it can only do one thing at a time.
The call stack is where synchronous code runs. Each function call is pushed onto the stack,
and when it returns, it’s popped off. JavaScript executes the stack top-to-bottom until it’s empty.

The event loop watches the call stack and manages two main queues:
- The macro task queue — for big events like timers, network callbacks, or user input.
- The microtask queue — for promise reactions and other small tasks that must run before the next macro task.

When the call stack is empty, the event loop:
1. Flushes all pending microtasks.
2. Then moves to the next macro task.
3. Runs its callback on the call stack.
4. Repeats forever.

This cycle is what makes asynchronous JavaScript appear concurrent even though it’s single-threaded.

------------------------------------------------------------

3. Example: Promise Inside a Timeout

console.log("A");

const p = new Promise((resolve) => {
console.log("B");
setTimeout(() => {
console.log("C");
resolve("done");
}, 0);
});

p.then((v) => console.log("A:", v));
p.then((v) => console.log("B:", v));

console.log("E");

Step-by-Step Timeline
1. The call stack starts executing top-down.
2. console.log("A") → runs on the call stack.
3. The Promise constructor runs immediately → console.log("B").
4. setTimeout is called → the browser schedules a macro task; callback is stored in the macro task queue.
5. Two .then() calls run synchronously → their callbacks are stored inside the Promise’s internal reaction list.
6. console.log("E") runs → the call stack is now empty.
7. Event loop checks: call stack is clear → run next macro task (the timeout).
8. The timeout callback executes:
- console.log("C") runs synchronously on the stack.
- resolve("done") fulfills the promise.
The runtime moves both .then() callbacks to the microtask queue.
(Because both .then() handlers are attached to the same promise rather than chained,
they’re treated as two separate reactions to the same fulfillment event.
The JS engine queues both of their callbacks at the same time, in registration order.)
9. The macro task finishes → the event loop flushes all pending microtasks.
10. Each .then() callback runs on the call stack → logs "A: done" and "B: done".

Final Output
A
B
E
C
A: done
B: done

------------------------------------------------------------

4. Real-World Example: Asynchronous API Call (Browser)

console.log("1 — Script start");

fetch("https://api.example.com/data")
.then((res) => res.json())
.then((data) => console.log("3 — Data received:", data))
.catch((err) => console.error("Error:", err));

console.log("2 — Script end");

Step-by-Step Timeline (Call Stack Focused)

1. The call stack begins executing the script.
2. console.log("1 — Script start") executes on the call stack.

3. fetch(...) is called:
- The fetch function itself is synchronous JavaScript that lives in the browser’s environment.
- The JS engine calls into the browser’s Fetch API subsystem, which starts the network request outside the JS engine.
- The fetch call immediately returns a Promise object (Promise A).
- Promise A is managed by the JS engine but fulfilled or rejected later by the browser once the response headers arrive.
- This Promise A is returned to the call stack and becomes the base for the .then() chain.

4. The first .then(res => res.json()) executes synchronously:
- This attaches a fulfillment reaction to Promise A.
- Because Promise A is still pending, nothing runs yet.
- The .then() call returns a new pending Promise (Promise B).
- Promise B represents the *future result* of res.json(), not the fetch response itself.

5. The second .then(data => console.log("3 — Data received:", data)) executes synchronously:
- This attaches a fulfillment reaction to Promise B.
- It also returns another new Promise (Promise C), which will fulfill once the second callback completes.
- Note: each .then() in this chain is linked to the *previous* promise, not the same one.
This means when Promise A fulfills, only the first .then() callback (res => res.json()) is queued.
When Promise B later fulfills, its own .then() (data => console.log(...)) is queued in a *subsequent microtask cycle*.
These reactions are not added to the microtask queue together — each link runs when its parent settles.

6. console.log("2 — Script end") executes on the call stack.
- The stack is now empty; the fetch promise (Promise A) remains pending while the network request continues outside JS.

7. The browser continues the network request in parallel at the system level (not part of the JS call stack).
- When headers arrive, the browser enqueues a microtask to resolve Promise A with a Response object.
- Once that microtask runs:
a. Promise A’s fulfillment callback (res => res.json()) executes.
b. res.json() returns a new Promise (still pending) → this becomes Promise B.
c. Promise B fulfills when body parsing completes.
d. When Promise B fulfills, its reaction (data => console.log(...)) is queued as a new microtask.
e. The final .catch() will only be triggered if any of the previous promises reject.

Key Distinction:
- The first .then() belongs to Promise A (the fetch Promise).
- The second .then() belongs to Promise B (the res.json() Promise).
- They are not queued together because each depends on the previous promise’s resolution.
- Each promise in the chain queues its own reaction when it settles,
resulting in a cascading sequence of microtasks — one per fulfilled link in the chain vs all pushed to queue.

Final Output (simplified sequence):
1 — Script start
2 — Script end
3 — Data received: {...}

(fetch network and JSON parsing happen asynchronously between the synchronous logs)

------------------------------------------------------------

5. Browser-Level Orchestration of Fetch

- The browser’s network thread manages fetch, not the JS engine.
- It listens for two key events:
1. Headers received → queue microtask → resolve(fetchPromise, new Response())
2. Network error → queue microtask → reject(fetchPromise, TypeError('NetworkError'))
- When headers arrive, the browser enqueues the Promise’s resolve() into the microtask queue.
- The JS engine doesn’t call resolve() directly; it just executes whatever microtasks are queued once the stack clears.
- This ensures the fetch promise fulfills as soon as headers are available — the body may still be downloading.

Example of the Response Object stored in [[PromiseResult]]:
{
url: "https://api.example.com/data",
type: "basic",
status: 200,
ok: true,
headers: Headers { "content-type": "application/json" },
body: ReadableStream,
bodyUsed: false
}

------------------------------------------------------------

6. Promise Chaining and Microtask Behavior

Example:

fetch("/api")
.then(res => res.json())
.then(data => data.user)
.then(user => console.log(user));

At runtime:
- fetch("/api") runs synchronously on the call stack and returns a pending Promise (fetchPromise).
- The browser’s network layer begins the request outside of JS.
- The .then(res => res.json()) callback is registered but not executed yet.

When the network response headers arrive:
- The browser enqueues a microtask that resolves fetchPromise.
- The event loop flushes that microtask once the call stack is empty.
- The first .then(res => res.json()) callback runs on the main stack.
- Inside this callback, res.json() returns another Promise (Promise A).
- Because a Promise is returned, the JS engine links them: Promise A remains pending until JSON parsing completes.

When Promise A fulfills:
- A new microtask is queued for the next .then(data => data.user).
- That callback runs on the stack, extracts data.user, and returns a value.
- The engine wraps that value in a new Promise (Promise B).

Promise B fulfills immediately:
- The engine queues another microtask for the final .then(user => console.log(user)).
- That callback runs on the call stack and logs the user synchronously.
- No new Promises are created, so the chain ends.

Microtask Queue Evolution:
[then(res=>res.json)]
→ [then(data=>data.user)]
→ [then(user=>console.log(user))]

At each step:
- One microtask runs → its callback executes on the call stack.
- That callback either returns a value (immediate fulfillment) or another Promise (delayed chaining).
- Each new promise adds its own microtask to the queue in order.
- The event loop continues flushing microtasks sequentially until the chain finishes.

------------------------------------------------------------

7. Key Takeaways

- The call stack runs all synchronous code first.
- The event loop coordinates when to pull microtasks and macro tasks back into the call stack.
- fetch() itself runs synchronously on the call stack, but networking happens in the browser outside the JS engine.
- The Promise returned by fetch remains pending until the browser pushes resolve() or reject() into the microtask queue.
- The resolved [[PromiseResult]] holds a Response object with metadata and a ReadableStream body.
- Each .then() or .catch() returns a new Promise; returned values are wrapped automatically.
- Promise chaining builds a sequence of microtasks, each executing one callback on the main stack.
- Microtasks always complete before the next macro task.

One-liner summary:
Promises don’t make JavaScript asynchronous — they make asynchronous work predictable by coordinating between the call stack, the microtask queue, and the browser’s asynchronous environment.
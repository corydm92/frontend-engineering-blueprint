Fetch „ Browser Integration, Promise Lifecycle, and Streaming Behavior

1. Purpose and Relationship to the JS Engine

fetch() is not a JavaScript-native function „ itÍs a browser API that bridges JavaScript with the network stack.
It returns a Promise to integrate smoothly with JSÍs microtask-based event loop,
but all actual I/O and state changes occur inside the browserÍs internal subsystems, not the JS engine.

Key design goal:
Expose asynchronous HTTP behavior as a single composable Promise chain,
while allowing the browser to handle connection management, streaming, and error states underneath.

------------------------------------------------------------

2. How fetch() Works Internally

fetch(url) ? steps executed by browser and JS engine:

1. JS calls fetch(url) on the call stack.
- The browserÍs networking layer is instructed to start an HTTP request asynchronously.
- JS immediately receives a pending Promise (fetchPromise).
- fetchPromise has:
[[PromiseState]]: "pending"
[[PromiseResult]]: undefined
[[PromiseFulfillReactions]] / [[PromiseRejectReactions]]: empty arrays

2. The browser monitors the network connection outside the JS runtime.

3. When response headers arrive:
- The browser enqueues a microtask that executes fetchPromiseÍs resolve() callback.
- This resolve passes a Response object as the [[PromiseResult]].
- The Promise becomes "fulfilled".
- All registered .then() callbacks are queued as microtasks for execution.

4. If an error occurs (network failure, DNS, CORS, abort):
- The browser enqueues a microtask to run reject().
- [[PromiseState]] becomes "rejected".
- [[PromiseResult]] is a TypeError('NetworkError').
- Registered .catch() callbacks are queued as microtasks.

The JS engine never calls resolve() or reject() directly „ those are handled entirely by the browserÍs internal fetch subsystem.

------------------------------------------------------------

3. The Response Object

When fetchPromise fulfills, the [[PromiseResult]] holds a Response instance built by the browser.

Example Response:
{
url: "https://example.com/api/data",
status: 200,
ok: true,
headers: Headers { "content-type": "application/json" },
body: ReadableStream,
bodyUsed: false
}

- Metadata (status, ok, headers) is immediately available once headers arrive.
- body is a ReadableStream that may still be downloading.
- Response methods like .json(), .text(), and .blob() each return a new Promise that resolves once the body is fully read and parsed.

------------------------------------------------------------

4. Streaming Behavior

The fetch promise resolves when headers are available „ not when the full body has finished downloading.

You can consume the body progressively through its ReadableStream:
const res = await fetch('/api/stream');
const reader = res.body.getReader();

while (true) {
const { done, value } = await reader.read();
if (done) break;
console.log('Received chunk:', new TextDecoder().decode(value));
}

Key distinction:
- fetchPromise resolves on header arrival (metadata ready)
- Response.body stream resolves incrementally (data ready)
This separation allows progressive rendering, streaming APIs, and React Server Components (RSC) payloads.

------------------------------------------------------------

5. Relationship to the Event Loop

fetch integrates with the event loop via microtasks:
- When headers arrive ? browser queues a microtask to resolve(fetchPromise)
- When body chunks arrive ? stream reader queues new microtasks for each chunk read
- When parsing (e.g., res.json()) finishes ? another microtask resolves the new Promise returned by that parser

The browserÍs network operations occur independently from JS.
JS only re-enters when a microtask is ready, at which point the associated callback runs on the main call stack.

Timeline summary:
Call Stack ? fetch() ? returns pending Promise
Browser ? performs network I/O
Browser ? queueMicrotask(resolve)
Event Loop ? flushes microtasks ? run .then()
Optional ? body stream produces more microtasks as chunks arrive

------------------------------------------------------------

6. Promise Chaining with fetch

fetch("/api") // Promise A
.then(res => res.json()) // Promise B (attached to A)
.then(data => data.user) // Promise C (attached to B)
.then(user => console.log(user));// Promise D (attached to C)

Timeline:

1. Promise A (fetch) is pending.
- Callbacks registered:
A.[[PromiseFulfillReactions]] = [res => res.json()]
B, C, D are created but pending, waiting on AÍs chain.

2. When Promise A fulfills (headers received):
- Only its registered reactions (the first .then) are queued as microtasks.
- Microtask Queue: [res => res.json()]

3. When that microtask runs:
- res.json() executes and returns a new Promise ? Promise B.
- The callback finishes, so Promise B fulfills or stays pending depending on when body parsing finishes.

4. When Promise B fulfills:
- All of Promise BÍs registered callbacks (the second .then) are now queued as microtasks.
- Microtask Queue: [data => data.user]

5. When that microtask runs:
- data.user executes synchronously, returns a value, fulfilling Promise C immediately.

6. Promise CÍs callback (user => console.log(user)) is now queued in the next microtask cycle.
- Microtask Queue: [user => console.log(user)]
- When that runs, the chain completes.

So yes „ only the callbacks attached to the currently settling promise are ever moved into the microtask queue.
Each link triggers the next one *after* it resolves. The later .then() handlers arenÍt scheduled until their promiseÍs turn in the chain.


------------------------------------------------------------

7. Error Propagation

Any network or parsing failure triggers reject() inside the fetch or body parser Promise.
That rejection travels through the chain until a .catch() handles it.

Example:
fetch("/bad-url")
.then(res => res.json())
.catch(err => console.error("Network or JSON error:", err));

Error steps:
1. Browser encounters failure ? queues reject() as a microtask.
2. Microtask runs ? fetchPromise [[PromiseState]] = "rejected".
3. The event loop executes the .catch() callback on the call stack.
4. If .catch() returns normally, its value becomes the new resolved Promise for chaining.

------------------------------------------------------------

8. Summary Mental Model

fetch() delegates networking to the browser while exposing a Promise interface to JavaScript.

- fetch() starts instantly and returns a pending Promise.
- The browser controls when to resolve or reject it, using microtasks to sync back into JS.
- The first Promise resolves with a Response object as soon as headers are received.
- Response.body is a ReadableStream that delivers data progressively.
- .then(), .json(), .text(), and .catch() all build additional Promises chained through microtasks.
- The event loop ensures all microtasks from fetch resolve before moving to the next macro task.

One-liner summary:
fetch() is a coordination layer between JavaScriptÍs microtask system and the browserÍs network engine „ resolving early for headers, streaming late for data, and surfacing both through Promises that integrate seamlessly with the event loop.

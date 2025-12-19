JavaScript Runtime & Execution Model

Purpose:
Define what the JavaScript runtime actually does „ from parsing and execution to how asynchronous code interacts with the event loop.
This section separates what happens at runtime from what happens at build time, so behavior is predictable across environments.

---

JavaScript is interpreted and single-threaded, executing inside a runtime environment (browser or Node.js) powered by an engine (V8, SpiderMonkey, etc.).

At runtime, three phases occur:
1. Parsing ? code converted to an Abstract Syntax Tree (AST)
2. Compilation ? JIT-compiled into machine code
3. Execution ? global + function contexts created, event loop manages async tasks

All behaviors here occur at runtime, not during bundling or transpilation.

---

Runtime Gotchas (Ranked by Impact)

1. Event Loop
DO:
- Remember JavaScript is single-threaded. Async behavior comes from the runtime environment (browser APIs or NodeÍs libuv).
- Understand the event loop: queued tasks only run once the call stack is empty.
- Distinguish microtasks (Promises, queueMicrotask) vs macrotasks (setTimeout, setInterval, I/O).

Example:
setTimeout(() => console.log('macro'));
Promise.resolve().then(() => console.log('micro'));
console.log('sync');
// ? sync ? micro ? macro

DONÍT:
- Expect parallelism „ concurrency is simulated through scheduling.

---

2. Execution Context & Scope Chain
DO:
- Each function call creates a new execution context (scope, variable environment, this binding).
- Variable resolution is dynamic: JS walks the scope chain at runtime, not compile time.
- Closures preserve the lexical environment after the parent scope returns.

Example:
function counter() {
let n = 0;
return () => ++n;
}
const c = counter();
c(); // 1
c(); // 2

DONÍT:
- Confuse lexical scoping with runtime binding of this.
- Assume variables are resolved at import time „ theyÍre resolved at runtime during execution.

---

3. Hoisting & TDZ (Temporal Dead Zone)
DO:
- Recognize hoisting is a runtime parsing phase behavior, not build-time.
- var declarations initialize as undefined, function declarations hoist fully.
- let, const, and class are hoisted but uninitialized „ exist in the TDZ until declaration executes.

Example:
console.log(a); // undefined
var a = 1;

console.log(b); // ReferenceError
let b = 2;

DONÍT:
- Access let/const before declaration „ itÍs a ReferenceError at runtime.

---

4. Microtasks vs Macrotasks
DO:
- Microtasks always flush before the next macrotask.
- Promise callbacks (.then, .catch, .finally) run as microtasks.

Example:
Promise.resolve().then(() => console.log('micro'));
setTimeout(() => console.log('macro'));
console.log('sync');
// sync ? micro ? macro

DONÍT:
- Expect setTimeout(fn, 0) to run immediately „ the microtask queue always wins.

---

5. this Binding
DO:
- Understand this is determined at call time, not at declaration.
- Arrow functions capture this lexically (from their enclosing scope).
- Use .bind() or arrow functions in callbacks to avoid unintentional rebinding.

Example:
const obj = {
val: 42,
fn() {
setTimeout(() => console.log(this.val)); // ? 42
},
};
obj.fn();

DONÍT:
- Assume this refers to the same object inside nested callbacks or event handlers.

---

6. Closures & Memory Retention
DO:
- Use closures for encapsulation but release references when no longer needed.
- Remember closures hold variables by reference, not value „ preventing GC if objects remain referenced.

Example:
function make() {
const big = new Array(1e6).fill('*');
return () => console.log(big.length);
}

DONÍT:
- Keep persistent closures to large data „ they survive beyond function lifetime, leaking memory.

---

7. Blocking the Main Thread
DO:
- Split long-running loops into chunks (setTimeout, queueMicrotask, requestIdleCallback) to yield back to the event loop.

Example:
function process(items) {
const batch = items.splice(0, 1000);
// work on batch...
if (items.length) setTimeout(() => process(items), 0);
}

DONÍT:
- Run heavy synchronous computation in the browser „ it freezes UI until completion.

---

8. Implicit Globals
DO:
- Always declare variables (let, const, var).
- Use "use strict" globally to prevent implicit global creation.

Example:
"use strict"
foo = 5; // ? ReferenceError

DONÍT:
- Assign undeclared variables „ in non-strict mode they auto-attach to window or globalThis.

---

9. Shadowing & Scope Confusion
DO:
- Avoid redeclaring the same variable name in nested scopes.
- Understand that inner var declarations hoist and shadow outer scope variables.

Example:
var x = 1;
function test() {
console.log(x); // undefined (inner var x hoisted)
var x = 2;
}

DONÍT:
- Mix var with let in the same scope „ it creates runtime confusion.

---

10. Garbage Collection (GC)
DO:
- Remember GC is non-deterministic „ the runtime decides when to reclaim memory.
- Release DOM references and event listeners when elements are removed.

DONÍT:
- Assume nulling an object triggers instant collection „ GC runs opportunistically.

---

11. Prototypal Inheritance
DO:
- Understand that JavaScript uses prototype chains, not classical inheritance.
- All objects link to a prototype object via [[Prototype]].

Example:
const animal = { eats: true };
const dog = Object.create(animal);
dog.barks = true;
console.log(dog.eats); // true (inherited via prototype)

DONÍT:
- Confuse class syntax for classical inheritance „ itÍs syntactic sugar over prototypes.

---

12. Event Loop Phases (Node-specific)
DO:
- Know NodeÍs loop has additional phases: timers ? pending ? idle ? poll ? check ? close.
- Microtasks (Promises, process.nextTick) still take priority after each phase.

DONÍT:
- Use process.nextTick carelessly „ it can starve the event loop if queued recursively.

---

Diagnostic & Debugging Tools
- performance.now() „ micro-timing for event loop intervals
- console.time(), console.profile() „ call-stack duration analysis
- Chrome DevTools ? inspect call stacks, scopes, closures
- Node --inspect or --trace-events ? visualize async operations
- Lighthouse ? measure blocking time on main thread

---

Key Takeaways
- Hoisting, scope, and async timing all happen at runtime, not during bundling.
- Promises and microtasks always preempt macrotasks.
- Closures and references directly impact memory stability.
- The event loop defines perceived concurrency „ never block it.
- Mastering the runtime = mastering JavaScript behavior across browsers, Node, and frameworks.

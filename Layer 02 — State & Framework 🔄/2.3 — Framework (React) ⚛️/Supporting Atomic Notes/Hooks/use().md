use()
Ex: client or server component reading async data

Read a promise or context during render and let React suspend until the value is ready, without effects or local loading state

1. Goal

Understand what use() does, where it fits in React’s rendering model, and the exact rules that make it safe and predictable.
This note builds from basic mechanics to advanced usage, without skipping steps or assuming framework magic.

2. What use() Is

use() is a low-level React API that lets a component read the value of a resource during render.

That resource can be:
- a Promise (or thenable)
- a Context value
- a special framework-provided resource

use() is about reading, not performing work.

use() does not:
- start async work
- manage lifecycles
- cache values
- retry fetches
- replace data libraries

3. Where use() Fits in React’s Render Model

React rendering is synchronous from the component’s point of view.

During render, a component must either:
- produce a value synchronously, or
- abort rendering entirely

use() integrates with this rule.

Instead of waiting, polling, or yielding:
- use() either returns a value
- or throws (to suspend or error)

This is how async data fits into synchronous render semantics.

4. What use() Actually Does (Exact Semantics)

Given a value x, use(x):

- If x is a fulfilled promise → returns the resolved value
- If x is a pending promise → throws the promise (triggers Suspense)
- If x is a rejected promise → throws the error (triggers error handling)
- If x is a supported non-promise resource (e.g. Context) → returns its value
- If x is not a supported type → throws immediately

From the component’s perspective, use() is purely synchronous.

5. use() and Suspense (Foundational Requirement)

When use() throws a promise:
- React stops rendering the current tree
- React looks for the nearest Suspense boundary
- React shows the fallback
- React retries rendering when the promise resolves

Without a Suspense boundary:
- the thrown promise becomes a runtime error

This makes Suspense a non-optional part of using use() with promises.

6. Basic Example: Reading Async Data with a Cached Promise

const cache = new Map();

function fetchData(key) {
if (!cache.has(key)) {
cache.set(key, new Promise(res => {
setTimeout(() => res("Hello"), 1000);
}));
}
return cache.get(key);
}

function Example() {
const data = use(fetchData("greeting"));
return <div>{data}</div>
}

Key mechanics:
- fetchData always returns the same promise for the same key
- use() observes the promise during render
- React retries rendering when the promise resolves
- no effects or lifecycle hooks are involved

7. Critical Rule: Stable Identity

Promises passed to use() must be referentially stable across renders.

This breaks:

function Example() {
const data = use(new Promise(res => res("Hi")));
}

Why this fails:
- a new promise is created every render
- React never sees the previously thrown promise resolve
- render suspends forever

Stable identity is not an optimization.
It is required for correctness.

8. Error Handling with use()

If the promise passed to use() rejects:
- use() throws the error
- React propagates it to the nearest error boundary

This means:
- error handling is declarative
- try/catch inside render does not apply
- errors must be handled with Error Boundaries

Suspense handles loading.
Error boundaries handle failure.
use() integrates with both by throwing.

9. use() with Context

use() can read Context values directly.

Example:

const ThemeContext = createContext("light");

function Button() {
const theme = use(ThemeContext);
return <button className={theme}>Click</button>
}

Behavior:
- identical to useContext
- works during render
- follows the same propagation rules

This exists to unify resource reading under one primitive.

10. use() Does Not Cache (And Why That Matters)

use() does not cache anything.

If a value is cached:
- that caching must happen outside React
- typically in a module, framework layer, or data library

React’s responsibility:
- observe the resource
- retry render when it resolves
- keep rendering deterministic

Caching is intentionally not part of use().

11. use() Is Not Async / Await

use() does not pause execution.
It does not resume execution.
It does not work like await.

Mental model difference:

await:
- pauses a function
- resumes later

use():
- either returns now
- or aborts render entirely

Render either completes synchronously or does not complete at all.

12. Client vs Server Usage (Important Constraint)

use() can be used:
- in Server Components
- in Client Components

But with different expectations.

On the server:
- frameworks often provide cached resources
- use() commonly reads server-fetched data

On the client:
- promises must already exist and be stable
- use() does not initiate fetches
- Suspense boundaries are required

use() does not magically make client fetching safe.
The same rules apply.

13. What use() Is Not

use() is not:
- a replacement for useEffect
- a data-fetching library
- a state management solution
- an async control-flow mechanism
- a way to “pause” part of a render

It does not:
- trigger side effects
- coordinate retries
- manage request lifetimes

14. When to Use use()

use() is appropriate when:
- data is required to render
- the resource can be cached externally
- suspension is acceptable
- a Suspense boundary exists
- rendering should retry automatically on resolution

use() is inappropriate when:
- data is optional
- side effects are involved
- progressive updates are required
- promise identity cannot be stabilized
- loading should not block rendering

15. How use() Fits with Other Primitives

use():
- reads required data during render

useEffect:
- performs side effects after commit

useTransition:
- controls priority of state updates

Suspense:
- defines loading behavior

Each primitive handles one axis.
use() is the read-time primitive.

16. One-Sentence Final Model

use() allows React to synchronously read required resources during render by throwing promises or errors, letting Suspense and error boundaries control what the user sees while React retries rendering until the data is ready.
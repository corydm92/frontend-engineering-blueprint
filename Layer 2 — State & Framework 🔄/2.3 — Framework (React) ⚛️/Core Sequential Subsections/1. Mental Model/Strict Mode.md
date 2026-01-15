Strict Mode


1. Mental Model

Strict Mode is a development-only feature that helps surface unsafe or side-effect-prone code before it becomes a production bug.
It does not change how your app behaves in production.

Instead, it adds extra checks and intentional re-renders in development to expose potential problems early.

Think of it as ReactÍs stress test for:
- render purity
- effect correctness
- cleanup discipline
- legacy or unsafe patterns

------------------------------------------------------------

2. What Strict Mode Does

When enabled, React intentionally double-invokes certain operations to reveal side effects and impure logic.

In development:
- Components are rendered twice (mount ? unmount ? mount) to test purity
- Effects (`useEffect`, `useLayoutEffect`) are set up, cleaned up, and set up again
- Warnings appear for deprecated APIs and unsafe lifecycles
- Legacy patterns (string refs, `findDOMNode`, unsafe lifecycles) are flagged

Strict Mode only runs these checks in development.
Production builds render normally and once.

------------------------------------------------------------

3. Enabling Strict Mode

Wrap your app (or part of it) in `<React.StrictMode>`:

import React from "react"
import ReactDOM from "react-dom/client"
import App from "./App"

ReactDOM.createRoot(document.getElementById("root")).render(
<React.StrictMode>
<App />
</React.StrictMode>
);

Strict Mode can also be scoped to a subtree if youÍre incrementally migrating legacy code.

------------------------------------------------------------

4. The Core Rule to Remember

In Strict Mode (development only):
- React may render, discard, and re-render
- Effects may mount, clean up, and re-mount
- Work may be started, abandoned, and restarted

Any code that assumes ñthis runs onceî is unsafe.

Fetches and setState are the most common failure points.

------------------------------------------------------------

5. Broken Pattern: Fetch in useEffect Without Cleanup

function User() {
const [user, setUser] = useState(null);

useEffect(() => {
fetch("/api/user")
.then(res => res.json())
.then(data => setUser(data));
}, []);

return <div>{user?.name}</div>
}

Why this fails in Strict Mode:
- effect runs
- fetch starts
- cleanup runs (but does nothing)
- effect runs again
- second fetch starts
- both responses may call setState

Problems:
- duplicate requests
- race conditions
- stale updates

------------------------------------------------------------

Correct Pattern A: Abort the Fetch

function User() {
const [user, setUser] = useState(null);

useEffect(() => {
const controller = new AbortController();

fetch("/api/user", { signal: controller.signal })
.then(res => res.json())
.then(data => setUser(data))
.catch(err => {
if (err.name !== "AbortError") throw err;
});

return () => {
controller.abort();
};
}, []);

return <div>{user?.name}</div>
}

Why this works:
- cleanup cancels in-flight work
- duplicate runs are safe
- abandoned renders donÍt leak effects

------------------------------------------------------------

Correct Pattern B: Guard Against Stale Effects

function User() {
const [user, setUser] = useState(null);

useEffect(() => {
let isActive = true;

fetch("/api/user")
.then(res => res.json())
.then(data => {
if (isActive) {
setUser(data);
}
});

return () => {
isActive = false;
};
}, []);

return <div>{user?.name}</div>
}

Why this works:
- cleanup invalidates the previous effect run
- stale responses are ignored
- repeated mounts are safe under Strict Mode

------------------------------------------------------------

6. Broken Pattern: setState During Render

function Counter() {
const [count, setCount] = useState(0);

if (count === 0) {
setCount(1);
}

return <div>{count}</div>
}

Why this fails:
- render must be pure
- Strict Mode retries render
- setState fires repeatedly
- infinite render loop

------------------------------------------------------------

Correct Pattern: Move State Updates to Effects or Events

function Counter() {
const [count, setCount] = useState(0);

useEffect(() => {
if (count === 0) {
setCount(1);
}
}, [count]);

return <div>{count}</div>
}

Why this works:
- render stays pure
- state updates happen after commit
- repeated mounts are safe

------------------------------------------------------------

7. Broken Pattern: Fetch During Render

function User() {
const [user, setUser] = useState(null);

fetch("/api/user")
.then(res => res.json())
.then(data => setUser(data));

return <div>{user?.name}</div>
}

Why this fails:
- render runs multiple times
- fetch runs on every render
- setState retriggers render
- infinite loop

------------------------------------------------------------

Correct Pattern: Fetch in Effect (or Suspense + use())

Effect-based fix:

function User() {
const [user, setUser] = useState(null);

useEffect(() => {
let cancelled = false;

fetch("/api/user")
.then(res => res.json())
.then(data => {
if (!cancelled) setUser(data);
});

return () => {
cancelled = true;
};
}, []);

return <div>{user?.name}</div>
}

Suspense-based fix:

const cache = new Map();

function fetchUser() {
if (!cache.has("user")) {
cache.set("user", fetch("/api/user").then(r => r.json()));
}
return cache.get("user");
}

function User() {
const user = use(fetchUser());
return <div>{user.name}</div>
}

------------------------------------------------------------

8. Broken Pattern: Subscriptions Without Cleanup

function Socket() {
useEffect(() => {
socket.connect();
socket.on("message", handleMessage);
}, []);

return null;
}

Why this fails:
- effect runs twice in Strict Mode
- subscriptions stack
- handlers fire multiple times
- memory leaks

------------------------------------------------------------

Correct Pattern: Full Cleanup

function Socket() {
useEffect(() => {
socket.connect();
socket.on("message", handleMessage);

return () => {
socket.off("message", handleMessage);
socket.disconnect();
};
}, []);

return null;
}

Why this works:
- every setup has a teardown
- remounting is safe
- no duplicated side effects

------------------------------------------------------------

9. Broken Pattern: Fetch + setState Without Identity Control

function Search({ query }) {
const [results, setResults] = useState([]);

useEffect(() => {
fetch(`/api/search?q=${query}`)
.then(res => res.json())
.then(setResults);
}, [query]);

return <Results data={results} />
}

Why this fails:
- rapid query changes
- older responses may resolve later
- stale data overwrites fresh data
- Strict Mode makes this visible sooner

------------------------------------------------------------

Correct Pattern: Abort or Track Request Identity

Abort-based fix:

function Search({ query }) {
const [results, setResults] = useState([]);

useEffect(() => {
const controller = new AbortController();

fetch(`/api/search?q=${query}`, { signal: controller.signal })
.then(res => res.json())
.then(data => setResults(data))
.catch(err => {
if (err.name !== "AbortError") throw err;
});

return () => {
controller.abort();
};
}, [query]);

return <Results data={results} />
}

Alternative fixes:
- request IDs
- external cache
- Suspense + use()

------------------------------------------------------------

10. Broken Pattern: Assuming Effects Run Once

useEffect(() => {
analytics.trackPageView();
}, []);

Why this fails:
- Strict Mode mounts, cleans up, and remounts
- analytics fires twice in development

------------------------------------------------------------

Correct Pattern: Make Effects Idempotent or Guarded

useEffect(() => {
if (process.env.NODE_ENV !== "production") return;
analytics.trackPageView();
}, []);

Or move analytics to:
- router-level events
- server-side tracking
- external instrumentation

------------------------------------------------------------

11. The Unifying Rule

Every effect must tolerate:
- being set up
- being torn down
- being set up again

Every render must tolerate:
- restarting
- being discarded
- never committing

------------------------------------------------------------

12. One-Sentence Summary

Strict Mode exposes fetch and setState patterns that assume single execution,
forcing you to write code that remains correct under re-renders,
interruptions, cleanups, and future concurrent React behavior.

React Strict Mode

1
. Mental Model

Strict Mode is a development-only feature that helps surface unsafe or side-effect-prone code before it becomes a production bug.
It doesnÍt change how your app behaves in production„it adds extra checks and intentional re-renders in development to expose potential problems.

Think of it as ReactÍs ñstress testî for purity, side effects, and legacy patterns.

------------------------------------------------------------

2. What Strict Mode Does

When enabled, React intentionally double-invokes certain lifecycle operations (like rendering and effects) to reveal side effects and impure logic.

In development:
- Components are rendered twice (mount ? unmount ? mount) to test for purity.
- Effects (`useEffect`, `useLayoutEffect`) run twice to detect unintended side effects.
- Warnings are shown for deprecated APIs and unsafe lifecycles.
- Identifies usage of legacy React features (like string refs or `findDOMNode`).

Strict Mode only runs these checks in development.
In production builds, components render normally and once.

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

4. Example: Detecting Impure Render

function Greeting({ name }) {
console.log("Rendering:", name); //
?
Side effect in render
return <h1>Hello, {name}</h1>
}

With Strict Mode on:
- React renders twice.
- YouÍll see ñRendering: Coryî twice in console.
This reveals that your render contains a side effect (logging).

Fix:
Move side effects to `useEffect` if needed, or remove them entirely from render.

------------------------------------------------------------

5. Example: Exposing Incorrect Cleanup

function Timer() {
useEffect(() => {
const id = setInterval(() => console.log("tick"), 1000);
return () => clearInterval(id); //
?
Cleanup
}, []);

return <p>Timer running</p>
}

If cleanup is missing, Strict Mode will run the effect twice:
- Interval runs twice ? youÍll see ñtickî twice per second.
This signals missing cleanup logic.

------------------------------------------------------------

6. Example: Side Effects During Render

function Profile() {
document.title = "User" //
?
modifies global state during render
return <h1>Profile</h1>
}

With Strict Mode enabled:
- React renders, then unmounts, then renders again.
- document.title will be set twice, revealing this impure behavior.
Fix by moving side effects to an effect:

function Profile() {
useEffect(() => {
document.title = "User"
}, []);
return <h1>Profile</h1>
}

------------------------------------------------------------

7. Example: Missing Cleanup in Effects

useEffect(() => {
window.addEventListener("resize", handleResize); // no cleanup
?

}, []);

Strict Mode will call this effect twice in dev:
- Two event listeners are added.
- YouÍll notice duplicate behavior, revealing missing cleanup.

Fix:
useEffect(() => {
window.addEventListener("resize", handleResize);
return () => window.removeEventListener("resize", handleResize);
}, []);

------------------------------------------------------------

8. Why It Double Invokes

ReactÍs concurrent rendering model can start, pause, discard, or restart renders.
Strict Mode simulates this behavior to help developers find:
- Components that rely on mount timing.
- Code that mutates state or performs irreversible actions during render.
- Effects missing cleanup or using stale data.

By forcing multiple mounts and unmounts, it exposes code that isnÍt resilient to these realities.

------------------------------------------------------------

9. Common Misunderstandings

- It does *not* run in production, so performance impact is zero there.
- ItÍs not a bug if a component renders twice in development„itÍs intentional.
- You should *not* disable Strict Mode to hide warnings; fix the root cause instead.

------------------------------------------------------------

10. When to Use It

- Always in development root apps.
- When modernizing old codebases (exposes unsafe lifecycles and side effects).
- When introducing new hooks or concurrent features.
- When validating third-party libraries for React 18+ compatibility.

------------------------------------------------------------

11. Typical Strict Mode Warnings

- ñEffect function must not return anything besides a cleanup function.î
- ñDetected legacy string ref.î
- ñfindDOMNode is deprecated.î
- ñUnsafe lifecycle method found in class component.î

These indicate that your code relies on patterns that can break in modern React concurrency.

------------------------------------------------------------

12. Key Takeaways

- Strict Mode is a safety harness, not a production feature.
- It double-renders components in dev to expose side effects and impure logic.
- Helps identify missing cleanup, unsafe APIs, and side-effect-prone code.
- Should be left enabled throughout development.
- Fixing Strict Mode warnings ensures future React versions and concurrent rendering work seamlessly.

------------------------------------------------------------

13. One-liner summary

Strict Mode intentionally breaks fragile code in development so your app wonÍt break in production.

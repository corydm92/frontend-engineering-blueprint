React-to-Paint Lifecycle

React Fiber Lifecycle + Browser Paint Loop + Rendering Pipeline (End-to-End Flow)

────────────────────────────
🔹 REACT FIBER LIFECYCLE
────────────────────────────

1. React Schedules an Update (Fiber Work Begins)
   A state or prop change triggers React’s Fiber scheduler.
   React breaks rendering into small “units of work” so it can yield between them if the main thread is busy.
   → This happens in React’s render “work loop,” managed by the Fiber scheduler.

2. Reconciliation Phase (Render Phase)
   React walks the Fiber tree, building the next virtual DOM and comparing it to the previous one.
   → Purpose: generate a list of mutation instructions (what needs to be added, removed, or changed).
   → No DOM writes occur yet — this is purely computational, in-memory work.
   → Each Fiber node gets a set of "effects" describing what needs to happen in the commit phase.

3. Prepare for Commit (Pre-Mutation Phase)
   React finalizes all pending effects before touching the real DOM.
   → Includes cleanup of components that will unmount and running cleanup functions from previous effects.
   → React ensures all refs that will be removed are cleared and prepares refs for new DOM nodes.

4. Commit Phase (Apply Mutations)
   React now applies the queued DOM mutations synchronously.
   → This is not one giant operation — it’s a sequence of small synchronous JavaScript function calls,
   each one updating specific nodes (e.g. setAttribute, appendChild, removeChild).
   → Each mutation is pushed onto the call stack and executed sequentially.
   → The browser does not paint yet — it waits until all these calls complete and the stack is empty.

⚙️ Why We Say “React Passes Changes Off to the Browser”:

- When React executes those DOM mutation functions, it’s invoking the browser’s **Document Object Model (DOM) API**.
- The `document` object and its methods (`createElement`, `setAttribute`, `appendChild`, etc.) are part of the browser’s
  native API surface — the interface between JavaScript and the browser engine.
- In other words, React is not giving the browser a “to-do list” and walking away; it’s directly **calling into**
  the browser’s own API to perform those changes.
- That’s why we describe this step as a “pass-off” — React’s JS logic hands control to the browser’s DOM engine
  through these API calls, which are what actually modify the rendering tree.

5. useLayoutEffect (Layout Phase)
   After the DOM has been updated but before the browser paints, React synchronously runs all useLayoutEffect callbacks.
   → Each callback is also pushed onto the call stack after DOM mutations finish.
   → These can measure layout or adjust styles and will block paint until complete.
   → React runs them in the same commit tick, ensuring layout reads/writes happen before the next paint.

────────────────────────────
🔹 BROWSER PAINT LOOP
────────────────────────────

6. Event Loop Waits for Completion
   The event loop ensures the browser only continues once all synchronous JS tasks — including commit-phase DOM updates
   and useLayoutEffect callbacks — have cleared the call stack.

7. Microtasks Execute (Promises, MutationObservers)
   Once the stack clears, pending microtasks run (e.g. resolved Promises, mutation observers).

8. Macrotasks Execute (setTimeout, MessageChannel, etc.)
   Then, the browser runs any queued macrotasks, each in its own event-loop tick.

9. Browser Paints (Render Frame)
   With JS finished and the stack empty, the browser performs the rendering pipeline steps:

9a. Style Recalculation → Compute all CSS rules and final computed styles for elements.
9b. Layout → Determine geometry and positions for each element in the render tree.
9c. Paint → Rasterize each element into layers (bitmaps, textures).
9d. Composite → Combine layers in the correct stacking order into a final image.
9e. Display → The GPU sends the composited frame to the screen — pixels appear.

────────────────────────────
🔹 POST-PAINT REACT EFFECTS + BROWSER HOUSEKEEPING
────────────────────────────

10. useEffect (Passive Effects)
    After the paint, React asynchronously runs all useEffect callbacks.
    → These run outside the render/commit path and do not block painting.
    → Commonly used for data fetching, logging, subscriptions, or DOM listeners.

11. Idle Callbacks (requestIdleCallback)
    If the main thread is idle, the browser can run background or low-priority work (analytics, cleanup, prefetching).
    React may use this time for background Fiber tasks or preloading future components.

12. Next Animation Frame (requestAnimationFrame)
    The browser queues up the next frame render. Any scheduled rAF callbacks run before the next paint,
    ideal for smooth animations and visual updates tied to refresh rate.

────────────────────────────
Summary:
Steps 1–5 → React Fiber’s full render + commit lifecycle (including reconciliation, DOM mutation, and layout effects).
Steps 6–9 → Browser event loop + paint loop, containing the Rendering Pipeline inside Step 9.
Steps 10–12 → Post-paint React effects and browser scheduling (idle, animation, and background work).

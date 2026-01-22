React-to-Paint Lifecycle (Full System Pipeline with Fiber Lifecycle Included)

This note covers the entire pipeline end-to-end:
React scheduling → Fiber render → Fiber commit → Browser event loop → Rendering pipeline → Paint → Post-paint effects.

It is the high-level “big picture” you reference when thinking about how updates really flow through React and the browser.

────────────────────────────────────────────────────────────────────────
1. React Schedules an Update (Entry Point into the System)
────────────────────────────────────────────────────────────────────────

• A state, prop, or context change creates an update object.
• React’s scheduler assigns a priority lane.
• React marks the root fiber as needing work and begins the render phase.

Important:
This is only scheduling. No DOM changes occur yet.

Conceptually: “JS signals that the UI needs to change; React prepares to compute the next UI.”

────────────────────────────────────────────────────────────────────────
2. React Render Phase (Fiber Reconciliation – Pure, No DOM Writes)
────────────────────────────────────────────────────────────────────────

React enters the Fiber tree and constructs the Work-In-Progress tree in memory.

BEGIN WORK (top-down)
• For each fiber:
– Check if the fiber needs updating (state, props, context, lane priority).
– If no update → bail out and reuse previous child fibers.
– If update needed → React calls the component function immediately.
The component returns new elements.
React reconciles these against previous child fibers *right now*.
New, reused, or deleted fibers are created on the spot.
• React descends into the updated children immediately.

COMPLETE WORK (bottom-up)
• Finalizes WIP fibers.
• Prepares host instances (DOM nodes).
• Attaches effect flags (Placement, Update, Deletion, etc.).
• Bubbles flags upward.
• Produces the final effect list for commit.

By the end of the render phase:
• The full Work-In-Progress fiber tree exists.
• All diffing/reconciliation has already occurred.
• The effect list contains every mutation React must apply.

Conceptually: “React computes the next UI tree in memory.”

────────────────────────────────────────────────────────────────────────
3. Pre-Commit Phase (DOM-Safety Preparation)
────────────────────────────────────────────────────────────────────────

Before touching the DOM:
• React runs cleanup functions for any layout effects being removed.
• Clears refs for nodes being detached.
• Finalizes the effect list ordering.

Still no DOM mutations.

Conceptually: “React prepares for DOM mutation so commit is safe and atomic.”

────────────────────────────────────────────────────────────────────────
4. Commit Phase – DOM Mutations (Synchronous, Atomic)
────────────────────────────────────────────────────────────────────────

React walks the effect list and performs the actual DOM updates.

For each flagged fiber:
• Placement → insert DOM nodes
• Deletion → remove DOM nodes
• Update → update attributes, text, props
• Ref → update or clear refs

These map directly to browser APIs:
appendChild, insertBefore, removeChild, setAttribute, nodeValue, etc.

Browser does NOT paint during this.
Commit is synchronous and uninterruptible.

Conceptually: “React performs the minimal set of DOM changes needed for the new UI.”

────────────────────────────────────────────────────────────────────────
5. Commit Phase – Layout Effects (useLayoutEffect)
────────────────────────────────────────────────────────────────────────

After DOM mutations but before paint:
• React runs all useLayoutEffect setup callbacks.
• These may read layout, measure DOM, adjust layout synchronously.
• They block paint until complete.

Conceptually: “DOM is final; layout effects run before pixels update.”

────────────────────────────────────────────────────────────────────────
6. Fiber Tree Swap (React Finishes)
────────────────────────────────────────────────────────────────────────

React swaps:
current ← workInProgress

• The new UI tree becomes “current.”
• The previous tree becomes the alternate for the next update.

React is now done. From here on, it’s all browser behavior.

Conceptually: “React has produced and committed the new UI.”

────────────────────────────────────────────────────────────────────────
7. Browser Event Loop (Before Frame Render)
────────────────────────────────────────────────────────────────────────

The browser will not paint until the JS call stack is empty.

Ordering:
1. Synchronous JS (React commit + layout effects)
2. Then microtasks:
– Promise callbacks
– queueMicrotask
– MutationObserver
3. Then macrotasks:
– setTimeout
– setInterval
– MessageChannel
– events

Only after all JS work completes can the browser proceed to render.

Conceptually: “Browser waits for JavaScript to finish before updating pixels.”

────────────────────────────────────────────────────────────────────────
8. Browser Rendering Pipeline (The Actual Paint Path)
────────────────────────────────────────────────────────────────────────

Once the event loop allows rendering, the browser executes the full pipeline:

1. Style Recalculation
– CSS selectors match DOM.
– Browser computes final computed styles.

2. Layout (Reflow)
– Browser determines geometry and position of every element.
– Runs top-down from the layout root.

3. Paint
– Browser generates paint commands.
– Rasterizes pixels into layers.

4. Compositing
– Layers are merged together by the GPU.
– Handles transforms, opacity, z-index, stacking contexts.

5. Display
– Final composited frame is pushed to the screen.

This is when the user finally sees the updated UI.

Conceptually: “Browser converts DOM + styles into pixels on screen.”

────────────────────────────────────────────────────────────────────────
9. Passive Effects (useEffect) – Post-Paint
────────────────────────────────────────────────────────────────────────

After paint:
• React runs all useEffect callbacks asynchronously.
• These do not block rendering.
• Ideal for async work, logging, subscriptions, or DOM listeners.

Conceptually: “All nondeterministic, non-visual side effects run after the frame.”

────────────────────────────────────────────────────────────────────────
10. rAF, Idle Time, and Browser Scheduling Windows
────────────────────────────────────────────────────────────────────────

During the frame boundary and idle windows:

• requestAnimationFrame:
– Runs before the next paint.
– Perfect for animations and per-frame DOM reads/writes.

• requestIdleCallback:
– Runs during idle periods.
– Used for low-priority work, cleanup, caching, prefetching.

• Observers:
– IntersectionObserver
– ResizeObserver
– run after layout/paint cycles as needed.

Conceptually: “Browser exposes timing hooks for animation and background work.”

────────────────────────────────────────────────────────────────────────
Summary (Full Pipeline Flow)
────────────────────────────────────────────────────────────────────────

1. React schedules update (lanes).
2. Fiber render phase (compute next UI, build WIP tree, diff incrementally).
3. Pre-commit (cleanup + ref prep).
4. Commit mutations (DOM updates).
5. Commit layout effects (layout-sensitive code).
6. React swaps fiber trees (React is done).
7. Event loop clears JS work.
8. Browser pipeline:
• Style → Layout → Paint → Composite → Display.
9. Passive effects (useEffect) run after paint.
10. rAF and idle tasks execute between frames.

This is the complete, high-level system pipeline from React update → browser paint.
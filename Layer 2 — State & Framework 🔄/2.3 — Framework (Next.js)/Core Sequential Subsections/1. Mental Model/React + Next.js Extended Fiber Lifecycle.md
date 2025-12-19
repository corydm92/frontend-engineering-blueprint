React + Next.js Extended Fiber Lifecycle
(From server render to client hydration and beyond)

????????????????????????????

0. PURPOSE + REACT/NEXT RELATIONSHIP
????????????????????????????


Next.js is the runtime coordinator, React is the renderer.

´ On the server:
- Next.js owns routing, data fetching, and determines when to call ReactÍs render engine.
- React executes the render phase for all components (Server + Client boundaries).
- Output: HTML + serialized RSC payload (component structure + props).

´ On the client:
- The browser runs React (react + react-dom) and a small Next.js router runtime.
- This router runtime:
´ Boots hydration by calling ReactDOM.hydrateRoot().
´ Intercepts <Link> clicks.
´ Requests new RSC payloads from the server when navigating.
´ Hands those payloads to React to merge into the active Fiber tree.

Next.js (full framework) never runs in the browser.
The browser only runs React and a lightweight router bridge.
React runs in both environments:
Server ? render-only phase.
Client ? hydration, commit, and all future renders.

????????????????????????????

1. SERVER INITIALIZATION PHASE
????????????????????????????


Location: Server (Node or Edge runtime)

1. An HTTP request (or build step) triggers a route.
2. Next.js creates a React element tree for that route.
- Server Components execute (can access DB, secrets, APIs).
- Client Components are replaced with lightweight placeholders (boundary IDs + props).
3. React runs its render phase only:
- React Fiber walks the tree, evaluating components.
- No DOM operations „ produces HTML strings + RSC payload describing the element graph.
4. Next.js streams the response:
- HTML chunks first (for early paint).
- Then RSC payload chunks (JSON-like serialized data for React).

????????????????????????????

2. BROWSER PARSE & DEPENDENCY LOAD PHASE
????????????????????????????


Location: Browser

1. Browser receives the HTML stream.
- Parses incrementally.
- Builds DOM and paints progressively.
2. Encounters <script> tags and begins loading JS bundles:
- React and ReactDOM.
- Your compiled app code.
- The tiny Next.js router runtime.
3. Scripts download in parallel but execute sequentially in DOM order.
4. When the bundles finish, ReactDOM.hydrateRoot is available.
5. The small Next.js client bootstrap runs automatically at the end of the HTML,
calling ReactDOM.hydrateRoot(document.getElementById("__next"), <App />).

????????????????????????????

3. CLIENT HYDRATION ENTRY
????????????????????????????


Location: Browser
Trigger: Next.js bootstrap script

Sequence:

1. hydrateRoot() is a React API call, initiated by Next.js client bootstrap.
This starts the React runtime in hydration mode.

2. React locates the serialized RSC payload:
- Either embedded in a <script id="__NEXT_DATA__"> tag.
- Or streamed via a network channel.

3. React deserializes the payload into an in-memory virtual element tree:
- Each entry contains component type, props, key, and boundary ID.
- React reconstructs what the server already rendered, purely in memory.

4. At this stage, React has not touched the DOM yet.
It has built the virtual tree that mirrors what the server output should be.

????????????????????????????

4. HYDRATION RENDER PHASE (Fiber Reconstruction)
????????????????????????????


Location: Browser (React runtime)

1. React creates Fiber nodes for each element in the virtual tree.
Each Fiber holds the component type, props, and a slot for a DOM node reference.

2. React simultaneously walks two trees:
- The virtual element tree (expected structure, in memory).
- The real DOM tree (painted by the browser from server HTML).

The hydration algorithm advances DOM pointers as it traverses the virtual tree,
matching by tagName, key, and sibling order.

3. When a DOM node matches the expected element:
? React ñclaimsî that DOM node
(fiber.stateNode = that DOM element; no DOM creation).
When it doesnÍt match:
? React marks that subtree dirty and schedules re-render (will rebuild later).

4. Result:
React builds a Fiber graph in memory where every Fiber now references
its real, already-existing DOM node.

Think of this as React stitching its virtual model around the DOM that already exists.

????????????????????????????

5. HYDRATION COMMIT PHASE (Attaching Behavior)
????????????????????????????


Location: Browser (React runtime)

Once the Fiber tree mirrors the DOM (1:1 linkage established):

1. React runs the commit phase:
- Attaches event listeners (click, input, etc.) to claimed DOM nodes.
- Runs useLayoutEffect callbacks.
- Initializes local state for client components.

2. The DOM referenced here is the real browser DOM built from server HTML.
React doesnÍt re-render it „ it attaches behavior and ownership.

3. After the next paint tick:
- React runs useEffect callbacks (passive effects).

At this point, hydration is complete:
React now fully controls the DOM and can perform updates normally.

????????????????????????????

6. CLIENT NAVIGATION VIA <Link />
????????????????????????????


Steps 1<ETH>3: Server work
Steps 4<ETH>6: Client work

1. User clicks a <Link /> in the browser.
- The Next.js router intercepts the click (no full reload).

2. The router fetches the new routeÍs RSC stream from the Next.js server.

3. The server:
- Runs a new React render phase for the target route.
- Produces a new serialized RSC payload (component structure + props).
- Streams that payload to the client.

4. The client React runtime receives the new payload:
- Deserializes it into a new virtual element tree.
- Compares that new tree with the current Fiber tree (the one already mounted).

5. React performs a reconciliation:
- Fibers missing in the new tree ? unmount (cleanup, remove DOM nodes).
- Fibers that still exist (like layouts) ? kept alive.
- New Fibers ? mount (create or hydrate new DOM nodes as needed).

6. React runs the commit phase for any added/changed components:
- Applies DOM changes, attaches listeners, runs effects.

Result:
The DOM updates in place „ no reload.
The server only provided data; the browser performed all updates.

????????????????????????????

7. HOW THE RSC PAYLOAD MAPS TO FIBERS
????????????????????????????


The RSC payload is a serialized description of the React element tree.
Each entry includes:
- Component type (via module ID)
- Props (serialized)
- Key
- Boundary markers for client hydration zones

During hydration:
- React deserializes payload ? creates element objects.
- For each element ? creates Fiber node ? links to DOM node if it exists.

Difference from CSR:
- CSR executes component functions to create elements.
- RSC hydration reads elements from payload (precomputed by server).
- Both result in the same Fiber graph structure in memory.

????????????????????????????

8. FULL LOOP COMPARISON
????????????????????????????


Pure CSR:
render ? diff ? commit ? effect ? repeat.

Next.js RSC:
server render (no commit)
? serialize to RSC stream
? browser parse + paint
? hydrate render (rebuild Fiber graph)
? commit (attach behavior)
? effects
? normal client Fiber loop resumes
? navigation: fetch new RSC ? reconcile ? commit ? effects

Hydration simply replaces the first client-side render with reconstruction
based on server-provided data.

????????????????????????????

9. CONTINUOUS PIPELINE SUMMARY (LOOPED FLOW EXAMPLE)
????????????????????????????


A. INITIAL LOAD LOOP
1. Server: React render ? serialize ? stream HTML + RSC payload.
2. Browser: parse + paint ? load bundles.
3. React (client): hydrate render ? link fibers to DOM.
4. React: commit ? attach behavior.
5. React: effects ? app live.
6. Fiber lifecycle continues for local state updates.

B. CLIENT NAVIGATION LOOP (to a route with new client component)
1. User click ? Next router intercepts.
2. Router fetches RSC stream for new route.
3. Server: executes React render ? produces new serialized tree.
4. Client: receives payload ? React begins render phase again (virtual tree build).
5. React: diffs new elements vs existing Fiber tree.
- Missing ? unmount (cleanup + DOM removal)
- Persistent ? reuse
- New ? mount (hydrate or create DOM)
6. React: commit phase ? apply DOM ops + attach listeners.
7. React: effect phase ? run hooks.
8. Back to idle Fiber loop until next update or navigation.

C. CLIENT STATE UPDATE LOOP (no server)
1. setState() schedules update.
2. React: render ? diff ? commit ? effects (local only).

All flows converge on the same React core pattern:
Render ? Reconcile ? Commit ? Effect.

????????????????????????????

10. WHY THIS MATTERS
????????????????????????????


´ Next.js runs only on the server (routing + RSC rendering).
´ The browser runs React + a minimal router runtime.
´ The RSC payload bridges both environments.
´ Hydration is a special render phase that links virtual tree ? real DOM.
´ After hydration, the normal React Fiber lifecycle continues.
´ Client navigation or state updates simply restart the loop at the render phase,
whether new data originates from the server (RSC) or from local state.

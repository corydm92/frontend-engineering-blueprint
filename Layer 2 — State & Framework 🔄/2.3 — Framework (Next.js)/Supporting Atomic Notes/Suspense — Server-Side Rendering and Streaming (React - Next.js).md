Suspense „ Server-Side Rendering and Streaming (React / Next.js)


Go
al

Understand how Suspense behaves during server-side rendering, how it enables streaming, and how this differs from client-only Suspense behavior.


What Server-Side Suspense Is Used For

On the server, Suspense does not show spinners.
It controls:
- what HTML is sent immediately
- what HTML is deferred
- how rendering is streamed to the client

Suspense boundaries become streaming boundaries.


High-Level SSR Behavior

During server rendering:
- React renders the tree top-down
- If a Suspense boundary suspends:
- React emits fallback HTML for that boundary
- continues rendering other parts of the tree
- Completed sections are streamed to the client as they finish

Rendering does not block the entire page.


Example Mental Structure

<Suspense fallback={<SidebarSkeleton />}>
<Sidebar />
</Suspense>

<Suspense fallback={<PostsSkeleton />}>
<Posts />
</Suspense>

Server behavior:
- shell HTML is sent immediately
- Sidebar and Posts render independently
- whichever resolves first streams first


SSR with Data Fetching

When a server component or data dependency suspends:
- React pauses rendering of that subtree
- fallback HTML may be streamed
- resolved content streams later

The client receives:
- initial HTML
- followed by streamed patches
- hydration attaches to each boundary independently


SSR and Code Splitting

On the server:
- React knows which chunks are needed
- chunk references are embedded in the HTML
- Suspense boundaries align with chunk boundaries

On the client:
- required chunks load
- Suspense boundaries hydrate when ready


Critical Difference: SPA vs SSR

Client-only rendering:
- Suspense shows fallback UI while waiting
- rendering blocks until dependencies resolve

Server-side rendering:
- Suspense controls streaming order
- fallback may never be visible to the user
- UI appears progressively as HTML arrives


Suspense in Next.js (Conceptual)

Next.js uses Suspense to:
- stream route segments
- defer slow server components
- coordinate server and client boundaries

Suspense boundaries define:
- HTML streaming chunks
- hydration boundaries
- loading UI placement


What Server-Side Suspense Is Not

Suspense on the server is not:
- a loading spinner mechanism
- a fetch API
- a client-only UX tool

It is a server rendering orchestration primitive.


Key Invariants (Server)

- Suspense boundaries define streaming boundaries
- server rendering can continue past suspended subtrees
- HTML is streamed progressively
- hydration occurs per boundary
- transitions can still influence fallback behavior


One-Line Mental Model

Server-side Suspense decides what HTML is sent now versus later.
It is about streaming, not waiting.

Advanced Transition: Integration with use() and Suspense

Goal

Understand how startTransition, use(), and Suspense interact, and why a state update wrapped in a transition can suspend without showing a fallback even though data fetching happens later during render.

Core Concepts

1. startTransition marks state updates, not execution

startTransition does not:
- create an async scope
- await anything
- track promises

startTransition does exactly one thing:
It marks state updates as non-urgent (transition priority).

2. use() does not run async work

use():
- inspects a value during render
- if given a pending promise, it throws to suspend
- does not initiate fetching
- does not cache

Any fetching must already be running and cached elsewhere.

3. Suspense reacts to render priority

Suspense always asks:
Did something suspend?

Transitions add a second question:
Is this render urgent or can it wait?

That answer determines whether the fallback is shown.

Step-by-Step Execution Flow

Step 1: User interaction triggers a state update

Without transition (urgent update)

<button onClick={() => setTab('posts')}>
Posts
</button>

setTab is urgent and React must commit immediately.

With transition (non-urgent update)

const [isPending, startTransition] = useTransition();

<button
onClick={() => {
startTransition(() => {
setTab('posts');
});
}}
>
Posts
</button>

setTab is marked as transition work and React may delay committing the result.

Step 2: React schedules a render

After setTab('posts'), React schedules a render where:

{tab === 'posts' && <PostsTab />}

This render inherits the priority of the state update.
Nothing inside PostsTab needs to be aware of transitions.

Step 3: PostsTab renders and suspends

function PostsTab() {
const posts = use(fetchData('/posts'));
return <Posts posts={posts} />
}

Execution:
1. fetchData('/posts') returns a cached promise
2. the promise is pending on first render
3. use(promise) throws
4. rendering suspends

The Critical Divergence

Case A: Urgent render (no transition)

<Suspense fallback={<h1>Loading...</h1>}>
<PostsTab />
</Suspense>

- React must commit immediately
- New UI is incomplete
- Suspense fallback is rendered

Result:
Loading UI appears

Case B: Transition render

- React is allowed to delay committing
- Previous UI remains visible
- Suspense fallback is not shown
- isPending becomes true

Result:
Old content stays until new content is ready

Why This Works Without Explicit Wiring

PostsTab, use(), and fetchData are not aware of transitions.
They do not need to be.

Render priority is decided when the update is scheduled, not during execution.
Everything caused by that state update inherits the transition priority automatically.

Key Invariants

- startTransition marks state updates, not code blocks
- render priority propagates through the entire render tree
- use() suspends by throwing during render
- Suspense fallback appears only for urgent renders
- transition renders may suspend without showing fallback
- previous UI remains visible until new UI is ready

One-Line Mental Model

Transitions do not make data faster.
They make incomplete UI optional.
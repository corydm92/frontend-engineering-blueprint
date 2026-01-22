useTransition()
Ex: search input driving a slow list

Mark state updates as non-urgent so React can keep the UI responsive while deferring expensive renders

1. Goal

Understand how useTransition() works end-to-end:
- how React schedules updates internally
- how lanes determine priority and interruption
- what useTransition() actually marks
- how async work and await behave
- what is guaranteed vs explicitly not guaranteed

This note is mechanical, not ergonomic.

2. The Big Picture: How React Decides What Runs

React does not run updates immediately.
It schedules work using a cooperative scheduler.

Every state update is assigned to a lane.

A lane represents:
- priority
- interruptibility
- restart and abandonment rules
- commit timing

Hooks like useTransition() influence which lane React chooses.

3. The Three Lane Classes (Scheduler Reality)

3.1 Sync Lanes (Urgent / Discrete)

Used for:
- clicks
- key presses
- text input
- imperative updates

Properties:
- highest priority
- cannot be interrupted
- render and commit immediately
- block paint until finished

Mental model:
The user is actively interacting. Finish this now.

3.2 Transition Lanes (Non-Urgent, Interruptible)

Used when updates are wrapped in startTransition().

Properties:
- lower priority than Sync lanes
- interruptible by Sync updates
- render work can be paused, restarted, or discarded
- commit happens only if rendering completes uninterrupted

Mental model:
This update matters, but responsiveness matters more.

3.3 Idle Lanes (Background / Best-Effort)

Used for:
- offscreen work
- speculative or prefetch behavior

Properties:
- lowest priority
- starved until nothing else is pending
- may never run under sustained interaction

Mental model:
Only do this if nothing else is happening.

4. Where useTransition() Fits

useTransition() does exactly one thing:
It causes state updates to be scheduled in Transition lanes instead of Sync lanes.

It does not:
- delay execution
- debounce
- batch commits manually
- guarantee completion
- track promises
- make code async

5. What useTransition() Is

useTransition is a Hook that lets you render part of the UI in the background
by marking state updates as non-blocking Transitions.

const [isPending, startTransition] = useTransition();

It returns:
- isPending: whether there is at least one pending Transition
- startTransition: a function that marks updates as a Transition

6. startTransition(action): What React Actually Marks

startTransition(() => {
setState(next);
});

React behavior:
1. Calls the action immediately
2. While the action executes synchronously:
- any state updates are tagged with a Transition lane
3. The scheduler decides:
- when to render
- whether to pause
- whether to restart
- whether to abandon the render

Only updates scheduled synchronously during the action are marked.

7. Render vs Commit (Why Transitions Can Restart)

React work happens in two phases:

Render phase:
- pure computation
- may run multiple times
- may be paused or discarded
- produces a work-in-progress tree

Commit phase:
- applies changes to the DOM
- runs effects
- happens once, or not at all

Transition renders may restart many times.
Commit happens only if rendering completes uninterrupted.

8. isPending: What It Means

isPending === true means:
- at least one Transition lane update exists
- it has not yet committed

It does not mean:
- async work is running
- a promise is unresolved
- rendering is currently happening
- the update will finish

isPending is a scheduler signal, not a lifecycle or async signal.

9. Interruption Behavior

If a Transition update is interrupted by user input:
- the Transition render is paused or discarded
- the Sync update renders and commits
- the Transition render restarts later

This is intentional and required for correctness.

10. Async Work and the await Boundary (Critical Rule)

Lane context is synchronous.

startTransition(async () => {
await fetch(...)
setState(data) // NOT automatically a Transition
});

After await, the Transition context is lost.
State updates after await default back to Sync lanes.

11. Correct Pattern for Async + State

startTransition(async () => {
const data = await fetch(...)
startTransition(() => {
setState(data)
})
})

Async work may occur inside the action.
State updates after await must be wrapped in another startTransition().
This is a documented limitation.

12. Suspense + Transitions

If a Transition render suspends:
- the previous UI remains visible
- the fallback is delayed
- the Transition stays pending
- user input can still interrupt

Without a Transition:
- fallback shows immediately
- previous UI is replaced

Transitions preserve UI continuity across async boundaries.

13. Important Constraints

- Transition updates cannot control text inputs
- State updates in setTimeout, promises, or handlers outside startTransition
are not Transitions
- startTransition has a stable identity
- Multiple Transitions are currently batched together
- You must have access to the state setter to wrap an update
(otherwise prefer useDeferredValue)
- To start a Transition outside components/hooks,
use the standalone startTransition API

14. What useTransition() Is Not

It is not:
- an async primitive
- a promise tracker
- a performance fix
- a fairness guarantee
- a starvation prevention tool
- a replacement for memoization or virtualization

Transitions can be interrupted, restarted, abandoned, or starved.
This is by design.

15. When useTransition() Is Correct

Use it when:
- updates are derived, not fundamental
- interruption is acceptable
- UI should remain responsive
- Suspense boundaries exist
- correctness does not require immediate commit

Avoid it when:
- updates must commit synchronously
- state drives critical layout
- performance issues come from expensive computation
- correctness depends on immediacy

16. One-Sentence Final Model

useTransition() moves state updates from Sync lanes into Transition lanes,
making them non-blocking, interruptible, restartable, and discardable,
while preserving responsiveness and UI continuity.
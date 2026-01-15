useDeferredValue(sourceState)
Ex: text input feeding an expensive visualization

Create a lagging snapshot of state so expensive consumers update later without blocking urgent input


1. Goal and When to Use This Tool

useDeferredValue() is used to keep the UI responsive when a frequently changing
value would otherwise trigger expensive rendering that is not immediately
critical to user feedback.

You reach for useDeferredValue when:
- a value updates often (typing, sliders, drag interactions)
- rendering based on that value is expensive
- the UI can safely show a slightly stale result
- input responsiveness matters more than visual freshness

Typical use cases:
- search results
- large filtered lists
- expensive visualizations
- derived views that lag behind user input

You do NOT use it to:
- manage async data
- debounce business logic
- guarantee skipped renders
- enforce correctness or ordering

This note builds in order:
mental model ? mechanics ? scheduling ? render vs commit ? concrete example ? gotchas.


------------------------------------------------------------

2. Mental Model

useDeferredValue() lets React lag a derived value behind its source
when the app is under rendering pressure.

Key ideas:
- deferred values are not stale state; they are a transitional view
- they represent a lower-priority view of the same data
- they may lag behind based on scheduling pressure
- renders using them may be interrupted or discarded

Think of it as:
ÒKeep the UI interactive now; update the expensive view when thereÕs time.Ó

Deferred values must always be:
- interruptible
- restartable
- discardable

Those constraints define the API.


------------------------------------------------------------

3. What useDeferredValue() Is

useDeferredValue() is a React Hook that derives a low-priority version
of a value.

Signature:

const deferredValue = useDeferredValue(value);

Where:
- value is the urgent source value
- deferredValue is a lagging, deprioritized view of that value

Important:
useDeferredValue does NOT introduce async state, timers, queues, or promises.
It only influences render priority.


------------------------------------------------------------

4. What useDeferredValue() Actually Does

On each update, React may:

- render urgently using the previous deferredValue
- speculatively render a new deferredValue
- abandon that render before committing
- reuse the previous committed output

There is NO guarantee that:
- a deferred render will commit
- intermediate values will appear
- execution will be skipped

The only guarantee is correctness of committed UI.


------------------------------------------------------------

5. Deferred Values and Scheduling

useDeferredValue() assigns a lower-priority lane to renders
that depend on the deferred value.

That means:
- urgent updates (typing, clicking) are not blocked
- background renders may be paused or dropped
- React may restart work multiple times

Deferred rendering is opportunistic, not guaranteed.


------------------------------------------------------------

6. Core Example: Deferred Rendering with Speculative Execution

This example demonstrates the key behavior:
render execution can happen even when commits do not.

App component:

import { useState, useDeferredValue } from 'react';
import SlowList from './SlowList.js';

export default function App() {
const [text, setText] = useState('');
const deferredText = useDeferredValue(text);

return (
<>
<input
value={text}
onChange={e => setText(e.target.value)}
/>
<SlowList text={deferredText} />
</>
);
}

SlowList component:

import { memo } from 'react';

const SlowList = memo(function SlowList({ text }) {
console.log('[ARTIFICIALLY SLOW] Rendering 250 <SlowItem />');

let items = [];
for (let i = 0; i < 250; i++) {
items.push(<SlowItem key={i} text={text} />);
}

return <ul>{items}</ul>
});

function SlowItem({ text }) {
let startTime = performance.now();
while (performance.now() - startTime < 1) {
// Artificial 1ms blocking work per item
}

return <li>Text: {text}</li>
}

export default SlowList;

Observed behavior:
- on every keypress, the console log fires
- SlowList executes repeatedly
- the DOM does NOT update immediately
- the deferred value lags behind
- many renders never commit

This is expected and correct.


------------------------------------------------------------

7. Render vs Commit: The Critical Distinction

With useDeferredValue():

- render functions may execute
- console logs may fire
- hooks may run
- work may be abandoned
- no DOM updates occur

Render execution does NOT imply commit.

React is allowed to discard rendered work.


------------------------------------------------------------

8. Why React.memo Does NOT Prevent This

React.memo:
- allows reuse of previously committed output
- does NOT guarantee skipping render execution

In the example:
- props may be referentially equal
- React may still execute SlowList
- then reuse the previous commit
- discarding the new work

Memo optimizes commits, not execution.


------------------------------------------------------------

9. Broken Mental Model: ÒDeferred Means It WonÕt RunÓ

Incorrect assumptions:
- deferred components wonÕt render
- memo prevents execution
- logs indicate committed UI

Why this is wrong:
- React must evaluate work to decide whether to keep it
- speculative rendering is fundamental to concurrency
- logs observe speculation, not reality


------------------------------------------------------------

10. Blocking Render Work Limits Deferred Benefits

In the example:
- SlowItem blocks synchronously
- individual function executions cannot be interrupted mid-call
- useDeferredValue only helps at scheduling boundaries

Deferred rendering works best when:
- work is split into smaller units
- React can yield between them


------------------------------------------------------------

11. When useDeferredValue() Is the Wrong Tool

Do NOT use useDeferredValue() for:
- data fetching
- state synchronization
- correctness-critical logic
- replacing debouncing or throttling
- preventing renders entirely

It is a UX optimization only.


------------------------------------------------------------

12. What useDeferredValue() Is Not

useDeferredValue() is not:
- async state
- a timer
- a Promise
- memoization
- a guarantee of skipped execution

It is a render-priority hint.


------------------------------------------------------------

13. One-Sentence Summary

useDeferredValue() allows React to deprioritize and speculatively render
expensive UI using a lagging value; render functions may execute repeatedly,
but commits are deferred or skipped to preserve responsiveness.

useOptimistic(baseState, reducer)
Ex: submitting a form with immediate UI feedback

Render speculative state immediately while async work is in flight, then reconcile with the committed result


1. Goal

Understand what useOptimistic() does, why it exists, and how to use it correctly
under concurrent rendering without misinterpreting optimistic behavior as bugs.

This note builds in order:
mental model ? mechanics ? transitions ? patterns ? convergence.


------------------------------------------------------------

2. Mental Model

useOptimistic() lets the UI display a temporary, speculative version of state
while an async action is in progress.

Key ideas:
- optimistic updates represent intent, not results
- they are temporary
- they may be replayed
- they may be discarded

Think of it as:
ñShow what we expect to happen, but donÍt commit to it yet.î

Optimistic state must always be:
- interruptible
- restart-safe
- discardable

Those constraints define the API.


------------------------------------------------------------

3. What useOptimistic() Is

useOptimistic() is a React Hook that derives an optimistic view of state
from a committed base state.

Signature:

const [optimisticState, addOptimistic] = useOptimistic(
baseState,
reducer
);

Where:
- baseState is the committed source of truth
- reducer describes how optimistic intent is applied
- optimisticState is what the UI renders
- addOptimistic records speculative intent

Important:
useOptimistic never mutates baseState.


------------------------------------------------------------

4. What useOptimistic() Actually Does

On every render, React computes:

optimisticState =
baseState
+ replayed optimistic updates

Properties:
- optimistic updates are replayed in order
- replay happens on every render
- baseState is always read fresh
- no deduplication occurs
- no identity reconciliation occurs

When async work completes:
- baseState updates
- optimistic overlays may still be replayed
- overlays disappear only when no longer relevant


------------------------------------------------------------

5. Why Optimistic Updates Must Run in Transitions

Optimistic updates are:
- speculative
- non-urgent
- allowed to be interrupted
- allowed to be discarded

Therefore, they must run in Transition lanes.

Calling addOptimistic synchronously would:
- block urgent updates
- prevent interruption
- violate ReactÍs scheduling model


------------------------------------------------------------

6. Broken Pattern: Calling addOptimistic Outside startTransition

function BrokenExample() {
const [items, setItems] = useState([]);

const [optimisticItems, addOptimistic] = useOptimistic(
items,
(state, newItem) => [...state, newItem]
);

function addItem(item) {
addOptimistic(item); // ? invalid
}

return (
<>
<button onClick={() => addItem({ id: 1, text: "Hello" })}>
Add
</button>
<ul>
{optimisticItems.map(item => (
<li key={item.id}>{item.text}</li>
))}
</ul>
</>
);
}

Why this is invalid:
- optimistic updates are not urgent
- React must be able to interrupt or discard them
- sync lanes are not allowed here


------------------------------------------------------------

7. Correct Pattern: addOptimistic Inside startTransition

function CorrectExample() {
const [items, setItems] = useState([]);

const [optimisticItems, addOptimistic] = useOptimistic(
items,
(state, newItem) => [...state, newItem]
);

const [isPending, startTransition] = useTransition();

function addItem(item) {
startTransition(() => {
addOptimistic(item);
});
}

return (
<>
<button onClick={() => addItem({ id: 1, text: "Hello" })}>
Add
</button>
<ul>
{optimisticItems.map(item => (
<li key={item.id}>{item.text}</li>
))}
</ul>
</>
);
}

Why this works:
- optimistic update is non-blocking
- React may interrupt or restart it
- UI stays responsive
- rollback is safe


------------------------------------------------------------

8. Progressive Example: Optimistic List with Async Commit

function List() {
const [input, setInput] = useState("");
const [items, setItems] = useState([]);

const [optimisticItems, addOptimistic] = useOptimistic(
items,
(state, newItem) => [...state, newItem]
);

const [isPending, startTransition] = useTransition();

function addItem() {
const id = Date.now();

startTransition(async () => {
addOptimistic({
id,
text: `${input} (Loading...)`,
});

await submitItemToServer({
id,
text: input,
});
});
}

async function submitItemToServer(item) {
await new Promise(res => setTimeout(res, 2000));
setItems(prev => [...prev, item]);
}

return (
<>
<ul>
{optimisticItems.map(item => (
<li key={item.id}>{item.text}</li>
))}
</ul>

<input onChange={e => setInput(e.target.value)} />
<button onClick={addItem}>Add</button>
</>
);
}


------------------------------------------------------------

9. Why Form Actions Do NOT Need startTransition

Form actions are special.

When using:
- <form action={action}>
- server / form action APIs

React automatically schedules them as Transitions.

That means:
- updates inside form actions already run in transition lanes
- optimistic updates are interruptible by default
- manual startTransition is unnecessary


------------------------------------------------------------

10. Same Example Using a Form Action

function ListWithForm() {
const [items, setItems] = useState([]);

const [optimisticItems, addOptimistic] = useOptimistic(
items,
(state, newItem) => [...state, newItem]
);

async function submitItemToServer(item) {
await new Promise(res => setTimeout(res, 2000));
setItems(prev => [...prev, item]);
}

async function action(formData) {
const text = formData.get("text");
const id = Date.now();

addOptimistic({
id,
text: `${text} (Loading...)`,
});

await submitItemToServer({ id, text });
}

return (
<form action={action}>
<ul>
{optimisticItems.map(item => (
<li key={item.id}>{item.text}</li>
))}
</ul>

<input name="text" />
<button type="submit">Add</button>
</form>
);
}


------------------------------------------------------------

11. The Core Gotcha: Identity and Convergence

useOptimistic replays intent.
It does NOT reconcile identity.

If optimistic and committed data share identity and appear in the same render,
both will be rendered.

That violates ReactÍs key contract.


------------------------------------------------------------

Problem: Duplicate Identity in One Render

function List() {
const [items, setItems] = useState([]);

const [optimisticItems, addOptimistic] = useOptimistic(
items,
(state, item) => [...state, item]
);

const [_, startTransition] = useTransition();

function add() {
const id = 1;

startTransition(async () => {
addOptimistic({ id, text: "Hello (Loading...)" });
await Promise.resolve();
setItems([{ id, text: "Hello" }]);
});
}

return optimisticItems.map(i => (
<div key={i.id}>{i.text}</div>
));
}

During a render, React sees:

[
{ id: 1, text: "Hello" },
{ id: 1, text: "Hello (Loading...)" }
]

Result:
- duplicate keys
- React warning
- undefined reconciliation behavior

This is expected.


------------------------------------------------------------

Solution A: Explicit Identity Convergence

Force optimistic intent to replace committed identity.

const [optimisticItems, addOptimistic] = useOptimistic(
items,
(state, item) =>
state.some(i => i.id === item.id)
? state.map(i => (i.id === item.id ? item : i))
: [...state, item]
);

Why this works:
- one item per identity
- optimistic overlay replaces committed data
- React reconciliation is stable


------------------------------------------------------------

Solution B (Docs Pattern): Avoid Identity Until Commit

Do not assign stable identity during optimism, rather use the index instead of a value of the object itself.

function List() {
const [items, setItems] = useState([]);

const [optimisticItems, addOptimistic] = useOptimistic(
items,
(state, text) => [
{ text, sending: true },
...state,
]
);

async function action(formData) {
const text = formData.get("text");

addOptimistic(text);
await Promise.resolve();
setItems(prev => [{ text }, ...prev]);
}

return optimisticItems.map((item, index) => (
<div key={index}>
{item.text}
{item.sending && " (Sending...)"}
</div>
));
}

Why this works:
- optimistic entries have no real identity yet
- index represents temporal intent
- committed data becomes authoritative
- no identity collision occurs


------------------------------------------------------------

12. Convergence Is Explicitly Your Responsibility

React guarantees:
- interruption safety
- replay correctness
- scheduling guarantees

You must guarantee:
- identity correctness
- convergence rules
- key uniqueness per render

React will not infer intent.


------------------------------------------------------------

13. What useOptimistic() Is Not

useOptimistic() is not:
- a replacement for useState
- a server cache
- a mutation API
- an identity manager

It only replays speculative UI intent.


------------------------------------------------------------

14. One-Sentence Summary

useOptimistic replays speculative intent on top of committed state; transitions make it interruptible, but identity and convergence are explicitly the applicationÍs responsibility.

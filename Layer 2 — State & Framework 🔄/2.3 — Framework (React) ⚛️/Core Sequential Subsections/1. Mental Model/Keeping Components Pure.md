Keeping Components Pure

1. Mental Model

A pure component behaves like a pure function: same inputs ? same output, no side effects.
React relies on this purity to reason about rendering, batching, and optimization.
When a componentÍs output depends only on its props, state, and context„and never mutates them„it becomes predictable and efficient.

An impure component, on the other hand, reads or writes external data during render or mutates input objects, making behavior unpredictable across renders.

------------------------------------------------------------

2. Purity in Rendering

ReactÍs rendering phase must be free of side effects.
During render:
- React may call a component multiple times.
- It may interrupt or discard renders for performance or concurrent updates.

If a component modifies external variables or performs side effects during render, ReactÍs reconciliation can break.

Pure render:
- Reads inputs (props/state/context) only.
- Returns JSX deterministically.
- Has no observable side effects.

Impure render:
- Writes to global variables.
- Mutates props/state.
- Triggers effects like network requests or logging.

------------------------------------------------------------

3. Example: Impure Component Mutating Props

function Greeting({ user }) {
user.name = user.name.toUpperCase(); //
?
Mutation during render
return <h1>Hello, {user.name}</h1>
}

Step-by-Step Timeline:
1. Parent passes user = { name: "Cory" }.
2. Greeting mutates it to { name: "CORY" }.
3. Parent re-renders later, expecting user.name === "Cory".
4. ReactÍs render output now diverges from expected state.

Fix:
function Greeting({ user }) {
const upperName = user.name.toUpperCase(); //
?
No mutation
return <h1>Hello, {upperName}</h1>
}

------------------------------------------------------------

4. Side Effects Belong in Effects or Handlers

Side effects (network calls, DOM changes, timers, logs) must not happen during render.

?
Wrong:
function Dashboard() {
fetch('/api/data'); // runs on every render
return <div>Loading...</div>
}

?
Correct:
function Dashboard() {
useEffect(() => {
fetch('/api/data');
}, []);
return <div>Loading...</div>
}

Reason:
React may render components multiple times before committing. Running effects in render leads to duplicate requests or inconsistent state.

------------------------------------------------------------

5. Event Handlers Are Safe for Mutations

ReactÍs render phase is pure, but event handlers are safe for mutations„they only run after React commits updates.

Example:
function Counter() {
const [count, setCount] = useState(0);

function handleClick() {
setCount(count + 1); //
?
Safe, runs after commit
}

return <button onClick={handleClick}>{count}</button>
}

------------------------------------------------------------

6. Common Sources of Impurity

- Mutating props or state directly.
- Modifying arrays/objects without creating new copies.
- Making network requests during render.
- Logging or reading external data inside render.
- Manually updating the DOM (bypassing React).

------------------------------------------------------------

7. Ensuring Purity

- Treat props, state, and context as immutable.
- Use `useEffect` for side effects.
- Clone or spread objects when updating: `{ ...oldObj, key: value }`.
- Avoid touching globals or browser APIs in render.
- Keep render functions deterministic.

------------------------------------------------------------

8. Example: State Mutation Causing UI Bugs

function TodoList() {
const [todos, setTodos] = useState([{ id: 1, text: "Learn React" }]);

function addTodo() {
todos.push({ id: 2, text: "Stay pure" }); //
?
Mutates state directly
setTodos(todos); // Same reference ? React skips render
}

return (
<>
<ul>{todos.map((t) => <li key={t.id}>{t.text}</li>)}</ul>
<button onClick={addTodo}>Add</button>
</>
);
}

Fix:
function TodoList() {
const [todos, setTodos] = useState([{ id: 1, text: "Learn React" }]);

function addTodo() {
setTodos([...todos, { id: 2, text: "Stay pure" }]); //
?
Creates new reference
}

return (
<>
<ul>{todos.map((t) => <li key={t.id}>{t.text}</li>)}</ul>
<button onClick={addTodo}>Add</button>
</>
);
}

------------------------------------------------------------

9. Mental Trick „ Think Like a Math Function

A React component is like f(x):
- Input: props, state, context.
- Output: JSX.
- No side effects during execution.

When React re-renders, it just calls f(x) again with possibly new inputs.
If the component is pure, re-rendering is safe, predictable, and free of surprises.

------------------------------------------------------------

10. Key Takeaways

- Pure components always return the same output for the same inputs.
- Never mutate props, state, or context during render.
- Never trigger side effects in render„use effects or handlers instead.
- Impure components can cause inconsistent state, double fetches, or skipped re-renders.
- Keeping components pure ensures React can safely optimize and schedule rendering.

------------------------------------------------------------

11. One-liner summary

Pure components make React predictable and fast„impure components break its guarantees.

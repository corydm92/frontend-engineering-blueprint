setState vs Functional Updates in React

1. Direct setState(value)

Use when the new state does NOT depend on the previous state.
YouÍre replacing state with a known or external value.

Examples:
setCount(5);
setTheme("dark");
setUser({ name: "Cory" });

Behavior:
- React replaces the old state with the new value.
- Ideal for overwriting state or updating from external sources (API, props, user input).

? Use when:
- Resetting or overwriting to a fixed value.
- The new value comes directly from props or fetched data.
- The value does not rely on what the old state was.

------------------------------------------------------------

2. Functional Update Form „ setState(prev => newValue)

Use when the new state depends on the previous state.
React guarantees that "prev" will be the latest committed value, even across batched updates.

Examples:
setCount(prev => prev + 1);
setTodos(prev => [...prev, newTodo]);
setForm(prev => ({ ...prev, email: value }));

Behavior:
- Prevents stale closures.
- Each update uses the latest version of state.
- Ensures correctness under ReactÍs batched updates.

------------------------------------------------------------

3. Incorrect vs Correct Example

Incorrect (stale closure):
setCount(count + 1);
setCount(count + 1);

If count = 0, final result = 1 because both read the same old value.

Correct (functional form):
setCount(prev => prev + 1);
setCount(prev => prev + 1);

Final result = 2 because each uses the latest committed state.

------------------------------------------------------------

4. When React Batches Updates

React batches updates in:
- Event handlers
- Async callbacks (setTimeout, fetch, etc.)
- Transition or concurrent rendering

If you use direct setState with a stale variable, earlier updates can be lost.
The functional form ensures updates always stack correctly.

------------------------------------------------------------

5. Real-World Example: Appending Data

Buggy:
setItems([...items, newItem]); // items may be stale if multiple updates happen quickly

Correct:
setItems(prev => [...prev, newItem]); // always merges with the latest array

------------------------------------------------------------

6. Rule of Thumb

- If the next value does not depend on the old one ? use direct form: setState(value)
- If the next value depends on the old one ? use functional form: setState(prev => newValue)
- If multiple updates can happen quickly or asynchronously ? default to functional form for safety
- If updating from props or API data ? use direct form inside useEffect

Example:
useEffect(() => {
setUser(apiUser); // direct form, updates from external data
}, [apiUser]);

------------------------------------------------------------

One-liner summary:
Use direct setState(value) for fixed updates and setState(prev => ...) when the next value depends on the previous one „ especially in batched or async updates.

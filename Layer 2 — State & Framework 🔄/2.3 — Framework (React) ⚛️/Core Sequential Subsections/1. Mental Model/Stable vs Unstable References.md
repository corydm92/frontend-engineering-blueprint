Stable vs Unstable References

1. Mental Model

React uses referential equality (===) to decide whether to re-render components or skip updates.
Every value in JavaScript „ object, array, or function „ is stored as a reference in memory.
If that reference changes between renders, React assumes the data changed and re-renders the consuming component.

There are two kinds of references:
- Stable Reference: The same memory identity is preserved across renders (refA === refB)
- Unstable Reference: A new identity is created each render (refA !== refB)

Stable references ? fewer renders and better performance.
Unstable references ? frequent re-renders even when the actual data is the same.

------------------------------------------------------------

2. React Reconciliation and Referential Equality

ReactÍs reconciliation compares the current virtual DOM tree with the previous one.
To decide whether to update, it performs shallow equality checks:
- For primitive values, equality is by value.
- For objects, arrays, and functions, equality is by reference.

If a prop or context value has a new reference, React treats it as a change:
- The component re-renders, even if the contents of the object or array are identical.
- This happens because new references fail shallow equality checks.

------------------------------------------------------------

3. Example: Unstable Function Causing Re-renders

function Parent() {
const [count, setCount] = useState(0);

const handleClick = () => setCount((c) => c + 1); // new function each render

return <Child onClick={handleClick} />
}

function Child({ onClick }) {
console.log("Child rendered");
return <button onClick={onClick}>Click</button>
}

Step-by-Step Timeline:
1. Parent renders initially ? creates a new handleClick function (refA).
2. Child receives onClick = refA ? renders.
3. setCount triggers Parent to re-render.
4. Parent creates a new handleClick function (refB).
5. Child compares old onClick (refA) with new one (refB) ? not equal.
6. Child re-renders unnecessarily, even though its UI didnÍt change.

------------------------------------------------------------

4. Stabilizing References

Stable references are created using ReactÍs memoization hooks:
- useCallback(fn, deps) ? memoizes a function reference.
- useMemo(factory, deps) ? memoizes an object, array, or computed value.

Example:
function Parent() {
const [count, setCount] = useState(0);
const handleClick = useCallback(() => setCount((c) => c + 1), []); // stable reference
return <Child onClick={handleClick} />
}

Result:
- The same handleClick reference is reused between renders.
- Child does not re-render unless other props change.

------------------------------------------------------------

5. Example: Unstable Objects in Props

function Parent() {
const [theme, setTheme] = useState("dark");
const style = { background: theme }; // new object each render
return <Child style={style} />
}

function Child({ style }) {
console.log("Child rendered");
return <div style={style}>Hello</div>
}

Even if "theme" doesnÍt change, the inline object literal recreates a new reference every render.
React sees style as a new prop ? re-renders Child unnecessarily.

Fix:
function Parent() {
const [theme, setTheme] = useState("dark");
const style = useMemo(() => ({ background: theme }), [theme]);
return <Child style={style} />
}

------------------------------------------------------------

6. Context and Stable References

When using React Context, all consumers re-render if the context value reference changes.
If a provider passes an unstable object, all children will re-render even if values inside didnÍt change.

Example:
<Context.Provider value={{ user, setUser }}> ?
New object created on every render ? all consumers re-render.

Fix:
const contextValue = useMemo(() => ({ user, setUser }), [user]);
<Context.Provider value={contextValue}> ?

------------------------------------------------------------

7. Common Sources of Unstable References

- Inline functions inside JSX (onClick={() => ...})
- Inline objects or arrays ({ foo: "bar" }, [1,2,3])
- Context providers passing new objects each render
- Effects depending on non-memoized functions
- Derived data recalculated on every render without useMemo

------------------------------------------------------------

8. Real-World Example: Derived Data

const filtered = data.filter(item => item.active);

Problem:
- Creates a new array each render.
- Any component receiving "filtered" as a prop re-renders.

Fix:
const filtered = useMemo(() => data.filter(item => item.active), [data]);

------------------------------------------------------------

9. Key Takeaways

- React re-renders based on referential equality, not deep equality.
- Objects, arrays, and functions are compared by reference, not content.
- Recreating these values in render makes them unstable, triggering extra re-renders.
- useCallback and useMemo preserve stable references between renders.
- Passing stable references down prevents wasted renders and improves performance.
- Stability is especially critical when using memoized components, React.memo, or Context.

------------------------------------------------------------

10. One-liner summary

Stable references keep React predictable and performant; unstable ones silently trigger re-renders even when nothing visually changes.

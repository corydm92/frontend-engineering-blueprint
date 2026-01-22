State Paradigms

1. UI State Machine Paradigm

Treat the user interface as a finite set of valid states. Every transition between them must be explicit and intentional.

✅
DO:
• Define discrete states (idle, loading, success, error, empty).
• Centralize transitions through reducers, actions, or state machines.
• Use enums or discriminated unions for clarity.
• Always model "what the user sees" from one source of truth.

❌
DON’T:
• Combine contradictory flags like isLoading && isError.
• Mutate multiple states independently to represent one UI mode.
• Rely on implicit conditions or timers for state.
• Let UI render impossible combinations.

💡
Example:
Bad:
const [isLoading, setIsLoading] = useState(false);
const [hasError, setHasError] = useState(false);

Good:
type UIState = 'idle' | 'loading' | 'success' | 'error';
const [uiState, setUiState] = useState<UIState>('idle');

Why it matters: Finite state modeling eliminates ambiguity. The UI never lies about what’s happening.
---

2. Event-Driven UI (Reactive Paradigm)

The UI reacts to discrete events, not manual orchestration. Events trigger transitions; components respond declaratively.

✅
DO:
• Model user and system actions as events.
• Derive new state from those events.
• Keep handlers pure—no hidden side effects.
• Use observables or subscriptions for async reactivity where needed.

❌
DON’T:
• Manually poll or mutate data in arbitrary places.
• Chain side effects inside unrelated components.
• Depend on global flags to trigger UI updates.
• Hide transitions in promises or callbacks.

💡
Example:
Bad:
onClick={() => {
setCount(count + 1);
saveCount(count + 1);
refreshUI();
}}

Good:
dispatch({ type: 'increment' });

function reducer(state, event) {
switch (event.type) {
case 'increment': return { ...state, count: state.count + 1 };
default: return state;
}
}

Why it matters: Event-driven UIs are predictable and traceable. Every change has a cause and an effect.
---

3. Unidirectional Data Flow (Flux Paradigm)

Data flows down; events bubble up. This ensures predictable propagation and controlled mutation.

✅
DO:
• Keep parent components as single sources of truth.
• Pass data down via props, context, or store selectors.
• Emit events upward through callbacks or dispatchers.
• Use reducers for mutation control.

❌
DON’T:
• Mutate child state directly from parents.
• Maintain parallel state copies across components.
• Mix two-way bindings that obscure data origin.
• Let side effects modify state outside the main loop.

💡
Example:
Bad:
<Child count={count} setCount={setCount} />

Good:
<Child count={count} onIncrement={() => dispatch({ type: 'increment' })} />

Why it matters: A single data direction simplifies reasoning, debugging, and time-travel inspection.
---

4. Single Source of Truth (State Authority Paradigm)

Every piece of data lives in exactly one authoritative location. All views derive from it.

✅
DO:
• Store canonical data centrally (store, query cache, or context).
• Compute derived state instead of duplicating values.
• Sync backend and client data through clear ownership.
• Invalidate caches, don’t overwrite data blindly.

❌
DON’T:
• Mirror the same data in multiple stores.
• Manually synchronize local copies.
• Treat props and global state as equal sources.
• Patch over desync with conditional rendering.

💡
Example:
Bad:
const [user, setUser] = useState(getUserFromCache());
const [profile, setProfile] = useState(getUserFromServer());

Good:
const user = useUser(); // one canonical query/cache
const profile = user.profile;

Why it matters: One truth prevents conflicting UI states and simplifies persistence logic.
---

5. UI as Reflection of Application State (Mirror Paradigm)

The UI is never the source of truth—it’s a visual projection of state.

✅
DO:
• Derive all visual changes from state or props.
• Control all form inputs.
• Reflect server data and loading states directly.
• Keep UI purely representational.

❌
DON’T:
• Let UI state drift from data state.
• Read values directly from DOM.
• Hide server errors visually while keeping stale data.
• Mutate UI manually.

💡
Example:
Bad:
<input defaultValue="John" />

Good:
<input value={user.name} onChange={e => updateName(e.target.value)} />

Why it matters: When UI is just a mirror, it can always be rebuilt from state—no hidden dependencies.
---

6. Side-Effects Isolation (Functional Discipline)

Pure logic stays separate from effects like I/O, network, or timers.

✅
DO:
• Keep side effects inside dedicated hooks or middleware.
• Test logic without external dependencies.
• Make effects idempotent and cancelable.
• Handle async flow through clear entry points (sagas, thunks, queries).

❌
DON’T:
• Fire network requests inside render paths.
• Mix mutation logic with view rendering.
• Hide effects in anonymous callbacks.
• Depend on mutable globals.

💡
Example:
Bad:
useEffect(() => {
fetch('/api/user').then(setUser);
}, [someChangingProp]);

Good:
const { data: user } = useQuery({ queryKey: ['user'], queryFn: fetchUser });

Why it matters: Isolation makes state deterministic and effects observable, improving both reliability and testability.
---

Paradigms & Mental Models Summary

Layer 2 defines how state behaves, flows, and transitions.
Finite states, unidirectional flow, single authority, and isolated effects ensure every UI transition is explicit and reversible.

These paradigms operationalize Layer 1’s declarative, composable, and predictable mindset—turning philosophy into system behavior.
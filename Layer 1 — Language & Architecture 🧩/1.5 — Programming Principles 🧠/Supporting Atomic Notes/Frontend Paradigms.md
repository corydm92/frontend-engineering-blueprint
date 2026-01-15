Frontend Paradigms

1. Declarative Over Imperative

Describe intent, not procedure. Code should express what outcome you want, not every step to achieve it.

✅
DO:
• Use JSX, configuration, and data mapping to declare behavior.
• Model UI as a function of state.
• Favor descriptive function and variable names over procedural comments.
• Let frameworks handle orchestration through declarative APIs.

❌
DON’T:
• Manually mutate the DOM or global state.
• Orchestrate rendering through nested imperative logic.
• Use side effects to control UI flow.
• Rely on comments to explain complex order of operations.

💡
Example:
Imperative (bad):
function TodoList() {
const [todos, setTodos] = useState([]);
useEffect(() => {
fetch('/api/todos')
.then(res => res.json())
.then(data => {
const ul = document.getElementById('list');
ul.innerHTML = '';
data.forEach(t => {
const li = document.createElement('li');
li.textContent = t.title;
ul.appendChild(li);
});
});
}, []);
return <ul id="list"></ul>
}

Declarative (good):
function TodoList() {
const { data: todos } = useQuery({ queryKey: ['todos'], queryFn: fetchTodos });
return (
<ul>
{todos?.map(t => <li key={t.id}>{t.title}</li>)}
</ul>
);
}

Why it matters: Declarative systems scale because they minimize hidden state and make behavior self-evident.
---

2. Separation of Concerns (Contextualized)

Each concern — UI, data, logic, and side effects — lives in its rightful layer. This is SoC applied specifically to frontend systems.

✅
DO:
• Separate rendering, business rules, and effects (fetching, logging).
• Keep data access out of components.
• Define clear module boundaries aligned with layers.
• Write pure functions wherever possible.

❌
DON’T:
• Mix network calls with component rendering.
• Allow cross-layer imports (e.g., API code in UI files).
• Combine presentation and domain logic.
• Blur boundaries for short-term convenience.

💡
Example:
Bad:
function ProductCard() {
const [data, setData] = useState([]);
useEffect(() => {
fetch('/api/products').then(res => res.json()).then(setData);
}, []);
return <div>{data.map(p => <p>{p.name}</p>)}</div>
}

Good:
function ProductCard() {
const { data } = useProducts();
return <div>{data.map(p => <p>{p.name}</p>)}</div>
}

Why it matters: Separation at the system level prevents coupling and clarifies ownership across the stack.
---

3. Composition Over Inheritance

Assemble behavior from smaller, focused units rather than rigid hierarchies.

✅
DO:
• Compose features from modular hooks and utilities.
• Use higher-order functions or components for reuse.
• Pass dependencies explicitly through composition.
• Build systems that scale horizontally, not vertically.

❌
DON’T:
• Depend on deep class hierarchies.
• Share behavior through implicit inheritance.
• Hide complexity in shared base classes.
• Assume a single “god” component or utility.

💡
Example:
Inheritance (bad):
class BaseModal {
open() { /* show modal */ }
close() { /* hide modal */ }
}
class ConfirmModal extends BaseModal {
confirm() { /* confirm logic */ }
}

Composition (good):
function useModal() {
const [open, setOpen] = useState(false);
return { open, openModal: () => setOpen(true), closeModal: () => setOpen(false) };
}

function ConfirmModal({ onConfirm }) {
const { open, openModal, closeModal } = useModal();
return (
<>
<button onClick={openModal}>Confirm</button>
{open && (
<div className="modal">
<p>Are you sure?</p>
<button onClick={onConfirm}>Yes</button>
<button onClick={closeModal}>Cancel</button>
</div>
)}
</>
);
}

Why it matters: Composition in React replaces rigid hierarchies with reusable hooks and declarative assembly. It scales with features, not inheritance trees.
---

4. Explicit Contracts and Types (Design-by-Contract)

Define clear boundaries for every interface and API. The system should fail loudly when a contract is broken.

✅
DO:
• Use TypeScript interfaces and generics to enforce shape and intent.
• Validate runtime data with schemas.
• Version API contracts and document expectations.
• Treat types as executable documentation.

❌
DON’T:
• Rely on “any” or implicit casting.
• Assume third-party data shape.
• Bypass compile-time safety for speed.
• Leave API assumptions undocumented.

💡
Example:
Bad:
function getUser(user) {
return user.name.toUpperCase();
}

Good:
interface User { name: string; }
function getUser(user: User) {
return user.name.toUpperCase();
}

Why it matters: Explicit contracts protect system integrity and reduce downstream regressions.
---

5. Predictability and Determinism

Given the same input, the system should always produce the same result. Predictability is the antidote to chaos.

✅
DO:
• Keep state transitions pure and testable.
• Derive all UI from state.
• Isolate non-deterministic behavior (time, randomness) behind testable interfaces.
• Ensure side effects are traceable and idempotent.

❌
DON’T:
• Introduce hidden mutations.
• Depend on external timing or ordering.
• Store overlapping or conflicting sources of truth.
• Hide side effects in untracked callbacks.

💡
Example:
Bad:
let counter = 0;
function increment() { counter += Math.random() * 2; }

Good:
function increment(counter, step = 1) { return counter + step; }

Why it matters: Predictable systems are maintainable, testable, and debuggable — they build confidence across the team.
---

Paradigms & Principles Summary

Declarative, composable, predictable systems are the natural evolution of the core engineering principles. They operationalize DRY, KISS, YAGNI, SoC, and Fail Fast in the context of modern frontend architecture.

Where Core Engineering Principles define how engineers think, Layer 1 defines how that thinking manifests in software behavior.
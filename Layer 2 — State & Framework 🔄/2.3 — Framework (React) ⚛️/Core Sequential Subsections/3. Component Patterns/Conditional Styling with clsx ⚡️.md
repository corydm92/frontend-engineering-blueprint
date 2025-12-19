Conditional Styling with clsx
??


Purpose
clsx manages conditional classNames based on state or props.
It bridges **component state** and **visual expression** „ ensuring class logic remains declarative, readable, and maintainable.

Avoids
- Manual string concatenation for conditional styles.
- Mixing boolean checks inline with long template literals.
- Duplicating Tailwind utilities across conditional branches.
- Hiding class intent behind nested ternaries.
- Mutating class arrays dynamically within render.

---

1) Keep conditionals declarative and flat.
Do:
<button className={clsx("btn", isActive && "btn--active")}>Save</button>

DonÍt (almost good):
<button className={`btn ${isActive ? "btn--active" : ""}`}>Save</button>

Avoid:
Inline string building that obscures state intent.

---

2) Group base, variant, and state classes clearly.
Do:
const buttonClass = clsx(
"btn",
variant === "primary" && "btn--primary",
isLoading && "opacity-60 cursor-wait"
);

DonÍt (almost good):
clsx(variant && `btn--${variant}`, isLoading && "opacity-60", "btn");

Avoid:
Unordered, non-semantic class lists that reduce scanability.

---

3) Use helper utilities for repeated patterns.
Do:
function getButtonClass({ variant, disabled }) {
return clsx("btn", variant && `btn--${variant}`, disabled && "btn--disabled");
}

DonÍt (almost good):
clsx("btn", variant === "primary" && "text-white bg-blue-600", variant === "secondary" && "bg-gray-100");

Avoid:
Rewriting class conditionals in every component.

---

4) Compose clsx with Tailwind safely.
Do:
<div className={clsx(
"flex items-center justify-between",
isOpen && "bg-gray-100",
disabled && "opacity-50 pointer-events-none"
)}>

DonÍt (almost good):
<div className={`flex items-center justify-between ${isOpen && "bg-gray-100"} ${disabled && "opacity-50"}`}>

Avoid:
Mixing clsx and template strings „ pick one convention per project.

---

5) Derive visual state from data state „ not vice versa.
Do:
const isError = Boolean(errors?.name);
<label className={clsx("label", isError && "label--error")}>Name</label>

DonÍt (almost good):
const labelClass = clsx("label--error");
const isError = labelClass.includes("error");

Avoid:
Letting UI state drive data logic; keep direction one-way.

---

When to Use clsx (with examples)
- Toggling Tailwind utilities based on props or context.
- Applying variant classes (`size`, `intent`, `status`) dynamically.
- Simplifying readability of long conditional style expressions.
- Sharing class logic between parent and child components.
- Encapsulating repeated patterns in utility functions.

When Not to Use clsx (with examples)
- Static components with fixed styles.
- Style systems already handling variants (e.g., cva, tv, or class-variance-authority).
- Styling logic based on async data loading (derive once, not on every render).
- Overriding design system tokens conditionally.
- As a theme switcher „ use a dedicated theme provider.

---

Key Principle
clsx connects **state** to **style**, not the other way around.
State decides appearance „ clsx keeps that decision expressive, predictable, and easy to refactor.

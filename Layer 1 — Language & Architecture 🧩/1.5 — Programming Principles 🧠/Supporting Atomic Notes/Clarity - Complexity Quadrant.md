Clarity / Complexity Quadrant

Every piece of code lives somewhere along two axes:

Clarity — how easy it is to read, reason about, and maintain
Complexity — how many moving parts or cognitive steps it requires to understand

----------------------------------------

The four zones:

Ideal Zone (High Clarity + Low Complexity)
Simple, readable, and safe to change.

Expert Zone (High Clarity + High Complexity)
Complex by necessity, but intentionally structured, well-named, and documented.

Trivial Zone (Low Clarity + Low Complexity)
Unstructured or improvised code that “just works” but offers no pattern to follow.

Danger Zone (Low Clarity + High Complexity)
Clever, opaque code that fails silently and resists change.

----------------------------------------

Interpretation:
Complexity itself isn’t failure — obscurity is. As complexity rises, clarity must rise with it.
Good engineers make hard problems look simple; bad engineers make simple problems look hard.

----------------------------------------

Usage:
Use this quadrant during reviews or refactors to ask:
- Does this module justify its complexity?
- If yes, is the clarity proportional?
- If not, can it be simplified or decomposed?

----------------------------------------

Goal:
Keep systems in the top half — high clarity at any complexity level.
When complexity is unavoidable, invest equal effort in naming, docs, and tests to raise clarity accordingly.

----------------------------------------

Reference:
clarity complexity quadrant software engineering
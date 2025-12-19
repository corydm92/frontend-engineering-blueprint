Comment Best Practices

Purpose
Comments communicate intent, constraints, and reasoning. Code already expresses *what* happens „ comments explain *why*.

Avoids
- Narrating code the reader can already see.
- Repeating type system information.
- Commenting to excuse unclear naming.
- Fear-based warnings without explanation.
- TODOs with no scope, trigger, or resolution path.

---

1) Comment the ñwhy,î not the ñwhat.î
Do:
/**
* We collapse middle pages to keep pagination compact on large page sets.
* Preserves context while reducing visual noise.
*/

DonÍt (almost good):
// This makes the pagination shorter.

Avoid:
Narrating code that already explains itself.

---

2) Document invariants and assumptions.
Do:
/**
* Assumes `currentPage` is within [1, totalPages].
* Caller must validate bounds before invoking.
*/

DonÍt (almost good):
// currentPage should be valid here.

Avoid:
Letting critical assumptions live only in your head.

---

3) Clarify input ? output contract.
Do:
/**
* Returns an array of page numbers and 'ellipsis' sentinel values.
* UI must render 'ellipsis' as non-interactive.
*/

DonÍt (almost good):
// Returns numbers and sometimes ellipsis.

Avoid:
Returning multiple value shapes without documenting how they must be interpreted.

---

4) Record reasoning when tradeoffs exist.
Do:
/**
* Mutation is used here to prevent repeated allocations in a hot path.
* Reduces GC churn during rapid UI updates.
*/

DonÍt (almost good):
// Using mutation for performance reasons.

Avoid:
Omitting the reasoning „ future contributors will remove or break the optimization.

---

5) Only comment non-obvious logic.
Do:
/**
* Avoid early-return so both cleanup steps always execute, even on errors.
*/

DonÍt (almost good):
// We don't early return so cleanup can run.

Avoid:
Explaining trivial control flow the reader can infer instantly.

---

6) Use TODOs intentionally „ only when the work is out of scope.
Do:
/**
* TODO: Normalize SKU sorting „ current logic breaks on alphanumeric IDs.
* This is outside the scope of the cart UI refactor.
* Add to monthly tech-debt review board.
*/

DonÍt (almost good):
// TODO: rewrite once new product API stabilizes
// (Needs explicit trigger: which API, and what counts as ñstable.î)

Avoid:
// TODO: fix later
(No scope, no reason for deferral, no owner, no resolution condition.)

---

When to Comment (with examples)
- Domain rules
/**
* Business rule: user profile updates allowed once every 24h.
*/

- Performance decisions
/**
* Preallocating avoids reallocation on large dataset iterations.
*/

- Shared utilities
/**
* Normalizes phone numbers to E.164. UI handles display formatting.
*/

- Non-obvious branching logic
/**
* Retry only on timeouts; surface all other errors immediately.
*/

---

When Not to Comment (with examples)
- Narrating obvious behavior
// Loop through users

- Restating type system information
// price is a number

- Explaining standard library behavior
// filter returns matching items

- Commenting to compensate for unclear naming
// total number of users
const x = users.length

- Fear-based warnings
// Don't touch this, it breaks things
(If true, document *why*, not fear.)

---

Key Principle
Comments preserve **intent, reasoning, and constraints** „ not code narration.

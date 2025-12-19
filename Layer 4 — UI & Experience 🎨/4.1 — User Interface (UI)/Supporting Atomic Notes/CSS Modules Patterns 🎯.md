CSS Modules Patterns ?

Purpose
CSS Modules provide locally scoped, predictable styling for components.
They balance **encapsulation** with **clarity**, ensuring that styles remain traceable and conflict-free at scale.

Avoids
- Relying on global cascade or inheritance.
- Duplicating colors, spacing, or variables outside tokens.
- Deep selector nesting for specificity control.
- Mixing global CSS and module CSS without clear hierarchy.
- Using Modules to override third-party component styles.

---

1) Co-locate styles with their component.
Do:
Button.tsx
import styles from "./Button.module.css"
<button className={styles.primary}>Save</button>

DonÍt (almost good):
import "./Button.module.css"
<button className="primary">Save</button>

Avoid:
Losing the mapping between component and style ownership.

---

2) Follow clear naming conventions.
Do:
.card {}
.cardHeader {}
.cardFooterActive {}

DonÍt (almost good):
.card {}
.headerBlue {}
.activeFooter {}

Avoid:
Names that describe presentation instead of function.

---

3) Use variables for theme consistency.
Do:
:root {
--color-brand: #0044cc;
--space-md: 1rem;
}
.button { background-color: var(--color-brand); margin: var(--space-md); }

DonÍt (almost good):
.button { background-color: #0044cc; margin: 16px; }

Avoid:
Hardcoding design values; always pull from tokens.

---

4) Compose shared utilities.
Do:
@value buttonBase from "../utils.module.css"
.buttonPrimary { composes: buttonBase; background: var(--color-brand); }

DonÍt (almost good):
.buttonPrimary { padding: 12px 24px; border-radius: 6px; }

Avoid:
Re-implementing patterns that already exist as utilities.

---

5) Keep selectors shallow and intent-based.
Do:
.input:focus { border-color: var(--color-brand); }

DonÍt (almost good):
.form .field .wrapper .input:focus { border-color: var(--color-brand); }

Avoid:
Using deep selectors to compensate for weak component structure.

---

When to Use CSS Modules (with examples)
- Component-specific layouts or overrides that Tailwind canÍt express clearly.
- Styling complex interactive states or custom animations.
- When style isolation is critical (widgets, embeds, or microfrontends).
- To co-locate visual logic with component code.
- When collaborating with non-Tailwind teams or legacy stylesheets.

When Not to Use CSS Modules (with examples)
- For utility composition or token-based spacing (use Tailwind).
- For global layout resets or typography baselines.
- When working inside a shared design system with enforced patterns.
- As an override layer for third-party components.
- To patch visual inconsistencies instead of fixing the design tokens.

---

Key Principle
CSS Modules enforce **style ownership and isolation**.
Each component owns its visual identity „ clean, scoped, and token-aligned.
The goal is **clarity over cleverness**, not cascading inheritance.

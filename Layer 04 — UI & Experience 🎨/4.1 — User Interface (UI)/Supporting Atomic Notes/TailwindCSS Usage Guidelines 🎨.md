TailwindCSS Usage Guidelines 🎨

Purpose
Tailwind enables utility-first styling that prioritizes speed, consistency, and design token alignment.
Utilities express **intent**, not decoration. The system’s power comes from disciplined composition, not improvisation.

Avoids
- Stacking arbitrary utilities without visual system alignment.
- Mixing Tailwind with raw CSS unpredictably.
- Hard-coding arbitrary values (e.g., w-[73px]) outside the spacing scale.
- Using @apply as a global stylesheet shortcut.
- Treating Tailwind as a design playground instead of a system constraint.

---

1) Use Tailwind to express system intent.
Do:
<div className="flex items-center gap-4 text-sm text-gray-700">
<Avatar />
<span>User Profile</span>
</div>

Don’t (almost good):
<div className="flex align-center text-12px gray-text">

Avoid:
Inventing classes that don’t align to tokens or Tailwind conventions.

---

2) Configure Tailwind to match design tokens.
Do:
// tailwind.config.js
theme: {
extend: {
colors: { brand: "#0044cc" },
spacing: { 18: "4.5rem" }
}
}

Don’t (almost good):
// tailwind.config.js
theme: { colors: { blueish: "#0055ff" } }

Avoid:
Creating arbitrary design values outside the token system.

---

3) Use consistent utility order for readability.
Do:
<div className="flex items-center justify-between p-4 bg-white rounded-lg shadow-sm">

Don’t (almost good):
<div className="bg-white justify-between p-4 flex rounded-lg shadow-sm items-center">

Avoid:
Inconsistent ordering that makes scanning class sets difficult.

---

4) Extract and reuse patterns, not noise.
Do:
@layer components {
.btn-primary { @apply px-4 py-2 bg-brand text-white rounded-md; }
}

Don’t (almost good):
@apply text-sm text-white p-3 bg-blue-500 rounded-sm border-0 cursor-pointer;

Avoid:
Copy-pasting full class strings across components without abstraction.

---

5) Combine Tailwind utilities and CSS Modules intentionally.
Do:
<button className={`${styles.button} flex items-center gap-2`}>Save</button>

Don’t (almost good):
<button className="button flex gap-2 items-center">Save</button>

Avoid:
Using identical class names in Tailwind and local CSS, causing confusion.

---

When to Use Tailwind (with examples)
- Rapidly compose layouts with predictable spacing.
- Style visual primitives (Stack, Box, Grid, Button).
- Express design tokens directly (color, typography, spacing).
- Prototype components quickly with production-safe utilities.
- Enforce visual consistency through the theme configuration.

When Not to Use Tailwind (with examples)
- Complex, component-specific animations or dynamic states.
- Longform content or prose styling — use a typography plugin.
- Deep, scoped overrides — use CSS Modules instead.
- Global resets or HTML element defaults — use base layer.
- Workarounds for inconsistent tokens — fix the design scale instead.

---

Key Principle
Tailwind is a **system amplifier**, not a shortcut.
Utilities exist to enforce design token fidelity, composition speed, and visual consistency — never as creative freedom.
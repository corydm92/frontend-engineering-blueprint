Theming and Dark Mode Strategy 🌗

Purpose
Theming defines how visual tokens (color, spacing, motion) adapt across modes, brands, and user preferences.
It ensures **consistency**, **accessibility**, and **maintainability** of appearance without code duplication.

Avoids
- Hardcoding color values directly in components.
- Creating separate themes instead of variable-driven modes.
- Ignoring contrast ratios when defining dark palettes.
- Mixing CSS variables and Tailwind colors inconsistently.
- Storing theme state locally without persistence or context.

---

1) Define tokens, not themes.
Do:
:root {
--color-bg: 255, 255, 255;
--color-text: 20, 20, 20;
}
[data-theme="dark"] {
--color-bg: 15, 15, 15;
--color-text: 235, 235, 235;
}

Don’t (almost good):
body.dark { background: #111; color: #eee; }

Avoid:
Duplicating entire stylesheets for light and dark variants.

---

2) Use variables or theme extensions for runtime theming.
Do:
// tailwind.config.js
extend: { colors: {
bg: "rgb(var(--color-bg) / <alpha-value>)",
text: "rgb(var(--color-text) / <alpha-value>)"
}}

Don’t (almost good):
colors: { bgLight: "#fff", bgDark: "#000" }

Avoid:
Creating new design tokens per theme instead of switching variable values.

---

3) Respect user OS preference and allow override.
Do:
@media (prefers-color-scheme: dark) {
:root { color-scheme: dark; }
}

Don’t (almost good):
Force dark mode with `data-theme="dark"` and ignore system settings.

Avoid:
Overriding user preferences without control or fallback.

---

4) Centralize theme logic in one provider or hook.
Do:
const [theme, setTheme] = useTheme();
document.documentElement.dataset.theme = theme;

Don’t (almost good):
const [theme, setTheme] = useState("light");
document.body.classList.add(theme);

Avoid:
Scattering theme state management across unrelated components.

---

5) Validate contrast ratios and accessibility for each mode.
Do:
// Use tooling like axe or Stark
Ensure minimum 4.5:1 contrast for body text, 3:1 for large text.

Don’t (almost good):
Eyeball test for contrast in Figma.

Avoid:
Shipping unreadable themes under the guise of “brand color fidelity.”

---

When to Apply Theming (with examples)
- Supporting light/dark preferences globally.
- Managing brand-specific palettes within a single design system.
- Implementing high-contrast or accessibility-focused themes.
- Creating runtime theme switchers with persisted preference.
- Ensuring UI readability across devices and lighting conditions.

When Not to Apply Theming (with examples)
- Simple static landing pages without user customization.
- Legacy apps with no design token foundation.
- When theming logic adds more maintenance than benefit.
- As a patch for inconsistent design standards.
- Per-component color overrides — use global tokens instead.

---

Key Principle
Theming manages **visual adaptability**, not visual creativity.
Themes translate token values dynamically — the design system remains constant across every mode.
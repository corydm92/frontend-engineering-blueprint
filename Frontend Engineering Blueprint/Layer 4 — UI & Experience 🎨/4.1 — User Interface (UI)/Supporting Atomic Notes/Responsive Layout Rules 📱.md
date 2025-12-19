Responsive Layout Rules ?

Purpose
Responsive design ensures interfaces scale predictably across devices, viewports, and densities.
It maintains **usability**, **readability**, and **visual rhythm** in every environment.

Avoids
- Designing for a single viewport and retrofitting responsiveness later.
- Hardcoding pixel values outside breakpoint scale.
- Hiding elements between breakpoints without accessible fallbacks.
- Using arbitrary widths or media queries scattered across files.
- Forcing overflow scrolls to ñfixî layout issues.

---

1) Define breakpoints at the system level.
Do:
// tailwind.config.js
theme: { screens: {
sm: "640px", md: "768px", lg: "1024px", xl: "1280px", "2xl": "1536px"
}}

DonÍt (almost good):
@media (max-width: 700px) { ƒ }

Avoid:
Ad-hoc breakpoints that drift from design system expectations.

---

2) Use responsive prefixes consistently.
Do:
<div className="p-4 sm:p-6 lg:p-8">

DonÍt (almost good):
<div className="lg:p-8 sm:p-6 p-4">

Avoid:
Random ordering that breaks scanning consistency and predictability.

---

3) Use layout primitives (flex, grid) over margin hacks.
Do:
<div className="grid grid-cols-3 gap-6">

DonÍt (almost good):
<div className="flex flex-wrap"><div className="mr-8 mb-8">ƒ</div></div>

Avoid:
Spacing layout elements manually with margins instead of structural utilities.

---

4) Scale type and spacing fluidly.
Do:
<h1 className="text-2xl sm:text-3xl md:text-4xl">Title</h1>

DonÍt (almost good):
<h1 className="text-[32px] sm:text-[40px] md:text-[48px]">

Avoid:
Hardcoded pixel fonts that ignore token scaling rules.

---

5) Test responsiveness across standard device widths.
Do:
´ Mobile: 375px
´ Tablet: 768px
´ Laptop: 1024px
´ Desktop: 1440px
´ Large Display: 1920px

DonÍt (almost good):
Test only in the dev window or one viewport.

Avoid:
Shipping untested breakpoints „ every layout should degrade gracefully.

---

When to Apply Responsive Rules (with examples)
- Component design intended for multiple breakpoints.
- Layout containers (Grid, Stack, Flex) defining page structure.
- Typography and image scaling for device variety.
- Adaptive component states (collapsing menus, stacked layouts).
- Accessibility-driven adjustments for zoom and DPI scaling.

When Not to Apply Responsive Rules (with examples)
- Fixed-size internal tools that run in controlled environments.
- Email templates or PDFs with static dimensions.
- Minimal prototype pages without production breakpoints.
- Decorative-only content that does not change functionally with viewport.
- Legacy layouts bound to iframes or embedded contexts.

---

Key Principle
Responsive design preserves **structure and usability** across every display context.
Layouts flex „ semantics and hierarchy do not.
Build mobile-first, test wide, and respect the systemÍs rhythm.

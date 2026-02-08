When to use ADR

✅ You should create an ADR when:
• Introducing a new tool, dependency, or service
(e.g., “Add oRPC for type-safe backend calls,” “Integrate external Workout API.”)
• Replacing or removing a core technology
(e.g., “Migrate from Redux Toolkit to Zustand.”)
• Changing a fundamental pattern or convention
(e.g., “Switch from REST to GraphQL,” “Adopt feature-based folder architecture.”)
• Defining or revising architecture principles
(e.g., “Use module federation for multi-app structure.”)
• Modifying core CI/CD or build systems
(e.g., “Switch from Vercel to Cloudflare Pages,” “Adopt Turborepo for monorepo management.”)

⸻

⚙️ You don’t need an ADR for:
• Minor implementation details (e.g., adding a new page or component).
• Library updates that don’t affect architecture (e.g., bumping patch versions).
• Cosmetic or content changes.

If it doesn’t change how the system behaves or scales, it doesn’t warrant an ADR.

Here’s how it breaks down in your blueprint terms:

⸻

🧩 Layer Responsibility
• Layer 1 (Language & Architecture) → Decision layer
You made the architectural choice: “Use shadcn/ui as the component and styling foundation.”
That’s captured in ADR 0001 – Project Setup Contract and reflected in your stack summary.
✅ Decision is logged.
• Layer 4 (UI & Experience) → Implementation layer
This is where you apply that decision — defining how components are structured, customized, themed, and extended.
You don’t make another ADR, but you document implementation details in your /docs/layers/04-ui-experience/ directory:
• /docs/layers/04-ui-experience/component-architecture.md
• /docs/layers/04-ui-experience/shadcn-guidelines.md
These are implementation notes, not architectural decisions.

⸻

🧭 When You Would Make a New ADR

You’d only add one if:
• You switch styling strategy (e.g., move from shadcn/ui to MUI).
• You fundamentally alter how it’s used (e.g., custom design system replaces shadcn entirely).
• You introduce another UI layer that changes architectural behavior (e.g., SSR-rendered style pipeline, design tokens system, or dark-mode theming at build level).

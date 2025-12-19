When to use ADR

? You should create an ADR when:
¥ Introducing a new tool, dependency, or service
(e.g., ÒAdd oRPC for type-safe backend calls,Ó ÒIntegrate external Workout API.Ó)
¥ Replacing or removing a core technology
(e.g., ÒMigrate from Redux Toolkit to Zustand.Ó)
¥ Changing a fundamental pattern or convention
(e.g., ÒSwitch from REST to GraphQL,Ó ÒAdopt feature-based folder architecture.Ó)
¥ Defining or revising architecture principles
(e.g., ÒUse module federation for multi-app structure.Ó)
¥ Modifying core CI/CD or build systems
(e.g., ÒSwitch from Vercel to Cloudflare Pages,Ó ÒAdopt Turborepo for monorepo management.Ó)

?

?? You donÕt need an ADR for:
¥ Minor implementation details (e.g., adding a new page or component).
¥ Library updates that donÕt affect architecture (e.g., bumping patch versions).
¥ Cosmetic or content changes.

If it doesnÕt change how the system behaves or scales, it doesnÕt warrant an ADR.


HereÕs how it breaks down in your blueprint terms:

?

? Layer Responsibility
¥ Layer 1 (Language & Architecture) ? Decision layer
You made the architectural choice: ÒUse shadcn/ui as the component and styling foundation.Ó
ThatÕs captured in ADR 0001 <ETH> Project Setup Contract and reflected in your stack summary.
? Decision is logged.
¥ Layer 4 (UI & Experience) ? Implementation layer
This is where you apply that decision Ñ defining how components are structured, customized, themed, and extended.
You donÕt make another ADR, but you document implementation details in your /docs/layers/04-ui-experience/ directory:
¥ /docs/layers/04-ui-experience/component-architecture.md
¥ /docs/layers/04-ui-experience/shadcn-guidelines.md
These are implementation notes, not architectural decisions.

?

? When You Would Make a New ADR

YouÕd only add one if:
¥ You switch styling strategy (e.g., move from shadcn/ui to MUI).
¥ You fundamentally alter how itÕs used (e.g., custom design system replaces shadcn entirely).
¥ You introduce another UI layer that changes architectural behavior (e.g., SSR-rendered style pipeline, design tokens system, or dark-mode theming at build level).

Type Organization Strategy — One File per Component

All types live under `/types`, mirroring the structure of `/src`.
Each component, feature, and utility owns a single `*.types.ts` file defining only what’s relevant to that module.
This enforces clean ownership, predictable imports, and prevents type sprawl across the codebase.

src/
├── components/
│ ├── Button/
│ │ └── Button.tsx
│ ├── Modal/
│ │ └── Modal.tsx
│
├── features/
│ ├── Cart/
│ │ └── Cart.tsx
│ ├── Auth/
│ │ └── Auth.tsx
│
├── util/
│ ├── api/
│ │ └── api.ts
│ ├── format/
│ │ └── currency.ts
│ └── validation/
│ └── schemaValidator.ts
│
└── types/
├── components/
│ ├── button.types.ts
│ └── modal.types.ts
│
├── features/
│ ├── cart.types.ts
│ └── auth.types.ts
│
├── util/
│ ├── api.types.ts
│ ├── currency.types.ts
│ └── schemaValidator.types.ts
│
└── common/
└── index.ts

✅ DO:
- Mirror the `/src` structure inside `/types` for 1:1 clarity. – (typescript mirrored types directory pattern)
- Create one `*.types.ts` file per component, feature, or utility. – (typescript colocated types pattern)
- Keep each type file scoped to its module — no cross-domain definitions. – (modular type organization best practices)
- Import types directly from their module (`import { ButtonProps } from '@/types/components/button.types'`). – (explicit imports vs barrel files typescript)
- Define only **truly global primitives** (e.g., `ID`, `AppEnv`, `Nullable<T>`) inside `types/common/index.ts`. – (typescript global type definitions best practices)

❌ DON’T / FIX FIRST:
- Store type definitions inside `/src`. – (separation of code and contracts pattern)
- Combine unrelated modules into one giant type file. – (anti pattern monolithic type definitions)
- Use barrel exports (`index.ts`) to merge multiple type files. – (typescript barrel file drawbacks)
- Inline shared or stable types directly inside components. – (inline type definition anti pattern)
- Leave unused type files or definitions after refactors. – (dead code cleanup in typescript)
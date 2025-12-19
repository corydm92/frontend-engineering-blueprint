Type Organization Strategy „ One File per Component

All types live under `/types`, mirroring the structure of `/src`.
Each component, feature, and utility owns a single `*.types.ts` file defining only whatÍs relevant to that module.
This enforces clean ownership, predictable imports, and prevents type sprawl across the codebase.

src/
??? components/
? ??? Button/
? ? ??? Button.tsx
? ??? Modal/
? ? ??? Modal.tsx
?
??? features/
? ??? Cart/
? ? ??? Cart.tsx
? ??? Auth/
? ? ??? Auth.tsx
?
??? util/
? ??? api/
? ? ??? api.ts
? ??? format/
? ? ??? currency.ts
? ??? validation/
? ??? schemaValidator.ts
?
??? types/
??? components/
? ??? button.types.ts
? ??? modal.types.ts
?
??? features/
? ??? cart.types.ts
? ??? auth.types.ts
?
??? util/
? ??? api.types.ts
? ??? currency.types.ts
? ??? schemaValidator.types.ts
?
??? common/
??? index.ts

? DO:
- Mirror the `/src` structure inside `/types` for 1:1 clarity. <ETH> (typescript mirrored types directory pattern)
- Create one `*.types.ts` file per component, feature, or utility. <ETH> (typescript colocated types pattern)
- Keep each type file scoped to its module „ no cross-domain definitions. <ETH> (modular type organization best practices)
- Import types directly from their module (`import { ButtonProps } from '@/types/components/button.types'`). <ETH> (explicit imports vs barrel files typescript)
- Define only **truly global primitives** (e.g., `ID`, `AppEnv`, `Nullable<T>`) inside `types/common/index.ts`. <ETH> (typescript global type definitions best practices)

? DONÍT / FIX FIRST:
- Store type definitions inside `/src`. <ETH> (separation of code and contracts pattern)
- Combine unrelated modules into one giant type file. <ETH> (anti pattern monolithic type definitions)
- Use barrel exports (`index.ts`) to merge multiple type files. <ETH> (typescript barrel file drawbacks)
- Inline shared or stable types directly inside components. <ETH> (inline type definition anti pattern)
- Leave unused type files or definitions after refactors. <ETH> (dead code cleanup in typescript)

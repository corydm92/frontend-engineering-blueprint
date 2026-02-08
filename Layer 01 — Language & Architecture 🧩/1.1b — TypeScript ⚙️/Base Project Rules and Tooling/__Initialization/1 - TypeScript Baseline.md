# TypeScript Baseline

## Goal

Boot TypeScript with a strict baseline that scales across a growing codebase.

## Architecture decisions

- `strict: true` to make types meaningful.
- A single root `tsconfig.json` with limited overrides.
- Path aliases (`@app/*`) for clarity without hidden coupling.

## Steps

1. Install TypeScript.
2. Add a strict `tsconfig.json`.
3. Add a `typecheck` script.
4. Add one small typed module to validate the pipeline.

## Example

Frontend example — File: `@app/tsconfig.json`

```json
{
  "compilerOptions": {
    "target": "ES2022",
    "lib": ["ES2022", "DOM"],
    "module": "ESNext",
    "moduleResolution": "Bundler",
    "strict": true,
    "noUncheckedIndexedAccess": true,
    "exactOptionalPropertyTypes": true,
    "jsx": "react-jsx",
    "baseUrl": ".",
    "paths": {
      "@app/*": ["src/*"]
    },
    "skipLibCheck": true
  },
  "include": ["src"]
}
```

Frontend example — File: `@app/package.json`

```json
{
  "scripts": {
    "typecheck": "tsc -p tsconfig.json --noEmit"
  }
}
```

Frontend example — File: `@app/src/example/typedConfig.ts`

```ts
export type FeatureFlags = {
  enableNewCheckout: boolean;
};

export function readFlag(flags: FeatureFlags, key: keyof FeatureFlags): boolean {
  return flags[key];
}
```

## Validation

- `npm run typecheck` succeeds.
- A deliberate type error fails the build.

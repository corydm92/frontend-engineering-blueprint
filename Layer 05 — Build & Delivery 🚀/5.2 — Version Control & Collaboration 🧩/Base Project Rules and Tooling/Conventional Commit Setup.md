# Conventional Commits + Husky Setup (pnpm)

Updated by Cory Morrissey: 1/26/2026

This note is **one base install** + an **optional upgrade**.

- **Path 1 (Base)**: Husky + commitlint (**with helper formatter**) + standard-version + hooks
- **Path 2 (Upgrade)**: Add Prettier/ESLint/TypeScript and tighten the pre-commit gate

(So Path 2 is just “do Path 1, then apply these changes”.)

---

# Path 1 — Base Setup (Husky + commitlint + release)

## Preconditions

```sh
corepack enable
corepack use pnpm@10.28.2
pnpm -v
```

## Install dependencies

```sh
pnpm add -D husky @commitlint/cli @commitlint/config-conventional @commitlint/format standard-version
```

## package.json scripts (baseline)

```json
{
	"scripts": {
		"prepare": "husky",
		"test": "echo \"No test specified\" && exit 0",
		"release": "standard-version"
	}
}
```

## Initialize Husky hooks folder

```sh
pnpm run prepare
```

Don't delete the `prepare` script after initialization — Husky expects this pattern so hooks get installed automatically after dependency installs (fresh clones, CI containers, and teammates who won’t remember a one-off init command).

## Commitlint formatter (prints help on failure)

```sh
cat > commitlint.config.formatter.mjs <<'EOF'
import { format } from '@commitlint/format';

const validTypes = [
  'feat','fix','docs','style','refactor','perf','test','build','ci','chore','revert',
];

export default function formatter(report) {
  const output = format(report);
  const isValid = report.results?.every((r) => r.valid) === true;
  if (isValid) return output;

  const help = `
──────────────────────────────────────────────
Valid commit types:

  ${validTypes.map((t) => `- ${t}`).join('\n  ')}

Examples:

  feat: add user login
  fix: correct validation bug
  docs: update README with setup steps
  chore: add husky + commitlint hooks

Format:

  <type>: <subject>
──────────────────────────────────────────────
`;
  return output + help;
}
EOF
```

## Commitlint config

```sh
cat > commitlint.config.cjs <<'EOF'
module.exports = {
  extends: ['@commitlint/config-conventional'],
  formatter: './commitlint.config.formatter.mjs',
}
EOF
```

## Husky hooks

### commit-msg

```sh
test -d .husky || (echo "Missing .husky/. Run: pnpm run prepare" && exit 1)
cat > .husky/commit-msg <<'EOF'
#!/usr/bin/env sh
pnpm exec commitlint --edit "$1"
EOF
chmod +x .husky/commit-msg
```

### pre-commit (base: run tests placeholder)

```sh
cat > .husky/pre-commit <<'EOF'
#!/usr/bin/env sh
pnpm test
EOF
chmod +x .husky/pre-commit
```

## Verify

```sh
pnpm test
echo "bad message" | pnpm exec commitlint
```

Then:

```sh
git add .
git commit -m "bad message"  # should FAIL (and print helper block)
git commit -m "chore(ci): add commitlint and husky setup"  # should PASS
```

If hooks aren’t firing:

```sh
git config core.hooksPath
ls -la .husky
```

## Release automation

```sh
pnpm release
git push --follow-tags origin main
```

---

# Path 2 — Upgrade (Prettier + ESLint v9 + TypeScript + stricter pre-commit)

> Start from Path 1, then apply the changes below.

## Install additional dependencies

```sh
pnpm add -D \
  prettier \
  eslint @eslint/js typescript-eslint eslint-plugin-import globals \
  typescript
```

## Minimal project structure (if TS needs something to compile)

```sh
mkdir -p src
cat > src/index.ts <<'EOF'
export const hello = () => "hello";
EOF
```

## Update package.json scripts

Add/extend scripts:

```json
{
	"scripts": {
		"prepare": "husky",
		"format": "prettier . --write",
		"format:check": "prettier . --check",
		"lint": "eslint .",
		"type-check": "tsc -p tsconfig.json --noEmit",
		"test": "echo \"No test specified\" && exit 0",
		"release": "standard-version"
	}
}
```

## Tool configs

### tsconfig.json

```sh
cat > tsconfig.json <<'EOF'
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "NodeNext",
    "moduleResolution": "NodeNext",
    "strict": true,
    "noEmit": true,
    "skipLibCheck": true
  },
  "include": ["src/**/*.ts"]
}
EOF
```

### eslint.config.js (ESLint v9 flat config)

```sh
cat > eslint.config.js <<'EOF'
import js from "@eslint/js";
import globals from "globals";
import importPlugin from "eslint-plugin-import";
import tseslint from "typescript-eslint";

export default [
  {
    ignores: [
      "dist/**",
      "build/**",
      "coverage/**",
      "node_modules/**",

      // Tooling files: keep linting focused on app code
      "commitlint.config.cjs",
      "commitlint.config.formatter.mjs"
    ],
  },

  js.configs.recommended,
  ...tseslint.configs.recommended,

  {
    files: ["**/*.{ts,tsx,js,mjs,cjs}"],
    languageOptions: {
      globals: { ...globals.node, ...globals.es2023 }
    },
    plugins: { import: importPlugin },
    rules: {
      "no-unused-vars": "off",
      "@typescript-eslint/no-unused-vars": ["warn", { argsIgnorePattern: "^_" }]
    }
  }
];
EOF
```

### Prettier config

```sh
cat > .prettierrc.json <<'EOF'
{
  "semi": true,
  "singleQuote": true,
  "trailingComma": "all"
}
EOF
```

Optional `.prettierignore`:

```sh
cat > .prettierignore <<'EOF'
node_modules
dist
build
coverage
docs
.github
EOF
```

## Upgrade the pre-commit gate

Replace `.husky/pre-commit` with:

```sh
cat > .husky/pre-commit <<'EOF'
#!/usr/bin/env sh
pnpm format
pnpm lint
pnpm type-check
pnpm test
EOF
chmod +x .husky/pre-commit
```

## Verify (upgrade)

```sh
pnpm format:check
pnpm lint
pnpm type-check
pnpm test
```

Then:

```
git add .
git commit -m "bad message"  # should FAIL
git commit -m "feat: updated husky precommit gate"  # should PASS
```

## Release automation (same as base)

```sh
pnpm release
git push --follow-tags origin main
```

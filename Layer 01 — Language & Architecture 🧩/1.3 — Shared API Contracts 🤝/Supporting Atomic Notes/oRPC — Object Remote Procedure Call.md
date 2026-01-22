oRPC — Object Remote Procedure Call

Perfect — that’s the most realistic and maintainable model for ORPC: the backend owns the contract, the frontend consumes it.
Here’s your section updated to include that model — short, clear, and fits the Blueprint tone.

⸻

ORPC — Object Remote Procedure Call

What It Is:
ORPC lets the frontend call backend functions as if they were local, replacing REST endpoints with type-safe, schema-driven procedure calls.
It works best when both sides use TypeScript + Node, since type inference flows end-to-end without schema translation.

⸻

Example

Backend

// server/orpc.ts
import { createORPC } from 'orpc'

const orpc = createORPC()

export const router = orpc.router({
getUser: orpc.procedure
.input({ id: 'string' })
.resolve(async ({ input }) => db.user.findById(input.id))
})

export type AppRouter = typeof router

Frontend

import { createORPCClient } from 'orpc'
import type { AppRouter } from '@myorg/contracts'

const client = createORPCClient<AppRouter>({ url: '/api/orpc' })
const user = await client.getUser({ id: '123' })

Result → No manual fetch calls, no endpoint juggling, and both sides share the same typed contract.

⸻

Sharing Contracts (Server-Owned Model)

In this setup, the backend owns the ORPC contract and publishes the generated types to your private registry.
This ensures the server remains the single source of truth for schema, validation, and procedure definitions.

Flow:
1. Backend defines the ORPC router and exports its type (AppRouter).
2. A lightweight contracts/ subpackage re-exports that type.
3. CI builds and publishes @myorg/contracts to your private npm registry (GitHub Packages, Nexus, etc.).
4. Frontend installs the package and imports the types directly.

Example Folder Structure

backend/
├── src/orpc/router.ts
└── contracts/
├── index.ts // export type { AppRouter }
├── tsconfig.json // emits .d.ts only
└── package.json // name: "@myorg/contracts"

CI Behavior
• Watch src/orpc/** for changes.
• On merge to main, rebuild the contracts package and npm publish it.
• Frontend pins the version and receives automatic PR bumps when new types are published.

Philosophy: The backend defines truth; the frontend mirrors it safely.
No schema drift, no guesswork, no manual synchronization.

⸻

DO
• Keep contract exports pure (no DB or framework imports).
• Automate publish via CI — never manual.
• Enforce version pinning in frontend ("@myorg/contracts": "1.2.3").
• Include drift detection in CI to prevent stale type usage.

DON’T
• Copy/paste types between repos.
• Publish from local machines.
• Bundle runtime code with contract types.
• Share private logic — export only the public schema.

⸻

Why It Matters:
This model gives you runtime validation + compile-time safety without coupling repos.
Frontend teams develop confidently against a frozen contract version, and backend teams evolve APIs predictably — a single, versioned source of truth for all cross-layer communication.
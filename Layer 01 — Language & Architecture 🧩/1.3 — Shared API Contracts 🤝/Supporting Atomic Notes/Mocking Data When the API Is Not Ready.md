Mocking Data When the API Is Not Ready

Purpose
Mock data preserves frontend velocity while backend contracts are stabilizing.
Mocks must mirror the official Shared API Contract types, ensuring client integrations
remain accurate even before real endpoints exist.

Key Principles
- Always mock against the Shared API Contract types.
- Keep mocks versioned with the contract — they evolve together.
- Simulate realistic data, latency, and errors to validate client resilience.
- Expose mocks through the same service interface the real API will use.
- Treat mocks as temporary scaffolding, tracked and removed after integration.

------------------------------------------------------------

1) Mirror the Real Contract

// 🟢 GOOD — mock implements shared contract type
import type { User } from "@shared/contracts"
export const mockUser: User = {
id: "u_001",
name: "Rhea",
email: "rhea@example.com",
};

// 🟡 CAUTION — ad-hoc mock, not aligned to contract
export const mockUser2 = { username: "test" };

------------------------------------------------------------

2) Centralize and Version

// 🟢 GOOD — mocks co-located with contract, versioned together
packages/
shared/
contracts/
user.ts
user.mock.ts

// 🟡 CAUTION — scattered mocks across unrelated folders
src/
features/profile/mockUser.ts
components/dashboard/mockUser.ts

------------------------------------------------------------

3) Simulate Real Behavior (Latency, Errors, Pagination)

// 🟢 GOOD — mock simulates realistic delay and error rate
export async function getUser() {
await delay(150 + Math.random() * 200);
if (Math.random() < 0.1) throw new Error("Network timeout");
return mockUser;
}

// 🟡 CAUTION — returns instantly; hides loading/error states
export async function getUser() {
return mockUser;
}

------------------------------------------------------------

4) Switch Between Mock and Real in One Control Point

Context:
USE_MOCKS is a boolean flag (env-driven or build-driven) that determines
whether the app consumes mock services or real API services. The UI should
never know or care which is active.

// 🟢 GOOD — single flag controls data source at the service layer
const USE_MOCKS = process.env.NEXT_PUBLIC_USE_MOCKS === "true"
export const getUser = USE_MOCKS ? getMockUser : getRealUser;

// 🟡 CAUTION — environment logic sprinkled in components
if (process.env.NODE_ENV === "development") return mockUser;

------------------------------------------------------------

5) TODOs Must Be Scoped, Triggered, and Tracked

// 🟢 GOOD — clear owner, condition, and tracking reference
/**
* TODO(API-243): Replace with GET /users/:id when backend merges.
* Deferred until v2 contract release. Logged in tech-debt review.
*/

// 🟡 CAUTION — vague TODO with no context
// TODO: remove later

------------------------------------------------------------

6) Enforce Type Safety

// 🟢 GOOD — mock uses strict contract type
import type { Product } from "@shared/contracts"
const mockProduct: Product = { id: "p1", name: "Hat", price: 25 };

// 🟡 CAUTION — bypassing compiler with `as any`
const mockProduct2 = { id: 1, name: "Hat" } as any;

------------------------------------------------------------

7) Keep Mocks Minimal but Representative

// 🟢 GOOD — focused, relevant data covering edge cases
const mockUsers = [
{ id: "u_1", name: "Active User" },
{ id: "u_2", name: "Suspended User" }
];

// 🟡 CAUTION — massive mock dataset for no reason
const mockUsers = Array(50).fill({ name: "placeholder" });

------------------------------------------------------------

8) Maintain Versioned Mocks

// 🟢 GOOD — mocks versioned alongside contracts
contracts/
v1/user.ts
v1/user.mock.ts
v2/user.ts
v2/user.mock.ts

// 🟡 CAUTION — mocks left outdated after API v2 rollout
contracts/
user.ts
user.mock.ts // still returns v1 shape

------------------------------------------------------------

9) Never Violate Contract Invariants

// 🟢 GOOD — values respect valid enums and rules
export const mockUser = { id: "u_1", status: "active" as const };

// 🟡 CAUTION — introducing invalid enum values
export const mockUser = { id: "u_1", status: "pending" };

------------------------------------------------------------

10) Keep Mocks Deterministic

// 🟢 GOOD — consistent, repeatable data
export const mockUser = {
id: "u_123",
createdAt: "2024-01-01T00:00:00Z"
};

// 🟡 CAUTION — random data breaks reproducibility
export const mockUser = {
id: Math.random().toString(),
createdAt: new Date().toISOString()
};

------------------------------------------------------------

11) Validate Factory Mocks Against Schema

// 🟢 GOOD — factory output validated by schema
const UserSchema = z.object({ id: z.string(), name: z.string() });
export const createMockUser = (): User => {
const user = { id: "u_123", name: "Rhea" };
UserSchema.parse(user);
return user;
};

// 🟡 CAUTION — unchecked factory can produce invalid mocks
export const createMockUser = () => ({
id: Math.random(),
name: 123
});

------------------------------------------------------------

12) Exclude Mocks From Production Bundles

// 🟢 GOOD — conditionally imported or tree-shaken in prod
if (process.env.NEXT_PUBLIC_USE_MOCKS === "true") {
const { mockUser } = await import("@shared/contracts/user.mock");
}

// 🟡 CAUTION — mock data imported globally, bloating prod build
import { mockUser } from "@shared/contracts/user.mock"

------------------------------------------------------------

13) Simulate Status Codes and Error Shapes

// 🟢 GOOD — mock matches backend error schema
export async function getUser() {
await delay(200);
return { status: 404, message: "Not Found" };
}

// 🟡 CAUTION — mock throws generic error shape
throw new Error("Something broke");

------------------------------------------------------------

14) Every Mock Must Have an Expiration Path

// 🟢 GOOD — expiration clearly documented and tracked
/**
* TODO(API-291): Remove after Orders endpoint release to staging.
* Target date: 2025-04-30
*/

// 🟡 CAUTION — "temporary" mock left to rot
export const mockOrders = [{ id: 1 }];

------------------------------------------------------------

Core Takeaway
Mocks are extensions of the shared API contract. They must:
1) Conform to contract types
2) Live with the contract definition
3) Simulate realistic behavior (latency, errors, pagination)
4) Stay deterministic and versioned
5) Be removed when real endpoints are ready

If a mock diverges from the contract, the contract loses its authority.
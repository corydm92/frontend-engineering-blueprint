TanStack Router

1. Mental Model

TanStack Router defines where the application is allowed to exist.

Routing is not navigation.
Routing is permission and precondition enforcement.

If a route loads, the system has already decided:
- the user is allowed
- the context is valid
- required conditions are satisfied

------------------------------------------------------------

2. Syntax & File Scaffolding (Concrete Setup)

TanStack Router is file-based, but explicit. Nothing is implicit or magical.

Directory structure:

src/
router/
__root.tsx
dashboard.lazy.tsx
settings.route.tsx
routeTree.gen.ts
main.tsx

------------------------------------------------------------

__root route (required)

File: src/router/__root.tsx

import { createRootRoute, Outlet } from '@tanstack/react-router'

export const Route = createRootRoute({
component: () => (
<>
<Outlet />
</>
),
})

Purpose:
- Defines the root execution boundary
- Owns shared layout and global context
- Every route renders inside this tree

------------------------------------------------------------

Lazy route with access control (code-split)

File: src/router/dashboard.lazy.tsx

import { createLazyFileRoute, redirect } from '@tanstack/react-router'

export const Route = createLazyFileRoute('/dashboard')({
loader: async () => {
const isAuthed = await isAuthenticated()
if (!isAuthed) {
throw redirect({ to: '/login' })
}
},
component: () => <Dashboard />,
})

function Dashboard() {
return <div>Dashboard</div>
}

async function isAuthenticated() {
return false
}

------------------------------------------------------------

Non-lazy route with access control (eager)

File: src/router/settings.route.tsx

import { createRoute, redirect } from '@tanstack/react-router'
import { Route as RootRoute } from './__root'

export const Route = createRoute({
getParentRoute: () => RootRoute,
path: '/settings',
loader: async () => {
const isAuthed = await isAuthenticated()
if (!isAuthed) {
throw redirect({ to: '/login' })
}
},
component: Settings,
})

function Settings() {
return <div>Settings</div>
}

async function isAuthenticated() {
return false
}

------------------------------------------------------------

Router bootstrap using routeTree

File: src/main.tsx

import { createRoot } from 'react-dom/client'
import { StrictMode } from 'react'
import { RouterProvider, createRouter } from '@tanstack/react-router'
import { routeTree } from './routeTree.gen'

const router = createRouter({ routeTree })

const container = document.getElementById('root')
const root = createRoot(container!)

root.render(
<StrictMode>
<RouterProvider router={router} />
</StrictMode>
)

Purpose:
- routeTree is the compiled routing authority
- Router is created once at the application boundary
- Router decides what may exist before React renders anything
- No routing logic lives inside components

------------------------------------------------------------

3. How routeTree.gen Is Created

routeTree.gen.ts is generated code, not handwritten.

It is produced by TanStack Router’s file-based routing compiler, which:
- Scans the src/router directory
- Reads __root.tsx, *.route.tsx, *.lazy.tsx
- Extracts paths, loaders, components, and parent/child relationships
- Produces a fully typed route graph

You never manually edit routeTree.gen.ts.

------------------------------------------------------------

4. How routeTree Works at Runtime

routeTree is a static, explicit description of the entire routing graph.

At runtime:
- The router evaluates the tree top-down
- Parent loaders run before child loaders
- If any loader throws, rendering stops
- If the tree resolves, React renders the approved subtree

Key properties:
- Routes are evaluated before render
- No route exists unless it passes validation
- The UI never asks if it’s allowed — the router already decided

------------------------------------------------------------

5. Redirects Belong in Loaders

Wrong (too late, UI already rendering):

function Page() {
if (!isAuthed) {
navigate('/login')
return null
}
return <Dashboard />
}

Correct (fail fast, no UI):

loader: () => {
if (!isAuthed) {
throw redirect({ to: '/login' })
}
}

Reason:
- Components may render multiple times
- Loaders run before render
- Prevents partial or flickering UI

------------------------------------------------------------

6. Common Gotchas

Auth checks inside components:

function Page() {
if (!isAuthed) return null
return <Dashboard />
}

Problem:
- Route already exists
- Unauthorized UI path is reachable
- Logic duplicated across components

Allowing UI before validation:

component: () => {
useQuery(fetchSensitiveData)
return <Dashboard />
}

Problem:
- Query may fire before auth is verified

------------------------------------------------------------

7. Router and Query Ordering Rule

Correct order:
1. Router loader validates access
2. Route renders
3. Queries execute inside approved boundary

Correct enforcement:

loader: async () => {
if (!isAuthed) throw redirect({ to: '/login' })
}

component: () => {
useQuery({ queryKey: ['data'], queryFn: fetchData })
return <Dashboard />
}

Guarantee:
- Loader always runs first
- Queries never fire for unauthorized routes
- Cached data does not leak

------------------------------------------------------------

8. When Not to Use TanStack Router

Component-level conditional rendering:

function Page() {
if (featureFlag) {
return <NewUI />
}
return <OldUI />
}

Temporary UI flow control:

if (step === 2) {
setStep(3)
}

Routing should not be used for:
- Feature flags
- UI toggles
- Local flow state

------------------------------------------------------------

9. Mental Trick

If a user should never see a screen,
the decision belongs in the router,
not the component.

------------------------------------------------------------

10. One-liner Summary

TanStack Router decides whether a route may exist;
components only decide how it looks.
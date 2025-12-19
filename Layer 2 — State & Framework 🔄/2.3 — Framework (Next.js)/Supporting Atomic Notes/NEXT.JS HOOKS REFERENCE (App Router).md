
NEXT.JS HOOKS REFERENCE (App Router)


All examples are production-style and compatible with Next.js 13+ App Router, and some need React 19+.

????????????????????????????

1) useRouter
????????????????????????????

Definition: Programmatic navigation and route utilities (push, replace, back, refresh).

Example:
'use client'
import { useRouter } from 'next/navigation'

export default function GoToDashboard() {
const router = useRouter() // gives router instance tied to current client boundary

return (
<button
onClick={() => {
// router.push() performs a client-side navigation
router.push('/dashboard')
}}
>
Go to Dashboard
</button>
)
}

Use: Navigate after user actions; replace URL after form submission; refresh data after a Server Action.

????????????????????????????

2) usePathname
????????????????????????????

Definition: Returns the current URL path (string), e.g., "/settings/billing".

Example:
'use client'
import { usePathname } from 'next/navigation'

export default function PathBadge() {
const pathname = usePathname() // updates reactively when route changes

return (
<span data-path={pathname}>
{/* render current path for debugging or breadcrumbs */}
Path: {pathname}
</span>
)
}

Use: Breadcrumbs, active nav highlighting, analytics.

????????????????????????????

3) useSearchParams
????????????????????????????

Definition: Readonly interface to query string parameters.

Example:
'use client'
import { useSearchParams, useRouter } from 'next/navigation'
import { startTransition } from 'react'

export default function ProductFilters() {
const router = useRouter()
const params = useSearchParams() // reactive map of ?key=value params
const sort = params.get('sort') ?? 'popular'

function setSort(next) {
// create new URL based on current
const url = new URL(window.location.href)
url.searchParams.set('sort', next)
// update URL without blocking render
startTransition(() => router.replace(url.toString()))
}

return (
<div>
<p>Sorting: {sort}</p>
{/* updating sort param re-renders automatically via useSearchParams */}
<button onClick={() => setSort('popular')}>Popular</button>
<button onClick={() => setSort('price-asc')}>Price ?</button>
<button onClick={() => setSort('price-desc')}>Price ?</button>
</div>
)
}

Use: Drive list filtering/sorting via URL state.

????????????????????????????

4) useParams
????????????????????????????

Definition: Dynamic route params for the current segment.

Example:
'use client'
import { useParams } from 'next/navigation'

export default function UserHeader() {
const { userId } = useParams() // for route /users/[userId]

return (
<header>
{/* useParams gives access to dynamic segments without prop drilling */}
<h1>User ID: {userId}</h1>
</header>
)
}

Use: Read dynamic segments without prop-drilling.

????????????????????????????

5) useSelectedLayoutSegments
????????????????????????????

Definition: Array of active layout segments for the current layout level.

Example (sidebar highlighting by route):
'use client'
import { useSelectedLayoutSegments } from 'next/navigation'

const items = [
{ href: '/dashboard', key: 'dashboard', label: 'Dashboard' },
{ href: '/settings', key: 'settings', label: 'Settings' },
{ href: '/billing', key: 'billing', label: 'Billing' },
]

export default function SidebarNav() {
const segments = useSelectedLayoutSegments() // e.g., ['settings', 'billing']

return (
<nav>
{items.map(item => {
const active = segments.includes(item.key) // check if current segment is active
return (
<a
key={item.key}
href={item.href}
aria-current={active ? 'page' : undefined}
className={active ? 'active' : ''}
>
{item.label}
</a>
)
})}
</nav>
)
}

Use: Layout-aware navigation where multiple nested segments may be active.

????????????????????????????

6) useSelectedLayoutSegment
????????????????????????????

Definition: Active segment string for the current layout level (single value).

Example (tabs within a layout section):
'use client'
import { useSelectedLayoutSegment } from 'next/navigation'

const tabs = [
{ key: 'overview', href: '/settings/overview', label: 'Overview' },
{ key: 'billing', href: '/settings/billing', label: 'Billing' },
{ key: 'team', href: '/settings/team', label: 'Team' },
]

export default function SettingsTabs() {
const active = useSelectedLayoutSegment() // e.g., 'billing'

return (
<div role="tablist" aria-label="Settings">
{tabs.map(t => (
<a
key={t.key}
href={t.href}
role="tab"
// useSelectedLayoutSegment() allows us to mark correct tab active
aria-selected={active === t.key}
className={active === t.key ? 'tab active' : 'tab'}
>
{t.label}
</a>
))}
</div>
)
}

Use: Single-level tab UIs keyed to nested routes.

????????????????????????????

7) useServerInsertedHTML (Server Component only)
????????????????????????????

Definition: Inject HTML into the server-rendered stream before itÍs sent to the client.

Example (SSR CSS injection for CSS-in-JS):
// No 'use client' „ this runs on the server.
import { useServerInsertedHTML } from 'next/navigation'
import { getCssText } from './styling/registry' // your styling registry

export default function StyleRegistry({ children }) {
// Hook ensures <style> tags are injected as server HTML streams
useServerInsertedHTML(() => {
return (
<style
id="ssr-styles"
dangerouslySetInnerHTML={{ __html: getCssText() }}
/>
)
})
return children
}

Use: Integrate SSR styling (styled-components/emotion/vanilla-extract), critical CSS, or per-request meta.

????????????????????????????

8) useFormStatus (Server Actions)
????????????????????????????

Definition: Read submission state of the nearest <form> that uses a Server Action.

Example (disable button while pending):
'use client'
import { useFormStatus } from 'react-dom'

export function SubmitButton() {
const { pending } = useFormStatus() // true while server action runs
return (
<button type="submit" disabled={pending} aria-busy={pending}>
{/* useFormStatus() allows responsive loading UI */}
{pending ? 'Savingƒ' : 'Save'}
</button>
)
}

Use: Pending spinners, disable UI during server-side mutations.

????????????????????????????

9) useFormState (Server Actions)
????????????????????????????

Definition: Keep form state (messages, validation) across submissions driven by a Server Action.

Server Action (server file, e.g., app/actions.ts):
'use server'

export async function updateProfile(prev, formData) {
const name = String(formData.get('name') ?? '')
if (!name.trim()) {
// return validation message to client via useFormState()
return { ok: false, message: 'Name is required.' }
}
// perform server mutation...
return { ok: true, message: 'Profile updated.' }
}

Client Form (client component):
'use client'
import { useFormState } from 'react-dom'
import { updateProfile } from '@/app/actions'
import { SubmitButton } from './SubmitButton'

const initial = { ok: false, message: '' }

export default function ProfileForm() {
// useFormState binds state + server action
const [state, formAction] = useFormState(updateProfile, initial)

return (
<form action={formAction}>
<label>
Name
<input name="name" placeholder="Ada Lovelace" />
</label>
<SubmitButton />
{/* access server-side feedback through state */}
{state.message && (
<p role="status" data-ok={state.ok}>{state.message}</p>
)}
</form>
)
}

Use: Server-validated forms without client libs; display per-submit feedback.

????????????????????????????

10) useOptimistic (React 19+)
????????????????????????????

Definition: Apply optimistic UI updates immediately; reconcile when the server result arrives.

Example (chat/comments optimistic add):
'use client'
import { useOptimistic } from 'react'
import { addMessage } from '@/app/actions' // 'use server' action

export default function Chat({ initialMessages }) {
// useOptimistic returns derived optimistic state + updater
const [messages, addOptimisticMessage] = useOptimistic(
initialMessages,
(current, optimisticText) => [
...current,
{ id: `temp-${Date.now()}`, text: optimisticText, pending: true }
]
)

async function send(formData) {
const text = String(formData.get('text') ?? '')
if (!text.trim()) return
// update UI instantly (before server returns)
addOptimisticMessage(text)
// wait for server action to commit
await addMessage(text)
}

return (
<form action={send}>
<ul>
{messages.map(m => (
<li key={m.id}>
{m.text}{m.pending ? ' (sending...)' : ''}
</li>
))}
</ul>
<input name="text" placeholder="Type a messageƒ" />
<button type="submit">Send</button>
</form>
)
}

Use: Feels-instant interactions (likes, comments, toggles) while waiting for server confirmation.

????????????????????????????

11) Combining route hooks
????????????????????????????

Definition: Compose pathname + params + search for full route awareness.

Example (analytics + UI control):
'use client'
import { usePathname, useParams, useSearchParams } from 'next/navigation'
import { useEffect } from 'react'

export default function RouteAware() {
const pathname = usePathname() // current path
const params = useParams() // dynamic route params
const search = useSearchParams() // query params

// reactively send analytics on route change
useEffect(() => {
const q = Object.fromEntries(search.entries())
window.gtag?.('event', 'route_change', { pathname, params, q })
}, [pathname, params, search])

return (
<pre>
{`pathname: ${pathname}
params: ${JSON.stringify(params)}
search: ${search.toString()}`}
</pre>
)
}

Use: Analytics, feature flags, conditional rendering, and deep-linking logic.

????????????????????????????

Notes
????????????????????????????

- App Router imports are from 'next/navigation'. Avoid 'next/router' (Pages Router).
- useServerInsertedHTML is server-only (no 'use client').
- For URL writes with useSearchParams, prefer router.replace/push with startTransition.
- Keep route-driven UI pure: derive UI from route state, not duplicated internal state.

TanStack Query

1. Mental Model

TanStack Query owns server state, not UI state.

Server state:
- Lives on a remote system
- Can be stale
- Can be refetched, invalidated, or retried
- Must be treated as eventually consistent

TanStack Query is a cache + lifecycle controller for that data.
React components consume it; they do not own it.

------------------------------------------------------------

2. Query Keys Define Data Boundaries

Query keys are identity, not labels.

Same key = same data
Different key = isolated data

Bad:
useQuery({ queryKey: ['user'], queryFn: fetchUser })

Good:
useQuery({
queryKey: ['user', userId],
queryFn: () => fetchUser(userId),
})

Rules:
- Include every variable that affects the result in the key
- User, org, permissions, feature scope all count
- Avoid generic keys like ['data'] or ['user']

------------------------------------------------------------

3. Basic Query Syntax

const { data, isLoading, error } = useQuery({
queryKey: ['projects', orgId],
queryFn: () => fetchProjects(orgId),
staleTime: 5 * 60 * 1000,
})

Notes:
- queryFn must be referentially stable
- Avoid inline object creation inside queryKey
- Prefer global defaults over per-query overrides

------------------------------------------------------------

4. Mutations Require Explicit Invalidation

Mutations do not update queries automatically.

Wrong:
useMutation(createProject)

Correct:
const queryClient = useQueryClient()

const mutation = useMutation({
mutationFn: createProject,
onSuccess: () => {
queryClient.invalidateQueries({ queryKey: ['projects'] })
},
})

Rule:
- Every mutation must either invalidate affected queries
- Or update the cache explicitly

------------------------------------------------------------

5. Auth Boundaries and Cache Reset

TanStack Query does not understand authentication.

On login or logout:
queryClient.clear()
or
queryClient.resetQueries()

If you don’t do this:
- Data can leak across users
- Background refetches may hit protected endpoints after logout

------------------------------------------------------------

6. Common Gotchas

- Reusing generic query keys across contexts
- Forgetting to invalidate after mutations
- Treating query cache as global app state
- Letting cached data survive auth changes
- Surfacing raw server errors directly to UI

------------------------------------------------------------

7. When Not to Use TanStack Query

- Local UI state
- Form input state
- Temporary interaction state
- Client-only derived values

If the server is not the source of truth, Query is the wrong tool.

------------------------------------------------------------

8. Mental Trick

If the data disappeared when the browser refreshed, it is not server state.
If the server can change it without the UI knowing, it is server state.

------------------------------------------------------------

9. One-liner Summary

TanStack Query owns server data lifecycles; you must define clear keys, explicit invalidation, and safe auth boundaries.
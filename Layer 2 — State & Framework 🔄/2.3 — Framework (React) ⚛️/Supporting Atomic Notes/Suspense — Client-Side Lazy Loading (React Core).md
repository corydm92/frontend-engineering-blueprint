Suspense „ Client-Side Lazy Loading (React Core)


Goal


Understand how Suspense works with client-side code splitting, dynamic imports, and lazy-loaded components in a purely client-rendered React application.


What Client-Side Suspense Is Used For

On the client, Suspense coordinates rendering when JavaScript needed to render a component is not yet available.

This commonly occurs with:
- React.lazy
- dynamic import()
- lazily loaded feature boundaries

Suspense does not load code.
It only reacts to missing render dependencies.


Basic Client-Side Lazy Loading Example

const PostsTab = React.lazy(() => import('./PostsTab'));

<Suspense fallback={<h1>Loading...</h1>}>
<PostsTab />
</Suspense>

Execution flow:

1. React attempts to render PostsTab
2. The module chunk has not been loaded
3. React.lazy throws the import() promise
4. Suspense catches the promise
5. Fallback UI is rendered
6. JavaScript chunk downloads
7. Promise resolves
8. React retries render
9. PostsTab renders successfully


Why Code Splitting Suspends

From ReactÍs perspective, code is a render dependency.

If a component cannot be executed because its module is missing:
- render cannot complete
- suspension occurs

Suspense treats missing code the same as missing data.


Combining Code Splitting with Data Fetching

Suspensions can stack.

const PostsTab = React.lazy(() => import('./PostsTab'));

function Posts() {
const posts = use(fetchData('/posts'));
return <PostsList posts={posts} />
}

<Suspense fallback={<h1>Loading...</h1>}>
<PostsTab />
</Suspense>

Possible suspension reasons:
- JS chunk not loaded
- data promise pending
- both

React retries render until all required dependencies are available.


Client-Side Fallback Rules

Fallback UI is shown when:
- render suspends
- the render is urgent
- React must commit immediately

Fallback UI may be skipped when:
- render is part of a transition
- previous UI is still valid
- React can delay committing


What Client-Side Suspense Is Not

Suspense is not:
- a loading spinner API
- an async control-flow tool
- a data-fetching solution

It is purely a render coordination mechanism.


Key Invariants (Client)

- missing code causes suspension
- React.lazy throws a promise during render
- Suspense catches thrown promises
- fallback UI is a commit decision
- transitions can suppress fallback display


One-Line Mental Model

Client-side Suspense delays rendering until the required JavaScript exists.

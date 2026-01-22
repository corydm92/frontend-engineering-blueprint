Order of priorities

1. Reduce Unnecessary Re-renders
- Use React.memo, useMemo, and useCallback to cut redundant renders.
- Split oversized components and lift state only when necessary.
- Profile render frequency with React DevTools Profiler to find wasted updates.

2. Ensure Code Quality
- Enforce ESLint + TypeScript strictness; refactor nested logic and dead code.
- Analyze time & space complexity — replace O(n²) loops with O(n) lookups (Map, Set).
- Profile and optimize hot paths; add lightweight performance tests to catch regressions early.

3. Data & Network Efficiency
- Cache with TanStack Query or SWR using proper staleTime and cacheTime.
- Deduplicate and prefetch predictable queries.
- Prefetch next-page data during idle or navigation hover.
- Batch or debounce requests to minimize API chatter.
- Debounce user-driven calls (search, autosave) to prevent spam.
- Use HTTP caching, compression, and preconnect to reduce latency.

4. Render Strategy Optimization
- Use code-splitting (React.lazy, Suspense) for route or module isolation.
- Implement SSR, SSG, or ISR for faster initial paint and better SEO.
- Use deferred hydration or lazy hydration to delay non-critical UI work.

5. Optimize Asset Loading
- Serve images via CDN with caching headers.
- Use modern formats (WebP, AVIF) and responsive sizes.
- Prefetch critical fonts and defer non-essential assets.

6. Enhance User Experience
- Use skeletons, smooth transitions, and avoid layout shifts (CLS).
- Focus on perceived performance — immediate feedback, visible progress.

7. Ensure Accessibility
- Semantic HTML, ARIA roles, and keyboard navigation.
- Maintain contrast and focus visibility.
- Test with Lighthouse or axe-core.
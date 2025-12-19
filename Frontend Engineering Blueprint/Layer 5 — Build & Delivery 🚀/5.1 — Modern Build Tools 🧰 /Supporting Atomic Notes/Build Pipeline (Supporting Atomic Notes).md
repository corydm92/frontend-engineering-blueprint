Build Pipeline (Supporting Atomic Notes)


1. Source Parsing & Transformation
- TypeScript ? JavaScript
- JSX ? JS via Babel/SWC/esbuild
- CSS preprocessing (Sass, Less, PostCSS)
- Asset loaders (images, fonts, raw files)

2. Dependency Graph Construction
- Resolve imports and module specifiers
- Follow dependency edges
- Classify dynamic imports for code splitting
- Detect side-effects and treeshake boundaries

3. Bundling / Chunking
- Merge modules into chunks
- Create shared vendor chunks
- Route-level chunk output (SPA/MPA/RSC frameworks)
- Represent dependency graph as executable bundles

4. Code & Asset Optimization
- Tree-shaking (remove unused exports)
- Dead code elimination
- Constant folding and scope hoisting
- CSS extraction and optimization
- Image optimization (resize, webp/avif conversion)
- Font optimization (subset, preload generation)

5. Minification
- JavaScript minification (Terser, SWC, esbuild)
- CSS minification (cssnano, lightningcss)
- Remove whitespace, rename bindings, compress literals

6. Compression (Server/CDN Stage)
- gzip, brotli, or zstd compression applied at deploy time
- Image compression (lossless/lossy)
- Not done by bundlers; handled by deployment pipeline or CDN

7. Hashing & Output Finalization
- Content-hash filenames (e.g., main.83fa3c.js)
- Emit manifest of chunk relationships
- Write finalized assets into output directory
- Ensure cache-busting and deterministic deployment behavior


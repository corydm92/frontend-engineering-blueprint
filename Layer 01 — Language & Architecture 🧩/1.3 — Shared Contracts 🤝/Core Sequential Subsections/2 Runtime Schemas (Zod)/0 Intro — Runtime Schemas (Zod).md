# Runtime Schemas (Zod) — Summary

Zod gives you **runtime contracts** for data that enters your system (API payloads,
form input, query params). This subsection is a progressive curriculum that starts
with basic schemas and parsing, then moves into composition, unions, refinements,
async validation, and reuse.

Each directory ends with a hands‑on tutorial that applies the concepts from that
directory. Move in order — each step builds on the previous one and mirrors a
handbook‑style progression from basics to advanced usage.

## Intro Note — What This Tool Is For

Zod is the “bouncer” at your data boundaries. Its job is to stop messy or untrusted
input from entering your system and to shape it into something your app can trust.

**Use Zod when you receive data you didn’t create yourself**, like:

- Form submissions (user input)
- API payloads (from other services or your own backend)
- Query params and URL state
- Local storage or cookies
- Webhook events

**What it solves**: it keeps invalid or unexpected data from leaking into your
application logic, and it gives you a single source of truth for both runtime
validation and TypeScript types.

**How it solves it**: you define a schema once, then Zod validates and parses data
at runtime. If valid, you get clean, typed data. If invalid, you get structured
errors you can show or log.

Mini example (form input):

```ts
const SignupSchema = z.object({
  email: z.string().email(),
  age: z.coerce.number().int().min(13),
});
```

## Outcomes

- Validate unknown input at system boundaries with confidence.
- Model complex shapes (objects, unions, enums) and compose them safely.
- Apply refinements, async checks, and reuse patterns without drift.

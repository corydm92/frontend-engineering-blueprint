# Arrays, Tuples, and Enums 📦

## Goal

Represent list data, fixed‑length structures, and finite sets.

## What you learn

- `z.array` validates homogeneous lists.
- `z.tuple` validates fixed‑length positions.
- `z.enum` represents a finite set of strings.

## Explanation

Arrays are for **variable‑length lists** (tags, items, results). Tuples are for
**fixed positions** (coordinates, ranges). Enums are for finite string values where
only known options are allowed.

## Example

Frontend example — File: `@app/src/schemas/listing.ts`

```ts
import { z } from "zod";

export const TagsSchema = z.array(z.string());
export const PointSchema = z.tuple([z.number(), z.number()]);
export const StatusSchema = z.enum(["draft", "published", "archived"]);
```

## Pitfalls

- Using arrays when the data is fixed‑length (use tuples instead).
- Using `z.string()` for finite sets instead of enums.

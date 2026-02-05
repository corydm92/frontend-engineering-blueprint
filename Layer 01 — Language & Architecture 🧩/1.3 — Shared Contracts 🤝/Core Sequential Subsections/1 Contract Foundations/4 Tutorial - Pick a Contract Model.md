# Tutorial — Pick a Contract Model 🧪

## Scenario

You need a model for sharing contracts across backend and frontend.

## Task

- Choose one source‑of‑truth model.
- Document who owns it and how changes flow.

## Hints

- Pick the model that matches your repo topology.
- Write down the owner and update path.

## Starter

Backend doc example — File: `@app/src/contracts/MODEL.md`

```md
Model:
Owner:
Change Flow:
```

## Answer

Backend doc example — File: `@app/src/contracts/MODEL.md`

```md
Model: Backend‑authored Zod schemas
Owner: Platform Team
Change Flow: PR → review → release
```

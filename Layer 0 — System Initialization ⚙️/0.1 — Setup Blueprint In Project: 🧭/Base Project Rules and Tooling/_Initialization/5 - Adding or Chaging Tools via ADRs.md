# 5 - Adding or Changing Tools via ADRs

## 🎯 Goal

Define a **clear, repeatable process** for introducing, changing, or removing foundational tools in the project.

This ensures:

- tool changes are intentional, reviewed, and traceable
- architectural decisions don’t live in PR comments or Slack
- the **Project Stack Summary always reflects current reality**, not decision history

ADRs govern _decisions_.  
The Project Stack Summary reflects the _current state_ after those decisions are accepted.

---

## 📦 What This Step Produces

This process produces **two artifacts over time**:

1. A new **Architecture Decision Record (ADR)** proposing the tool change
2. An **updated Project Stack Summary** reflecting the accepted decision

Only one artifact exists at a time:

- **Before acceptance** → ADR only
- **After acceptance** → ADR (immutable) + updated Project Stack Summary

---

## 🧭 Required Context Before Starting

Before proposing a tool change, the following must already exist:

- `/docs/process/adr-template.md`  
  The enforced structure for all decisions

- `/docs/_project/stack-summary.md`  
  The current, human-readable description of the project’s tools

- An understanding of:
  - what problem the new tool solves
  - what it replaces or changes (if anything)
  - why this change matters now

If the change is not architectural or foundational, **do not write an ADR**.

---

## 🔁 Standard Flow for Adding or Changing Tools

### 1 - Propose a New ADR

Create a new ADR in `/docs/adr/` using the ADR template.

- Status: `Proposed`
- Clearly state:
  - what tool is being added / changed / removed
  - what is explicitly _not_ being chosen
- Link to the current Project Stack Summary in Context

At this stage:

- the ADR **may be edited**
- the Project Stack Summary **must not change yet**

The proposal is under discussion, not law.

---

### 2 - Review and Accept the ADR

Once the decision is agreed upon:

- Update the ADR status to `Accepted`
- Record:
  - Accepted Date
  - Approver(s)
  - Approval context (PR, issue, meeting, etc.)

From this point forward:

- the ADR is **immutable**
- any future change requires a **new ADR**

---

### 3 - Update the Project Stack Summary

After the ADR is accepted:

- Update `/docs/_project/stack-summary.md` to reflect the new reality
- Describe:
  - the new tool
  - what problem it solves
  - how it fits into the system

Important:

- **Do not copy ADR language** (status, alternatives, approvals)
- Write as current truth, not historical narrative

The Project Stack Summary should read as:

> “This is how the project is built today.”

---

### 4 - (Optional) Supersede an Existing ADR

If the new decision replaces a prior one:

- Create a new ADR
- Mark the old ADR as `Superseded`
- Explicitly reference the new ADR in the old one

Never edit an accepted ADR to “update” it.

---

## 🧠 Mental Model

- **ADR** = decision history and governance
- **Project Stack Summary** = current state and onboarding clarity

ADRs answer: _“Why did we decide this?”_  
The Stack Summary answers: _“What are we using right now?”_

Both are required. Neither replaces the other.

---

## ✅ Verification Checklist

When a tool change is complete:

- A new ADR exists in `/docs/adr`
- ADR status is `Accepted`
- Owner and Approver(s) are recorded
- `/docs/_project/stack-summary.md` reflects the new tool
- The stack summary contains no ADR-specific language
- A new engineer can understand the change without reading the ADR

If all of the above are true, the process worked.

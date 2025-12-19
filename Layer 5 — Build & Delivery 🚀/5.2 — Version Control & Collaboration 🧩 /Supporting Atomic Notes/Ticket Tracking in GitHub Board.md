Ticket Tracking in GitHub Board

Purpose
Provide a lightweight, repo-based way to track TODOs, setup tasks, and progress across any project or system. This method is optional, flexible, and not tied to any specific app or framework.

Setup (5 minutes)
1) Create board
¥ GitHub ? Projects ? New project ? Board
¥ Name: ÒProject Execution BoardÓ (or your preferred name)
¥ Default views: keep ÒBoardÓ and optionally add a ÒTableÓ view for sorting/filtering.

2) Columns
Add the following columns:
¥ Not Started
¥ In Progress
¥ Blocked
¥ In Review
¥ Done
(Remove or rename any default columns GitHub includes.)

3) Custom Fields (optional but helpful)
Add dropdown fields for filtering and tracking:
¥ Category: Critical | Recommended | Optional
¥ Layer/Phase: 0<ETH>6 or Initialization | Development | Delivery
¥ Target Version: e.g., v0.1, v1.0
¥ Owner: person or team
¥ Type: Code | Docs | CI | Design | Test

4) Create issues from TODOs
¥ In your repo, add inline TODOs like:
<!-- TODO: Convert to issue -->
¥ When ready, create a corresponding issue in GitHub:
Issues ? New issue ? Title = TODO item
Body = details or links to relevant doc, ADR, or code section.
¥ Add labels (e.g., setup, docs, ci, or feature).
¥ In the issue sidebar, add it to your Project Board under ÒNot Started.Ó

5) Link issues to commits, PRs, and docs
¥ In commit messages or PR descriptions, include Òfixes #<issue>Ó or Òcloses #<issue>Ó.
¥ In documentation or ADRs, link issues directly (e.g., ÒTracking: #12Ó).
¥ When the PR merges, GitHub automatically moves the issue to ÒDone.Ó

6) Review and governance
¥ Pin the Project Board to your repo for quick access.
¥ During team syncs or reviews, filter by Category=Critical and Status-Done.
¥ Use saved views per scope (e.g., ÒPhase 1 Ñ SetupÓ, ÒPhase 2 Ñ DeliveryÓ).

Exit Criteria
When all Critical items are Done and related CI pipelines pass, the project or phase can progress to the next stage.

# 1 — Documentation Setup + Directory READMEs

## Goal
Create a predictable `/docs` structure and framing `README.md` files so contributors know where information lives before we write product code.

## Docs Structure
/docs — documentation root  
→ /docs/_project — project-wide truth (overview, stack, ownership, review cadence)  
→ /docs/adr — architecture decision records (immutable decisions)  
→ /docs/blueprint — layer guides, standards, examples  
→ /docs/process — workflows + templates used to run the project  
→ /docs/references — diagrams and external notes  

## Script Location
This step uses an existing script:

`scripts/init-docs.sh`

The script is already written. Please copy it to the base directory of your project

### Execute the script in your project

`chmod +x init-docs.sh`
`./init-docs.sh`

## Verification
- `docs/` exists with: `_project`, `adr`, `blueprint`, `process`, `references`
- Each directory contains a `README.md`
- `docs/blueprint/layers/*` exists and each layer directory contains a `README.md`
- Script created only directories and `README.md` files (no other placeholders)

## Commit
Commit message:  
`feat(docs): add docs structure and directory README framing`

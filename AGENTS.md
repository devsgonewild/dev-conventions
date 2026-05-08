# Agent guidance

This project follows shared conventions provided via the sibling
`dev-conventions/` repo, symlinked into:

- `.cursor/rules/` — operational rules (auto-loaded by Cursor).
- `.cursor/skills/` — agent skills.
- `docs/conventions/` — long-form prose referenced from the rules.
- `AGENTS.md` (this file) — shared orientation for any agent.

## Where to look

- **Rules**: `.cursor/rules/` covers testing, service layer, HTMX patterns,
  TDD design-review loop, and more. Each `.mdc` file's frontmatter controls
  when it applies.
- **Conventions**: `docs/conventions/` for long-form details (e.g.
  `testing.md`, `service-layer.md`, `evolution-and-compatibility.md`).
- **Tasks** (per-project, not shared): `docs/tasks/` — `open/`, `done/`,
  `completed.md`, and `CURRENT_HANDOFF.md` when multi-slice work is active.
- **Project-specific docs** (per-project): `docs/dev-doc/`, PRDs,
  implementation plans live alongside the project, not here.

## Editing rules vs. project code

- Project code → edit in this repo.
- Shared rules / skills / conventions / this file → edit in
  `../dev-conventions/` and commit there. The change is picked up
  automatically through the symlinks.

## Growing this file

This is intentionally a stub. Add shared guidance here as it emerges
(common workflows, agent etiquette, repo-shape orientation, etc.).
Project-specific guidance can live in a separate file at the project root
that complements this one.

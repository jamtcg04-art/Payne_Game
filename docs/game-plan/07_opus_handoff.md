# 07 — Handoff Rules for the Executing Thread

## Ground rules
1. Read files 00–06 first. Execute **milestones in order**; finish each milestone's "Done when" before starting the next.
2. **Excluded packs** (see file 02: Shooter Essentials + five unlicensed packs) are never committed; `.gitignore` covers `assets/third_party/{shooter_essentials,psx_brick_building,psx_cars,urbanman,detective_office,industrial_exterior}/`. Until jam supplies them locally, use CC0 packs and MK placeholders.
3. **Ask jam before**: choosing a different engine, making the repo public, committing third-party assets, any irreversible action, or adding paid dependencies.
3. Keep the game original. Never use names/characters/levels from existing games. Use names in file 01 or rename with jam's approval.
4. Everything the plan marks **[GUESS]** is changeable; if jam says otherwise, update the docs first, then code.
5. Do not edit anything in `assets/third_party/`; process into `assets/imported/`.
6. One milestone task per commit; Godot scenes and resources are text, so check diffs for accidental noise (UIDs ok, thumbnail caches no).
7. After each milestone, update `docs/STATUS.md` (what is done, what is blocked, open questions).

## First-session checklist (M0 + start of M1)
- [ ] `godot --version` available? If not, download the Godot 4.4+ Linux/headless build (check network access first).
- [ ] Verify the repo is empty and decide private/LFS/gitignore plan for assets (ask jam).
- [ ] Unpack asset zips into `assets/third_party/<pack>` (skip duplicate Shooter Essentials upload).
- [ ] Import check: open each pack's main file; log scale/orientation in `assets/DATA.md`.
- [ ] Create project, autoloads, input map, CI.
- [ ] Build `Test_Arena` and get a capsule moving with camera.

## Risks to watch
| Risk | Mitigation |
|---|---|
| UrbanMan rig not compatible with UAL | Fall back to UAL's mesh, retarget later; keep skin parts abstract |
| `.blend` import requires Blender | Batch-export GLB via headless Blender; else import directly |
| Ragdoll instability | Tune joint limits/damping, solver iterations; cap live ragdolls; freeze after 3 s at rest |
| Slow-mo breaking physics/audio | Use `time_scale` with fixed 60 Hz; test with 0.25; pitch-shift audio bus |
| Licenses unknown for packs 3, 4, 5, 8, 10 | Ask jam to confirm before shipping or publishing builds |
| No rifle/SMG animations | Pistol-first design; see stretch goals |

## Open questions for jam
1. ~~Engine~~ Answered: Godot 4 approved. Title "Static Hours" approved.
2. ~~Repo visibility~~ Answered: jam makes it private in GitHub settings; excluded packs stay out regardless.
3. Title, protagonist and city names OK? (Static Hours, Dez Harlan, Port Varro: placeholders.)
4. Audio: any source for music/SFX/voice, or should the plan assume placeholder sounds for now?
5. Scope: six missions plus hub fine? Controller support important?
6. Do you have licenses/store pages for packs 3, 4, 5, 8, 10 (PSX Brick, GGBot cars, UrbanMan, Detective Office, Industrial)?

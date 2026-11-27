# Project "Static Hours" (working title, a guess) — Game Plan

Original third-person noir shooter set in a rain-and-snow-soaked city. Inspired by the *feel* of early bullet-time noir shooters and gritty open-city crime games. **No copied names, characters, levels, story beats or assets.**

This folder is the plan a coding thread (Opus) executes step by step. Read in order:

| File | Contents |
|---|---|
| `01_engine_and_pillars.md` | Engine choice (guess), design pillars, original setting/story/names |
| `02_asset_inventory_and_licensing.md` | What each of the 11 uploaded zips contains, format, license, risks |
| `03_core_mechanics.md` | Gunplay, Hush Time (slow-mo), dives, ragdolls, healing, cover, vehicles |
| `04_levels_and_asset_mapping.md` | Level list, layouts, which assets build each one |
| `05_systems_architecture.md` | Godot project layout, autoloads, scenes, scripts, data resources |
| `06_milestones.md` | Phased milestones M0–M8 with concrete tasks and "done when" checks |
| `07_opus_handoff.md` | Rules and first-session checklist for the executing thread |

## Marked guesses (jam can change any of these)
Every guess is tagged **[GUESS]**. The big ones: engine = Godot 4; title; protagonist/city/story; PSX-retro-modern look; singleplayer, PC, ~6 missions plus a small open hub. Open questions are collected at the end of `07_opus_handoff.md`.

## Key findings from the asset inspection
1. Two uploaded zips are byte-identical (Shooter Essentials PolyPack ×2); treated as one pack.
2. Almost everything is FBX/GLB/OBJ/.blend, so it imports cleanly into Godot 4 with no conversion.
3. **Gaps:** no rifle/SMG/shotgun animations (the animation library has pistol only), no enemy-specific characters (one customizable "UrbanMan" body), no drivable-car rigs (static meshes), no interiors beyond one office.
4. **License risk:** Shooter Essentials forbids uploading assets to any repository; several packs have no license file at all. Details in file 02. Do not commit assets to a public repo.

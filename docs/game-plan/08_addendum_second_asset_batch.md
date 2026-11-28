# 08 — Addendum: Second Asset Batch (added 2026-11-28)

jam uploaded 24 more files. Duplicates found: **PSX Town Props sample ×2** (identical), **NY Street sampler ×2** (identical), and **Universal Animation Library** (identical to the one already in file 02). Treated as one each. Counts below are unique packs.

> **Not legal advice.** "Local-only" = keep out of git (gitignored) until jam confirms terms. Rule used: only CC0 packs may be committed; anything with a custom "no redistribution" license, or no license file, stays local. Many of these licenses forbid redistributing the raw files, which a repo may count as; jam making the repo private helps but does not settle it.

## Inventory

| Pack | Format | Contents | License as shipped | Repo? |
|---|---|---|---|---|
| **Cones & Barriers** | 32 GLB + 32 FBX | 4 cone types (+rubber variants), Jersey barriers (clean/dirty/broken centre/edge), type-2 barrier tops | no license file | local-only |
| **Buildings (rar)** | 1 GLB/FBX/DAE (10 meshes) + 54 textures | Building_01–09 as separate meshes in one file | no license file | local-only |
| **URBAN** | 483 GLB + 483 FBX, 5 `.blend` | Building Parts, Buildings Prebuild (hangars, flat/L-shaped), Walls & Fences (plaster, drystone, brick, picket, metal, wood, "placard" slabs), 104 road pieces, traffic lights, bus stops, cones & barriers, litter/dumpsters/trash cans, pipes, vents | no license file | local-only |
| **Metro_PSX (rar)** | 1 GLB/FBX/DAE (79 meshes) + textures | Subway station and subway car (seats, railings, doors, glass) | no license file | local-only |
| **PSX Derelict Furniture** | 6 × GLB/FBX/blend | chair, couch, fridge, mattress, shelf, vase | no license file | local-only |
| **DoriHome.fbx** | 1 FBX, 24 MB | Contents unknown (compressed FBX; likely a furnished home). Inspect in Godot/Blender | no license file | local-only |
| **3D Retro Plumbing & Wiring** | 9 `.blend` + textures | circuit breaker, generator, pipe valve, pipes, pump, switch, transformer, turbine, wires | no license file | local-only |
| **Street Furniture** | 13 FBX + `.blend` | cardboard, barrel, bottles, box, air conditioner, crowbar, flashlight, floppy disk, garbage bag, gas mask, hammer, old lock, trash can | no license file | local-only |
| **Trash and Debris** | 1 GLB/FBX/blend + PSDs, a `.unitypackage` | combined trash/debris set | no license file | local-only |
| **PSX Pistol Pack** | FBX + OBJ, textures | 5 pistol models (9 mm, Glock-style, USP-style, high-calibre, set) | no license file | local-only |
| **PSX Revolver Pack** | FBX + OBJ, textures | 5 revolver models incl. snub-nose and Python-style | no license file | local-only |
| **PSX Shotgun Pack** | FBX + OBJ, textures | 8 shotguns: pump, short pump, double-barrel, over-under, one-barrel + sawed-off variants | no license file | local-only |
| **PSX Cigarette Pack** | FBX + OBJ, textures | cigarette (full/smoked/snuffed/butt), pack (closed/open/foil) | no license file | local-only |
| **PSX Town Props FREE Sample** | 5 GLB+FBX, 256 px textures | trash can, fire hydrant, traffic cone, wooden crate, oil barrel (1 unit = 1 m) | Custom: commercial OK, no redistribution of files, no AI training. **Pack's own text says its models were produced with AI help** | local-only |
| **Stylized Ruined City Free Sampler** | 16 GLB+FBX, palette texture, colliders | 4 m wall modules (plain/window/door/shop front/broken/blast hole/parapet/pillar), wood floor, door with open animation, 16 m road tile, concrete barrier, sandbag wall, burning barrel, burnt car wreck (separable doors/wheels) | Custom: commercial OK, no redistribution | local-only |
| **NY Street Free Sampler** | GLB/FBX/OBJ, 2K PBR, 2 LODs | fire hydrant, payphone, wire litter basket (~20–28k tris at LOD0) | Custom: no redistribution of files | local-only |
| **NYC Alley Free Sampler** | GLB/FBX/OBJ, 2K PBR, 2 LODs | wet cardboard box stack, wooden pallet stack | Custom: no redistribution | local-only |
| **40 Free PSX Footsteps** | 40 OGG | 8 surfaces × 5: concrete, dirt, grass, gravel, metal, stairs, stone, wood | no license file | local-only |
| **Male Character VOX Pack** (ATTurtlez/JDSherbert) | WAV/OGG/MP3/M4A | grunt, die, jump, punch, sigh, "mhm", "bruh" with variations | Custom: royalty-free, **credit required**, do not copy/redistribute | local-only |
| **JDSFFX — Desert Eagle SFX (free)** | WAV/OGG, mono + stereo | pistol equip, aim, fire, dry-fire, reload | Custom: commercial OK, **credit required**, no redistribution of raw files, AI/ML use restricted | local-only |
| **160+ Cursors & Crosshairs (32×32)** | 1,702 PNG | crosshair/cursor sets in many colours | no license file | local-only |

## What changes in the plan

**Weapons (file 03 §3.2).** The pistol-first plan stays for *animation*, but models are no longer a gap:
- Pistols: 5 handguns; revolver: 5; shotguns: 8; plus the existing MGP7 machine pistol and grenades.
- Starter roster becomes: **pistol, revolver, machine pistol (MGP7), pump shotgun, sawed-off, frag grenade, flash grenade, bat**.
- Revolver and pistols share UAL pistol anims. Shotguns/sawed-off need two-handed holds: still no animation set, so use the pistol-aim pose with a procedural left-hand IK on a `GripL` marker. Still the biggest animation gap.
- **Originality:** several models resemble real firearm brands/models. In-game names, UI and code must be original (e.g. "Marlowe 9", "Kessler .38", "Dockhand pump"). Do not use brand names in shipped text.
- Shotgun/revolver SFX are still missing; only a Desert Eagle-style pistol SFX set exists (use it for the revolver/heavy pistol; layer pitch-shifted variants for others).

**Audio (answers the open question partly).**
- Footsteps: 8 surfaces map straight onto `SurfaceDB` (concrete, dirt, grass, gravel, metal, stairs, stone, wood). Add water/snow/glass later.
- VOX: grunt/die/jump/punch/sigh give player and enemy barks. The player's lines ("Mhm", "Bruh") are comic, so use sparingly or drop them; narration is not covered.
- Still missing: music, ambience (rain, traffic, sirens), impacts, explosions, shotgun/SMG fire, UI sounds. Needs a source or placeholders.

**Levels (file 04) — extra mapping.**
| Level | New assets |
|---|---|
| L0 Hub | URBAN roads (104 pieces), Walls & Fences, bus stops, traffic lights, Buildings.glb (10 buildings), Cones & Barriers, NYC/PSX Town props; Street Furniture pickups |
| L1 Paper Trail | PSX Derelict Furniture (couch, mattress, fridge, shelf, chair), DoriHome (if it is a home interior), cigarettes as clutter, pistol/revolver pickups |
| L2 Night Shift | Cones & Barriers + Jersey barriers for roadblocks, URBAN litter/dumpsters, NYC pallet/box clutter, Ruined City sandbag/concrete barrier |
| L3 Lowline | **Metro_PSX subway station + car** (new underpass/subway set piece), URBAN pipes/vents |
| L4 Ledger House | Plumbing & Wiring (fuse box, breaker, generator) for the basement/vault, Street Furniture clutter |
| L5 Harbor Authority | Ruined City burning barrel, burnt-car wreck, walls; URBAN hangars (Buildings Prebuild: `Hangar1`) |
| L6 Eight Floors Down | Plumbing & Wiring (pumps, turbine, pipes, valves) for the pump room; Trash and Debris for flooded tunnel |
| Props everywhere | Street Furniture (crowbar, hammer, flashlight, gas mask as pickups/melee), Trash and Debris, cigarette butts decals |

**Style mix.** Most packs are PSX low-poly. NY Street/Alley samplers are 2K PBR with 20k+ triangles at LOD0: use only LOD1 and run through the PSX shader (or skip) to keep the look consistent. Ruined City is stylized flat-palette; keep to sandbags, barrels, wreck.

**UI.** The cursors/crosshairs pack supplies crosshair candidates (32 px). Pick one, tint it by state.

## Import notes
- `.blend`-only packs (Plumbing, Street Furniture partly, Derelict extras): batch export to GLB via Blender headless (M0 task) or import `.blend` directly.
- Buildings and Metro are *one file with many meshes*: split into separate scenes by node name using `tools/import_assets.gd` (like Detective Office).
- Convert OGG only; ignore WAV/MP3/M4A duplicates.
- Record scale in `assets/DATA.md` after first import; Town Props is 1 unit = 1 m, Ruined City walls are 4 m modules (vs 3 m PSX brick): do not mix grids in the same `GridMap` layer.

## Updated exclusion list
Everything in this addendum is **local-only**. Updated `.gitignore` covers it under `assets/third_party/`. Only the four CC0 packs (Modular kit, Classic 64, Revline, UAL) are committable.

## Credits required (when shipping)
JDSherbert (VOX, Desert Eagle SFX), ATTurtlez (VOX), Alstra Infinite (Shooter Essentials), plus CC0 authors as a courtesy.

## New questions for jam
1. Which pack licenses can you confirm (store pages)? The ones with no license file stay out of any build you publish until then.
2. Is the AI-generated disclosure on PSX Town Props OK for you? It is only 5 props and easily replaced.
3. Do you want comic voice lines ("Bruh") in the game, or should I use only grunts/pain/death?
4. Still needed: music, ambience, shotgun/SMG sounds. Any sources, or placeholders?

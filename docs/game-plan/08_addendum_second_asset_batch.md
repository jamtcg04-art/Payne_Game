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

---
# Update 2026-11-28: jam's answers and music

**Answers from jam:** license/terms for all packs confirmed *for use in the game for now*; PSX Town Props (AI-assisted) approved; comic VOX lines approved. Confirmation covers using the assets in the game only. **They still stay out of the repo** (local-only) because most licenses forbid redistributing raw files.

## Music packs (new)
| Pack | Format | Contents | License as shipped |
|---|---|---|---|
| **Piano Pack** | 10 WAV | 10 piano tracks, 26–84 s each (Track 01–10) | no license file |
| **CHAOS — a collection of music** | 10 WAV + 10 OGG | 10 tracks, 45–180 s: Forgive Me, Fight Till Death, Speak Of The Devil, Frozen Hearts, Resurrection, Interlude To Chaos, Mastering Madness, Doom Prevails, Another Dawn, Last Fight | no license file |

Use the OGG files in Godot (WAV for the piano pack; convert to OGG at M0 to keep builds small). Loops: confirm each track loops cleanly; non-looping ones play as one-shots with a fade.

**Suggested mapping [GUESS; mapped from titles only, I have not listened]:**
| Use | Tracks |
|---|---|
| Hub, exploration, noir narration, menus, comic panels | Piano Pack 01–10 (quiet tracks for hub/menu, longer Track 06 for cutscenes) |
| Combat layer (adaptive) | Fight Till Death, Speak Of The Devil, Mastering Madness |
| Mission calm/tension | Frozen Hearts, Interlude To Chaos, Forgive Me |
| Set pieces | Resurrection (L3 yard), Doom Prevails (L5 docks) |
| Boss | Last Fight (L6 Usher) |
| Epilogue/credits | Another Dawn |

## Music system (add to file 05 autoloads → `Audio`)
- `MusicDirector`: two `AudioStreamPlayer`s (calm, combat) with crossfade 1.5 s; state driven by `Events` (`enemy_alerted` → combat; no alerts for 8 s → calm).
- `data/music/<level>.tres` (`MusicSet`: calm tracks, combat tracks, stinger) so tracks are assigned per level in data, not code.
- Hush Time: low-pass filter + pitch to 0.6 on the music bus (already planned for the world bus); piano tracks duck 6 dB under dialogue.
- Fallback if a track is missing (local-only assets): silent bus with a console warning, never a crash.

## Audio gaps remaining
Ambience (rain, traffic, sirens, wind), impacts, explosions, shotgun/revolver/SMG fire, UI sounds, voice narration. Pistol SFX exist (Desert Eagle set). Next step: jam to say whether to source more, or keep placeholders.

## Decision (jam, 2026-11-28): placeholders for the missing audio
Ambience, impacts, explosions, shotgun/revolver/SMG fire, UI sounds and narration use **placeholders for now**.
- Create `audio/placeholder/` with one short generated sound per event id (e.g. synthesized noise bursts/tones via a `tools/gen_placeholder_audio.gd` or Python script; no downloads, no licensing issues). Files named by event id: `sfx_shotgun_fire`, `sfx_revolver_fire`, `sfx_impact_<surface>`, `sfx_explosion`, `amb_rain_loop`, `amb_city_loop`, `ui_click`, etc.
- `Audio` autoload looks up sounds by event id from `data/audio/sfx.tres`; swapping in real audio later means changing the resource path only.
- Narration: on-screen text with a typewriter effect and a short blip; no voice-over until jam decides.
- Track each placeholder in `docs/audio_todo.md` so replacements are easy to find.

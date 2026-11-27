# 06 — Milestones (each task is one commit-sized step)

Estimate unit = one focused coding session. "Done when" lines are the acceptance checks; run them before moving on.

## M0 — Foundation (1–2 sessions)
1. Create Godot 4.4+ project; set Jolt, 60 Hz physics, window 1280×720, low-res viewport option; commit `.gitignore`, `.gitattributes`, `README.md`.
2. Place raw uploads in `assets/third_party/<pack>/` (decision: private repo vs. gitignored; **ask jam first**, see licensing). Skip the duplicate Shooter Essentials zip. Record units in `assets/DATA.md`.
3. Write `tools/import_assets.gd` and batch-convert Classic 64 `.blend` → GLB (Blender headless script `tools/blender_export.py`) if Blender is available; otherwise import `.blend` directly.
4. Autoload stubs (`Game`, `Events`, `Settings`, `TimeFX`, `Audio`, `Pool`, `Save`), input map, GUT, CI workflow.
**Done when:** project opens with 0 errors; headless smoke test passes in CI; `assets/DATA.md` lists scale and format per pack.

## M1 — Player and animation (2–3 sessions)
1. Build `Test_Arena.tscn` from MK ground, walls, ramps, stairs, cubes (grey-box).
2. Import UAL `UAL1_Standard.glb`; create `AnimationLibrary`; build `AnimationTree` (locomotion BlendSpace2D, aim pitch BlendSpace1D, actions).
3. Import UrbanMan parts; **retarget to UAL skeleton** (Godot `BoneMap`/`SkeletonProfileHumanoid`). **Fallback if retarget fails:** use UAL's own mesh body as player and skin NPCs later.
4. Third-person camera rig, movement states (idle/walk/jog/sprint/crouch/jump), collision, step handling.
**Done when:** player runs around the arena at 60 fps, all locomotion animations play, camera collides with walls, no foot sliding >10 cm in test.

## M2 — Gunplay (2–3 sessions)
1. `WeaponData` + `WeaponBase`; pistol using ZC57 mesh on right-hand socket; aim, fire, recoil, spread, reload (UAL pistol anims), ammo HUD.
2. Impact system: `SurfaceDB`, decals, sparks, tracers, brass shells, muzzle flash.
3. Target dummies (RigidBody) and `HealthComponent`; hit markers; hit-stop.
4. Add MGP7 (machine pistol) with upper-body hold pose.
**Done when:** headshot/body multipliers verified by tests; fire rate within 2% of data; effects pooled (no allocations per shot after warm-up).

## M3 — Hush Time and Throw (2 sessions)
1. `TimeFX`: time_scale ramp, gauge, audio filter, vignette/desat, bullet trails.
2. Throw (dive) state with aim-while-airborne, prone/get-up, auto-Hush.
3. UI Hush meter; tuning pass using `data/player.tres`.
**Done when:** time scale lerps correctly, pause ignores it, gauge rules match file 03, Throw works from sprint and idle.

## M4 — Ragdolls and enemies (3 sessions)
1. Build ragdoll scene with PhysicalBones (`tools/build_ragdoll.gd`), death + partial flinch + impulses.
2. Enemy scene (Thug) with nav, perception, shoot/take-cover/chase states; bake nav in arena.
3. Enemy variety with UrbanMan parts (hoodie up/down, cap, glasses, sunglasses) and tint.
4. Explosive barrel and frag grenade with radial ragdoll impulse; corpse cap and cleanup.
**Done when:** 10 enemies at 60 fps; ragdolls stable (no jitter explosions) across 100 randomized kill tests; corpse cap enforced.

## M5 — Health, cover, pickups, destructibles (2 sessions)
1. HealthComponent finalization, Steadies pickup/use, low-health FX, death/checkpoint reload, save/load.
2. Cover points + cover state, blind fire.
3. Glass shatter, cardboard box and prop breakage using C64/RV items; shotgun weapon + Heavy enemy.
**Done when:** save/load round-trips; cover state works at 5 sample points; destructibles spawn pooled debris.

## M6 — Level kit and Hub (3–4 sessions)
1. Build `kit_modular.tres` and `kit_psx_brick.tres` MeshLibraries; GridMap workflow documented.
2. Placeholder prop library (`PH_*.tscn`), RV/SE/C64 prop scenes with collision + surface meta.
3. Build **L0 Hub** per file 04 with traffic loops, NPC pedestrians, Pia's stand, Teddy's office (DO split).
4. One drivable car (`VehicleBody3D`), enter/exit, engine audio.
**Done when:** hub walkable from end to end, navmesh covers all walkable areas, load time <5 s, 60 fps on mid GPU.

## M7 — Missions L1–L3 (4–5 sessions)
1. L1 "Paper Trail": apartment, scripted beats, tutorial prompts, comic-panel intro.
2. L2 "Night Shift": streets + bar interior, roadblock set pieces.
3. L3 "Lowline": rail yard with explosive set pieces.
4. Objectives system, checkpoints, mission end screen.
**Done when:** each level completable start to finish, 3 checkpoints each, no blocked paths, perf budget met.

## M8 — Missions L4–L6 and polish (5–7 sessions)
1. L4 Ledger House, L5 Harbor Authority, L6 Eight Floors Down incl. Usher boss.
2. Music/SFX pass (decision on audio sourcing), voice-over text, subtitles, settings menus, controller polish.
3. Balance pass, difficulty levels, accessibility options (reduce flashing, hold-to-toggle).
4. Export builds (Linux/Windows), credits screen from `CREDITS.md`.
**Done when:** full playthrough with no softlocks; QA checklist in `docs/qa.md` passes.

## Stretch (post-M8, ask jam)
Two-handed weapons with extra animation sets, rifle/shotgun anims, additional hub streets, side contracts, stealth takedowns, photo mode, New Game+.

## Performance budgets
- 60 fps at 1080p on a mid-range GPU; ≤3,000 draw calls per frame (use MultiMesh for repeated props), ≤12 live ragdolls, ≤20 active AI, ≤256 pooled decals.

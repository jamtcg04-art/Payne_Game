# 03 — Core Mechanics (Godot 4, GDScript)

All tunables live in `data/*.tres` resources (see file 05) so balancing needs no code edits.

## 3.1 Player movement and camera
- Over-the-shoulder camera: `SpringArm3D` on a pivot; shoulder offset swaps sides (Q/bumper). Aim zoom narrows FOV and pulls in the arm.
- States (state machine): `Idle, Walk, Jog, Sprint, Crouch, Aim, Throw (dive), Prone, GetUp, Cover, Reload, Melee, Dead, Driving`.
- Character: `CharacterBody3D`, capsule 0.35 m radius, 1.8 m tall. Movement accel/decel curves; turn rate limited while aiming.
- Animations (UAL): Idle_Loop, Walk_Loop, Jog_Fwd_Loop, Sprint_Loop, Crouch_Idle/Fwd, Jump_Start/Loop/Land, Roll, Pistol_Idle/Aim_Up/Neutral/Down (blended by camera pitch via `BlendSpace1D`), Pistol_Shoot, Pistol_Reload, Hit_Chest/Head, Death01, Punch_Jab/Cross, Interact, PickUp_Table, Driving_Loop.

## 3.2 Gunplay
- Hitscan from camera ray to world, then bullet visual tracer from muzzle. Spread grows while moving/firing, shrinks while still/crouched.
- Weapons as `WeaponData` resources: damage, rpm, mag size, reserve, reload time, recoil pattern (curve), spread, range, ammo type, headshot multiplier, hit-stop ms, sound/muzzle ids.
- **Update (file 08):** the second asset batch adds pistol, revolver and shotgun models; roster is now pistol, revolver, machine pistol, pump shotgun, sawed-off, grenades, bat. Use original in-game names.
- Starter loadout: **pistol** (placeholder = ZC57 mesh), **machine pistol** (MGP7), **sawn shotgun** (primitive mesh placeholder, M5), **frag grenade** (M67), **flash grenade** (M84), **bat** melee (primitive).
- Feedback: camera kick, muzzle flash light (1 frame), brass ejection (RigidBody shells from `Bullet_*_Shell`), decals on impact (bullet holes by material), screen-space hit marker, 40 ms hit-stop on kill.
- Surface table: `SurfaceType` on collision layer metadata → impact VFX/sound (concrete, metal, wood, flesh, glass, water).
- Destructibles: glass (swap to shards, M5), explosive barrels (`FuelBarrelV1` → `FuelBarrelV1_Destroyed` + radial impulse + damage), cardboard boxes (break to physics bits), bottles/cans (Classic 64 food/drink items) as small RigidBody props.

## 3.3 Hush Time (slow motion)
- Original name; behaves like bullet time. Press **Hush** to enter a gauge-limited slow state.
- Implementation: `Engine.time_scale` lerps to 0.25 (config) over 0.15 s; player-only time via `player_time_scale = 1 / Engine.time_scale * 0.6` multiplier on player movement/aim/animation speed so the player remains somewhat faster than the world. Physics tick stays 60 Hz; set `Engine.physics_ticks_per_second` unchanged and rely on `time_scale` (Godot scales physics delta too).
- Gauge `hush_energy` 0–100: drains 18/s, refills on kills (+20 headshot, +12 body) and 4/s passively. Cannot trigger below 15.
- Audio: low-pass bus filter + pitch shift on world bus; heartbeat loop; whoosh on enter/exit. Visual: slight desaturation + bullet trail ribbons (`Trail3D` with `ImmediateMesh`) + vignette.
- **Throw** (dive) auto-triggers Hush for its duration (0.9 s real) when gauge ≥ 15 and sets the player invulnerable-to-aimed-flinch (not to damage).
- Edge cases: pause menu uses `process_mode = ALWAYS` and ignores time_scale; timers use `ignore_time_scale = true` for UI.

## 3.4 Throw (dive)
- Direction = movement input relative to camera (default forward). Launch 4.5 m/s impulse, 0.35 s airborne, 0.5 s prone.
- While airborne and in Hush you can aim and fire (the Aim anim layers over a dive pose; placeholder: Roll + pistol arm layer).
- Landing: ragdoll-lite (briefly physics-driven spine) for weight, then `GetUp`; getting up takes 0.7 s, sprint-cancel allowed.
- Collision: capsule shrinks to 0.6 m tall during dive; enemies' bullets still hit.

## 3.5 Ragdolls
- Skeleton: UAL 65-bone humanoid. `PhysicalBoneSimulator3D` with a `PhysicalBone3D` per major bone (pelvis, spine ×2, head, upper/lower arm ×2, thigh/shin ×2, hands/feet optional). Build via editor script `tools/build_ragdoll.gd` (one-time, then saved as scene).
- On death: play Death01 for 0.15 s blend → start simulator; apply hit impulse at hit bone proportional to weapon impulse; keep corpses 20 s then fade (cap 12 live ragdolls; oldest sleeps/freeze).
- Partial reaction: on hit, `physical_bones_start_simulation(["head","spine_02"])` for ~0.2 s with a small impulse for flinch while the rest animates.
- Explosions: radial impulse to all bodies and ragdolls in range; ragdolls can be pushed by cars (vehicle collision layer, impulse scaled by speed).
- Tuning: joint limits via `JointType.CONE`, angular damp 4, linear damp 0.5, Jolt solver iterations raised to 12; mass per bone from a table.
- Collision layers: `1 world, 2 player, 3 enemy, 4 ragdoll, 5 props, 6 vehicle, 7 trigger, 8 bullet-blocker`. Ragdolls collide with 1, 5, 6; not with each other's capsules but yes with their own limbs (self-collision off).

## 3.6 Health and Steadies
- Health 0–100, **slow regen is OFF**. Steadies (amber pill packs) heal 25 each, max carry 6; pickups spawn in apartments/bins (Classic 64 `food_*`/`MedKitV1` mesh).
- Using one takes 0.8 s (anim: Interact) and cannot be used at full health. Damage while healing cancels nothing (risk/reward).
- Low-health feedback: red edge vignette, heartbeat, tinnitus filter, sluggish aim.
- Down-state: at 0 health → `Dead` → fade, reload last checkpoint (autosave at room transitions + quicksave key).

## 3.7 Cover and melee
- Cover: raycast detects `CoverPoint` nodes (low/high) placed on props via the kit; stick-to-cover by interact key; blind fire and peek (animation = crouch idle + aim up).
- Melee: Punch_Jab/Cross on short range cone; knockback ragdoll on heavy hits; `CombatKnifeV1` as finishing pickup (M6).

## 3.8 Enemies (AI)
- Based on `UrbanMan` parts; archetypes: **Thug** (pistol, rushes), **Gunman** (machine pistol, takes cover), **Heavy** (shotgun, slow, high health, M5), **Usher** (boss, M7).
- `NavigationAgent3D` + baked `NavigationRegion3D` per level. Behaviour tree (or simple state machine): `Patrol/Idle → Alert → Chase/Take Cover → Flank → Retreat`.
- Perception: vision cone 100°, 30 m; hearing events from gunshots/grenades; alert propagation radius 15 m.
- Hush Time awareness: enemies react at world-time; difficulty settings change reaction delay and accuracy.
- Telegraph: laser/flashlight attachments from Shooter Essentials drawn on enemy guns (cosmetic).

## 3.9 Vehicles (M6, optional vertical slice)
- `VehicleBody3D` with 4 `VehicleWheel3D`; arcade handling tuned for grip; cars from GGBot pack, wheel mesh separate.
- Enter/exit with interact; player pose Driving_Loop. Engine loop audio from the pack's OGG. Police/taxi variants as ambient traffic on rails (path-follow) in the hub.
- Simplest first: one drivable sedan in Hub; NPC traffic = `PathFollow3D` loops (no AI driving).

## 3.10 Presentation
- PSX shader: vertex snap (grid 1/160), texture affine warp toggle, 8-bit colour dither, low-res `SubViewport` (default 640×360, scaled with nearest filter). Toggle for "modern" mode (full res, no snap).
- Fog + volumetric lights + rain particles + wet-road reflections (SSR or fake reflective plane).
- Graphic-novel cutscenes: still panels (generated in-engine from viewport captures + Control frames) with voice-over text; skippable.
- UI: ammo, health, Hush meter (ring), Steadies count, objective line, subtitles.

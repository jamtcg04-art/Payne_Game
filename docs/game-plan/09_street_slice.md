# 09 — First Playable Street Slice (vertical slice)

Builds on files 03, 04, 05, 06. Engine: Godot 4.4+, GDScript, Jolt. This slice is a thin, finished-feeling cut of M0–M4 on one small map, meant to answer one question: **does it feel good?**

## 0. Decisions from jam (override anything below that conflicts)
1. **Map:** the street plus apartment slice first. The apartment later becomes the main hub, and a mission has the player escape the apartment. So build the apartment interior as a reusable scene (`apartment.tscn`) with a hub-ready layout, not a throwaway.
2. **Guns:** machine pistol first, then shotgun. The pistol stays as the starting sidearm for the tutorial beat; the machine pistol is the slice's second gun, and the shotgun is added right after (Task C5 below). Shotgun uses PSX Shotgun pack, local only.
3. **Look:** both looks ship as options in settings: low-res PSX (640x360, vertex snap, dither) and modern-res grain and grade. Default is modern-res until jam says otherwise. Task F1 builds both with a settings toggle.
4. Story bible: tone is dark; the open questions there are left open.

Added tasks: C5 shotgun (spread pellets, pump reload, heavy knockback and ragdoll impulse), F7 settings menu with the look toggle, G1 apartment-escape beat (locked front door, a window/fire escape exit, 2 enemies breaching) as the first hub-apartment mission seed.
Question 2's machine-pistol and question 3's options are now settled.

## 1. Goal and success test
A 5–7 minute playable: start on a rainy street, fight through it into an apartment, end on the roof door. Pass criteria:
- Moving, aiming and shooting feels weighty, not floaty.
- Shooting a thug visibly staggers them, and killing one produces a believable ragdoll.
- Pressing Throw (dive) enters slow motion and you can shoot mid-air.
- A screenshot reads as "noir" with no explanation.
- 60 fps at 1280×720 on a mid GPU, with 6 enemies alive.

Out of scope: vehicles, cover system, grenades, save/load, music, cutscenes, hub, voice lines.

## 2. The map: "Cinder Street, Block 1" (L1 prologue cut)
One 3-floor tenement plus the street in front of it. Grey-box first, kit/dressing second.

```
 [Alley B: dumpster, fire escape, ladder to roof]
 ┌────────────── street 60 m × 14 m ───────────────┐
 │ spawn (W)  lamp  parked cars  lamp  barrels  door│ → apartment 1F lobby
 └──────────────────────────────────────────────────┘
 Apartment: 1F lobby+stairs → 2F hallway (2 flats) → roof door (end)
```
Beats (in order):
1. **Spawn, walk-up (45 s).** Rain, steam vents, one flickering sign. Teach move, camera, aim with an empty street.
2. **Street fight A (1 min).** 2 Thugs behind parked cars, pistol only. Teach aim, recoil, reload.
3. **Pickup.** Machine pistol on a bench or in the alley (2nd gun).
4. **Lobby door (30 s).** Doorway with 2 Thugs inside. Teaches Throw: the prompt appears when the player nears the door.
5. **Stairwell and 2F hallway (2 min).** 1 Gunman at the end plus 1 Thug in a flat. Tight space, best place to test Hush Time and ragdoll impact on walls and stairs.
6. **Roof door.** Fade out and "slice complete" card with stats (time, kills, accuracy).

Total: 6 enemies (5 Thugs, 1 Gunman). Pickups: 2 Steadies, 3 ammo boxes.

## 3. Feature spec (slice cut)
**Controller.** Over-the-shoulder SpringArm camera, shoulder swap, aim zoom. States: Idle, Walk, Jog, Sprint, Crouch, Aim, Reload, Throw, GetUp, Dead. Skip Prone, Cover, Melee, Jump. Tunables in `data/player.tres`.

**Weapons (2).** Pistol (original name, ZC57 mesh placeholder), machine pistol (MGP7). Hitscan from camera ray, tracer from muzzle. Per-gun recoil curve plus spread that grows while moving. Feedback list, all required for "weight": camera kick, 1-frame muzzle light, brass shells (pooled RigidBody), bullet decals by surface, hit marker, 40 ms hit-stop on kill, screen shake scaled by gun. Two surface types for the slice: concrete and flesh, plus metal for cars.

**Enemies.** Thug (pistol, rushes) and Gunman (machine pistol, holds position). Navmesh, vision cone, hearing, simple state machine: Idle → Alert → Chase/Shoot → Dead. Hit reaction: partial ragdoll on head/spine for 0.2 s, full ragdoll on death with impulse at the hit bone. Corpse cap 8.

**Ragdolls.** UAL skeleton with PhysicalBones, built once by `tools/build_ragdoll.gd`. Jolt, joint limits, damping per file 03 §3.5. Risk item: tuning for stairs.

**Hush Time and Throw.** Per file 03 §3.3–3.4: time_scale to 0.25 over 0.15 s, player runs at about 60% of world speed, gauge 0–100. Throw triggers Hush automatically, lets you aim and fire in the air, then lands and gets up. Audio low-pass and heartbeat, trails on bullets, vignette.

**Noir look.**
- Low-res SubViewport at 640×360 with nearest-filter upscale (toggle for modern res).
- Post shader: film grain (animated, luminance-weighted), strong vignette, 3-tone colour grade (crushed blacks, cool teal shadows, warm amber highlights), slight desaturation, optional scanline/dither.
- Lighting: dark ambient, 3–4 practical lights (street lamps, window, flickering sign), volumetric fog, rain particles, wet-road reflection via SSR or a fake reflective plane. Light puddles on the road.
- Hush Time pushes the grade further: more desaturation, blue shift, stronger vignette.

**Audio (placeholders).** Rain loop, gunshots from Shooter Essentials/pack SFX locally, footsteps by surface, impact thuds. Music none; we can add a Piano Pack loop to test mood.

**UI.** Crosshair from the 32 px cursors pack, ammo, health bar, Hush ring, Steadies count, and a "press Hush/Throw" hint. Debug overlay: fps, enemy count, time_scale.

## 4. Task breakdown (each is one commit-sized step)
Estimates in focused sessions (S) of roughly 1–2 h.

### Phase A — Foundation (≈1.5 S)
| # | Task | Done when |
|---|------|-----------|
| A1 | Godot project: Jolt, 60 Hz, 1280×720, `.gitignore` for third-party assets, folder layout from file 05 | opens with 0 errors |
| A2 | Autoload stubs (`Game`, `Events`, `TimeFX`, `Audio`, `Pool`) and input map | smoke test passes headless |
| A3 | Import CC0 packs (modular kit, Classic 64, UAL) and record scale in `assets/DATA.md` | assets load; scale documented |
| A4 | Grey-box block `street_block1.tscn` per beats 1–6 | walkable end to end with placeholder colliders |

### Phase B — Player (≈2 S)
| # | Task | Done when |
|---|------|-----------|
| B1 | Camera rig with collision, shoulder swap, aim FOV | camera never clips walls |
| B2 | CharacterBody3D movement states and acceleration curves | no jitter on stairs |
| B3 | AnimationTree with UAL locomotion and pistol aim blend | no foot sliding > 10 cm |
| B4 | Character mesh and retarget (fallback: UAL body) | player visible and animated |

### Phase C — Gunplay (≈2 S)
| # | Task | Done when |
|---|------|-----------|
| C1 | `WeaponData`, `WeaponBase`, pistol with recoil, spread, reload | fire rate within 2% of data |
| C2 | Impact system: decals, sparks, tracers, brass, muzzle flash, hit-stop | pooled, no allocations per shot |
| C3 | Machine pistol and weapon swap | both feel distinct |
| C4 | Target dummies and `HealthComponent` | headshot/body multipliers tested |

### Phase D — Enemies and ragdolls (≈3 S)
| # | Task | Done when |
|---|------|-----------|
| D1 | Ragdoll build tool and scene; death impulses | 100 random kills with no jitter explosions |
| D2 | Partial flinch ragdoll on hit | head/spine react while legs keep animating |
| D3 | Thug AI with navmesh, perception, shoot/chase | fights the player around cars |
| D4 | Gunman variant and spawn triggers per beat | all 6 enemies placed |
| D5 | Corpse cap and cleanup | cap of 8 enforced |

### Phase E — Hush Time and Throw (≈2 S)
| # | Task | Done when |
|---|------|-----------|
| E1 | `TimeFX` ramp, gauge, player-time compensation, pause ignores it | matches file 03 §3.3 |
| E2 | Throw state, aim while airborne, landing, get-up | works from sprint and idle |
| E3 | Hush audio and visual layer, Hush ring UI | readable and non-nauseating |

### Phase F — Look and polish (≈2.5 S)
| # | Task | Done when |
|---|------|-----------|
| F1 | Low-res viewport and post shader: grain, vignette, grade | A/B toggle shows clear difference |
| F2 | Rain, fog, wet road, lights per beat | screenshot reads as noir |
| F3 | Dress the block with Revline/Classic 64/street furniture props | no visibly empty areas |
| F4 | Audio pass (rain, shots, steps, impacts) | every action has sound |
| F5 | HUD, prompts, end card with stats | slice has a clear start and end |
| F6 | Tuning pass on `data/*.tres` and performance check | 60 fps with 6 enemies |

**Total ≈ 13 sessions.** Critical path: A → B → C → D → E, with F1/F2 startable once A4 exists. Tasks C and the F-look tasks can run in parallel.

## 5. Risks and mitigations
- **Retargeting UrbanMan to UAL fails** → use UAL's own mesh for player and enemies, retint per enemy.
- **Ragdoll instability on stairs** → raise Jolt iterations, add damping, cap angular velocity, and freeze after 3 s asleep.
- **Slow-mo breaks timers/audio** → all UI and pause timers use `ignore_time_scale`; test pause in Hush early (E1).
- **Noir look costs too much** → keep SSR optional, use a fake reflection plane as the default.
- **Only pistol animations exist** → machine pistol reuses pistol aim/shoot anims with a different socket; fine for a slice.
- **Licensing** → only CC0 packs get committed (per file 02); anything else stays local and gitignored.

## 6. Questions for jam
1. Is the 6-beat map right, or would you rather an apartment-only slice (denser, cheaper) with no street?
2. Is the pistol + machine pistol pair fine, or do you want the sawn shotgun instead of the machine pistol (more impact, fewer shots)?
3. Should the low-res PSX look be the default, or the modern-res grain-and-grade look?
4. (Answered by the coordinator) Don't scaffold a new project. Another thread built the M0 skeleton on branch claude/project-thread-tdrxry, awaiting jam's OK to push. Slice work builds on top of that branch once it's pushed, so Phase A is mostly done.

## 7. Asset notes for the slice (from the uploaded packs)
- Guns: use the PSX Pistol, Revolver and Shotgun packs. Pistol plus revolver is a strong two-gun pair, and the shotgun is the stretch option for question 2. Their licensing follows file 02 and 08, so they stay local and gitignored.
- Street and alley: the NY street and NYC alley samplers, Street Furniture, Trash and Debris and URBAN can dress the block (F3). Keep them local, since only CC0 packs may be committed.
- Audio: Piano Pack and the CHAOS collection can test the mood. Both stay local.
- Animation: Universal Animation Library (CC0) provides the pistol aim, shoot and reload set. Revolver and shotgun reuse the pistol animations.
- This document refines milestones M0 to M4 from files 03 and 06 and doesn't replace them.

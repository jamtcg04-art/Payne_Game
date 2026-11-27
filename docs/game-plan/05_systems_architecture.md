# 05 — Systems Architecture (Godot 4.4+, GDScript)

## Repo layout
```
Payne_Game/                      (rename freely)
  project.godot
  README.md  CREDITS.md  .gitignore  .gitattributes (LFS for glb/fbx/png/ogg if private)
  assets/third_party/<pack>/...   <- raw uploads; see licensing note (private repo or gitignored)
  assets/imported/                <- processed GLB, atlases, materials we author
  assets/DATA.md                  <- scale/units/notes per pack
  data/                           <- .tres resources: weapons, enemies, surfaces, levels, player
  scenes/
    player/ enemy/ weapons/ props/ vehicles/ ui/ fx/ kit/ levels/
  scripts/
    autoload/ player/ enemy/ weapons/ systems/ ui/ tools/
  shaders/ (psx_surface.gdshader, post_process.gdshader, wet_floor.gdshader)
  audio/ (buses.tres, placeholders)
  tests/ (GUT)
  tools/ (editor scripts, batch exporters)
  docs/ (copy of this plan)
```

## Autoloads (singletons)
| Name | Role |
|---|---|
| `Game` | state machine: boot, menu, loading, playing, paused, cutscene, game over; scene transitions; checkpoint save/load |
| `TimeFX` | Hush Time: time_scale lerp, gauge, audio filter hooks, `player_time_scale` |
| `Events` | typed signal bus: `enemy_died`, `player_hit`, `gunshot(pos, loudness)`, `explosion(pos, radius)`, `objective_changed`, `pickup_taken` |
| `Audio` | bus control, one-shot pools, music state, surface-sound lookup |
| `Settings` | input remaps, graphics (PSX/modern toggle, resolution scale), difficulty, volume, persisted to `user://settings.cfg` |
| `Pool` | object pools for bullets/tracers/decals/shells/particles |
| `Save` | JSON save at checkpoints: level, checkpoint id, health, ammo, weapons, steadies, flags |

## Core scenes and scripts
- `player/Player.tscn` (`CharacterBody3D`): children: `Model` (UAL skeleton + UrbanMan skin), `CameraRig` (pivot → SpringArm3D → Camera3D), `WeaponSocket` (BoneAttachment3D at right hand), `StateMachine`, `Health`, `HushComponent`, `Inventory`, `Interactor`.
  - `scripts/player/player.gd`, `player_states/*.gd` (one script per state, `enter/exit/physics_update`), `camera_rig.gd`, `aim.gd`, `interactor.gd`.
- `weapons/WeaponBase.tscn` + `weapon.gd` reading `data/weapons/*.tres` (`WeaponData`: damage, rpm, mag, reserve, spread curve, recoil curve, range, impulse, hitstop_ms, sfx ids, mesh scene). `projectile` only for grenades (RigidBody3D with timed fuse).
- `enemy/Enemy.tscn` (`CharacterBody3D`): `NavigationAgent3D`, `Perception` (cone + hearing), `Brain` (state machine), `Health`, `Ragdoll` (PhysicalBoneSimulator3D), weapon. Archetype config in `data/enemies/*.tres` (`EnemyData`).
- `systems/HealthComponent.gd`: `take_damage(amount, hit_info)` emits `damaged`, `died`; hit_info has `bone`, `impulse`, `point`, `weapon`.
- `systems/Ragdoll.gd`: `activate(hit_info)`, `partial_hit(bones, impulse)`, handles pooling/freeze.
- `systems/SurfaceDB.gd`: maps material/`surface` meta to VFX + SFX.
- `systems/Checkpoint.gd`, `Objective.gd`, `Trigger.gd`, `CoverPoint.gd`, `Pickup.gd`, `Destructible.gd`, `ExplosiveBarrel.gd`.
- `vehicles/Car.tscn` (`VehicleBody3D`) + `car.gd`; `traffic/TrafficLoop.gd` (PathFollow3D).
- `ui/HUD.tscn`, `PauseMenu.tscn`, `MainMenu.tscn`, `ComicPanel.tscn`, `Subtitles.tscn`.

## Kit / level building
- `tools/import_assets.gd` (EditorScript): walks `assets/third_party/**`, imports GLB/FBX, creates `scenes/kit/<pack>/<piece>.tscn` with collision (convex for props, trimesh for architecture), assigns shared materials, records metadata (surface type from filename keywords).
- `tools/build_meshlibrary.gd`: builds `MeshLibrary` resources (`kit_modular.tres`, `kit_psx_brick.tres`) for `GridMap` (cell 3×3×3 m).
- Levels: `GridMap` layers for shell + manual `Node3D` groups for props (`Props`, `Lights`, `Enemies`, `Pickups`, `Checkpoints`, `CoverPoints`), `NavigationRegion3D`, `WorldEnvironment`, `LevelConfig` resource (music, objectives, spawn).
- Grey-box → art pass: swap `MeshLibrary` item meshes, geometry layout stays.

## Rendering
- `SubViewportContainer` (low-res) → PSX post (dither, colour-quantize). `psx_surface.gdshader`: vertex snap in clip space, optional affine UV, unshaded/lit toggle, nearest-neighbour textures.
- Lighting: baked `LightmapGI` for interiors if cheap; otherwise a few `OmniLight3D` with shadows off except key lights; fog + volumetric fog on in exteriors.

## Physics
- Jolt (`physics/3d/physics_engine = "Jolt Physics"`), 60 Hz. Layers as in file 03. Ragdoll solver iterations raised. Vehicles use `VehicleBody3D` (Godot default physics for vehicle if Jolt lacks parity; test in M6).

## Input map (default)
WASD move, mouse aim, LMB fire, RMB aim, R reload, Shift sprint, C crouch, Space throw (dive/jump context), Q swap shoulder, F Hush Time, E interact, H use Steadies, 1–4 weapons, G grenade, Esc pause. Full gamepad map equivalents.

## Testing and CI
- GUT unit tests: health math, weapon fire-rate, gauge drain, save/load, inventory.
- Headless smoke test: `godot --headless --quit-after 300 scenes/levels/Boot.tscn` must not log errors.
- GitHub Action (M0): lint with `gdtoolkit` (`gdlint`, `gdformat --check`), headless import check, run GUT.
- Export presets: Linux/Windows; builds via CI artifact (no assets in public artifacts).

## Conventions
- Static typing everywhere (`var x: float`), `class_name` on reusable scripts, signals up / calls down, no cross-scene node paths: use groups and the `Events` bus.
- All numbers in resources, not hard-coded. Each system has a `docs/<system>.md` stub.
- Commit small, one milestone task per commit.

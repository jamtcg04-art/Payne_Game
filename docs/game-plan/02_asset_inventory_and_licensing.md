# 02 — Asset Inventory and Licensing

Source: the 11 uploaded zips, each unzipped into its own directory and inspected (contents treated as data). File counts exclude duplicates. "Godot import" = how to bring it in.

> **Not legal advice.** Licenses below are what the files in each zip state. Where a zip has no license file, it is marked **UNKNOWN**; jam should confirm with the source page before shipping.

## Summary table

| # | Pack | Format | What it gives | License as shipped | Ship risk |
|---|---|---|---|---|---|
| 1 | Free 3D Modular Game Assets For Prototyping (Rgsdev) | 81 FBX, 1 `texture.png` | Grey-box kit: walls, wall corners/doors/windows, ground, stairs, ramps, pillars, railings, fences, ladders, doors, cubes/cones/cylinders/spheres, spikes, coin/key/arrow/switch, a `Character.fbx`, 5 sample scenes | **CC0** (License.txt) | Low |
| 2 | Shooter Essentials PolyPack Starter (Alstra Infinite) **(uploaded twice, identical)** | 38 FBX + 38 GLB, 1 texture | 2 rigged guns (MGP7, ZC57) with attachments (optic, suppressor, handles, light, laser, foregrip), 2 grenades (M67, M84), sandbags, ammo boxes, med kit, fuel barrel (+destroyed), field radio, canteen, knife, bullets/shells/belts | **Custom (Alstra Infinite)**: commercial OK, credit required (full license §3.5), **may not be uploaded to any repository or marketplace**, no AI training | **Medium**: keep out of public git |
| 3 | PSX Modular Brick Building | 12 GLB + preset building, `.blend`, textures | 3 m snap grid: Wall-Basic, Window-Basic/Cover, Door-Basic/Cover/Roof, Roof-Basic/Side/Side-Broken/Corner-In/Out, Store-Basic; texture atlas | **UNKNOWN** (README says "purchased", no license file) | Medium: confirm |
| 4 | PSX Style Cars (GGBot) | OBJ+MTL+.blend+PNG skins, 16 OGG | 8 cars (Car 01–08) with colour/snow/taxi/police/mail skins, Wheel, shadow blob, engine/door/accel sounds | **UNKNOWN** (only an itch.io link) | Medium: confirm |
| 5 | UrbanMan (PolyMate_MaleV1) | 20 FBX (rigged body parts) | Body, head, hands, cargo legs, shoes, hoodie up/down, cap, glasses, sunglasses | **UNKNOWN** (same art style as Alstra; no file) | Medium: confirm |
| 6 | Classic 64 Asset Pack 0.6 (Craig Snedeker) | 130 `.blend`, 383 PNG, 349 JPG | Huge PSX-style library: buildings, windows, doors, floors, roads, walls, roofs, panels, signs, shelves, food, books, boxes, vehicles, industrial, nature, rocks, tools, water, wood, **materials/textures** | **CC0** (Readme; some textures modified from CC0 OpenGameArt packs) | Low |
| 7 | Revline LowPoly Street Props | 30 props × GLB/FBX/OBJ + parts | Benches, lamps, bins, mailbox, bus stop, traffic light, signs, hydrant, bollard, fences, gate, planter, picnic table, barriers, cone, phone booth, ATM, billboard, news stand, bike rack, street clock, vending machine, parking meter | **CC0** (LICENSE.txt, GamePip) | Low |
| 8 | DetectiveOffice | 1 OBJ + 1 FBX + `Col_Shemes.7z` (colour schemes) | One combined office set: lockers, shelf, boxes, books, pinboard, frames, fan, coat hanger, door, window, walls | **UNKNOWN** (no license file) | Medium: confirm |
| 9 | Universal Animation Library [Standard] (Quaternius) | GLB ×2 (+ `_RM` root-motion), FBX ×2 | 43 animations on a 65-bone humanoid: idle, walk, jog, sprint, crouch, jump, **roll**, hit (chest/head), death, **pistol aim up/neutral/down, idle, shoot, reload**, punch, push, interact, sit, driving, swim, sword, spell, dance | **CC0** | Low |
| 10 | Industrial exterior v1 (folder `Industrial_exterior_v2`) | 1 FBX (`IndustrialHorror_PS_like`) + 68 PNG | Combined industrial set with diffuse + normal textures: buildings 1–13, cargo containers, barrels, pipes, ventilation, cooling tower, generator, fence, roadblock, pallets, bags, road/asphalt, bridges | **UNKNOWN** (no license file) | Medium: confirm |

(Numbering here is the plan's own; the zip upload order differed.)

## Per-pack import notes (Godot 4)
1. **Modular kit:** import FBX as scenes; all share `texture.png`. Create one `StandardMaterial3D` and assign. Verify unit scale on first import (one wall segment = module size; record it in `assets/DATA.md`). Generate trimesh/convex collision per piece (Import dock → Generate Physics).
2. **Shooter Essentials:** use GLB. Guns are "Rigged" (animated bolt/slide bones). One shared 256px texture. Fuel barrel has a "Destroyed" variant (swap on explosion).
3. **PSX Brick Building:** use the 12 GLBs; 3 m grid, snap 3 m. Atlas texture; use nearest-neighbour filtering.
4. **Cars:** import OBJ (or GLB re-export from `.blend`). Skins are PNG per colour: build a material per skin. Wheels are a separate mesh. Build own `VehicleBody3D`; no rigs supplied.
5. **UrbanMan:** FBX body parts share a skeleton. Retarget to Godot humanoid/UAL skeleton (see M1). Hoodie, cap, glasses are swappable parts for NPC variety.
6. **Classic 64:** `.blend` files need Blender in Godot's editor settings, or batch-export GLB once (script provided in M0). Use the **materials/textures** (jpg/png) as the common PSX material library for floors/walls/roads.
7. **Revline props:** use GLB (single mesh) for static dressing and `parts/*.glb` for breakable props (parking meter, bollard, hydrant).
8. **DetectiveOffice:** one combined mesh. In Blender (or Godot's scene "Make unique + separate") split by object name (Lockers, Shelf, Pinboard…), then rebuild as separate nodes so desks/books can be physics props.
9. **Universal Animation Library:** use `Unreal-Godot/UAL1_Standard.glb` (non-root-motion) for gameplay; `_RM` for cutscenes. Build an `AnimationLibrary` resource from it; the README's Godot setup image shows the expected import (extract animations to a library).
10. **Industrial exterior:** one big FBX; split into scene pieces (buildings, containers, barrels) for the Docks level.

## Asset gaps and chosen workarounds
| Gap | Workaround |
|---|---|
| No SMG/rifle/shotgun animations | Pistol-only at first (UAL pistol set). Add two-handed weapons later by procedural upper-body IK/rotation on the pistol-idle pose, or add more free animations (jam's call). |
| Only one character body | Enemy variety from swappable parts (hoodie up/down, cap, glasses, sunglasses) plus per-instance colour tint on the single texture. Boss ("The Usher") gets a mask mesh built from primitives. |
| Cars not rigged | Own `VehicleBody3D` setup, wheels attached by script. |
| No interiors besides one office | Build apartments, bars, warehouses, offices from modular kit + Brick Building + Classic 64 walls/floors/doors/shelves. |
| No audio except car sounds (16 OGG) | Use car sounds. Everything else: placeholder generated beeps, then replace. Needs jam's decision on free audio sources. |
| No UI, skybox, VFX | Built in-engine (particles, shaders, Control nodes). |

## Repo exclusion list (decided with jam, 2026-11-27)
Keep these **out of the repo** (gitignored under `assets/third_party/`, kept locally) until licenses are confirmed:
- **Shooter Essentials PolyPack** — license forbids uploading to any repository.
- **PSX Modular Brick Building**, **PSX Style Cars (GGBot)**, **UrbanMan**, **Detective Office**, **Industrial exterior** — no license file found.

Safe to commit (CC0): Modular Prototyping Kit, Classic 64, Revline Street Props, Universal Animation Library. Repo should still be made private by jam in GitHub settings; the plan is built so work can start with the CC0 packs only (grey-box levels, UAL animations, Revline props, Classic 64 materials) and the excluded packs slot in locally.

> **Second batch of uploads is in `08_addendum_second_asset_batch.md`; all of it is local-only.**

## Licensing actions
- [ ] **Keep the excluded packs above out of git.** Shooter Essentials explicitly forbids repositories. Use a *private* repo, or add `assets/third_party/` to `.gitignore` and share a zip separately. **Ask jam which** (repo visibility is unknown).
- [ ] Add `CREDITS.md` crediting Rgsdev, Quaternius, GamePip, Craig Snedeker (CC0 credit not required but kind), and Alstra Infinite (required by their license).
- [ ] Confirm licenses for packs 3, 4, 5, 8, 10 by finding their original store pages; save the license text into `assets/third_party/<pack>/LICENSE.txt`.
- [ ] No pack may be used for AI training or redistributed as standalone files.
- [ ] Classic 64 asks not to be directly resold; fine inside a game.

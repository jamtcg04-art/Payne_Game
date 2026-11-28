# 04 — Levels and Asset Mapping

Six missions plus a hub. Each level = a Godot scene `levels/<name>.tscn` composed from **piece scenes** (see file 05 "Kit" section) placed on a 3 m grid using `GridMap` (MeshLibrary) for shells and manual placement for props. **Grey-box first** with the free modular kit, then swap pieces for PSX/Classic 64 variants without changing layout.

**Module size [GUESS, verify at import]:** 3 m grid (matches the PSX Brick Building spec). If the Modular kit differs, add a scale factor in its import script and record it.

## Asset legend
- **MK** = Free Modular Prototyping Kit (walls, wall door/window/corner, ground, stairs, ramps, pillars, railings, fences, ladders, doors, cubes/cylinders/cones/spheres).
- **PB** = PSX Modular Brick Building. **C64** = Classic 64 (floors, roads, walls, doors, windows, shelves, signs, food, books, boxes, industrial, nature, vehicles).
- **RV** = Revline Street Props. **SE** = Shooter Essentials. **CAR** = GGBot cars. **UM** = UrbanMan. **DO** = Detective Office. **IX** = Industrial exterior. **UAL** = animations.
- **MK-as-props** = placeholder objects built from MK primitives (cube/cylinder/sphere) with tint materials, replaced later: cars-not-chosen, crates, dumpsters, couches, beds, tables, desks, counters, bars, TVs.

---
## L0 — Hub: "Cinder Street" (open mini-city, ~4 blocks)
**Purpose:** safe zone, Pia's news stand (buy/store Steadies), mission board, one drivable car.
**Layout (top-down, 120 × 120 m):** a plus-shaped intersection. N: tenement row (PB buildings, 3 floors, mostly closed doors, 2 enterable). E: Teddy's office (DO). S: pocket park + alley to Docks gate. W: Pia's stand + bus stop + underpass.
- Shells: PB walls/doors/windows/roofs for buildings; MK for the extra upper floors, fire escapes (railing, ladder, stairs), rooftop ramps.
- Ground: C64 road + sidewalk materials on MK ground tiles (road decals: crosswalk RV sign).
- Props: RV (benches, lamps, bins, mailbox, hydrant, phone booth, bus stop, news stand, ATM, vending, parking meters, traffic light, bollards), CAR (parked/NPC loops), C64 trees/bushes in park.
- NPCs: UM with variants as pedestrians (idle/walk only).
- Interiors: Teddy's office = DO split into nodes.

## L1 — "Paper Trail" (tenement apartment, tutorial)
**Beats:** wake after delivery gone wrong → shot at in apartment → learn move/aim/reload → first Hush Time → first Throw through a doorway.
**Layout:** 1 apartment building, 4 floors, 2 apartments per floor around a central stairwell; corridors 2.4 m; ends on rooftop.
- Shells: PB Wall/Door/Window/Roof for exterior; interiors from MK walls (grey-box) with C64 floor/wall materials.
- Props: C64 books/food/boxes/shelves; RV bins; MK-as-props for couches, beds, tables.
- Enemies: 4 Thugs, 1 Gunman. Pickups: 1 Steadies, 2 ammo (SE `AmmoBox`).
- Set piece: fire escape chase (MK ladder/stairs/railing) over a street gap, rooftop entry.

## L2 — "Night Shift" (downtown streets and a diner/bar interior)
**Beats:** meet Pia; escape police roadblock; shootout at a bar; first cover firefights.
**Layout:** 2 long streets with side alleys (80 × 60 m) and a bar (30 × 20 m, two floors) with a back kitchen. Roadblocks (SE sandbag walls + RV barriers).
- Props: RV barriers, cones, traffic light, ATM, billboard; SE sandbags, med kit; C64 shelves/food for bar and kitchen; MK-as-props for bar counter, stools, tables, pool table.
- Enemies: Thugs and Gunmen; destructible glass storefronts (M5).
- Vehicles: parked CAR taxi/police skins as cover (physics shove).

## L3 — "Lowline" (rail yard + underpass)
**Beats:** train yard chase, exploding barrels, cargo container maze.
**Layout:** long, flat, 150 × 70 m; rail tracks (MK ground + custom rail strips), container stacks (IX cargo/C64 shipping container), signal gantry (RV traffic lights as signals).
- Props: IX barrels/pipes/pallets; SE fuel barrel (explosive); RV fences/gates; MK pillars/ramps for platforms.
- Enemies: Gunmen at height, Heavies introduced.

## L4 — "The Ledger House" (office tower interior; stealth-optional)
**Beats:** infiltrate office floors; storage vault; boss intro (The Usher, offscreen).
**Layout:** 6 stacked floors, each 24 × 24 m with a central core; elevator sequence (loading screen with comic panels).
- Shells: MK walls/doors/windows/ground (grey-box walls reused as office partitions); C64 floors/ceiling tiles/panels.
- Props: DO (desk fixtures, lockers, shelves, pinboard, frames), C64 books/papers/shelves, RV vending/ATM/clock; MK-as-props for desks and chairs.
- Features: security cameras (cosmetic), flashlight attachments on enemies, hostage room.

## L5 — "Harbor Authority" (docks, warehouses, exteriors)
**Beats:** big exterior firefight with Hush set pieces; crane yard; warehouse with truck.
**Layout:** 200 × 120 m open docks; 3 warehouses, crane tower, loading bay, break-room interior.
- Props & shells: IX entire set (buildings 1–13, containers, cooling tower, generator, roadblocks, bridges, asphalt, fences); C64 industrial; SE sandbags/ammo boxes/fuel barrel; RV light poles and barriers.
- Enemies: Gunmen, Heavies, rooftop snipers (M7), explosive barrel chains.

## L6 — "Eight Floors Down" (finale: Usher boss + escape)
**Beats:** drops into a half-flooded service tunnel network under the harbor authority, boss fight in a circular pump room, escape up to street at dawn.
**Layout:** linear tunnel (MK ground/walls/pillars scaled, C64 concrete/pipe materials), pump room 30 m diameter with catwalk (MK railing/stairs/ramp), final stairwell.
- Boss: The Usher (UM + custom mask mesh). Phases: (1) pistol fire with Hush counter, (2) lights out + flashlight, (3) melee rush. Ragdoll on death with slow-mo camera.

---
## Cross-level prop kit (reused everywhere)
| Category | Source | Examples |
|---|---|---|
| Street furniture | RV | bench, lamp, bin, mailbox, hydrant, phone booth, ATM, vending, barrier |
| Combat props | SE | sandbags, ammo boxes, fuel barrel, radio, med kit |
| Clutter | C64 | books, food, cans, boxes, tools, shelves, papers |
| Architecture | PB + MK + C64 | walls, doors, windows, roofs, stairs, railings, ladders, floors |
| Industrial | IX + C64 | containers, pipes, vents, cooling tower, generator, asphalt |
| Vehicles | CAR | 8 cars, taxi, police, mail |
| Placeholders | MK primitives | furniture (couch, bed, table, bar), crates, dumpsters, TV |

## Placeholder strategy (MK as stand-in props)
Create `props/placeholder/` scenes from MK cubes/cylinders with a named material (e.g. `ph_wood`, `ph_metal`, `ph_cloth`), carrying `PropData` (mass, surface type, breakable flag). Each real asset later replaces the mesh node, not the logic. Naming: `PH_<Thing>.tscn` → `<Thing>.tscn`.

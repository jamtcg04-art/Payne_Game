# 01 — Engine, Pillars, Setting

## Engine: Godot 4.4+ (stable), GDScript **[GUESS — jam can change]**
Why, based on the uploaded assets and the workflow:
- **Assets are GLB/FBX/OBJ/.blend.** Godot 4 imports all of them natively (even `.blend` directly if Blender is installed; otherwise export GLB). The Universal Animation Library ships a ready `Unreal-Godot/` GLB and a Godot setup screenshot.
- **AI-friendly source.** Scenes (`.tscn`), resources (`.tres`) and GDScript are plain text, so a coding agent can write and review everything in git diffs. Unreal relies on binary `.uasset` files and Blueprints, which an agent cannot edit well.
- **PSX look is cheap in Godot** (spatial shaders: vertex snapping, affine-ish texture warp, low-res viewport, dithering). Several packs are PSX-styled already.
- **Ragdolls:** `PhysicalBoneSimulator3D` + Jolt physics (built in since 4.4) gives usable partial and full ragdolls. Vehicles: `VehicleBody3D`.
- Free, small, fast iteration, headless export and tests (`godot --headless`, GUT test framework).
- Trade-off: not as photoreal as UE5. For a "retro-modern" target that is acceptable. If jam wants Unreal later, assets (GLB/FBX) carry over; code does not.

## Pillars
1. **Time as a weapon.** Hush Time (slow motion) and dives make every firefight a readable, cinematic puzzle.
2. **Weighty, gritty gunplay.** Heavy recoil, hit-stop, brass casings, ragdoll reactions, limited ammo. Pistols-first.
3. **A city with a pulse.** Wet streets, neon, steam, flickering signs; hub streets and tight interiors alternate.
4. **Noir voice.** Monologue narration, comic-panel style cutscenes (cheap, original, atmospheric).
5. **Retro-modern.** Low-poly PSX-era meshes and low-res textures, but modern lighting, fog, post-processing, physics.

## Original setting and story **[GUESS]**
- **City:** *Port Varro*, a fictional winter harbor city: rail yards, an industrial waterfront, brick tenements, a downtown financial strip.
- **Protagonist:** *Dez Harlan*, a disgraced ex-transit-police officer turned process server. (Use the UrbanMan body: hoodie/cap/sunglasses variants.)
- **Hook:** A routine paper delivery ends with a dead client and Dez's prints on everything. Someone is framing him; a ledger tied to the harbor authority is the key.
- **Antagonists (original):** the *Greywater Combine* (smuggling crew run out of the docks), a crooked deputy commissioner *Orla Venn*, and a masked enforcer called *The Usher*.
- **Allies:** *Pia Okafor*, a night-shift news-stand owner and informant; *Teodor "Teddy" Brandt*, a retired detective (the Detective Office).
- **Tone:** snowfall, sodium streetlights, rainy alleys, sparse jazz/drone score.
- **Healing item (original name):** **Steadies**, amber blister packs from Pia's stand. **Slow motion:** **Hush Time**. **Dive:** **Throw**. Rename freely.

## Scope **[GUESS]**
PC, single player, 6 missions (~3–4 h), small free-roam hub street in the middle. Controller + mouse/keyboard. No multiplayer.

extends Node
## Typed signal bus. Systems talk through here instead of node paths.

signal enemy_died(enemy: Node, hit_info: Dictionary)
signal player_hit(amount: float, hit_info: Dictionary)
signal gunshot(position: Vector3, loudness: float)
signal explosion(position: Vector3, radius: float)
signal objective_changed(objective_id: StringName)
signal pickup_taken(pickup_id: StringName)

extends Node
## Hush Time (slow motion). Stub: real gauge, audio filter and player_time_scale come in M3.

var player_time_scale: float = 1.0
var active: bool = false

func set_active(value: bool) -> void:
	active = value
	Engine.time_scale = 0.3 if value else 1.0

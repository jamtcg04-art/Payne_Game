extends Node
## Boot scene: confirms autoloads are alive, then hands off to the menu (later milestone).

func _ready() -> void:
	print("Static Hours boot OK, state=%s" % Game.State.keys()[Game.state])

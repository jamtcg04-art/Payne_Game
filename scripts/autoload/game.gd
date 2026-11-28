extends Node
## Global game state machine. Scene transitions and checkpoints arrive in later milestones.

signal state_changed(new_state: State)

enum State { BOOT, MENU, LOADING, PLAYING, PAUSED, CUTSCENE, GAME_OVER }

var state: State = State.BOOT


func set_state(new_state: State) -> void:
	if new_state == state:
		return
	state = new_state
	state_changed.emit(state)

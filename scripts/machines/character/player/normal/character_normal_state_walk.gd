extends state


func state_enter(last_state):
	pass
	

func state_exit(next_state):
	pass
	
func state_logic(delta):
	if parent.parent.path.size() > 0 :
		parent.parent.move_path(delta)
		parent.parent.handle_movement_cancel_input(delta)

	
func state_transitions(delta):
	if parent.parent.path.size() == 0:
		return Enum.character_normal_state.character_normal_state_idle


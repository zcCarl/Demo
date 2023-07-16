extends character_base_state
class_name character_normal_state_walk
func state_enter(last_state):
	pass
	

func state_exit(next_state):
	pass
	
func state_logic(delta):
	if context.path.size() > 0 :
		context.move_path(delta)

	
func state_transitions(delta):
	if context.path.size() == 0:
		return Enum.character_normal_state.character_normal_state_idle


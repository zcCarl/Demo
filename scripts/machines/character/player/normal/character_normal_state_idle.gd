extends character_base_state

class_name character_normal_state_idle

func state_enter(last_state):
	Signals.on_character_path.connect(on_input_click_ground)
	pass
	
func on_input_click_ground(path):
	if context.path.size() == 0:
		context.add_path(path)
	pass
func state_exit(next_state):
	pass
	
func state_logic(delta):
	#parent.parent.handle_movement_point_input(delta)
	pass
	
func state_transitions(delta):
	if context.path.size() > 0:
		return Enum.character_normal_state.character_normal_state_walk

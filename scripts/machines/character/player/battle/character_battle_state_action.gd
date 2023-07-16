extends character_base_state

class_name character_battle_state_action

func state_enter(last_state):
	
	#context._drag_item.set_enable(true)
	pass
	

func state_exit(next_state):
	
	#context._drag_item.set_enable(false)
	pass
	
func state_logic(delta):
	if context.path.size() > 0 :
		context.move_path(delta)

	
func state_transitions(delta):
	if context.action_point == 0:
		return Enum.character_battle_state.character_battle_state_ready



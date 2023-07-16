extends character_base_state

class_name character_battle_state_ready

func state_enter(last_state):
	pass
	
func state_exit(next_state):
	pass
	
func state_logic(delta):
	
	pass
	
func state_transitions(delta):
	if context.action_point > 0:
		return Enum.character_battle_state.character_battle_state_action
	pass

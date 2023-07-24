extends character_base_state

class_name character_battle_state_action

func state_enter(last_state):

	#context._drag_item.set_enable(true)
	pass
	

func state_exit(next_state):
	
	#context._drag_item.set_enable(false)
	pass
	
func state_logic(delta):
	if context.path.size()>0 and not context.is_move:
		context.move_index = 1
		context.move_step()
	pass

	
func state_transitions(delta):
	if context.action_point <= 0 and ! context.is_move:
		context.turn_end()
		return Enum.character_battle_state.character_battle_state_ready



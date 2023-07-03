extends state


func state_enter(last_state):
	pass
	

func state_exit(next_state):
	pass
	
func state_logic(delta):
	parent.parent.handle_movement_point_input(delta)
	pass
	

func state_transitions(delta):
	
	pass

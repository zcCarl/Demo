extends state


func state_enter(last_state):
	parent.parent._drag_item.set_enable(true)
	pass
	
func state_exit(next_state):
	parent.parent._drag_item.set_enable(false)
	pass
	
func state_logic(delta):
	
	pass
	
func state_transitions(delta):
	pass

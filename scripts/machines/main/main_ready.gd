extends state


func state_enter(last_state):
	pass
	

func state_exit(next_state):
	pass
	
func state_logic(delta):
	ui_root.open("res://scene/ui/ui_main_ready.tscn",Enum.ui_layer.fullscreen_root)
	pass
	

func state_transitions(delta):
	pass

extends Node
class_name state

@onready var parent:state_machine = get_parent()

func on_enable():
	pass
	
func on_disable():
	pass

func state_enter(last_state:state):
	print("enter state: "+name)
	pass
	
func state_exit( next_state:state):
	print("exit state: "+name)
	pass

func state_logic(delta):
	pass

func state_transitions(delta):
	pass

extends RefCounted
class_name state

var parent:state_machine

func _init(_parent:state_machine):
	parent = _parent

func on_enable():
	pass
	
func on_disable():
	pass

func state_enter(last_state:state):
	var script = get_script() as Script
	print("enter state: " + script.resource_path)
	pass
	
func state_exit( next_state:state):
	var script = get_script() as Script
	print("exit state: " + script.resource_path)
	pass

func state_logic(delta):
	pass

func state_transitions(delta):
	pass

extends Node

# We define a class to be used by other nodes.
class_name state_machine
var states= {} 
			
# We define the current and the old state.
var cur_state:state = null
var last_state:state = null
@export var enable:bool = false

func _enter_tree():
	init_states()

func _ready():
	pass

func init_states():
	pass
		
func set_enable(_enable):
	enable = _enable
	if enable:
		on_enable()
	else :
		on_disable()
		
func on_enable():
	if cur_state!=null:
		cur_state.on_enable()
	pass
func on_disable():
	if cur_state!=null:
		cur_state.on_disable()
		
# The _physics_process function is the recommended function for object loops that use physics
# The delta argument is updated with each frame.
# We apply the logic of the current state, as well as checking if you need to change the state, if necessary, change the state.
func _physics_process(delta):
	if enable and cur_state !=null:
		cur_state.state_logic(delta)
		var transition =cur_state.state_transitions(delta)
		if transition != null:
			set_state(transition)

func get_state(state_key):
	return states[state_key]

# Leaves the current state and enters the new state.
func set_state(state_key):
	var new_state = get_state(state_key)
	if new_state:
		last_state = cur_state
		cur_state = new_state
		if last_state != null:
			last_state.state_exit(new_state)
		if new_state != null:	
			new_state.state_enter(last_state)


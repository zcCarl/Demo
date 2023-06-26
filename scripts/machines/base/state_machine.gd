extends Node

# We define a class to be used by other nodes.
class_name state_machine

# We define the current and the old state.
var state = -1: set= set_state
var previous_state = null
var enable:bool = false
# We use a dictionary to define the states, to be defined by whoever inherits this script.
var states = {}
# We leave the father of this Node with easy access.
@onready var parent:base_character = get_parent ()

func set_enable(_enable):
	enable = _enable
	if enable:
		on_enable()
	else :
		on_disable()
		
func on_enable():
	pass
func on_disable():
	set_state(null)
# The _physics_process function is the recommended function for object loops that use physics
# The delta argument is updated with each frame.
# We apply the logic of the current state, as well as checking if you need to change the state, if necessary, change the state.
func _physics_process(delta):
	if enable and state > -1:
		_state_logic(delta)
		var transition =_get_transitions(delta)
		if transition != null:
			set_state(transition)
# Contains the current state logic
func _state_logic(_delta):
	pass

# Make appropriate transitions between states.
func _get_transitions(_delta):
	pass

# Function for entering a new state.
func _enter_state(_new_state, _old_state):
	pass

# State exit function.
func _exit_state(_old_state, _new_state):
	pass

# Leaves the current state and enters the new state.
func set_state(new_state):
	previous_state = state
	state = new_state
	if state == null :
		state = -1
	if previous_state != null:
		_exit_state(previous_state, new_state)
	if new_state != null:	
		_enter_state(new_state, previous_state)

# Adds a new state.
func add_state(state,state_name):
	states[state] = state_name

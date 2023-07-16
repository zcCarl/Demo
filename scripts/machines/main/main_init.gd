extends state
class_name main_init
func state_enter(last_state):
	super.state_enter(last_state)
	modules.load_option()
	parent.set_state(Enum.main_state.main_ready)
	pass

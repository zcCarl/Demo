extends state

func state_enter(last_state):
	super.state_enter(last_state)
	modules.load_setting()
	parent.set_state(Enum.main_state.main_ready)
	pass

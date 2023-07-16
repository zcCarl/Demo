extends state_machine
class_name main_machine

@onready var parent = get_parent()

func init_states():
	states[Enum.main_state.main_init] = main_init.new(self)
	states[Enum.main_state.main_ready] = main_ready.new(self)
	states[Enum.main_state.main_save] = main_save.new(self)
	states[Enum.main_state.main_game] = main_game.new(self)

func on_enable():
	super()
	set_state(Enum.main_state.main_init)


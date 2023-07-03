extends state_machine
class_name main_machine

@onready var parent = get_parent()

func init_states():
	states[Enum.main_state.main_init]=$main_init
	states[Enum.main_state.main_ready]=$main_ready
	states[Enum.main_state.main_save]=$main_save

func on_enable():
	super()
	set_state(Enum.main_state.main_init)


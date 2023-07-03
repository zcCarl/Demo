extends state_machine
class_name character_machine_normal

@onready var parent = get_parent()

func init_states():
	states[Enum.character_normal_state.character_normal_state_idle]=$character_normal_state_idle
	states[Enum.character_normal_state.character_normal_state_walk]=$character_normal_state_walk

func on_enable():
	super()
	set_state(Enum.character_normal_state.character_normal_state_idle)


extends state_machine
class_name character_battle_machine

@onready var parent:character = get_parent()

func init_states():
	states[Enum.character_battle_state.character_battle_state_ready] = $character_battle_state_ready
	states[Enum.character_battle_state.character_battle_state_action] = $character_battle_state_action
	states[Enum.character_battle_state.character_battle_state_over] = $character_battle_state_over

func on_enable():
	super()
	set_state(Enum.character_battle_state.character_battle_state_ready)

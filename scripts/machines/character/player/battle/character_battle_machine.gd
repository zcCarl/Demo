extends state_machine
class_name character_battle_machine

func init_states():
	super()
	states[Enum.character_battle_state.character_battle_state_ready] = character_battle_state_ready.new(self,get_parent())
	states[Enum.character_battle_state.character_battle_state_action] = character_battle_state_action.new(self,get_parent())
	states[Enum.character_battle_state.character_battle_state_over] = character_battle_state_over.new(self,get_parent())

func on_enable():
	super()
	set_state(Enum.character_battle_state.character_battle_state_ready)

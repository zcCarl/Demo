extends state_machine
class_name character_machine_normal

func init_states():
	states[Enum.character_normal_state.character_normal_state_idle]=character_normal_state_idle.new(self,get_parent())
	states[Enum.character_normal_state.character_normal_state_walk]=character_normal_state_walk.new(self,get_parent())

func on_enable():
	super()
	set_state(Enum.character_normal_state.character_normal_state_idle)


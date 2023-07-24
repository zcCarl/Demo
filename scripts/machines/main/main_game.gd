extends main_state
class_name main_game
func state_enter(last_state):
	var _module_save = modules.get_module(modules.module_enum.module_save) as module_save
	modules.on_enter_game(_module_save.get_save_index())
	var packed_scene = preload("res://scene/game.tscn") as PackedScene
	context.Game = packed_scene.instantiate() as game
	context.add_child(context.Game)
	context.Game.setup()
	pass
	

func state_exit(next_state):
	pass
	
func state_logic(delta):
	
	pass
	
func state_transitions(delta):
	pass

extends main_state
class_name main_save
var ui_save:ui_main_save 

func state_enter(last_state):
	super.state_enter(last_state)
	Signals.on_create_game_save.connect(create_save)
	Signals.on_load_game_save.connect(load_save)
	Signals.on_delete_game_save.connect(delete_save)
	ui_save = await ui_root.open(ui_config.ui_module_enum.ui_main_save) as ui_main_save
	pass

func create_save(save_index):
	modules.create_game(save_index)
	ui_save.set_save(save_index)
	parent.set_state(Enum.main_state.main_game)
	pass
func load_save(save_index):
	modules.load_game(save_index)
	parent.set_state(Enum.main_state.main_game)
	pass
func delete_save(save_index):
	modules.delete_game(save_index)
	ui_save.set_save(save_index)
	pass

func state_exit(next_state):
	super.state_exit(next_state)
	ui_root.close(ui_config.ui_module_enum.ui_main_save)
	pass
	
func state_logic(delta):
	pass
	

func state_transitions(delta):
	
	pass

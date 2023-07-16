extends state
class_name main_ready

func state_enter(last_state):
	super.state_enter(last_state)
	Signals.on_ui_main_ready_start.connect(start)
	Signals.on_ui_main_ready_continue.connect(contunue)
	Signals.on_ui_main_ready_save.connect(save)
	Signals.on_ui_main_ready_exit.connect(exit)
	ui_root.open(ui_config.ui_module_enum.ui_main_ready)
	pass
func start():
	var _module_save = modules.get_module(modules.module_enum.module_save) as module_save
	if !_module_save.has_save():
		modules.create_game(0)
		#开始新的存档
		parent.set_state(Enum.main_state.main_game)
	
func contunue():
	var _module_save = modules.get_module(modules.module_enum.module_save) as module_save
	if _module_save.has_save():
	#继续上次的存档
		var save_index = _module_save.get_struct().get_save_index()
		if _module_save.get_save(save_index):
			parent.set_state(Enum.main_state.main_game)
		else:
			parent.set_state(Enum.main_state.main_save)
		
func save():
	#进入存档界面
	parent.set_state(Enum.main_state.main_save)
	
func exit():
	#退出游戏
	Engine.get_main_loop().quit()
	


func state_exit(next_state):
	super.state_exit(next_state)
	ui_root.close("res://scene/ui/ui_main_ready.tscn")
	Signals.on_ui_main_ready_start.disconnect(start)
	pass


func state_logic(delta):
	pass
	

func state_transitions(delta):
	pass

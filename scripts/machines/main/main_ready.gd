extends state


func state_enter(last_state):
	super.state_enter(last_state)
	Signals.on_ui_main_ready_start.connect(start)
	Signals.on_ui_main_ready_continue.connect(contunue)
	Signals.on_ui_main_ready_save.connect(save)
	Signals.on_ui_main_ready_exit.connect(exit)
	ui_root.open(ui_config.ui_module_enum.ui_main_ready)
	pass
func start():
	var last_index = modules._module_user.save_index
	if last_index == -1:
		modules.create_game(0)
	#开始新的存档
	parent.set_state(Enum.main_state.main_game)
	
func contunue():
	#继续上次的存档
	var last_index = modules._module_user.save_index
	if last_index > -1:
		if modules._module_save.get_save(last_index):
			parent.set_state(Enum.main_state.main_game)
	
func save():
	#进入存档界面
	parent.set_state(Enum.main_state.main_save)
	
func exit():
	#退出游戏
	get_tree().get_root().propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		get_tree().quit() # default behavior

func state_exit(next_state):
	super.state_exit(next_state)
	ui_root.close("res://scene/ui/ui_main_ready.tscn")
	Signals.on_ui_main_ready_start.disconnect(start)
	pass


func state_logic(delta):
	pass
	

func state_transitions(delta):
	pass

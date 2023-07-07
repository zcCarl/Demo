extends ui_base
class_name ui_main_ready

# Called when the node enters the scene tree for the first time.
func _ready():
	print(modules._module_user)
	$bg/v/start.pressed.connect(func():Signals.on_ui_main_ready_start.emit())
	$bg/v/continue.pressed.connect(func():Signals.on_ui_main_ready_continue.emit())
	$bg/v/save.pressed.connect(func():Signals.on_ui_main_ready_save.emit())
	$bg/v/exit.pressed.connect(func():Signals.on_ui_main_ready_exit.emit())
	$bg/v/start.visible = modules._module_user.save_index == -1
	$bg/v/continue.visible = modules._module_user.save_index > -1
	pass # Replace with function body.



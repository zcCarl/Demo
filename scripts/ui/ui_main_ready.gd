extends ui_base
class_name ui_main_ready

# Called when the node enters the scene tree for the first time.
func _ready():
	$bg/v/start.pressed.connect(func():Signals.on_ui_main_ready_start.emit())
	$bg/v/continue.pressed.connect(func():Signals.on_ui_main_ready_continue.emit())
	$bg/v/save.pressed.connect(func():Signals.on_ui_main_ready_save.emit())
	$bg/v/exit.pressed.connect(func():Signals.on_ui_main_ready_exit.emit())
	var _module_save = modules.get_module(modules.module_enum.module_save) as module_save
	$bg/v/start.visible = !_module_save.has_save()
	$bg/v/continue.visible =  _module_save.has_save()
	pass # Replace with function body.



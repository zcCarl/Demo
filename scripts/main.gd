extends Node
class_name main
static var Game:game = null
# Called when the node enters the scene tree for the first time.
func _ready():
	
	print("_ready")
	$main_machine.set_enable(true)
#	var _ui_main_ready:ui_main_ready = await ui_root.open("res://scene/ui/ui_main_ready.tscn",Enum.ui_layer.fullscreen_root)
#	Signals.on_ui_main_ready_start.connect(_ui_main_ready.close)
	pass # Replace with function body.

static func get_game()->game:
	return Game		
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

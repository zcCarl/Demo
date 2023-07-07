extends Control


@onready var roots = {}
@onready var loading:loading_layer = $loading
var pool:Dictionary = {}

func _ready():
	roots[Enum.ui_layer.game_root] = $game_root
	roots[Enum.ui_layer.fullscreen_root] = $fullscreen_root
	roots[Enum.ui_layer.popup_root] = $popup_root
	roots[Enum.ui_layer.tips_root] = $tips_root


func open(index:ui_config.ui_module_enum)->ui_base:
	var config = ui_config.get_config(index)
	var r = ResourceQueue.get_resource(config.path)
	#var load_async_handler = ResourceQueue.queue_resource(config.path)
	#var r = await load_async_handler.completed
	if r and r is PackedScene:
		var ui = r.instantiate()
		pool[config.path] = ui
		roots[config.layer].add_child(ui)
		return ui
	return null



func close(path):
	pool[path].close()
	pass

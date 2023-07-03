extends Control


@onready var roots = {}

var pool:Dictionary = {}

func _ready():
	roots[Enum.ui_layer.game_root] = $game_root
	roots[Enum.ui_layer.fullscreen_root] = $fullscreen_root
	roots[Enum.ui_layer.popup_root] = $popup_root
	roots[Enum.ui_layer.tips_root] = $tips_root


func open(path,layer:Enum.ui_layer):
	var ui = load(path)
	pool[path] = ui
	roots[layer].add_child(ui)
	return ui

func close():
	pass

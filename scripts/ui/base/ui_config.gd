extends Node

enum ui_module_enum{
	ui_main_ready,
	ui_main_save,
	ui_message,
	character_hud,
}

var data: Array[Dictionary]= [
	{
		path = "res://scene/ui/ui_main_ready.tscn",
		layer = Enum.ui_layer.fullscreen_root,
	},
	{
		path = "res://scene/ui/ui_main_save.tscn",
		layer = Enum.ui_layer.fullscreen_root,
	},
	{
		path = "res://scene/ui/ui_message.tscn",
		layer = Enum.ui_layer.popup_root,
	}
]

func get_config(index:ui_module_enum):
	return data[index]

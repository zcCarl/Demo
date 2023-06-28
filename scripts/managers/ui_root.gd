extends Control

@onready var main_root = $main_root

@onready var fullscreen_root = $fullscreen_root

@onready var popup_root = $popup_root

@onready var tips_root = $tips_root

@onready var roots =[$main_root,$fullscreen_root,$popup_root,$tips_root]

enum ui_layer{
	main,fullscreen,popup,tips
}
var pool:Dictionary = {}

func open(path:String,layer:ui_layer):
	print(path)

func close():
	pass

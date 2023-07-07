extends Node
var game_modules_arr :Array[module_base]=[]
var setting_modules_arr :Array[module_setting_base]=[]
@onready var proto =  preload("res://scripts/modules/base/proto.gd")
@onready var _module_world := $module_world as module_world
@onready var _module_player := $module_player as module_player
@onready var _module_save := $module_save as module_save
@onready var _module_account := $module_account as module_account
@onready var _module_option := $module_option as module_option
@onready var _module_user := $module_user as module_user
# Called when the node enters the scene tree for the first time.
func _ready():
	for c in get_children():
		if c.visible:
			if c is module_base:
				game_modules_arr.append(c)
			elif c is module_setting_base:
				setting_modules_arr.append(c)

func save_setting():
	for m in setting_modules_arr:
		m.save_setting()
	
func load_setting():
	for m in setting_modules_arr:
		m.load_setting()
func default_setting():
	for m in setting_modules_arr:
		m.default()
func create_game(save_index:int):
	_module_user.save_index = save_index
	#_module_user.save_setting()
	_module_save.create_save(save_index)
	_module_save.save_setting()
	for m in game_modules_arr:
		m.create_game(save_index)

func save_game(save_index:int):
	for m in game_modules_arr:
		m.save_game(save_index)

func load_game(load_index:int):
	for m in game_modules_arr:
		m.load_game(load_index)
	
func delete_game(delete_index:int):
	_module_save.delete_save(delete_index)
	_module_save.save_setting()
	_module_user.save_index = _module_save.get_save_index()
	_module_user.save_setting()
	for m in game_modules_arr:
		m.delete_game(delete_index)

func on_enter_game(save_index):
	_module_user.save_index = save_index
	_module_user.save_setting()

extends Node
#var modules_table :Dictionary={}
#@onready var proto =  preload("res://scripts/modules/base/proto.gd")
# Called when the node enters the scene tree for the first time.
enum module_enum {
	module_account,
	module_setting,
	module_player,
	module_save,
	module_user,
	module_world,
}
var modules_table = {
	#module_enum.module_account : module_account.new(),
	#module_enum.module_setting : module_setting.new(),
	#module_enum.module_player : module_player.new(),
	module_enum.module_save : module_save.new(),
	#module_enum.module_user : module_user.new(),
	#module_enum.module_world : module_world.new(),
}


func get_module(module_type: module_enum):
	return modules_table[module_type]
	
func set_last_save(save_index):
	var _module_save = get_module(module_enum.module_save) as module_save
	_module_save.get_struct().set_save_index(save_index)
	_module_save.save_data()
#设置存档位置
func set_save_index(save_index):
	for k in modules_table:
		if modules_table[k] is module_game :
			var m:module_game = modules_table[k]
			m.save_index = save_index


func save_option():
	for k in modules_table:
		if modules_table[k] is module_option:
			modules_table[k].save_data()
	
func load_option():
	for k in modules_table:
		if modules_table[k] is module_option:
			modules_table[k].load_data()
			
func default_option():
	for k in modules_table:
		if modules_table[k] is module_option:
			modules_table[k].default()
			
func create_game(save_index:int):
	var _module_save = get_module(module_enum.module_save) as module_save
	_module_save.create_save(save_index)
	save_game(save_index)

func save_game(save_index:int):
	set_save_index(save_index)
	set_last_save(save_index)
	for k in modules_table:
		var m = modules_table[k] as module_base
		if m is module_game:
			m.save_data()

func load_game(load_index:int):
	for m in modules_table:
		m.load_game(load_index)
	
func delete_game(delete_index:int):
	var _module_save:module_save = get_module(module_enum.module_save)
	_module_save.delete_save(delete_index)
	set_save_index(delete_index)
	for k in modules_table:
		var m = modules_table[k] as module_base
		if m is module_game:
			m.delete()
	var last_save =  _module_save.get_struct().get_save_index()
	if delete_index == last_save:
		last_save = _module_save.get_save_index()
		set_last_save(last_save)
	set_save_index(last_save)
	
	

func on_enter_game(save_index):
	var _module_save = get_module(module_enum.module_save) as module_save
	_module_save.set_save_index(save_index)
	_module_save.save_data()

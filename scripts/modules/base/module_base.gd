extends Node
class_name module_base

const save_path = "res://{s}_{d}.save"
var _data = null

var proto_struct = null

func init_struct():
	pass

func create_game(save_index):
	on_create_game()
	save_game(save_index)
	
func save_game(save_index:int):
	var path = save_path.format({"s":name,"d":save_index})
	var file = FileAccess.open_encrypted_with_pass(path,FileAccess.WRITE,name)
	file.store_buffer(_data.to_bytes())
	file.close()
	on_save_game()
	pass
	
func load_game(load_index:int):
	var path = save_path.format({"s":name,"d":load_index})
	var file = FileAccess.open_encrypted_with_pass(path,FileAccess.READ,name)
	var bytes = file.get_buffer(file.get_length())
	_data.from_bytes(bytes)
	file.close()
	on_load_game()
	pass
func delete_game(delete_index:int):
	var path = save_path.format({"s":name,"d":delete_index})
	DirAccess.remove_absolute(path)
func on_save_game()->Dictionary:
	return {}

func on_load_game():
	pass

func on_create_game():
	pass
func on_delete_game():
	pass

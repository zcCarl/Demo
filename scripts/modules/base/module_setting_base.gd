extends Node
class_name module_setting_base

var bytes = null


const save_path = "res://{s}.save"
func save_setting():
	var path = save_path.format({"s":name})
	var file = FileAccess.open_encrypted_with_pass(path,FileAccess.WRITE,name)
	print(file.get_path_absolute())
	bytes = get_struct().to_bytes()
	file.store_buffer(bytes)
	file.close()
	on_save_game()
	pass
	
func load_setting():
	var path = save_path.format({"s":name})
	if !FileAccess.file_exists(path):
		return
	var file = FileAccess.open_encrypted_with_pass(path,FileAccess.READ,name)
	var bytes = file.get_buffer(file.get_length())
	get_struct().from_bytes(bytes)
	file.close()
	on_load_game()
	pass

func on_save_game():
	return null

func on_load_game():
	pass

func get_struct():
	pass

func default():
	pass

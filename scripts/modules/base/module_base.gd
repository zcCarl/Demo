extends Node
class_name module_base
var bytes = null
const save_path = "res://{s}.save"

func get_save_path() :
	return save_path.format({"s":get_class_name()})

func get_class_name():
	pass
func get_struct():
	pass
	
func save_data():
	var path = get_save_path()
	var file = FileAccess.open_encrypted_with_pass(path,FileAccess.WRITE,name)
	bytes = get_struct().to_bytes()
	file.store_buffer(bytes)
	file.close()
	on_save()
	pass
	
func load_data():
	var path = get_save_path()
	if !FileAccess.file_exists(path):
		default()
		return
	var file = FileAccess.open_encrypted_with_pass(path,FileAccess.READ,name)
	var bytes = file.get_buffer(file.get_length())
	get_struct().from_bytes(bytes)
	file.close()
	on_load()
	pass

func delete():
	var path = get_save_path()
	if !FileAccess.file_exists(path):
		return
	DirAccess.remove_absolute(path)
	on_delete()
	pass

func on_save():
	return null

func on_load():
	pass

func on_delete():
	pass


func default():
	pass

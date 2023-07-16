extends module_option
class_name module_save
var _data =proto.module_save_structs.new()

func get_class_name():
	return "module_save"

func get_struct()->proto.module_save_structs:
	return _data

func get_save(save_index)->proto.module_save_structs.module_save_struct:
	var save_data= _data.get_save_data()
	if save_data.has(save_index):
		print(str(save_data[save_index]))
		return save_data[save_index] 
	return null
func has_save():
	return _data.get_save_data().size()>0

func get_next_save_index():
	var save_data= _data.get_save_data()
	if save_data.size() > 0:
		return save_data.keys()[0]
	return 0	

func get_save_index():
	return _data.get_save_index()
	
func set_save_index(val):
	_data.set_save_index(val)

func load_game(save_index):
	_data.set_save_index(save_index)

func create_save(save_index):
	var data = _data.add_save_data(save_index)
	data.set_character(1)
	data.set_save_time(Time.get_datetime_string_from_system()) 
	data.set_save_map(1)
	data.set_save_character_pos("<0,0>")
	_data.set_save_index(save_index)
	

func delete_save(save_index):
	_data.remove_save_data(save_index)

func on_save_game():
	pass

func on_load():
	pass

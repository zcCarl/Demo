extends module_setting_base
class_name module_save
@onready var s_data =proto.module_save_structs.new()
var save_data = {}

func get_struct():
	return s_data

func get_save(save_index)->proto.module_save_structs.module_save_struct:
	if save_data.has(save_index):
		print(str(save_data[save_index]))
		return save_data[save_index] 
	return null

func get_save_index():
	if save_data.size() > 0:
		return save_data.keys()[0]
	return -1
		

func create_save(save_index):
	var data = s_data.add_save_data(save_index)
	data.set_character(1)
	data.set_save_time(Time.get_datetime_string_from_system()) 
	data.set_save_map(1)
	data.set_save_character_pos("<0,0>")
	

func delete_save(save_index):
	save_data.erase(save_index)

func on_save_game():
	pass

func on_load_game():
	save_data = s_data.get_save_data()
	pass

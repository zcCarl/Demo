extends module_base
class_name module_game

var save_index = -1

func get_save_path():
	return save_path.format({"s":get_class_name() + "_" + str(save_index)})


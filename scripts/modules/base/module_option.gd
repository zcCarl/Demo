extends module_base
class_name module_option

func get_save_path():
	return save_path.format({"s":get_class_name()})


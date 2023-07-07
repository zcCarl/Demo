extends Control

class_name ui_base
class ui_data:
	pass

var _data:ui_data = null
func on_create():
	pass
	
func on_open(data):
	pass
	
func on_close():
	pass

func close():
	get_parent().remove_child(self)


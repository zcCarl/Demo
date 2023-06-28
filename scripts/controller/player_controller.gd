extends base_controller

var _drag_handler:drag_handler 

func _init():
	_drag_handler = drag_handler.new()
	add_child(_drag_handler)
	pass

extends base_controller

class_name player_controller

@onready var _drag_handler:drag_handler = $"drag_handler"
var _scene:scene
var _current_character:base_character
func setup(s:scene):
	_scene = s
	Signals.on_character_turn.connect(set_character)

func set_character(c:base_character):
	_current_character = c

func _process(delta):
	if _current_character and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var path = _scene._map_ground.get_auto_path(_current_character.global_position,get_global_mouse_position())
		if _current_character.path.size()== 0:
			_current_character.add_path(path)
	pass

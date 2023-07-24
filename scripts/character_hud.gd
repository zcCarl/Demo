extends ui_base
class_name character_hud
var _target :Node2D
func set_target(target:Node2D):
	_target = target
	pass

func _process(delta):
	if !_target:
		return
#	position = get_viewport_transform() * (_target.get_viewport_transform() * _target.global_position)
#	scale = main.get_game().camera

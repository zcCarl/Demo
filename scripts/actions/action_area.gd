extends Area2D
class_name action_indicator

var _action : base_action
@onready var collisionPolygon = $CollisionPolygon2D as CollisionPolygon2D

func _ready():
	pass
func set_action(action:base_action):
	if action :
		_action = action
		_action.set_area(self)
		var ov = get_overlapping_areas()
		for t in ov:
			if t is action_target:
				_action.add_target(t)
		area_entered.connect(on_area_entered)
		area_exited.connect(on_area_exited)
	else:
		_action.clear()
		_action = null
		area_entered.disconnect(on_area_entered)
		area_exited.disconnect(on_area_exited)

	
	
func on_area_entered(area:Area2D):
	if area.get_parent() is action_target:
		_action.add_target(area.get_parent())
		
func on_area_exited(area:Area2D):
	if area.get_parent() is action_target:
		_action.remove_target(area.get_parent())
		
func preview():
	collisionPolygon.polygon.append_array([])
	pass

extends Camera2D
class_name camera_controller
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	var rect = get_viewport_rect()
#	rect.position = position
#	rect.position -= rect.size/2
#	rect.position += Vector2(10,10)
#	rect.size = Vector2(20,20)
#	if !rect.has_point(get_global_mouse_position()):
#		position += (get_global_mouse_position()-position).normalized()
	pass

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom = zoom.lerp(zoom*0.9,0.5)
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom = zoom.lerp(zoom*1.1,0.5)
		zoom = clamp(zoom,Vector2.ONE *0.1 ,Vector2.ONE*10)

extends Area2D

class_name drag_item

signal on_drag_item

var hover = false

var is_held = false

var enable = true 

var start_point = null

var target_point = null

var reseting = false

	

# Called when the node enters the scene tree for the first time.
func _ready():
	player_controller._drag_handler.regiest(self)
	pass # Replace with function body.

func set_enable(m_enable):
	enable = m_enable
	
	
func _unhandled_input(event):
	if enable and event is InputEventMouseButton:
		if hover:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				emit_signal("on_drag_item",self)
			elif event.button_index == MOUSE_BUTTON_LEFT and !event.pressed:
				emit_signal("on_drag_item",null)
		elif is_held:
			emit_signal("on_drag_item",null)
			
			
func _mouse_enter():
	hover = true
func _mouse_exit():
	hover = false
	
func pickup():
	if is_held:
		return
	start_point = get_parent().global_transform.origin
	is_held = true
	
func drop(succ,vec):
	assert(is_held)
	is_held = false
	if !succ:
		target_point = start_point
	else :
		target_point = vec
	reseting = true
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_held:
		get_parent().global_transform.origin = get_global_mouse_position()
	elif reseting:
		var now = get_parent().global_transform.origin
		get_parent().global_transform.origin = now.lerp(target_point,0.3)



extends Area2D

class_name drag_item


var hover = false

var is_held = false

@export var enable = true 
@export var resetable = true
var start_point = null

var target_point = null

var reseting = false


# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


func set_enable(m_enable):
	enable = m_enable
	if enable :
		on_enable()
	else:
		on_disable()
func on_enable():
	pass

func on_disable():
	pass
	
func _unhandled_input(event):
	if enable and event is InputEventMouseButton:
		if hover:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				Signals.signal_drag_item.emit(self)
			elif event.button_index == MOUSE_BUTTON_LEFT and !event.pressed:
				Signals.signal_drag_item.emit(null)
		elif is_held:
			Signals.signal_drag_item.emit(null)
			
			
func _mouse_enter():
	hover = true
func _mouse_exit():
	hover = false
	
func pickup():
	if is_held:
		return
	start_point = get_parent().global_position
	is_held = true
	
func drop(succ,vec):
	assert(is_held)
	is_held = false
	if !succ:
		target_point = start_point
		print(start_point)
	else :
		target_point = vec
	if resetable:
		reseting = true
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_held:
		get_parent().global_position = get_global_mouse_position()
	elif reseting:
		get_parent().global_position =  get_parent().global_position.lerp(target_point,1)
		print(get_parent().global_position,target_point)
		if (target_point-get_parent().global_position).length()<5 :
			get_parent().global_position = target_point
			reseting = false

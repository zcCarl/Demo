extends state_machine
class_name character_machine_normal
enum normal_state{
	idle ,walk
}
# Called when the node enters the scene tree for the first time.
func _ready():
	add_state(normal_state.idle,"idle")
	add_state(normal_state.walk,"walk")
	pass # Replace with function body.

func on_enable():
	super()
	await get_tree().process_frame
	call_deferred("set_state", normal_state.idle)

func on_disable():
	super()

func _state_logic(delta):
	if state == normal_state.idle:
		parent.handle_movement_point_input(delta)
	if parent.path.size() > 0 :
		parent.move_path(delta)
		parent.handle_movement_cancel_input(delta)
func _get_transitions(_delta):
	match state:
		normal_state.idle:
			if parent.path.size() > 0:
				return normal_state.walk
		normal_state.walk:
			if parent.path.size()==0:
				return normal_state.idle
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

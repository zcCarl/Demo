extends state_machine
class_name base_character_machine

# Called when the node enters the scene tree for the first time.
func _ready():
	add_state("ready")
	add_state("walk")
	add_state("run")
	add_state("pre_action")
	add_state("attack")
	add_state("skill")
	add_state("hurt")
	add_state("death")
	add_state("relive")
	await get_tree().process_frame
	call_deferred("set_state", states.ready)
	pass # Replace with function body.

func _state_logic(delta):
	if state == states.ready:
		if parent.is_battle:
			parent.handle_movement_input(delta)
			parent.handle_movement_cancel_input(delta)
		else:
			parent.handle_movement_point_input(delta)
	if parent.path.size() > 0 or parent.velocity.length()>0:
		parent.move_path(delta)
	

func _get_transitions(_delta):
	match state:
		states.ready:
			if parent.velocity.length()>0:
				return states.walk
			pass
		states.walk:
			if parent.velocity.length()==0:
				return states.ready
			pass
		states.attack:
			pass
		states.skill:
			pass
		states.hurt:
			pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

extends state_machine
class_name base_character_machine

# Called when the node enters the scene tree for the first time.
func _ready():
	add_state("idle")
	add_state("walk")
	add_state("run")
	add_state("ready")
	add_state("attack")
	add_state("skill")
	add_state("death")
	add_state("relive")
	await get_tree().process_frame
	call_deferred("set_state", states.idle)
	pass # Replace with function body.

func _state_logic(delta):
	if ![states.attack, states.skill, states.hurt, states.death].has(state):
		parent.handle_movement_input(delta)
	parent.move(delta)

func _get_transitions(_delta):
	match state:
		states.idle:
			if parent.velocity.length()>0:
				return states.walk
			elif Input.is_action_just_pressed("ui_attack"):
				return states.attack
			pass
		states.walk:
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

extends base_character


#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	#if not is_on_floor():
		#velocity.y += gravity * delta

	# Handle Jump.

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction_x = Input.get_axis("ui_left", "ui_right")
	var direction_y = Input.get_axis("ui_up", "ui_down")
	if abs(direction_x) > 0 and  abs(direction_y)>0 :
		if abs(move_direction.x) > 0 :
			direction_y = 0
		elif abs(move_direction.y) > 0 :
			direction_x = 0
	else:
		move_direction = Vector2(direction_x,direction_y)
	
	#print(move_direction)

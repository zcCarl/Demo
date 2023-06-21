extends CharacterBody2D

class_name base_character

const SLOPE_STOP = 64

@onready var collision = $"collision_shape"
@onready var sprite = $"body/sprite"

@onready var body = $"body"
@onready var animation = $"animation"

var is_battle = false

var volocity = Vector2()

var move_length = 100
var move_speed = 100
var hurt_knockback = Vector2()
var move_direction =Vector2()

# We get the move direction and set the sprite scale to that direction
func handle_movement_input(_delta):
	
		

	var direction_x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var direction_y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	if abs(direction_x) > 0 and  abs(direction_y)>0 :
		if abs(move_direction.x) > 0 :
			direction_y = 0
		elif abs(move_direction.y) > 0 :
			direction_x = 0
	else:
		move_direction = Vector2(direction_x,direction_y)

func move(_delta):
	velocity =lerp(velocity,move_speed * move_direction,0.2)
	print(velocity)
	if move_direction.length()==0 and velocity.length() < SLOPE_STOP:
		velocity = lerp(velocity,Vector2.ZERO,0.2)
	move_and_slide()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

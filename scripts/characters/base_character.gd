extends CharacterBody2D

class_name base_character

const SLOPE_STOP = 16

@onready var collision = $"collision_shape"
@onready var sprite = $"body/sprite"
@onready var body = $"body"
@onready var animation = $"animation"

var team:base_team = null
var team_index:int = -1

var is_battle = false
var is_turn = false
var has_moved = false
var has_action = false

var dir_str = ""

var path = []
var basic_proterties : character_properties 
var dynamic_proterties : character_properties 
var skills:Array[base_skill] = []
var ready_skill_index = -1
var volocity = Vector2()
@export var move_speed = 150
@export var move_idle_time = 0
var hurt_knockback = Vector2()
var move_direction =Vector2()


func setup(id):
	var _config = Settings.character_basic.data[id]
	basic_proterties = character_properties.new(_config)
	dynamic_proterties = character_properties.new().copy(basic_proterties) 

func on_join_team(t:base_team,i:int):
	team = t
	team_index = i
	pass

func on_leave_team(t:base_team):
	if team == t :
		team_index = -1
		team = null

func turn_start():
	is_turn = true 
	has_moved = false
	has_action = false
	input_pickable = true
	
func turn_end():
	is_turn = false 
	has_moved = true
	has_action = true

func battle_start():
	is_battle = true
	$character_machine_battle.set_enable(true)
	$character_machine_normal.set_enable(false)

func battle_end():
	is_battle = false
	$character_machine_battle.set_enable(false)
	$character_machine_normal.set_enable(true)
	
# We get the move direction and set the sprite scale to that direction
func handle_movement_point_input(_delta):
	pass
func handle_movement_cancel_input(_delta):
	pass

func handle_movement_input(_delta):
	pass
	
func handle_movement_drag_input(_delta):
	
	pass
var next_move_time = 0
func move_path(_delta):
#	if path.size() > 0:
#		move_direction = main._game._scene.map_to_gloal(path[0]) - global_position
#		if move_direction.length()>5:
#			move_direction=move_direction.normalized()
#		else:
#			path.remove_at(0)
#			return
#	velocity = move_speed * move_direction
#	if path.size() ==0 :
#		velocity = Vector2.ZERO
#	move_and_slide()
	if next_move_time > 0:
		next_move_time -= _delta
		return
	if path.size()>0 :
		var target_p = path[0]
		move_direction =target_p - global_position
		if move_direction.x < 0:
			self.dir_str = "left"
		elif move_direction.x > 0:
			self.dir_str = "right"
		elif move_direction.y > 0:
			self.dir_str = "down"
		elif move_direction.y < 0:
			self.dir_str = "up"
		global_position = global_position.move_toward(target_p,move_speed*_delta)

		
		if move_direction.length()== 0 :
			path.remove_at(0)
			if path.size()>0 :
				next_move_time = move_idle_time
			else:
				$body/sprite.play("idle_"+self.dir_str,1,true)
		else:
			if self.dir_str!= "" and $body/sprite.animation != "walk_" + self.dir_str:
				print(self.dir_str)
				$body/sprite.play("walk_" + self.dir_str,1,true)
func handle_open_action_area():
	pass
	
func handle_update_action_area():
	pass

func skill_ready(skill_index):
	ready_skill_index = skill_index
	pass

func skill(skill_index):
	var skill:base_skill = skills[skill_index]
	if skill.is_verification():
		return skill.apply()
	return false

func damage(damage_info):
	var attacker_properties:character_properties = damage_info.attacker_properties
	var damage = attacker_properties.attack - dynamic_proterties.defence
	dynamic_proterties.health_point -= damage
	pass
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

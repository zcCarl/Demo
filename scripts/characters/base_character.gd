extends CharacterBody2D

class_name base_character

class character_properties extends RefCounted:
	var health_point = 0
	var magic_point = 0
	var attack = 0
	var defence = 0
	var speed = 0
	var critical_chance = 0
	var critical_multiple = 0
	var effect_chance = 0 
	var effect_resist_chance = 0
	func copy(tmp:character_properties):
		health_point=tmp.health_point
		magic_point=tmp.magic_point
		attack=tmp.attack
		defence=tmp.defence
		speed=tmp.speed
		critical_chance=tmp.critical_chance
		critical_multiple=tmp.critical_multiple
		effect_chance=tmp.effect_chance
		effect_resist_chance=tmp.effect_resist_chance
	func _init( health_point = 0,magic_point = 0, attack = 0, defence = 0, speed = 0, critical_chance = 0, critical_multiple = 0, effect_chance = 0 , effect_resist_chance = 0):
		self.health_point = health_point
		self.magic_point = magic_point
		self.attack = attack
		self.defence = defence
		self.speed = speed
		self.critical_chance = critical_chance
		self.critical_multiple = critical_multiple
		self.effect_chance = effect_chance
		self.effect_resist_chance = effect_resist_chance
	
const SLOPE_STOP = 16

@onready var collision = $"collision_shape"
@onready var sprite = $"body/sprite"
@onready var body = $"body"
@onready var animation = $"animation"

var is_battle = true
var skill_target = {}
var path = []
var basic_proterties : character_properties 
var dynamic_proterties : character_properties 
var skills = []
var volocity = Vector2()
var move_speed = 100
var hurt_knockback = Vector2()
var move_direction =Vector2()


func setup(id):
	var _config = Settings.character_basic.data[id]
	basic_proterties = character_properties.new(_config.health_point,
												_config.magic_point,
												_config.attack,
												_config.defence,
												_config.speed,
												_config.critical_chance,
												_config.critical_multiple,
												_config.effect_chance,
												_config.effect_resist_chance)
	dynamic_proterties = character_properties.new()
	dynamic_proterties.copy(basic_proterties) 

# We get the move direction and set the sprite scale to that direction
func handle_movement_point_input(_delta):
	pass
func handle_movement_cancel_input(_delta):
	pass

func handle_movement_input(_delta):
	pass
	
func move_path(_delta):
	if path.size() > 0:
		move_direction = Vector2(path[0])-Vector2( main._game._scene.gloal_to_map(position))
		if move_direction.length()>0:
			move_direction=move_direction.normalized()
		else:
			path.remove_at(0)
			return
	velocity = move_speed * move_direction
	if path.size() ==0 and velocity.length() < SLOPE_STOP:
		velocity = Vector2.ZERO
	move_and_slide()

func handle_open_action_area():
	pass
	
func handle_update_action_area():
	pass
	
func skill(skill_index):
	var skill:base_skill = skills[skill_index]
	if skill.target_type == Enum.skill_target_type.firends:
		if skill_target.friends.size() > 0:
			skill.apply(skill_target.friends)	
		else:
			print("技能没有目标")
	pass

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

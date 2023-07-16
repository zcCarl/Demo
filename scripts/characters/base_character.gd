extends action_target

class_name base_character

const SLOPE_STOP = 16

@onready var collision = $"collision_shape"
@onready var sprite = $"body/sprite"
@onready var body = $"body"
@onready var animation = $"animation"

var team:base_team = null
var team_index:int = -1

var _on_turn_over:Callable 
var action_point_max = 8
var action_point : int = 0
var target_p:Vector2 = Vector2.INF
var is_alive = true
var is_battle = false
var is_turn = false

var dir_str = ""

var path = []
var basic_proterties : character_properties 
var dynamic_proterties : character_properties 
var actions:Array[base_action] = []
var ready_action_index = -1
@export var move_speed = 150
@export_range(0.0, 1, 0.05) var move_idle_time:float = 0.0
var move_direction =Vector2()


func setup(id):
	var _config = Settings.character_basic.data[id]
	basic_proterties = character_properties.new(_config)
	dynamic_proterties = character_properties.new().copy(basic_proterties) 
	dynamic_proterties.speed = RandomNumberGenerator.new().randf_range(99,200)
	
func on_join_team(t:base_team,i:int):
	team = t
	team_index = i
	pass

func on_leave_team(t:base_team):
	if team == t :
		team_index = -1
		team = null

func turn_start(on_turn_over:Callable):
	is_turn = true 
	action_point = action_point_max
	_on_turn_over = on_turn_over
	
func turn_end():
	is_turn = false 
	path.clear()
	target_p = Vector2.INF
	_on_turn_over.call()

func cost_action_point(cost)->bool:
	if action_point > cost:
		action_point -= cost
		print("消耗行动点",cost)
		return true
	print("行动点不够了")
	return false

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

func add_path(_path):
	print("增加点",_path)
	path.append_array(_path)

func move_path(_delta):
	if next_move_time > 0:
		next_move_time -= _delta
		return
	if path.size()>0 :
		if target_p == Vector2.INF or target_p != path[0]:
			#寻找下一个点
			print("目标点",path[0])
			target_p = path[0]
		move_direction =target_p - global_position
		var flip = false
		if move_direction.x < 0 and move_direction.y > 0:
#			flip = true

			flip = true
			self.dir_str = "rf"
		elif  move_direction.x < 0 and move_direction.y < 0:
			
			flip = true
			self.dir_str = "rb"
		elif  move_direction.x > 0 and move_direction.y > 0:
			
			self.dir_str = "rf"
		elif  move_direction.x > 0 and move_direction.y < 0:
			
			self.dir_str = "rb"
		else:
			flip = sprite.flip_h 
			self.dir_str = $body/sprite.animation
		global_position = global_position.move_toward(target_p,move_speed*_delta)
		
		if flip!=sprite.flip_h:
			sprite.flip_h = flip
		if (target_p - global_position).length()== 0 :
			if cost_action_point(1):
				path.remove_at(0)
				if path.size()>0 :
					next_move_time = move_idle_time
	#			else:
					#$body/sprite.play("rf",1,true)
			else:
				turn_end()
		else:
			if self.dir_str!= "" and $body/sprite.animation !=  self.dir_str:
				#print(self.dir_str)
				$body/sprite.play(self.dir_str,1,true)
				
func handle_open_action_area():
	pass
	
func handle_update_action_area():
	pass

func action_preview(action_index):
	ready_action_index = action_index
	pass

func action(action_index):
	var action:base_action = actions[action_index]
	if action.is_verification():
		return action.apply()
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

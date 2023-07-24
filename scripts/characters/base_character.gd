extends action_target

class_name base_character

@onready var collision = $"collision_shape"
@onready var sprite = $"body/sprite" as AnimatedSprite2D
@onready var body = $"body"
@onready var animation = $"animation"

@export_range(0.01, 500, 0.01) var move_speed:float = 0.2
@export_range(0.0, 1, 0.01) var move_idle_time:float = 0.05
var _map_ground:map_ground = null
var _controller:base_controller = null
var team:base_team = null
var team_index:int = -1

var _on_turn_over:Callable 
var action_point_max = 8
var action_point : int = 0
var target_p:Vector2 = Vector2.INF
var is_move = false
var is_move_step = false
var is_alive = true
var is_battle = false
var is_turn = false
var tween :Tween = null
var dir_str = "rf"

var path = []
var basic_proterties : character_properties 
var dynamic_proterties : character_properties 
var actions:Array[base_action] = []
var ready_action_index = -1
var move_direction =Vector2()
var move_index = 1
var next_move_time = 0

func setup(id,ground:map_ground):
	_map_ground = ground
	#_map_ground.refresh_dynamic_obsable(Vector2.INF,global_position)
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
	print("回合开始",team_index)
	_map_ground.refresh_dynamic_obsable(global_position,Vector2.INF)
	is_turn = true 
	action_point = action_point_max
	_on_turn_over = on_turn_over
	
func turn_end():
	print("回合结束",team_index)
	_map_ground.refresh_dynamic_obsable(last_global_position,global_position)
	is_turn = false 
	path.clear()
	target_p = Vector2.INF
	_on_turn_over.call()

func cost_action_point(cost)->bool:
	if action_point >= cost:
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

func _physics_process(delta):
	pass
func _process(delta):
	pass

func move_map_point(target_map_point:Vector2i):
	if not is_move:
		var self_map_point = scene_util.gloal_to_map(_map_ground,global_position)
		var path = _map_ground.get_auto_path(self_map_point,target_map_point)
		add_path(path)
	
func add_path(_path):
	path.clear()
	path.append_array(_path)
	move_index = 0
	print("路径",path)
	
var last_global_position = Vector2.INF
func move_step():
	if move_speed > 0 and path.size()>1 :
		is_move = true
		is_move_step = true
		velocity = path[move_index] - global_position
		tween = create_tween()
		var proterty_tweener:PropertyTweener = tween.tween_property(self, "global_position", path[move_index] , 1/move_speed)
		proterty_tweener.set_trans(Tween.TRANS_LINEAR)
		proterty_tweener.from(path[move_index-1])
		tween.tween_callback(on_move_step_over)
		on_frame_anim()
	else:
		path.clear()
		is_move = false
	pass
func on_move_step_over():
	if move_idle_time > 0:
		is_move_step = false
		on_frame_anim()
		await get_tree().create_timer(move_idle_time).timeout
	if cost_action_point(1):
		move_index += 1
		if move_index < path.size():
			move_step()
		else:
			path.clear()
			is_move_step = false
			is_move = false
		pass
	else:
		path.clear()
		is_move_step = false
		is_move = false
	on_frame_anim()
func on_frame_anim():
	#return
	if velocity.x < 0 and velocity.y > 0:
		self.dir_str = "lf"
	elif  velocity.x < 0 and velocity.y < 0:
		self.dir_str = "lb"
	elif  velocity.x > 0 and velocity.y > 0:
		self.dir_str = "rf"
	elif  velocity.x > 0 and velocity.y < 0:
		self.dir_str = "rb"
#	if self.dir_str == "":
#		self.dir_str = "rf"
	if !is_move_step :
		var play_str = "idle_" + self.dir_str 
		if play_str!=sprite.animation:
			sprite.play(play_str,1,true)
	else:
		var play_str = "walk_" + self.dir_str 
		if sprite.animation !=  play_str:
			sprite.play(play_str,1,true)
	pass
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



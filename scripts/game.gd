extends Node2D

var _scene : scene
var _player_team : base_team
var _camera_controller:camera_controller
var _ememy_team : base_team
# Called when the node enters the scene tree for the first time.
func setup():
	_camera_controller = preload("res://scene/camera_controller.tscn").instantiate()
	add_child(_camera_controller)
	_scene = preload("res://scene_1.tscn").instantiate()
	add_child(_scene)
	_player_team = base_team.new()
	add_child(_player_team)
	_ememy_team = base_team.new()
	add_child(_ememy_team)
	var _character= preload("res://scene/character/character_1.tscn").instantiate()
	_character.setup(1)
	_player_team.join_team(_character)
	_player_team.setup(1)
	
	var _enemy = preload("res://scene/monster/monster.tscn").instantiate()
	_enemy.setup(1)
	_ememy_team.join_team(_enemy)
	_ememy_team.setup(1)
	#	ui_manager.show()
	pass # Replace with function body.

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

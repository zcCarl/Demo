extends Node2D

var _scene : scene
var _player_team : base_team
# Called when the node enters the scene tree for the first time.
func setup():
	_scene = preload("res://scene_1.tscn").instantiate()
	add_child(_scene)
	_player_team = base_team.new()
	add_child(_player_team)
	var _character= preload("res://scene/character/character_1.tscn").instantiate()
	_character.setup(1)
	_player_team.join_team(_character)
	_player_team.setup(1)
#	ui_manager.show()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

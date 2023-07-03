extends Node2D
class_name game
@onready var _scene : scene = $"scene"
var _player_team : base_team
var _ememy_team : base_team
# Called when the node enters the scene tree for the first time.
func setup():
	var _character= preload("res://scene/character/character_1.tscn").instantiate()
	_character.setup(1)
	join_team($"teams/player_team",_character)
	_player_team.setup(1)
	
	var _enemy = preload("res://scene/monster/monster.tscn").instantiate()
	_enemy.setup(1)
	join_team($"teams/enemy_team",_enemy)
	#	ui_manager.show()
	pass # Replace with function body.

func join_team(team:base_team,c:base_character):
	team.join_team(c)
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

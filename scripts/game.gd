extends Node
class_name game
@onready var _scene = $"scene" as scene
@onready var _player_controller =$player_controller as player_controller
@onready var _action_manager = $action_manager
@onready var _battles:Array[battle_system] = []
@onready var _teams:Array[base_team] = []
var _ememy_team : base_team
# Called when the node enters the scene tree for the first time.
func setup():
	_player_controller.setup(_scene)
	pass # Replace with function body.

func create_team(player:bool,friend:bool,size:int,members:Array[base_character]):
	var new_team = base_team.new(player,friend,size)
	new_team.setup(1)
	new_team.join_characters(members)
	return new_team

func test_battle():
	var _character1= preload("res://scene/character/character_1.tscn").instantiate()
	_scene.add_child(_character1)
	_character1.setup(1)
	var _character2= preload("res://scene/character/character_1.tscn").instantiate()
	_scene.add_child(_character2)
	_character2.setup(1)
	var team = create_team(true,true,4,[_character1,_character2])
	
	var _character3= preload("res://scene/character/character_1.tscn").instantiate()
	_scene.add_child(_character3)
	_character3.setup(1)
	var _character4= preload("res://scene/character/character_1.tscn").instantiate()
	_character4.setup(1)
	_scene.add_child(_character4)
	var team2 = create_team(false,false,4,[_character3,_character4])
	start_battle([team,team2])
	
func start_battle(teams:Array[base_team]):
	var new_battle = battle_system.new()
	for t in teams:
		new_battle.join_queue(t)
	new_battle.battle_start(end_battle,next_turn)
	_battles.append(new_battle)
	change_battle(new_battle)

func next_turn(battle:battle_system):
	_player_controller.set_character(battle._current_turn_character)
	pass
	
func change_battle(battle):
	_player_controller.set_character(battle._current_turn_character)
	pass

func end_battle(battle:battle_system):
	_battles.erase(battle)
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

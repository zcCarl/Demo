extends RefCounted

class_name battle_system

var _battle_queue = battle_queue.new()

var _teams :Array[base_team] = []

var _on_battle_end:Callable
var _on_next_turn:Callable
var _current_turn_character:base_character = null

var turns = 0

func _init():
	pass
func setup():
	pass
func dispose():
	pass
func join_queue(team:base_team):
	team.battle_start()
	_teams.append(team)
	for index in range(team._size):
		var c:base_character = team.get_member(index)
		if c:
			join_character(c)

func join_character(c:base_character):
	var c_data = battle_queue.c_data.new()
	c_data.character_index = c.team_index
	c_data.team_index = _teams.find(c.team)
	c_data.speed = c.dynamic_proterties.speed
	c_data.delay = 1.0 / c.dynamic_proterties.speed
	_battle_queue.enqueue(c_data)
	pass

func next_turn():
	if check_over() !=0 :
		battle_end()
		return
	if _current_turn_character:
		join_character(_current_turn_character)
		_current_turn_character = null
	var data = _battle_queue.next_action()
	print("到了",data.team_index,"队",data.character_index,"速度",data.speed,"延迟",data.delay)
	_current_turn_character = _teams[data.team_index].get_member(data.character_index)
	_teams[data.team_index].turn_start(data.character_index,next_turn)
	_on_next_turn.call(self)
	
func check_over():
	var player_c_count = 0
	var enemy_c_count = 0
	for t in _teams:
		for index in range(t._size):
			if t.get_member(index) and t.get_member(index).is_alive:
				if t._is_player :
					player_c_count += 1
				elif !t._is_frendly:
					enemy_c_count += 1
	if player_c_count == 0 :
		return 1
	elif enemy_c_count == 0 :
		return 2
	
	return 0

func battle_start(on_battle_end:Callable,on_next_turn:Callable):
	_on_next_turn = on_next_turn
	_on_battle_end = on_battle_end
	next_turn()

func battle_end():
	_on_battle_end.call(self)
	pass

func _process(delta):
	pass

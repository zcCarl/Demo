extends RefCounted

class_name base_team
#队长
var leader :base_character = null

var _is_player = false
var _is_frendly = false
var _members = { }
var _is_battle = false
var _size = 1

func _init(is_player:bool,is_firendly:bool,size:int):
	_is_player = is_player
	_is_frendly = is_firendly
	_size = size
	pass

func setup(team_tag):
	pass

func replace_character(index:int,c:base_character):
	if _members.has(index):
		_members[index] = c

func get_member(index:int):
	if _members.has(index):
		return _members[index]
	return null
	
func join_character(member:base_character):
	var index = _members.size()
	if index < _size:
		_members[index] = member
		member.on_join_team(self,index)
		if !leader:
			leader = member

func join_characters(members:Array[base_character]):
	for c in members:
		join_character(c)

func leave_team(c:base_character):
	var index = _members.find_key(c)
	_members.erase(index)
	c.on_leave_team(self)
	
func battle_start():
	_is_battle = true
	for k in _members :
		_members[k].battle_start()

func battle_end():
	_is_battle = false
	for k in _members :
		_members[k].battle_end()
	
func turn_start(index:int, on_turn_over:Callable):
	_members[index].turn_start(on_turn_over)

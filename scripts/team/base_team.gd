extends Node

class_name base_team
#队长
var leader :base_character = null

var controller

var members = { }

var is_battle = false

var is_turn = false

func _init():
	pass

func setup(team_tag):
	pass

func replace_character(index:int,c:base_character):
	if members.has(index):
		members[index] = c

func get_character(index:int):
	return members[index]
	
func join_team(c:base_character):
	var index = members.size()
	members[index] = c
	add_child(c)
	c.on_join_team(self,index)
	if !leader:
		leader = c
	
func leave_team(c:base_character):
	var index = members.find_key(c)
	members.erase(index)
	get_parent().add_child(c)
	c.on_leave_team(self)
	
func battle_start():
	is_battle = true
	for k in members :
		members[k].battle_start()

func battle_end():
	is_battle = false
	for k in members :
		members[k].battle_end()
	
func turn_start():
	is_turn = true
	for k in members :
		members[k].turn_start()
	
func turn_end():
	is_turn = false
	for k in members :
		members[k].turn_end()

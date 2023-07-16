extends Node
class_name base_action

var action_name = "jineng"
var effect_type = Enum.skill_effect_type.damage
var params = []
var cost =	 1
var level =	 1
var cd =	 1
var area_type = Enum.skill_area_type.point
var area_length =  2
var area_center_type = Enum.skill_area_center_type.any 
var target_type = Enum.skill_target_type.enemy

var _target_type = -1
var _skill_range = -1
var _targets:Array[action_target] = []
var _owner:base_character
var _indicator:action_indicator
func setup():
	
	pass
func create_indicator():
	_indicator = preload("res://scene/action/action_area.tscn").instantiate()
	_indicator.set_action(self)
	
func add_target(target:action_target):
	_targets.append(target)
	pass
	
func add_targets(targets:Array[action_target]):
	_targets.append_array(targets)
	pass
func remove_target(target:action_target):
	_targets.erase(target)
	
func preview_action():
	
	pass

func cast_action():
	if self._config["area_type"] == Enum.skill_area_type.point:
		if self._config["area_center_type"] == Enum.skill_area_center_type.any:
			Signals.on_action_center_area_open.emit(self._config["area_length"],self._config["area_type"],self._config["area_center_type"],self._config["target_type"])
	pass
	
func clear():
	pass

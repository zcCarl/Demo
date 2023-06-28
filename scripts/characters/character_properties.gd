extends Node
class_name character_properties
var health_point = 0
var magic_point = 0
var attack = 0
var defence = 0
var speed = 0
var critical_chance = 0
var critical_multiple = 0
var effect_chance = 0 
var effect_resist_chance = 0
func copy(tmp:character_properties):
	health_point=tmp.health_point
	magic_point=tmp.magic_point
	attack=tmp.attack
	defence=tmp.defence
	speed=tmp.speed
	critical_chance=tmp.critical_chance
	critical_multiple=tmp.critical_multiple
	effect_chance=tmp.effect_chance
	effect_resist_chance=tmp.effect_resist_chance
	return self

func _init(_data = null):
	if _data :
		self.health_point = _data.health_point
		self.magic_point = _data.magic_point
		self.attack = _data.attack
		self.defence = _data.defence
		self.speed = _data.speed
		self.critical_chance = _data.critical_chance
		self.critical_multiple = _data.critical_multiple
		self.effect_chance = _data.effect_chance
		self.effect_resist_chance = _data.effect_resist_chance

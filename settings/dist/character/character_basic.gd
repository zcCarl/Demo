# warnings-disable
extends RefCounted

var True = true
var False = false
var None = null

class tb_character_basic  extends RefCounted:
	var tag#int
	var name#string
	var health_point#float
	var magic_point#float
	var attack#float
	var defence#float
	var speed#float
	var critical_chance#float
	var critical_multiple#float
	var effect_chance#float
	var effect_resist_chance#float
	
	func _init(m_tag,m_name,m_health_point,m_magic_point,m_attack,m_defence,m_speed,m_critical_chance,m_critical_multiple,m_effect_chance,m_effect_resist_chance,):
		tag=m_tag
		name=m_name
		health_point=m_health_point
		magic_point=m_magic_point
		attack=m_attack
		defence=m_defence
		speed=m_speed
		critical_chance=m_critical_chance
		critical_multiple=m_critical_multiple
		effect_chance=m_effect_chance
		effect_resist_chance=m_effect_resist_chance
		


var data = \
{
	1:tb_character_basic.new( 1,  '主角',  100.0,  100.0,  5.0,  2.0,  100.0,  10.0,  150.0,  0.0,  0.0, )
	
}


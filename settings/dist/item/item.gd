# warnings-disable
extends RefCounted

var True = true
var False = false
var None = null

class tb_item  extends RefCounted:
	var tag#int
	var name#string
	var description#string
	var quality#int
	var type#int
	var sub_type#int
	var use_effect#int
	var use_times#int
	var cooldown#float
	var icon#string
	var price#float
	
	func _init(m_tag,m_name,m_description,m_quality,m_type,m_sub_type,m_use_effect,m_use_times,m_cooldown,m_icon,m_price,):
		tag=m_tag
		name=m_name
		description=m_description
		quality=m_quality
		type=m_type
		sub_type=m_sub_type
		use_effect=m_use_effect
		use_times=m_use_times
		cooldown=m_cooldown
		icon=m_icon
		price=m_price
		


var data = \
{
	1:tb_item.new( 1,  '物品1',  '这是一个物品',  1,  10,  1,  0,  1,  5.0,  'item_icon',  100.0, )
	
}


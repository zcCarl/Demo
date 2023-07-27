extends Control
class_name InfiniteScrollContainerItem
class InfiniteScrollContainerItemData extends RefCounted:
	var _item_index 
	var _item_height 
	var _data :Dictionary
	func _init(index,height,data):
		_item_index = index
		_item_height = height
		_data = data
var _data :InfiniteScrollContainerItemData
func _ready():
	pass
	
func set_data(data:InfiniteScrollContainerItemData):
	_data = data
	pass

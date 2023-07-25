extends Control
class_name InfiniteScrollContainerItem
var _data 
@onready var button = $Button as Button
func _ready():
	pass
	
func set_data(data):
	_data = data
	button = $Button as Button
	self.button.set_text(str(data))
	pass

extends InfiniteScrollContainerItem
class_name InfiniteScrollContainerItem_Test

func _ready():
	pass
	
func set_data(data):
	super.set_data(data)
	var label = $Label as Label
	label.text = str(_data._item_index,"-",_data._item_height)
	
	pass

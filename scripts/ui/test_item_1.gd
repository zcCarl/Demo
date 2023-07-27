extends InfiniteScrollContainerItem
class test_item_1_data extends InfiniteScrollContainerItemData:
	var text = "test"

@onready var label = $Label as Label

func set_data(data):
	super.set_data(data)
	label.text = self._data.text

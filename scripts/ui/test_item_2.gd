extends InfiniteScrollContainerItem
class test_item_1_data extends InfiniteScrollContainerItemData:
	var texture = "res://icon.svg"

@onready var texture = $TextureRect as TextureRect

func set_data(data):
	super.set_data(data)
	texture.texture = self._data.texture

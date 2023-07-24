extends ScrollContainer
@export var template: PackedScene = null
@onready var content = $content
var _data_list = []
var items:Array[InfiniteScrollContainerItem]

func set_data(data_list):
	_data_list = data_list

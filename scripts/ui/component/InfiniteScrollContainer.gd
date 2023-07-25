extends ScrollContainer

const ITEM_HEIGHT = 40
const BUFFER_SIZE = 5

@onready var content:BoxContainer = $content
var total_items = 0
var current_index = 0
var visible_items = 0
var buffer = 0

var start_index = 0
var end_index = 0
var previous_value = 0.0
@export var template :PackedScene
func _ready():
	get_v_scroll_bar().connect("value_changed",_on_VScrollBar_value_changed)
	total_items = 100
	visible_items = min(ceili(get_rect().size.y/ITEM_HEIGHT),total_items)
	buffer = BUFFER_SIZE
	start_index = 0
	end_index = min(start_index + visible_items,total_items)
	
	update_visible_items()

func _on_VScrollBar_value_changed(value:float):
	print(value)
	start_index += int(value - previous_value)
	start_index = (start_index+total_items)%total_items
	end_index = (start_index+visible_items)%total_items
#	if value < previous_value and  start_index == 0:
#		previous_value = value
	update_visible_items()

func update_visible_items():
	var item_to_remove = []
	for i in range(content.get_child_count()):
		var item = content.get_child(i)
		var item_index = item.name.to_int()
		if !is_item_within_range(item_index):
			item_to_remove.append(item)
	for item in item_to_remove:
		content.remove_child(item)
		item.queue_free()
	print(start_index,end_index)
	for i in update_scroll_position():
		if content.has_node(str(i)) == false:
			var list_item = template.instantiate() as InfiniteScrollContainerItem
			list_item.set_data(i)
			#list_item.custom_minimum_size = Vector2(0, ITEM_HEIGHT)
			list_item.name = str(i)
			content.add_child(list_item)
#			if i<start_index:
#				content.move_child(list_item,0)
#			else:
#				content.move_child(list_item,content.get_child_count()-1)
	previous_value = get_v_scroll_bar().value
	pass	
func  is_item_within_range(index):
	if start_index<=end_index:
		return index>=start_index and index<end_index
	else:
		return index>=start_index or index < end_index
func update_scroll_position():
	var items = []
	if start_index<=end_index:
		items = range(start_index,end_index)
	else:
		items = range(start_index,end_index) + range(0,end_index)
	return items

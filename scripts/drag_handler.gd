extends Node2D

class_name drag_handler

signal drag_node
var last_z_index = 0
var last_item_dragged = null
var drag_items = []
# Called when the node enters the scene tree for the first time.
func add_item(item):
	drag_items.append(item)
	pass
func remove_item(item):
	drag_items.remove_at(drag_items.find(item))
	pass
func drag_item(item):
	if last_item_dragged != item:
		var z = last_z_index + 3
		item.z_index = z
		last_z_index = z
		last_item_dragged = item

func select_draggable_item():
	var search_items = []
	for item in drag_items:
		search_items.append([item.z_index,item])
	search_items.sort_custom(func(a, b): a[0] > b[0])
	if search_items.size() >0:
		if search_items.size()>1:
			emit_signal("drag_node",search_items[0][1],search_items[1][1])
		else:
			emit_signal("drag_node",search_items[0][1],null)
	else:
		emit_signal("drag_node",null,null)

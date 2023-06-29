extends Node

class_name drag_handler
var drag_items:Array[drag_item] = []
func _init():
	
	name = "drag_handler"
	
func regiest(item:drag_item):
	item.connect("on_drag_item",_on_drag_item)
	
func _on_drag_item(item:drag_item):
	if drag_items.size()>0 :
		if drag_items[0]!=item:
			drag_items[0].drop(false,null)
			drag_items.remove_at(0)
	if item:
		drag_items.append(item)
		drag_items[0].pickup()
# Called when the node enters the scene tree for the first time.
#func add_item(item):
#	drag_items.append(item)
#	pass
#func remove_item(item):
#	drag_items.remove_at(drag_items.find(item))
#	pass
#func drag_item(item):
#	if last_item_dragged != item:
#		var z = last_z_index + 3
#		item.z_index = z
#		last_z_index = z
#		last_item_dragged = item
#
#func select_draggable_item():
#	var search_items = []
#	for item in drag_items:
#		search_items.append([item.z_index,item])
#	search_items.sort_custom(func(a, b): a[0] > b[0])
#	if search_items.size() >0:
#		if search_items.size()>1:
#			emit_signal("drag_node",search_items[0][1],search_items[1][1])
#		else:
#			emit_signal("drag_node",search_items[0][1],null)
#	else:
#		emit_signal("drag_node",null,null)

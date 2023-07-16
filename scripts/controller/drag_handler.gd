extends Node2D

class_name drag_handler
var drag_items:Array[drag_item] = []

func _ready():
	Signals.signal_drag_item.connect(_on_drag_item)
	

func _on_drag_item(item:drag_item):
	if drag_items.size()>0 :
		if drag_items[0]!=item:
			drag_items[0].drop(false,null)
			drag_items.remove_at(0)
	if item:
		drag_items.append(item)
		drag_items[0].pickup()

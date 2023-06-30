extends Resource

class_name signal_resource

signal custum_event(type:String,item:drag_item)
@export var type := 'default_signal'

func emitSignal(object):
	custum_event.emit('custum_event', type, object)
	
func connectSignal(callable:Callable):
	custum_event.connect(callable)

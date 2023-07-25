
extends Button
class_name InfiniteScrollContainerItemButton


var just_pressed = false
var prev_pos

var threshold = 5

signal Scroll_Button_Pressed


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("gui_input", self._on_Button_gui_input)
	mouse_filter = MOUSE_FILTER_PASS


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Button_gui_input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			just_pressed = true
			prev_pos = event.position
			
		if not event.pressed and just_pressed and event.position.distance_to(prev_pos) < threshold:
			just_pressed = false
			emit_signal("Scroll_Button_Pressed")

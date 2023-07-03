extends base_character
class_name character

@onready var _drag_item:drag_item = $drag_item

func _ready():
	$character_machine_normal.set_enable(true)

func handle_movement_point_input(_delta):
	if path.size()==0 and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		path = Game._scene._astar.get_auto_path(global_position,get_global_mouse_position())

func handle_movement_cancel_input(_delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		if path.size()>0:
			var last= path[0]
			path = [last]
func handle_movement_input(_delta):
	var direction_x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var direction_y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	var input_direction = Vector2(direction_x,direction_y)
	var dir = -1
	if abs(input_direction.x) > 0 and  abs(input_direction.y)>0 :
		if abs(input_direction.x) > 0 :
			input_direction.y = 0
		elif abs(input_direction.y) > 0 :
			input_direction.x = 0
	if input_direction.length():
		if input_direction.x > 0 :
			dir = 0
		elif input_direction.x < 0 :
			dir = 2
		elif input_direction.y > 0 :
			dir = 1
		elif input_direction.y < 0 :
			dir = 3
#	if path.size()==0 and dir!=-1:
#		input_direction = input_direction.normalized()
#		var current = main._game._scene.gloal_to_map(global_position)
#
#		var neighbors = main._game._scene.get_map_dir(current)
#		path = [neighbors[dir]]	
		
func handle_open_action_area():
	if ready_skill_index > -1:
		var _skill:base_skill = skills[ready_skill_index]
		var targets = []#main._game._scene.open_action_area(true,_skill)
		_skill.add_targets(targets)
		
func handle_update_action_area():
	if ready_skill_index > -1:
		var _skill:base_skill = skills[ready_skill_index]
		var targets = [] #main._game._scene.refresh_action_area(_skill)
		_skill.add_targets(targets)

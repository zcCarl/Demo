extends Node2D
class_name scene
var _player_controller : player_controller
# Called when the node enters the scene tree for the first time.
func _ready():
	auto_road.setup($ground)
	_player_controller = player_controller.new(self)
	_player_controller.name = "player_controller"
	add_child(_player_controller)

func open_action_area(open:bool,skill_info:base_skill):
	var skill_target = []
	if open :
		return skill_target
	else:
		return skill_target
		
func refresh_action_area(skill_info:base_skill):
	var skill_target = []
	return skill_target
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

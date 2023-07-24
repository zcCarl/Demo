extends Node2D
class_name scene
#@onready var _player_controller = $"player_controller" as player_controller
#@onready var _astar:tilemap_astar = $"tilemap_astar"
@onready var _map_ground = $maps/map_ground as map_ground
@onready var _map_indicator = $maps/map_indicator as map_indicator
# Called when the node enters the scene tree for the first time.
func _ready():
	_map_indicator.setup(_map_ground)
#	_astar.setup($maps/map_ground,0)
#	_astar.show_navigation_cells_pos = true
#	_astar.show_navigation_cells_id = true
	pass
#func get_auto_path()
#	_astar.get_auto_path()
func open_action_area(open:bool,skill_info:base_action):
	var skill_target = []
	if open :
		return skill_target
	else:
		return skill_target
		
func refresh_action_area(skill_info:base_action):
	var skill_target = []
	return skill_target


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

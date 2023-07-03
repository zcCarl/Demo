extends Node2D
class_name scene
signal character_move_grid(c:character)

@onready var _astar:astar = $"astar"

# Called when the node enters the scene tree for the first time.
func _ready():
	_astar.setup($maps/map_ground)


#func get_auto_path()
#	_astar.get_auto_path()
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

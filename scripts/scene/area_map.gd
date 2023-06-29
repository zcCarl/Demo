extends TileMap

# Called when the node enters the scene tree for the first time.
func _ready():
	var areaList:Array[Vector2i]=[Vector2i(5,5),Vector2i(5,4),Vector2i(5,6),Vector2i(4,5),Vector2i(6,5)]
	set_cells_terrain_connect(0,areaList,0,0)
	pass # Replace with function body.


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

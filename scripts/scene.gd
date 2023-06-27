extends Node2D
class_name scene
var _auto_road:auto_road
var _drag_handler : drag_handler
# Called when the node enters the scene tree for the first time.
func _ready():
	_auto_road= auto_road.new($ground)
	_auto_road.name = "auto_road"
	_drag_handler = drag_handler.new()
	_drag_handler.name = "drag_handler"
	add_child(_auto_road)
	add_child(_drag_handler)
	var areaList=[Vector2i(5,5),Vector2i(5,4),Vector2i(5,6),Vector2i(4,5),Vector2i(6,5)]
	for p in areaList:
		var tile_data:TileData = $area.get_cell_tile_data(0,p)
		tile_data.terrain = 0
		tile_data.terrain_set = 0
		if tile_data!=null:
			tile_data.set_terrain_peering_bit(TileSet.CELL_NEIGHBOR_LEFT_SIDE,0)
			tile_data.set_terrain_peering_bit(TileSet.CELL_NEIGHBOR_RIGHT_SIDE,0)
			tile_data.set_terrain_peering_bit(TileSet.CELL_NEIGHBOR_BOTTOM_SIDE,0)
			tile_data.set_terrain_peering_bit(TileSet.CELL_NEIGHBOR_TOP_SIDE,0)
			
	
	
func gloal_to_map(gloal):
	return $ground.local_to_map($ground.to_local(gloal))
func map_to_gloal(map):
	return $ground.to_global($ground.map_to_local(map)) 
func get_map_dir(map):
	return $ground.get_surrounding_cells(Vector2i(map))
	
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

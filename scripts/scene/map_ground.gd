extends TileMap
class_name map_ground
var astar = tilemap_astar.new(self,0)

@onready var debug = $CanvasLayer/debug

func _ready():
	debug.astar = astar
	astar.show_navigation_cells_pos = true
	astar.show_navigation_cells_id = true
	debug.queue_redraw()

func get_auto_path(start,end):
	#astar.get_point_path()
#	if astar._point_map[v1] and astar._point_map[v2]:
#		return astar.get_id_path(astar._point_map[v1],astar._point_map[v2])
	var start_p = scene_util.gloal_to_map(self,start)
	var end_p = scene_util.gloal_to_map(self,end)
	if astar._point_map.has(start_p) and astar._point_map.has(end_p):
		var start_id = astar._point_map[start_p]
		var end_id = astar._point_map[end_p]
		var path = astar.get_point_path(start_id,end_id)
		for i in range(0,path.size()) :
			path[i] = scene_util.map_to_gloal(self,path[i])
		return path
	return []


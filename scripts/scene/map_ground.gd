extends TileMap
class_name map_ground
var astar = tilemap_astar.new(self,0)

@onready var debug = $debug

func _ready():
	
	#debug.astar = astar
	#astar.show_navigation_cells_pos = true
	#astar.show_navigation_cells_id = true
	debug.queue_redraw()
	pass
func get_auto_path(start_map_point,end_map_point):
	if astar._point_map.has(start_map_point) and astar._point_map.has(end_map_point):
		var start_id = scene_util.point_to_id(start_map_point)
		var end_id = scene_util.point_to_id(end_map_point)
		var path = astar.get_point_path(start_id,end_id)
		for i in range(0,path.size()) :
			path[i] = scene_util.map_to_gloal(self,path[i])
		return path
	return []

func refresh_dynamic_obsable(old_global_position:Vector2,new_global_position:Vector2):
	astar.refresh_dynamic_obstacle(old_global_position,new_global_position)
	debug.queue_redraw()

func _unhandled_input(event):
	if event is InputEventMouseButton and event.is_action_pressed("mouse_click"):
		var map_point = scene_util.gloal_to_map(self,get_global_mouse_position())
		Signals.on_ground_click.emit(map_point)

#func _unhandled_input(event):
##	if event is InputEventMouseButton and event.is_action_pressed("mouse_click"):
##		var map_point = scene_util.gloal_to_map(self,get_global_mouse_position())
##		Signals.on_ground_click.emit(map_point)
#	pass

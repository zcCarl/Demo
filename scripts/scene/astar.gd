extends Node
class_name astar
var tile_map:TileMap 
var astar_node : AStar2D 
var map = {} 
var direction = [Vector2.RIGHT,Vector2.LEFT,Vector2.DOWN,Vector2.UP]
func calculate_point_index(vec):
	return vec.x * 10000000+ vec.y 
	pass
func calculate_point(id):
	return Vector2( id / 10000000, id % 10000000)
	pass
	
func setup(tileMap:TileMap):
	tile_map = tileMap
	astar_node = AStar2D.new() 
	for tile in tile_map.get_used_cells(0):
		var vec = Vector2(tile.x,tile.y)
		var point_index = calculate_point_index(vec)
		map[point_index] = vec
		astar_node.add_point(point_index , vec)
		for dir in direction:
			var point_relative_index = calculate_point_index(vec+dir)
			if astar_node.has_point(point_index) and astar_node.has_point(point_relative_index):
				astar_node.connect_points(point_index,point_relative_index,true)
		pass


func get_auto_path(start,end):
	var start_p = scene_util.gloal_to_map(tile_map,start)
	var end_p = scene_util.gloal_to_map(tile_map,end)
	var start_id = calculate_point_index(start_p)
	var end_id = calculate_point_index(end_p)
	var path = astar_node.get_point_path(start_id,end_id)
	for i in range(0,path.size()) :
		path[i] = scene_util.map_to_gloal(tile_map,path[i])
	return path

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

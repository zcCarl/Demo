extends Node

class_name scene_util

static func gloal_to_map(tilemap:TileMap,gloal:Vector2):
	return tilemap.local_to_map(tilemap.to_local(gloal))
static func map_to_gloal(tilemap:TileMap,map:Vector2i):
	return tilemap.to_global(tilemap.map_to_local(map)) 
static func get_map_dir(tilemap:TileMap,map:Vector2i):
	return tilemap.get_surrounding_cells(Vector2i(map))
	

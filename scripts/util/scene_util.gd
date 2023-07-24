extends Node

class_name scene_util

static func gloal_to_map(tilemap:TileMap,gloal:Vector2)->Vector2i:
	return tilemap.local_to_map(tilemap.to_local(gloal))
static func map_to_gloal(tilemap:TileMap,map:Vector2i)->Vector2:
	return tilemap.to_global(tilemap.map_to_local(map)) 
static func get_map_dir(tilemap:TileMap,map:Vector2i):
	return tilemap.get_surrounding_cells(Vector2i(map))

static func point_to_id(point:Vector2i):
	if point == Vector2i.ZERO:
		return 0
	var k = max(abs(point.x),abs(point.y))
	if point.x > point.y:
		return 4 * k * k + 1 + 2 * k + point.x + point.y
	else :
		return 4 * k * k + 1 - 2 * k - point.x - point.y
static func id_to_point(id:int):
	if id == 0:
		return Vector2i.ZERO
	var sqrtX = sqrt(id)
	var k = int((sqrtX + 1) / 2)
	var xAy = 0
	if sqrtX > 2 * k:
		xAy = id - (4 * k * k + 1) - 2 * k
	else:
		xAy = (4 * k * k + 1) - id - 2 * k
	if xAy < 0:
		return Vector2i(-k, xAy + k)
	else :
		return Vector2i(k, xAy - k)

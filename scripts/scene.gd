extends Node2D
class_name scene
var _auto_road:aotu_road
var _tile_map : TileMap
func _init():
	_tile_map = preload("res://tileMap1.tscn").instantiate()
	main.add_child(_tile_map)
	_auto_road=aotu_road.new(_tile_map)
	main.add_child(_auto_road)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func gloal_to_map(gloal):
	return _tile_map.local_to_map(_tile_map.to_local(gloal))
func map_to_gloal(map):
	return _tile_map.to_global(_tile_map.map_to_local(map)) 
func get_map_dir(map):
	return _tile_map.get_surrounding_cells(Vector2i(map))
	
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

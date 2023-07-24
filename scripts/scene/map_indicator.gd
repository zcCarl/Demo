extends TileMap

class_name map_indicator

var indicator_pos:Vector2i
var _map_ground:map_ground
var indicator_tile = {
	"indicator_point_white":{
		"layer" : 2,
		"source_id":0,
		"atlas_coords":Vector2(0,2),
		"alternative_tile":-1
	},
	"indicator_point_yellow":{
		"layer" : 2,
		"source_id":0,
		"atlas_coords":Vector2(1,2),
		"alternative_tile":-1
	},
	"indicator_player":{
		"layer" : 0,
		"source_id":0,
		"atlas_coords":Vector2(0,0),
		"alternative_tile":-1
	},
	"indicator_enemy":{
		"layer" : 0,
		"source_id":0,
		"atlas_coords":Vector2(0,1),
		"alternative_tile":-1
	},
	"indicator_skill":{
		"layer" : 1,
		"source_id":0,
		"atlas_coords":Vector2(1,1),
		"alternative_tile":-1
	},
}

func setup(ground:map_ground):
	_map_ground = ground
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = create_tween()
	
	tween.tween_property(self,"modulate",Color(modulate,0),0.4)
	tween.tween_property(self,"modulate",Color(modulate,1),0.4)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.set_loops()
	pass # Replace with function body.

func refresh_player_indicator(v:Vector2i):
	var layer = indicator_tile["indicator_point_white"]["layer"]
	var source_id = indicator_tile["indicator_point_white"]["source_id"]
	var atlas_coords = indicator_tile["indicator_point_white"]["atlas_coords"]
	if indicator_pos != v:
		set_cell(layer,indicator_pos)
		set_cell(layer,v,source_id,atlas_coords)
		indicator_pos = v
	pass

func open_action_area(open:bool,skill_info:base_action):
	var skill_target = []
	if open :
		return skill_target
	else:
		return skill_target
		
func refresh_action_area(skill_info:base_action):
	var skill_target = []
	return skill_target

func _input(event):
	if _map_ground and event is InputEventMouseMotion:
		var map_position = scene_util.gloal_to_map(_map_ground,get_global_mouse_position())
		if _map_ground.astar.has_point(scene_util.point_to_id(map_position)):
			refresh_player_indicator(map_position)
	#return

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

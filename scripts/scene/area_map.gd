extends TileMap

var indicator_pos:Vector2i

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

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func refresh_player_indicator(v:Vector2i):
	var layer = indicator_tile["indicator_point_white"]["layer"]
	var source_id = indicator_tile["indicator_point_white"]["source_id"]
	var atlas_coords = indicator_tile["indicator_point_white"]["atlas_coords"]
	if indicator_pos != v:
		set_cell(layer,indicator_pos)
		set_cell(layer,v,source_id,atlas_coords,)
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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

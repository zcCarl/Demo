extends ui_base
class_name ui_main_save
var temp = 0
@onready var character_texture : Array[TextureRect] = [
	$pad/vc/m1/save/has/mc/character_texture as TextureRect,
	$pad/vc/m2/save/has/mc/character_texture as TextureRect,
	$pad/vc/m3/save/has/mc/character_texture as TextureRect,
]
@onready var save_data_label = [
	[
		$pad/vc/m1/save/has/vc/group1/save_data_label,
		$pad/vc/m1/save/has/vc/group2/save_data_label,
		$pad/vc/m1/save/has/vc/group3/save_data_label,
		$pad/vc/m1/save/has/vc/group4/save_data_label,
	],
	[
		$pad/vc/m2/save/has/vc/group1/save_data_label,
		$pad/vc/m2/save/has/vc/group2/save_data_label,
		$pad/vc/m2/save/has/vc/group3/save_data_label,
		$pad/vc/m2/save/has/vc/group4/save_data_label,
	],
	[
		$pad/vc/m3/save/has/vc/group1/save_data_label,
		$pad/vc/m3/save/has/vc/group2/save_data_label,
		$pad/vc/m3/save/has/vc/group3/save_data_label,
		$pad/vc/m3/save/has/vc/group4/save_data_label,
	],
]
@onready var none:Array[Control] = [
	$pad/vc/m1/save/none as Control,
	$pad/vc/m2/save/none as Control,
	$pad/vc/m3/save/none as Control,
]
@onready var save : Array[Node]= [
	$pad/vc/m1/save/has,
	$pad/vc/m2/save/has,
	$pad/vc/m3/save/has,
]
@onready var create_btns : Array[BaseButton]= [
	$pad/vc/m1/save/none/create_save as BaseButton,
	$pad/vc/m2/save/none/create_save as BaseButton,
	$pad/vc/m3/save/none/create_save as BaseButton,
]

@onready var load_btns : Array[BaseButton]= [
	$pad/vc/m1/save/has/vc/group5/load_button as BaseButton,
	$pad/vc/m2/save/has/vc/group5/load_button as BaseButton,
	$pad/vc/m3/save/has/vc/group5/load_button as BaseButton,
]

@onready var delete_btns : Array[BaseButton]= [
	$pad/vc/m1/save/has/vc/group5/delete_button as BaseButton,
	$pad/vc/m2/save/has/vc/group5/delete_button as BaseButton,
	$pad/vc/m3/save/has/vc/group5/delete_button as BaseButton,
]
# Called when the node enters the scene tree for the first time.
func _ready():
	create_btns[0].pressed.connect(func():create_save(0))
	create_btns[1].pressed.connect(func():create_save(1))
	create_btns[2].pressed.connect(func():create_save(2))
	load_btns[0].pressed.connect(func():load_save(0))
	load_btns[1].pressed.connect(func():load_save(1))
	load_btns[2].pressed.connect(func():load_save(2))
	delete_btns[0].pressed.connect(func():delete_save(0))
	delete_btns[1].pressed.connect(func():delete_save(1))
	delete_btns[2].pressed.connect(func():delete_save(2))
	set_save(0)
	set_save(1)
	set_save(2)
	pass
	
func create_save(index):
	Signals.on_create_game_save.emit(index)
	pass

func load_save(index):
	Signals.on_load_game_save.emit(index)

func delete_save(index):
	Signals.on_delete_game_save.emit(index)

func set_save(index):
	var save_data = modules._module_save.get_save(index) 
	print("222"+JSON.stringify(save_data))
	if save_data :
		print("33333")
		none[index].visible = false
		save[index].visible = true
		save_data_label[index][0].text = str(save_data.get_character())
		save_data_label[index][1].text = save_data.get_save_time()
		save_data_label[index][2].text = str(save_data.get_save_map())
		save_data_label[index][3].text = save_data.get_save_character_pos()
	else :
		none[index].visible = true
		save[index].visible = false
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

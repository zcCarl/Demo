extends ui_base

class_name ui_main_game
@onready var action_root = $action_root as Control
@onready var select_root = $action_root/select_root as FlowContainer
@onready var sub_select_root = $action_root/sub_select_root as InfiniteScrollContainer

@onready var move_btn = $action_root/select_root/move_btn
@onready var attack_btn = $action_root/select_root/move_btn
@onready var spell_btn = $action_root/select_root/move_btn
@onready var item_btn = $action_root/select_root/move_btn

signal on_character_move_preview 
signal on_character_attack_preview 
signal on_character_spell_preview

var _cur_character:base_character = null

func _ready():
	move_btn.connect("button_down",on_move_preview)
	attack_btn.connect("button_down",on_attack_preview)
	spell_btn.connect("button_down",on_spell_list)
	item_btn.connect("button_down",on_item_list)
	action_root.visible = false
	sub_select_root.visible = false
	pass

func _process(delta):
	if _cur_character and action_root.visible:
		position = get_viewport_transform() * (_cur_character.get_viewport_transform() * _cur_character.global_position)
		#scale = main.get_game().camera
		#action_root.global_position = _cur_character.global_position
	pass	

func set_cur_character(c:base_character):
	_cur_character = c
	action_root.visible = true
	pass
func on_move_preview():
	sub_select_root.visible = false
	on_character_move_preview.emit(_cur_character)
	
func on_attack_preview():
	sub_select_root.visible = false
	on_character_attack_preview.emit(_cur_character)
	
func on_spell_list():
	sub_select_root.visible = true
	var datas = []
	var data = InfiniteScrollContainerItem.InfiniteScrollContainerItemData.new(0,40,{})
	datas.append(data)
	sub_select_root.set_datas(datas)
	
func on_item_list():
	sub_select_root.visible = true

extends ui_base
@onready var action_root = $action_root
@onready var select_root = $action_root/select_root
@onready var sub_select_root = $action_root/sub_select_root

@onready var move_btn = $action_root/select_root/move_btn
@onready var attack_btn = $action_root/select_root/move_btn
@onready var spell_btn = $action_root/select_root/move_btn
@onready var item_btn = $action_root/select_root/move_btn

signal on_character_move_preview 

func _ready():
	move_btn.connect("button_down",on_move_preview)
	attack_btn.connect("button_down",on_attack_preview)
	spell_btn.connect("button_down",on_spell_list)
	item_btn.connect("button_down",on_item_list)
	pass
func on_move_preview():
	on_character_move_preview.emit()
	
func on_attack_preview():
	on_character_move_preview.emit()
	
func on_spell_list():
	on_character_move_preview.emit()
	
func on_item_list():
	on_character_move_preview.emit()

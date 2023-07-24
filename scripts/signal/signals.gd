extends Node


signal on_ui_main_ready_start 
signal on_ui_main_ready_continue 
signal on_ui_main_ready_save 
signal on_ui_main_ready_exit 

signal on_create_game_save(int)

signal on_load_game_save(int)

signal on_delete_game_save(int)

signal on_action_center_area_open()

signal on_character_path
signal on_character_turn

signal on_ground_click

signal signal_drag_item(item:drag_item)

extends Node

enum skill_target_type{
	firends = 1,
	enemies = 2,
	firends_except_me = 3,
	all = 4,
}

enum ui_layer{
	game_root,
	fullscreen_root,
	popup_root,
	tips_root,
}

enum main_state{
	main_init,
	main_ready,
	main_save,
	main_game,
}

enum character_normal_state{ 
	character_normal_state_idle,
	character_normal_state_walk
}

enum character_battle_state{ 
	character_battle_state_ready,
	character_battle_state_action,
	character_battle_state_over,
}

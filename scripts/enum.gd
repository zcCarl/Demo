extends Node


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
enum skill_effect_type{
	none,heal,damage,tickle,create_object
}

enum skill_target_type{
	enemy,   #可见的
	teammate,#队友
	own,     #自己
}

enum skill_area_center_type{
	any ,     #任意位置为中心
	own ,     #玩家位置为中心
	enermy ,  #敌人位置为中心
	teammate ,#队友位置为中心
}

enum skill_area_type{
	rectangle ,#矩形
	point ,    #点
	line ,     #线
	rhombus ,  #菱形
}

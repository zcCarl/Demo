extends state_machine
class_name character_machine_battle

enum battle_state{
	ready ,move ,pre_action ,action ,hurt ,death ,relive , 
}
# Called when the node enters the scene tree for the first time.
func _ready():
	add_state(battle_state.ready,"ready")
	add_state(battle_state.pre_action,"pre_action")
	add_state(battle_state.action,"action")
	add_state(battle_state.hurt,"hurt")
	add_state(battle_state.death,"death")
	add_state(battle_state.relive,"relive")
	pass # Replace with function body.

func on_enable():
	super()
	await get_tree().process_frame
	call_deferred("set_state", battle_state.ready)

func on_disable():
	super()

func _state_logic(delta):
	if state == battle_state.ready:
		if !parent.has_moved:
			parent.handle_open_action_area()
		elif !parent.has_action:
			parent.handle_open_action_area()
	if state == battle_state.pre_action:
		parent.handle_update_action_area()
		
func _get_transitions(_delta):
	match state:
		battle_state.ready:
			if parent.ready_skill_index>-1:
				return battle_state.pre_action
			elif parent.velocity.length()>0:
				return battle_state.move
			pass
		battle_state.walk:
			if parent.velocity.length()==0:
				return battle_state.ready
			pass
		states.attack:
			pass
		states.skill:
			pass
		states.hurt:
			pass
func _enter_state(_new_state, _old_state):
	match _new_state:
		states.ready:
			pass
		states.move:
			pass
		states.pre_action:
			pass
		states.action:
			pass
		states.hurt:
			pass
		states.death:
			pass
		states.relive:
			pass
			
			

# State exit function.
func _exit_state(_old_state, _new_state):
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

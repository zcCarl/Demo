class_name state_machine


class state:
	var _name = ""
	
	var _context = {}

	func enter(context):
		_context = context
		
	func exit():
		pass
	func process(delta: float):
		pass

signal state_changed(previous, new)

var is_active = true:
	set = set_is_active

var _state: state:
	set = set_state
var _state_name = ""

var _context = null

func init(context= {}):
	_context = context

func start(initial_state):
	change(initial_state)
	
func process(delta: float):
	if(is_active):
		_state.process(delta)

func change(state, context={}):
	var previour = _state
	_state = state
	if previour!=null :
		previour.exit()
	_state.enter(context)
	_on_state_changed(previour, _state)
#	Events.player_state_changed.emit(_state.name)


func set_is_active(value):
	is_active = value

func set_state(value):
	_state = value
	_state_name = _state._name


func _on_state_changed(previous, new):
	print("state changed")
	state_changed.emit(previous, new)

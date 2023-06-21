extends Node

var machine:state_machine

	

# Called when the node enters the scene tree for the first time.
func _ready():
	loading.forward()
	self.machine = state_machine.new()
	self.machine.start(state_machine.state.new())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.machine:
		self.machine.process(delta)

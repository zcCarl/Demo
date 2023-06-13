extends Node

var machine:state_machine

func wait_confirmation():
	print("Prompting user")
	await $Button.button_up # Waits for the button_up signal from Button node.
	print("User confirmed")
	return true
	
	

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Will ask the user")
	var confirmed = await wait_confirmation()
	if confirmed:
		print("User confirmed")
	else:
		print("User cancelled")
	self.machine = state_machine.new()
	self.machine.start(state_machine.state.new())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.machine:
		self.machine.process(delta)

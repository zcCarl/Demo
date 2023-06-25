extends Node

var machine:state_machine
var _game:game 
	

# Called when the node enters the scene tree for the first time.
func _ready():
	_game = game.new()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.machine:
		self.machine.process(delta)

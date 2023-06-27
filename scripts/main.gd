extends Node

var _game:game 
	

# Called when the node enters the scene tree for the first time.
func _ready():
	_game = game.new()
	_game.name = "game"
	add_child(_game)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

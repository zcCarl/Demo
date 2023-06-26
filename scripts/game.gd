extends Node2D

class_name game

var _scene : scene
var _character : base_character
# Called when the node enters the scene tree for the first time.
func _init():
	_scene = scene.new()
	main.add_child(_scene)
	_character= preload("res://scene/character/character_base.tscn").instantiate()
	_character.setup(1)
	main.add_child(_character)
	_character.position=Vector2.RIGHT*200 + Vector2.DOWN *200
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

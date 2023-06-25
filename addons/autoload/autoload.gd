@tool
extends EditorPlugin


func _enter_tree():
	add_autoload_singleton("ui_manager","res://scripts/managers/ui_manager.gd")
	add_autoload_singleton("main","res://scripts/main.gd")
	# Initialization of the plugin goes here.
	pass


func _exit_tree():
	# Clean-up of the plugin goes here.
	pass

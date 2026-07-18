@tool
extends EditorPlugin


func _enter_tree():
	add_custom_type("Look At", "Node", preload("look_at.gd"), preload("look_at_icon.png"))


func _exit_tree():
	# Clean-up of the plugin goes here.
	# Always remember to remove it from the engine when deactivated.
	remove_custom_type("Look At")

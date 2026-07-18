@tool
extends EditorPlugin

func _enter_tree():
#	add_custom_type("Clickable Area 2D", "Area2D", preload("clickable_area_2d.gd"), preload("clickable_area_2d_icon.png"))
	pass


func _exit_tree():
	# Clean-up of the plugin goes here.
	# Always remember to remove it from the engine when deactivated.
#	remove_custom_type("Clickable Area 2D")
	pass

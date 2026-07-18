@tool
extends EditorPlugin


func _enter_tree():
	add_custom_type("Mouse AudioListener3D", "Node", preload("mouse_listener.gd"), preload("mouse_listener_icon.png"))


func _exit_tree():
	# Clean-up of the plugin goes here.
	# Always remember to remove it from the engine when deactivated.
	remove_custom_type("Mouse AudioListener3D")

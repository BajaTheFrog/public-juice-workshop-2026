extends HBoxContainer
class_name AmmoUI

@export var shell_scene: PackedScene

func _ready() -> void:
	Game.events.player.ammo_changed.connect(_on_ammo_changed)


func _on_ammo_changed(old_count: int, new_count: int) -> void:
	var current_count = get_child_count()
	
	# Add if we need to add
	while current_count < new_count:
		_add_shell()
		current_count = get_child_count()
		
	# Subtract if we need to subtract
	while current_count > new_count:
		var future_count = _remove_shell()
		current_count = future_count
	

func _add_shell() -> void:
	var shell_instance = shell_scene.instantiate()
	add_child(shell_instance)
	

func _remove_shell() -> int:
	var current_count = get_child_count()
	var last_node = get_children().pop_back()
	if last_node:
		last_node.queue_free()
	
	return current_count - 1

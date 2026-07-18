extends Node
class_name Change

@export var content_root: Node
@export var transition_root: Transition

var current_content_packed_scene: PackedScene

func move_current_scene_to_content_root() -> void:
	var root = get_tree().root
	var has_root_children = root.get_child_count() > 1
	var has_content_children = content_root.get_child_count() > 0
	
	if not has_root_children:
		return
	
	var children = root.get_children()
	for index in range(1, children.size()):
		var child = children[index]
		if has_content_children:
			root.remove_child(child)
		else:
			child.reparent(content_root)
		

func go_to_starting_context() -> void:
	go_to(Content.starting_context)
	transition_root.fade_in()
	

func go_to(context_id: Content.Contexts) -> void:
	var new_context_scene = Game.content.get_context_scene(context_id)
	if not new_context_scene:
		return
	
	_go_to_context_packed_scene(new_context_scene)
	
	
func _go_to_context_packed_scene(packed_scene: PackedScene) -> void:
	await transition_root.fade_out()
	transition_root.fade_out_then_fade_in(0.3)
	_clear_current_content()
	_instantiate_and_add_content(packed_scene)


func _clear_current_content() -> void:
	if content_root.get_children().is_empty():
		return
		
	for child in content_root.get_children():
		content_root.remove_child(child)
		child.queue_free()
	

func _instantiate_and_add_content(packed_scene: PackedScene) -> void:
	var content = packed_scene.instantiate()
	content_root.add_child(content)
	current_content_packed_scene = packed_scene
	transition_root.fade_in_when_ready(content)
	

func scene_swap(parent: Node, new_scene: PackedScene) -> Node:
	await transition_root.fade_out()
	#transition_root.fade_out_then_fade_in(0.3)
	for child in parent.get_children():
		parent.remove_child(child)
		child.queue_free()
		
	var child_scene = new_scene.instantiate()
	parent.add_child(child_scene)
	transition_root.fade_in_when_ready(child_scene)
	return child_scene
	

func scene_add(parent: Node, new_scene: PackedScene) -> Node:
	await transition_root.fade_out()
	#transition_root.fade_out_then_fade_in(0.3)
	var child_scene = new_scene.instantiate()
	parent.add_child(child_scene)
	transition_root.fade_in_when_ready(child_scene)
	return child_scene
	

func reload_current() -> void:
	if get_tree().current_scene:
		get_tree().reload_current_scene()
	elif current_content_packed_scene:
		_go_to_context_packed_scene(current_content_packed_scene)

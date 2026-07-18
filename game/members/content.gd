extends Node
class_name Content

enum Contexts {
	TITLE,
	PLAY
}

static var starting_context: Contexts = Contexts.TITLE
@export var title_context_scene: PackedScene
@export var play_context_scene: PackedScene
var context_dictionary: Dictionary

func load_dictionaries() -> void:
	# NOTE: In Godot 4.4 there will be support
	# for typed dictionaries, so this can be done in editor
	context_dictionary = {
		Contexts.TITLE: title_context_scene, 
		Contexts.PLAY: play_context_scene
	}
	
	# NOTE: Load other types of content here!
	

func get_context_scene(id: Contexts) -> PackedScene:
	if context_dictionary.is_empty():
		load_dictionaries()
		
	return context_dictionary[id]

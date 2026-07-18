extends Node
class_name Component
# Component
# Base class for "component" type nodes that provide
# standardized utility. Main advantage compared to a regular
# Node is the "enabled" flag. 
# See also Component2D

@export var enabled: bool = true

func enable() -> void:
	enabled = true
	

func disable() -> void:
	enabled = false


func _process(delta):
	if enabled:
		_component_process(delta)
		
		
func _component_process(delta):
	# Override process logic in subclasses 
	pass
	
	
func _physics_process(delta):
	if enabled:
		_component_physics_process(delta)


func _component_physics_process(delta):
	# Override physics process logic in subclasses 
	pass

extends Node2D
class_name Component2D
# Component2D
# Base class for "component" type nodes that provide
# standardized utility. Main advantage compared to a regular
# Node is the "enabled" flag. 
# See also Component

@export var enabled: bool = true

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

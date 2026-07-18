extends Component
class_name Spinner
# Spinner
# Logic for just making a target node spin indefinitely

enum SpinDirection { CLOCKWISE, COUNTER_CLOCKWISE }

@export var target: Node2D
@export var spin_direction: SpinDirection
@export var rotations_per_second: float = 1
	
	
func _component_process(delta):
	if not target:
		return
		
	var current_rotation = target.rotation_degrees
	var rot_speed = rad_to_deg(rotations_per_second * 2 * PI)
	var new_rotation_delta = rot_speed * delta
	
	var direction_multiplier = 1 if spin_direction == SpinDirection.CLOCKWISE else -1
	new_rotation_delta *= direction_multiplier
	var new_rotation = target.rotation_degrees + new_rotation_delta
	target.rotation_degrees = new_rotation

extends Component
class_name LookAt
# A node for hooking up look_at behavior
# for the mouse or arbitrary nodes

enum TargetMode {
	MOUSE,
	TARGET,
}

enum UpdateMode {
	PROCESS,
	PHYSICS,
}

@export var node_to_rotate: Node2D = null
@export var target_mode: TargetMode = TargetMode.MOUSE
@export var target: Node2D = null
@export var update_mode: UpdateMode = UpdateMode.PROCESS
@export_range(-360.0, 360.0) var degree_adjustment: float = 0.0


func _component_process(_delta):	
	if update_mode != UpdateMode.PROCESS:
		return
		
	_look()
	
	
func _component_physics_process(_delta):
	if update_mode != UpdateMode.PHYSICS:
		return
		
	_look()
		

func _look():
	if node_to_rotate:
		var point = _get_point()
		node_to_rotate.look_at(point)
		node_to_rotate.rotation_degrees += degree_adjustment
		
		
func _get_point() -> Vector2:
	match target_mode:
		TargetMode.MOUSE:
			return get_viewport().get_mouse_position()
		TargetMode.TARGET:
			if target == null:
				return Vector2.ZERO
			
			return target.position
				
	return Vector2.ZERO
	

func clear() -> void:
	node_to_rotate = null
	target = null

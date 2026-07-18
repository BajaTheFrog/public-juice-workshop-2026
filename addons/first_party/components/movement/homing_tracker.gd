extends Component
class_name HomingTracker

@export var target_to_move: Node = null
@export var homing_target: Node = null
@export var rotate_towards_target = true

@export_range(0, 1000_000.0) var speed: float = 1500.0
@export_range(0, 1000_000.0) var steer_force: float = 4000.0
@export var increase_seek_over_time: bool = true
@export_range(0, 1000_000.0) var seek_multiplier: float = 1.0

var velocity = Vector2.ZERO
var acceleration = Vector2.ZERO


func seek(delta):
	var steer = Vector2.ZERO
	if homing_target:
		var desired = (homing_target.global_position - target_to_move.global_position).normalized() * speed
		steer = (desired - velocity).normalized() * steer_force
		
	if increase_seek_over_time:
		seek_multiplier += delta
		
	return steer * seek_multiplier


func _component_physics_process(delta):
	if not target_to_move or not homing_target:
		return
	
	acceleration += seek(delta)
	velocity += acceleration * delta
	velocity = velocity.limit_length(speed)
	if rotate_towards_target:
		target_to_move.rotation = velocity.angle()
	target_to_move.global_position += velocity * delta

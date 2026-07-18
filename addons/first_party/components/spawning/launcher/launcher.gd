extends Spawner2D
class_name Launcher2D

signal projectile_launched(launched_node)
signal debug_direction_info(given_direction, final_direction)

enum LaunchLimits {UNLIMITED, LIMITED}
enum DirectionMode {ABSOLUTE, RELATIVE_TO_SPAWNER, RELATIVE_TO_PARENT}

@export_range(0.0, Tools.EXPORT_RANGE_FLOAT_MAX) var projectile_speed: float = 1000
@export_range(0.0, Tools.EXPORT_RANGE_FLOAT_MAX) var shots_per_second: float = 10.0
@export_range(0, Tools.EXPORT_RANGE_INT_MAX) var max_projectiles: int
@export_range(0, Tools.EXPORT_RANGE_INT_MAX) var remaining_projectiles: int
@export var launch_limits: LaunchLimits
@export var direction_mode: DirectionMode
@export var launch_direction_data: Resource 

var timer: Timer
var can_fire = true

func _ready():
	timer = Timer.new()
	add_child(timer)
	
	node_spawned.connect(_on_projectile_spawned)
	timer.timeout.connect(_on_timer_timeout)
	timer.wait_time = 1.0 / shots_per_second
	timer.autostart = false
	

# Returns bool representing if it fired or not
func fire() -> bool:
	if can_fire and are_projectiles_available():
		spawn()
		timer.start()
		can_fire = false
		return true
	else:
		return false
		
		
func spawn():
	super.spawn()
	if launch_limits == LaunchLimits.LIMITED:
		remaining_projectiles -= 1
		
		
func are_projectiles_available() -> bool:
	if launch_limits == LaunchLimits.UNLIMITED:
		return true
	else:
		return remaining_projectiles > 0
		
		
func get_projectile_stock() -> float:
	if launch_limits == LaunchLimits.UNLIMITED:
		return 1.0
	else:
		return float(remaining_projectiles) / float(max_projectiles)
		
		
func restock_projectiles(amount: int = -1) -> void:
	if amount <= 0:
		remaining_projectiles = max_projectiles
	else:
		remaining_projectiles += amount
		remaining_projectiles = clamp(remaining_projectiles, 0.0, max_projectiles)
		
		
func _on_timer_timeout():
	can_fire = true
	

func _on_projectile_spawned(spawned_node: Node2D):
	if not "velocity" in spawned_node:
		return
	
	var launch_direction = _get_launch_direction_vector()
	debug_direction_info.emit(launch_direction_data.get_direction_vector().normalized(), launch_direction)
	spawned_node.velocity = launch_direction * projectile_speed
	spawned_node.rotation_degrees = rad_to_deg(launch_direction.angle())
	projectile_launched.emit(spawned_node)
	

# its normalized
func _get_launch_direction_vector() -> Vector2:
	var launch_direction_vector = launch_direction_data.get_direction_vector()
	match rotation_mode:
		DirectionMode.ABSOLUTE:
			pass
		DirectionMode.RELATIVE_TO_SPAWNER:
			var direction_deviation_radians = launch_direction_vector.angle()
			var global_rotation_radians = deg_to_rad(self.global_rotation_degrees) + direction_deviation_radians
			var global_rotation_vector = Vector2.RIGHT.rotated(global_rotation_radians)
			launch_direction_vector = global_rotation_vector
		DirectionMode.RELATIVE_TO_PARENT:
			var direction_deviation_radians = launch_direction_vector.angle()
			var global_parent_rotation_radians = deg_to_rad(parent_for_spawn.global_rotation_degrees) + direction_deviation_radians
			var parent_lobal_rotation_vector = Vector2.RIGHT.rotated(global_parent_rotation_radians)
			launch_direction_vector = parent_lobal_rotation_vector
			
	return launch_direction_vector.normalized()

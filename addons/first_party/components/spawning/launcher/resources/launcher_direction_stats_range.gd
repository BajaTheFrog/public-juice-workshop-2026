extends LauncherDirectionStatsBase
class_name LauncherDirectionStatsRange

enum DirectionMode {VECTOR, DEGREES}

@export var min_vector: Vector2
@export var max_vector: Vector2
@export_range(-360.0, 360.0) var min_degrees
@export_range(-360.0, 360.0) var max_degrees
@export var mode: DirectionMode

func _init(p_min_vector = Vector2(0.5, -0.5), p_max_vector = Vector2(0.5, 0.5), p_min_degrees = -45, p_max_degrees = 45):
	min_vector = p_min_vector
	max_vector = p_max_vector
	min_degrees = p_min_degrees
	max_degrees = p_max_degrees


func get_direction_vector() -> Vector2:
	if mode == DirectionMode.VECTOR:
		var x = randf_range(min_vector.x, max_vector.x)
		var y = randf_range(min_vector.y, max_vector.y)
		return Vector2(x, y)
	else:
		var random_degrees = randf_range(min_degrees, max_degrees)
		var random_radians = deg_to_rad(random_degrees)
		return Vector2.RIGHT.rotated(random_radians)

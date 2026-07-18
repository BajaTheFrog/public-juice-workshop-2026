extends LauncherDirectionStatsBase
class_name LauncherDirectionStatsFixed

enum DirectionMode {VECTOR, DEGREES}

@export var vector: Vector2
@export_range(-360, 360) var degrees: float
@export var mode: DirectionMode

func _init(p_vector = Vector2.RIGHT, p_degrees = 0):
	vector = p_vector
	degrees = p_degrees


func get_direction_vector() -> Vector2:
	if mode == DirectionMode.VECTOR:
		return vector
	else:
		var radians = deg_to_rad(degrees)
		return Vector2.RIGHT.rotated(radians)

extends Line2D
class_name TrailRenderer

@export_range(0, Tools.EXPORT_RANGE_FLOAT_MAX) var add_distance = 0.0
@export_range(0, Tools.EXPORT_RANGE_INT_MAX) var point_limit = 0
@export_range(0.0, Tools.EXPORT_RANGE_FLOAT_MAX) var removal_frequency = 0.0

var fade_timer: float = 0.0
var last_flight_position: Vector2

func _physics_process(delta: float) -> void:
	fade_timer += delta
	
	if not last_flight_position:
		last_flight_position = owner.global_position
	
	if owner.global_position.distance_to(last_flight_position) >= add_distance:
		add_point(owner.global_position)
		last_flight_position = owner.global_position
		
	if get_point_count() > point_limit or (fade_timer > removal_frequency and get_point_count() > 0):
		remove_point(0)
		fade_timer = 0

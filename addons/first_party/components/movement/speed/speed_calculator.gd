extends Node
class_name SpeedCalculator

signal speed_changed(old_speed, new_speed)

@export_range(0.0, Tools.EXPORT_RANGE_FLOAT_MAX) var top_speed: float
@export var has_acceleration: bool
@export_range(0.0, Tools.EXPORT_RANGE_INT_MAX) var acceleration: float
@export_range(0.0, Tools.EXPORT_RANGE_INT_MAX) var deacceleration: float

var current_speed = 0.0

func get_current_speed() -> float:
	# Subclasses should provide 
	# their own calculation
	return current_speed
	

func update_speed(old_speed, new_speed):
	speed_changed.emit(old_speed, new_speed)

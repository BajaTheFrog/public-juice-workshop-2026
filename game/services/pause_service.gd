extends GameService
class_name PauseService

signal paused_value_changed(new_value: bool)

@export_range(0.0, Tools.EXPORT_RANGE_FLOAT_MAX) var min_time_between_changes = 0.3
var _time_since_last_request = 0


func _ready():
	_time_since_last_request = min_time_between_changes


func _process(delta):
	if _time_since_last_request <= min_time_between_changes:
		_time_since_last_request += delta


func is_paused():
	return get_tree().paused
	
	
func toggle_pause():
	if is_paused():
		pause_off()
	else:
		pause_on()
	
	
func pause_on():
	_set_paused(true)
	
	
func pause_off():
	_set_paused(false)
	
	
func _set_paused(paused_value: bool):
	# squash "double presses" or inputs from multiple nodes
	if _time_since_last_request < min_time_between_changes:
		return

	get_tree().paused = paused_value
	paused_value_changed.emit(paused_value)
	_time_since_last_request = 0

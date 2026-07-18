extends BoolSequencer
class_name ToggleSequencer
# ToggleSequencer
# A node that toggles a bool value at a set interval

@export var starting_value: bool
@export_range(0.0, Tools.EXPORT_RANGE_FLOAT_MAX) var time_between_toggles: float
@export var auto_start: bool = false

var current_value: bool
var timer: Timer
var has_timer_started = false

func enable():
	super.enable()
	timer.paused = false
	

func disable():
	super.disable()
	timer.paused = true


func _ready():
	current_value = starting_value
	
	timer = Timer.new()
	timer.timeout.connect(_on_timeout)
	add_child(timer)
	timer.wait_time = time_between_toggles
	timer.one_shot = false
	if auto_start:
		timer.start()
	

func _on_timeout():
	new_value.emit(current_value)
	current_value = not current_value
	
	
func start() -> void:
	if has_timer_started:
		return 
		
	timer.start()
	has_timer_started = true
	
	
func start_with(first_value: bool) -> void:
	current_value = first_value
	start()
	new_value.emit(current_value)
	
	
func stop() -> void:
	if not has_timer_started:
		return 
		
	timer.stop()
	has_timer_started = false
	
	
func stop_with(last_value: bool) -> void:
	current_value = last_value
	new_value.emit(current_value)
	stop()
	
	
func is_running() -> bool:
	return has_timer_started and enabled

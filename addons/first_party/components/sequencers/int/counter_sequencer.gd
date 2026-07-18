extends IntSequencer
class_name CounterSequencer
# CounterSequencer
# An IntSequencer that emits all the numbers in a sequence
# at regular timed intervals

@export_range(0, Tools.EXPORT_RANGE_INT_MAX) var count_to_value: int
@export_range(0, Tools.EXPORT_RANGE_FLOAT_MAX) var time_between_increments: float
@export var zero_index: bool = true
@export var max_value_inclusive: bool = true
@export var emit_remaining_element_count: bool = false
@export var current_value: int = 0

var timer: Timer

func enable():
	super.enable()
	timer.paused = false
	

func disable():
	super.disable()
	timer.paused = true


func _ready():
	current_value = 0 if zero_index else 1
	
	# TODO: add utility or base class for 
	# simple timer behavior we want in a class
	# ex. Utility.AddTimer(arg1, arg2, self, ...)
	timer = Timer.new()
	timer.timeout.connect(_on_timeout)
	add_child(timer)
	timer.wait_time = time_between_increments
	timer.one_shot = false
	timer.start()
	
	
func get_max_value() -> int:
	return count_to_value if max_value_inclusive else count_to_value - 1
	

func _on_timeout():	
	var value_to_emit = current_value
	if emit_remaining_element_count:
		value_to_emit = get_max_value() - current_value
	
	new_value.emit(value_to_emit)
	current_value += 1
	
	
	if current_value > get_max_value():
		_end()
		

func _end():
	timer.stop()
		
		
func _reset():
	current_value = 0 if zero_index else 1
	timer.start()

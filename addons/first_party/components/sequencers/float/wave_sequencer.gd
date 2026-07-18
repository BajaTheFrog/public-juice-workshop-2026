extends FloatSequencer
class_name WaveSequencer
# WaveSequencer
# A FloatSequencer that emits values over time that correspond
# with a wave function as defined by the given parameters

@export_range(0.0, 1.0) var initial_value_position = 0.0
@export var min_value: float = 0.0
@export var max_value: float = 1.0
@export var min_to_max_time: float = 1.0

#TODO: Add to signal or as variables what the current value is from a weight and normalized value
var current_time = 0.0
var calculator = WaveCalculator.new()

func _component_process(delta):
	calculator.initial_value_position = initial_value_position
	calculator.min_value = min_value
	calculator.max_value = max_value
	calculator.min_to_max_time = min_to_max_time
	
	var wave_value = calculator.get_wave_value(current_time)
	new_value.emit(wave_value)
	current_time += delta
	

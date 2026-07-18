extends RefCounted
class_name RangeTranslator

var min_value 
var max_value

func _init(min_value: float, max_value: float):
	self.min_value = min_value
	self.max_value = max_value
	
	
# Returns POSITION (0.0-1.0) of position along range
# ex. (400 - 500).range_position_from_value(410) -> 0.10
func range_position_from_value(value: float, should_clamp: bool = true) -> float:
	if should_clamp:
		value = clamp(value, min_value, max_value)		
	var current_spot_in_range = value - min_value
	return current_spot_in_range / get_full_value_range()
	

# Returns PERCENT (0.0-1.0) representing what % portion 
# the value represents of the whole range
# ex. (400 - 500).percent_from_range_portion(30) -> 0.30
func percent_from_range_portion(value: float, should_clamp: bool = true) -> float:
	if should_clamp:
		value = clamp(value, 0, get_full_value_range())
	return value / get_full_value_range()


# Returns VALUE representing the number along the range at the 
# given position from 0.0 to 1.0
# ex. (400 - 500).value_from_range_position(0.8) -> 480
func value_from_range_position(percent_position: float, should_clamp: bool = true) -> float:
	if should_clamp:
		percent_position = clamp(percent_position, 0.0, 1.0)
	var current_spot_in_range = percent_position * get_full_value_range()
	return current_spot_in_range + min_value 
	
	
# Returns RANGE PORTION representing the coverage or portion of the range
# represented by the given percent
# ex. (400 - 500).range_portion_from_percent(0.6) -> 60
func range_portion_from_percent(percent: float, should_clamp: bool = true) -> float:
	if should_clamp:
		percent = clamp(percent, 0.0, 1.0)
	return percent * get_full_value_range()
	

func get_full_value_range() -> float:
	return max_value - min_value

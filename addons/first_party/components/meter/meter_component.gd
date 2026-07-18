extends Component
class_name MeterComponent

signal changed(info: Meter.MeterChangeInfo)

@export_range(0.0, Tools.EXPORT_RANGE_FLOAT_MAX) var min_value: float = 0:
	get:
		return _meter.min_value 
	set(value): 
		_meter.min_value = min_value
		
@export_range(0.0, Tools.EXPORT_RANGE_FLOAT_MAX) var max_value: float = 1: 
	get:
		return _meter.max_value
	set(value):
		_meter.max_value = max_value
		
@export var current_value: float = 1.0:
	get:
		return _meter.current_value
	set(value):
		_meter.set_value(value)
		
@export_range(0.0, 1.0) var current_percent: float = 1.0:
	get:
		return _range_translator.range_position_from_value(_meter.current_value)
	set(value):
		var translated_value = _range_translator.value_from_range_position(value)
		_meter.set_value(translated_value)
		
# SOURCE OF TRUTH!
var _meter: Meter = Meter.new()
var _range_translator: RangeTranslator = null

func _ready():
	_range_translator = RangeTranslator.new(min_value, max_value)
	_meter.min_value = min_value
	_meter.max_value = max_value
	_meter.current_value = current_value
	_meter.changed.connect(_on_meter_changed)
	
	
func set_meter(p_meter: Meter) -> void:
	_meter.changed.disconnect(_on_meter_changed)
	_meter = p_meter
	min_value = _meter.min_value
	max_value = _meter.max_value
	current_value = _meter.current_value
	current_percent = _meter.current_percent
	_meter.changed.connect(_on_meter_changed)
	

func _on_meter_changed(change_info: Meter.MeterChangeInfo) -> void:
	changed.emit(change_info)


func is_full() -> bool:
	return _meter.is_full()
	

func is_empty() -> bool:
	return _meter.is_empty()


func change_value_by(amount: float):
	if enabled:
		_meter.change_value_by(amount)
	
	
func change_value_by_percent(percent: float):
	if enabled:
		_meter.change_value_by_percent(percent)
	

func set_value(new_value: float):
	if enabled:
		_meter.set_value(new_value)
	

func set_value_to_percent(percent: float):
	if enabled:
		_meter.set_value_by_percent(percent)
	

extends Component
class_name Flasher

@export var target: CanvasItem
@export var flash_color: Color
@export var flash_material: Material
@export var starting_value: bool
@export_range(0, Tools.EXPORT_RANGE_FLOAT_MAX) var time_between_toggles: float
@export var auto_start: bool = false

var current_value
var timer
var has_timer_started

var _original_color: Color
var _original_material: Material

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
		start()
		
	if not target:
		return
		
	_original_color = target.modulate
	

func _on_timeout():
	current_value = not current_value
	
	if not target:
		return
	
	if current_value:
		_flash_on(target)
	else:
		_flash_off(target)
			
			
func _flash_on(canvas_item: CanvasItem) -> void:
	canvas_item.modulate = flash_color
	if flash_material:
		canvas_item.material = flash_material
	

func _flash_off(canvas_item: CanvasItem) -> void:
	canvas_item.modulate = _original_color
	if flash_material:
		canvas_item.material = _original_material
	
	
func start() -> void:
	if has_timer_started:
		return 
		
	timer.start()
	has_timer_started = true
	
	
func start_with(first_value: bool) -> void:
	current_value = first_value
	start()
	
	
func stop() -> void:
	if not has_timer_started:
		return 
		
	timer.stop()
	has_timer_started = false
	
	
func stop_with(last_value: bool) -> void:
	current_value = last_value
	stop()
	
	
func is_running() -> bool:
	return has_timer_started and enabled

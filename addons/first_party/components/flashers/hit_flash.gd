extends Component
class_name HitFlasher

@export var target: CanvasItem
@export var flash_color: Color
@export_range(0, Tools.EXPORT_RANGE_FLOAT_MAX) var flash_duration: float
@export var auto_start: bool

@onready var flash_material = preload("res://addons/third_party/shaders/single_color_shader_material.tres")

var timer: Timer
var has_timer_started = false

func enable():
	super.enable()
	timer.paused = false
	

func disable():
	super.disable()
	timer.paused = true


func _ready():
	timer = Timer.new()
	timer.timeout.connect(_on_timeout)
	add_child(timer)
	timer.wait_time = flash_duration
	timer.one_shot = true
	
	if not target:
		return
		
	if auto_start:
		flash()
	

func _on_timeout():
	if not target:
		return
		
	target.material = null
	has_timer_started = false
			
			
func flash() -> void:
	if has_timer_started:
		return 
		
	timer.start()
	has_timer_started = true
	
	if not target:
		return
		
	target.material = flash_material
	target.material.set_shader_param("color", flash_color)
	
	
func is_in_flash() -> bool:
	return has_timer_started and enabled

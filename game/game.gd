extends Node
# Game
# This is the AUTOLOAD anchor for all the major game systems. 

@export var info: Info
@export var events: Events
@export var groups: Groups
@export var messages: Messages
@export var steps: Steps
@export var content: Content
@export var change: Change
@export var services: Services

# Currently prevents being able to reload with get_tree().reload_current_scene()
@export var use_content_root = true

var has_been_initialized = false

func _ready() -> void:
	await get_tree().root.ready
	
	if use_content_root:
		_move_current_scene_to_content_root()
		
	initialize_services()
	has_been_initialized = true
	Game.events.application.game_is_ready.emit()
	

func _move_current_scene_to_content_root() -> void:
	change.move_current_scene_to_content_root()


## SERVICES

func initialize_services():
	services.on_game_initialize()
	services.pause.paused_value_changed.connect(_on_paused_value_changed)
	services.theme.game_theme_changed.connect(_on_game_theme_changed)
	
	
func _process(delta):
	if not has_been_initialized:
		return
	
	services.on_game_process(delta)
	
	if Input.is_action_just_pressed("reset_scene"):
		reload_current_scene()
		
		
func _physics_process(delta):
	if not has_been_initialized:
		return
	
	services.on_game_physics_process(delta)
	
	
func reload_current_scene() -> void:
	get_tree().reload_current_scene()
	
	
## SIGNALS AND CALLBACKS

func _on_paused_value_changed(new_value: bool) -> void:
	Game.events.application.pause_changed.emit(new_value)
	
	
func _on_game_theme_changed(new_theme: GameTheme) -> void:
	Game.events.game_theme.theme_changed.emit(new_theme)
	

## PAUSING AND RUNTIME

func async_stop(duration: float) -> Signal:
	return services.time.set_temporary_scale(0.0, duration)


func resume_normal_time_scale() -> void:
	services.time.resume_normal_time_scale()
	
	
func is_paused() -> bool:
	return services.pause.is_paused()
	
	
func toggle_pause() -> void:
	services.pause.toggle_pause()
	

func pause_on() -> void:
	services.pause.pause_on()
	
	
func pause_off() -> void:
	services.pause.pause_off()

extends Node
class_name Services

@export var theme: ThemeService
@export var sound: SoundService
@export var pause: PauseService
@export var time: TimeService
@export var screen: ScreenService
@export var camera: CameraService
@export var world: WorldService
@export var entity: EntityService


func on_game_initialize():
	var service_children = get_children()
	for child in service_children:
		var service = child as GameService
		if not service or not service.is_running:
			continue
			
		service.on_game_initialize()
	
	
func on_game_process(delta):
	var service_children = get_children()
	for child in service_children:
		var service = child as GameService
		if not service or not service.is_running:
			continue
			
		service.on_game_process(delta)
		
		
func on_game_physics_process(delta):
	var service_children = get_children()
	for child in service_children:
		var service = child as GameService
		if not service or not service.is_running:
			continue
			
		service.on_game_physics_process(delta)

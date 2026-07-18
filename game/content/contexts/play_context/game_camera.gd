extends Camera2D
class_name GameCamera

@export var standard_zoom = Vector2.ONE
@export var enhanced_zoom = Vector2.ONE
## The level's juice box owns the camera kinetics (see LevelJuiceBox.Kinetics).
@export var juice_box: LevelJuiceBox

func _ready() -> void:
	Game.services.camera.set_active_camera(self)
	self.make_current()


func _process(_delta: float) -> void:
	if not enabled:
		return

	juice_box.kinetics.track_camera(self)

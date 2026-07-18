extends Component
class_name LevelJuiceBox

@export var flash_rect: ColorRect

var kinetics: Kinetics
var feedback: Feedback

func _ready() -> void:
	kinetics = Kinetics.new(self)
	feedback = Feedback.new(self)


class Kinetics:
	var _box: LevelJuiceBox

	func _init(box: LevelJuiceBox) -> void:
		_box = box


	func track_camera(camera: GameCamera) -> void:
		var camera_center: Vector2 = Game.services.screen.get_screen_center()
		camera.global_position = camera_center

		if not Steps.check(_box, Steps.CAMERA_TRACKING):
			if camera.zoom != camera.standard_zoom:
				camera.zoom = camera.standard_zoom
			return

		# [STEP-3.1.1]: Track the player's position with the camera
		pass


class Feedback:
	var _box: LevelJuiceBox

	func _init(box: LevelJuiceBox) -> void:
		_box = box


	func async_on_player_died() -> void:
		if not Steps.check(_box, Steps.SCREEN_FLASH):
			return

		# [STEP-3.2.3]: Full-screen flash to drive impact of death
		pass

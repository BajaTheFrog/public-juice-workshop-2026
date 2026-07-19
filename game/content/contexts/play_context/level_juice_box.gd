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

		# [STEP-3.1.A]: Track the player's position with the camera
		_track_player_with_camera(camera, camera_center)


	# Pre-written for you. Eases the camera toward the player and zooms in a little.
	# Exercise 3.1.A is just about calling it - but read it if you're curious.
	func _track_player_with_camera(camera: GameCamera, camera_center: Vector2) -> void:
		if camera.zoom == camera.standard_zoom:
			camera.zoom = camera.enhanced_zoom

		var player_pos: Vector2 = Game.services.entity.get_player_location()
		if player_pos == Vector2.INF:
			return

		var arena_ratio := player_pos / 1920.0
		var translated_position := arena_ratio * Vector2(1920.0, 1080.0)
		player_pos = translated_position

		var scaled_delta := (player_pos - camera_center) * 0.1
		camera.global_position = camera_center + scaled_delta


class Feedback:
	var _box: LevelJuiceBox

	func _init(box: LevelJuiceBox) -> void:
		_box = box


	func async_on_player_died() -> void:
		if not Steps.check(_box, Steps.SCREEN_FLASH):
			return

		# [STEP-3.2.C]: Full-screen flash to drive impact of death
		var flash_time: float = 0.1
		var flash_alpha: float = 1.0

		var tween = _box.flash_rect.create_tween()
		tween.set_ignore_time_scale()
		tween.tween_property(_box.flash_rect, "color:a", flash_alpha, flash_time)
		await tween.finished
		_box.flash_rect.color.a = 0.0

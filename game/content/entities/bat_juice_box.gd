extends Component
class_name BatJuiceBox

@export var hit_flash_sprites: Array[Sprite2D]

@export_group("Sounds")
@export var hit_sound: AudioStream

var kinetics: Kinetics
var feedback: Feedback

func _ready() -> void:
	kinetics = Kinetics.new(self)
	feedback = Feedback.new(self)


class Kinetics:
	var _box: BatJuiceBox

	func _init(box: BatJuiceBox) -> void:
		_box = box


	func async_hitstop() -> void:
		if not Steps.check(_box, Steps.BAT_HITSTOP):
			return

		# [STEP-2.1.2]: Briefly freeze the whole world to emphasize hit contact
		pass


class Feedback:
	var _box: BatJuiceBox

	func _init(box: BatJuiceBox) -> void:
		_box = box


	func async_on_hit() -> void:
		Game.services.sound.play_sfx(_box.hit_sound)

		if not Steps.check(_box, Steps.BAT_HIT_FLASH):
			return

		# [STEP-2.2.3]: Flash the entire bat to emphasize hit contact
		pass


	func async_on_died() -> void:
		pass

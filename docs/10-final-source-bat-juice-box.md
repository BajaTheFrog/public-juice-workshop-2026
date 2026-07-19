# Final Source — `bat_juice_box.gd`

The complete `bat_juice_box.gd` file after **every** bat exercise is done.


```gdscript
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

		# [STEP-2.1.B]: Briefly freeze the whole world to emphasize hit contact
		var hitstop_time: float = 0.05
		await Game.async_stop(hitstop_time)


class Feedback:
	var _box: BatJuiceBox

	func _init(box: BatJuiceBox) -> void:
		_box = box


	func async_on_hit() -> void:
		Game.services.sound.play_sfx(_box.hit_sound)

		if not Steps.check(_box, Steps.BAT_HIT_FLASH):
			return

		# [STEP-2.2.C]: Flash the entire bat to emphasize hit contact
		var hit_flash_time: float = 0.02
		await _async_flash(_box, _box.hit_flash_sprites, hit_flash_time)


	func async_on_died() -> void:
		pass


	# Pre-written for you. Shows a set of sprites, waits, then hides them again.
	# Exercise 2.2.C is just about calling it - but read it if you're curious.
	func _async_flash(node: Node, sprites: Array[Sprite2D], duration: float) -> void:
		for sprite in sprites:
			sprite.visible = true

		await Wait.on(node, duration).timeout

		for sprite in sprites:
			sprite.visible = false
```

## 🍎 🍉 🍊 🍋 🍍 🥝 🫐 🍇

### [← Final Source — `player_juice_box.gd`](09-final-source-player-juice-box.md) | [Table of Contents](00-contents.md) | [Final Source — `player_bullet_juice_box.gd` →](11-final-source-player-bullet-juice-box.md)

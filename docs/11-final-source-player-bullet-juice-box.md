# Final Source — `player_bullet_juice_box.gd`

The complete `player_bullet_juice_box.gd` file after **every** bullet exercise is done.


```gdscript
extends Component
class_name PlayerBulletJuiceBox

@export var body: Node2D
@export var muzzle_sprite: Sprite2D

@export_group("Sounds")
@export var shoot_sound: AudioStream

var feedback: Feedback

func _ready() -> void:
	feedback = Feedback.new(self)


class Feedback:
	var _box: PlayerBulletJuiceBox

	func _init(box: PlayerBulletJuiceBox) -> void:
		_box = box


	func async_on_fired() -> void:
		Game.services.sound.play_sfx(_box.shoot_sound, 0.3)
		_apply_bigger_bullet()
		await _async_muzzle_flash()


	func _apply_bigger_bullet() -> void:
		if not Steps.check(_box, Steps.BIGGER_BULLETS):
			return

		# [STEP-2.2.A]: Increase the size of the bullet (seed) so its more prominent
		_box.body.scale *= 2.0


	func _async_muzzle_flash() -> void:
		if not Steps.check(_box, Steps.MUZZLE_FLASH):
			return

		# [STEP-2.2.B]: Add muzzle flash to communicate bullet (seed) exit
		var muzzle_flash_time: float = 0.05
		var random_x_scale = Random.randf_range(0.7, 1.2)
		var random_y_scale = Random.randf_range(0.5, 1.1)

		_box.muzzle_sprite.scale = Vector2(random_x_scale, random_y_scale)

		await _async_flash(_box, _box.muzzle_sprite, muzzle_flash_time)


	func async_on_impact() -> void:
		pass


	func _async_flash(node: Node, sprite: Sprite2D, duration: float) -> void:
		sprite.visible = true
		await Wait.on(node, duration).timeout
		sprite.visible = false
```

## 🍎 🍉 🍊 🍋 🍍 🥝 🫐 🍇

### [← Final Source — `bat_juice_box.gd`](10-final-source-bat-juice-box.md) | [Table of Contents](00-contents.md) | [Final Source — `level_juice_box.gd` →](12-final-source-level-juice-box.md)

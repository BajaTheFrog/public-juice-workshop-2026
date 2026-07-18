# Final Source — `player_juice_box.gd`

The complete `player_juice_box.gd` file after **every** player step is done.

```gdscript
extends Component
class_name PlayerJuiceBox

@export var player: Player
@export var body_sprite: Sprite2D

@export_group("Sounds")
@export var jump_sound: AudioStream
@export var land_sound: AudioStream
@export var hurt_sound: AudioStream
@export var death_sound: AudioStream
@export var reload_sound: AudioStream


var kinetics: Kinetics
var feedback: Feedback

func _ready() -> void:
	kinetics = Kinetics.new(self)
	feedback = Feedback.new(self)
	feedback.setup()


class Kinetics:
	var _box: PlayerJuiceBox
	var _player: Player

	func _init(box: PlayerJuiceBox) -> void:
		_box = box
		_player = box.player


	func get_acceleration(is_in_air: bool) -> float:
		var value := _player.speed

		if Steps.check(_box, Steps.ACCELERATION):
			# [STEP-1.1.1]: Ease into top speed so the ball carries weight
			value = _player.acceleration

		if Steps.check(_box, Steps.AIR_DAMPENING) and is_in_air:
			# [STEP-1.1.3]: Give up some control in the air
			value *= _player.air_dampening_mult

		return value


	func get_gravity_scale(velocity_y: float) -> float:
		if not Steps.check(_box, Steps.JUMP_GRAVITY):
			return 1.0

		# [STEP-1.1.2]: Fall faster than we rise
		return _player.fall_gravity_mult if velocity_y > 0 else 1.0


	func get_shoot_angle(base_degrees: float) -> float:
		if not Steps.check(_box, Steps.SHOOT_SPREAD):
			return base_degrees

		# [STEP-2.1.4]: Randomize the exit trajectory a bit
		return base_degrees + Random.randf_range(-_player.shoot_vector_bump, _player.shoot_vector_bump)


	func apply_knockback(gun: Launcher2D) -> void:
		if not Steps.check(_box, Steps.SHOOT_KNOCKBACK):
			return

		# [STEP-2.1.3]: Every shot shoves us off it
		_player.apply_knockback(gun.global_position, _player.knockback_amount)


	func async_hitstun() -> void:
		if not Steps.check(_box, Steps.DEATH_HITSTUN):
			return

		# [STEP-2.1.1]: Stun the body to drive home what happened to the player
		var hitstun_time: float = 0.75
		await Game.async_stop(hitstun_time)


	func on_danger_changed(closeness: float) -> void:
		if not Steps.check(_box, Steps.DANGER_SLOWMO) or closeness <= 0.0:
			Game.services.time.clear_sustained_time(Game.messages.time.danger_zone)
			return

		# [STEP-3.1.2]: As the immediate danger to the player increases, we can slow time
		Game.services.time.set_sustained_time(Game.messages.time.danger_zone, _player, lerpf(1.0, 0.2, closeness))


class Feedback:
	var _box: PlayerJuiceBox
	var _body_sprite: Sprite2D
	var body_true_scale := Vector2.ONE

	var _body_tween: Tween

	func _init(box: PlayerJuiceBox) -> void:
		_box = box
		_body_sprite = box.body_sprite


	func setup() -> void:
		body_true_scale = _body_sprite.scale


	func on_landed() -> void:
		Game.services.sound.play_sfx(_box.land_sound)

		if not Steps.check(_box, Steps.LAND_SQUASH):
			return

		# [STEP-1.2.2]: Squash on landing to communicate impact
		var squash_amount: Vector2 = Vector2(1.2, 0.8)
		var squash_time: float = 0.06
		var recover_time: float = 0.06

		var tween = _restart_body_tween()
		tween.tween_property(_body_sprite, "scale", body_true_scale * squash_amount, squash_time)
		tween.tween_property(_body_sprite, "scale", body_true_scale, recover_time)


	func on_jump_takeoff() -> void:
		Game.services.sound.play_sfx(_box.jump_sound)

		if not Steps.check(_box, Steps.JUMP_SQUASH):
			return

		# [STEP-1.2.1]: "Animate" the jump takeoff with some classic squash and stretch
		var squash_amount: Vector2 = Vector2(1.5, 0.5)
		var stretch_amount: Vector2 = Vector2(0.75, 1.25)
		var squash_time: float = 0.1
		var stretch_time: float = 0.1
		var recover_time: float = 0.2

		var tween = _restart_body_tween()
		tween.tween_property(_body_sprite, "scale", body_true_scale * squash_amount, squash_time)
		tween.tween_property(_body_sprite, "scale", body_true_scale * stretch_amount, stretch_time)
		tween.tween_property(_body_sprite, "scale", body_true_scale, recover_time)


	func on_shot(gun: Launcher2D) -> void:
		if not Steps.check(_box, Steps.SHOOT_SHAKE):
			return

		# [STEP-3.2.1]: Make the "gun" feel more powerful with screenshake
		var shake_amplitude: float = 8.0
		var shake_time: float = 0.25
		Game.services.camera.add_shake(shake_amplitude, shake_time)


	func on_hit() -> void:
		Game.services.sound.play_sfx(_box.hurt_sound)

		if not Steps.check(_box, Steps.DEATH_SHAKE):
			return

		# [STEP-3.2.2]: Shake the camera on death
		var shake_amplitude: float = 80.0
		var shake_time: float = 0.5

		Game.services.camera.add_shake(shake_amplitude, shake_time)


	func async_on_died() -> void:
		Game.services.sound.play_sfx(_box.death_sound)


	func on_reloaded() -> void:
		Game.services.sound.play_sfx(_box.reload_sound)

	## The squash tweens all drive body_sprite.scale, so only one may be live at a time.
	func _restart_body_tween() -> Tween:
		if _body_tween and _body_tween.is_valid():
			_body_tween.kill()

		_body_tween = _body_sprite.create_tween()
		_body_tween.set_parallel(false)
		return _body_tween
```

## 🍎 🍉 🍊 🍋 🍍 🥝 🫐 🍇

### [← Appendix — The Juice Menu](19-appendix-juice-menu.md) | [Table of Contents](00-contents.md) | [Final Source — `bat_juice_box.gd` →](21-final-source-bat-juice-box.md)

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
			# [STEP-1.1.A]: Ease into top speed so the ball carries weight
			value = _player.acceleration

		if Steps.check(_box, Steps.AIR_DAMPENING) and is_in_air:
			# [STEP-1.1.C]: Give up some control in the air
			value *= _player.air_dampening_mult

		return value


	func get_gravity_scale(velocity_y: float) -> float:
		if not Steps.check(_box, Steps.JUMP_GRAVITY):
			return 1.0

		# [STEP-1.1.B]: Fall faster than we rise
		return _player.fall_gravity_mult if velocity_y > 0 else 1.0


	func get_shoot_angle(base_degrees: float) -> float:
		if not Steps.check(_box, Steps.SHOOT_SPREAD):
			return base_degrees

		# [STEP-2.1.D]: Randomize the exit trajectory a bit
		return base_degrees


	func apply_knockback(gun: Launcher2D) -> void:
		if not Steps.check(_box, Steps.SHOOT_KNOCKBACK):
			return

		# [STEP-2.1.C]: Every shot shoves us off it
		pass


	func async_hitstun() -> void:
		if not Steps.check(_box, Steps.DEATH_HITSTUN):
			return

		# [STEP-2.1.A]: Stun the body to drive home what happened to the player
		pass


	func on_danger_changed(closeness: float) -> void:
		if not Steps.check(_box, Steps.DANGER_SLOWMO) or closeness <= 0.0:
			Game.services.time.clear_sustained_time(Game.messages.time.danger_zone)
			return

		# [STEP-3.1.B]: As the immediate danger to the player increases, we can slow time
		pass


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

		# [STEP-1.2.B]: Squash on landing to communicate impact
		pass


	func on_jump_takeoff() -> void:
		Game.services.sound.play_sfx(_box.jump_sound)

		if not Steps.check(_box, Steps.JUMP_SQUASH):
			return

		# [STEP-1.2.A]: "Animate" the jump takeoff with some classic squash and stretch
		pass


	func on_shot(gun: Launcher2D) -> void:
		if not Steps.check(_box, Steps.SHOOT_SHAKE):
			return

		# [STEP-3.2.A]: Make the "gun" feel more powerful with screenshake
		pass


	func on_hit() -> void:
		Game.services.sound.play_sfx(_box.hurt_sound)

		if not Steps.check(_box, Steps.DEATH_SHAKE):
			return

		# [STEP-3.2.B]: Shake the camera on death
		pass


	func async_on_died() -> void:
		Game.services.sound.play_sfx(_box.death_sound)


	func on_reloaded() -> void:
		Game.services.sound.play_sfx(_box.reload_sound)


	func _restart_body_tween() -> Tween:
		if _body_tween and _body_tween.is_valid():
			_body_tween.kill()

		_body_tween = _body_sprite.create_tween()
		_body_tween.set_parallel(false)
		return _body_tween

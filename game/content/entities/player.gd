extends CharacterBody2D
class_name Player

@export_group("Movement")
@export var speed: float = 1200.0
## How high the jump peaks, in pixels.
@export var jump_height: float = 510.0
## How long the rise takes. Lower is snappier and cuts float at the apex.
@export_range(0.05, 2.0, 0.01) var time_to_apex: float = 0.5
## [STEP-1.1.1]: How fast we reach top speed. Lower carries more weight.
@export var acceleration: float = 40.0
## [STEP-1.1.2]: How much faster we fall than we rise.
@export var fall_gravity_mult: float = 1.7
## [STEP-1.1.3]: How much horizontal control we give up while airborne.
@export var air_dampening_mult: float = 0.7
## How much of our speed we keep when we rebound off a wall.
@export_range(0.0, 1.0, 0.05) var wall_bounce_mult: float = 0.45
## Creep into a wall slower than this and we just stop, so resting
## against one stays quiet.
@export var wall_bounce_min_speed: float = 250.0

var _is_in_air = true # we start floating
var _last_ground_direction = 0.0
var _has_landed_since_jump = false
var _jump_just_pressed = false
var _jump_just_released = false
var _movement_direction = 0.0

var _is_hurdling = false
var _hurdled_objects: Array = []

@export_group("Animation")
@export var air_rotation_per_frame = 7
@export var body_radius: float = 150

@export_group("Shooting")
@export var reload_amount = 10
@export var ammo_max = 10
@export var knockback_amount: float = 400.0
@export var knockback_decay: float = 10.0
## [STEP-2.1.4]: Degrees of spread on each shot.
@export var shoot_vector_bump: float = 5.0

var _is_shooting = false
var _knockback_velocity: Vector2 = Vector2.ZERO

@export_group("Danger")
@export var danger_falloff_distance: float = 500.0

var _dangerous_bats: Array[Node2D] = []

@export_group("Nodes")
@export var juice_box: PlayerJuiceBox
@export var hurt_area: Area2D
@export var interaction_area: Area2D
@export var hurdle_cast: RayCast2D
@export var danger_area: Area2D
@export var hand: Node2D
@export var gun: Launcher2D
@export var body_sprite: Sprite2D

var _health = 1

func _ready() -> void:
	self.add_to_group(Game.groups.roots.player)
	hurt_area.add_to_group(Game.groups.hurt_area.player)
	interaction_area.add_to_group(Game.groups.interaction_area.player)

	gun.max_projectiles = ammo_max
	gun.restock_projectiles(ammo_max)

	_late_ready.call_deferred()


func _late_ready() -> void:
	Game.events.player.ammo_changed.emit(0, gun.remaining_projectiles)


func _process(_delta: float) -> void:
	_aim_hand()
	juice_box.kinetics.on_danger_changed(_get_danger_closeness())


func _aim_hand() -> void:
	hand.look_at(get_global_mouse_position())


func _read_input() -> void:
	_jump_just_pressed = Input.is_action_just_pressed("jump")
	_jump_just_released = Input.is_action_just_released("jump")
	_movement_direction = Input.get_axis("left", "right")
	_is_shooting = Input.is_action_pressed("shoot_hand")


func _physics_process(delta: float):
	_read_input()
	_knockback_velocity = _knockback_velocity.move_toward(Vector2.ZERO, knockback_decay * speed * delta)
	var _was_in_air = _is_in_air
	_is_in_air = not is_on_floor()
	
	var landed = false
	if _was_in_air and not _is_in_air:
		landed = true

	if _is_in_knockback():
		_movement_direction = 0.0

	if _is_in_air:
		_handle_in_air(delta)
	elif _jump_just_pressed:
		_handle_jump()
	elif not _has_landed_since_jump and landed:
		_handle_landing()

	_handle_movement()
	_handle_shooting()

	velocity += _knockback_velocity

	# move_and_slide flattens velocity into whatever we hit, so the bounce has to be
	# handed the speed we were carrying on the way in.
	var impact_velocity = velocity
	move_and_slide()
	_handle_wall_bounce(impact_velocity)

	# After moving we can "animate" our roll
	_rotate_from_movement(delta)


func _handle_wall_bounce(impact_velocity: Vector2) -> void:
	if not is_on_wall():
		return

	var impact_speed := absf(impact_velocity.x)
	if impact_speed < wall_bounce_min_speed:
		return

	velocity.x = get_wall_normal().x * impact_speed * wall_bounce_mult


func _is_in_knockback() -> bool:
	return _knockback_velocity.length() > 50.0


func _rotate_from_movement(delta: float) -> void:
	if _health <= 0:
		return
	
	if velocity.length() > 0.0:
		var distance_traveled = velocity.length() * delta
		var radians_to_rotate = distance_traveled / body_radius

		if _is_in_air:
			# while in air, rotate continuously
			var radians = deg_to_rad(air_rotation_per_frame)
			radians *= 1.0 if _last_ground_direction >= 0 else -1.0
			body_sprite.rotation += radians
		else:
			# Rotate based on horizontal movement direction
			if velocity.x > 0:
				body_sprite.rotation += radians_to_rotate
			else:
				body_sprite.rotation -= radians_to_rotate


func _handle_in_air(delta: float) -> void:
	velocity.y += _get_gravity() * delta

	if velocity.y < 0 and _jump_just_released:
		velocity.y = velocity.y / 2

	_check_hurdles()


func _check_hurdles() -> void:
	hurdle_cast.force_raycast_update()
	if _is_hurdling or _hurdled_objects.size() == 1:
		return

	while hurdle_cast.is_colliding() and not _is_hurdling:
		_is_hurdling = true
		var collider = hurdle_cast.get_collider()
		_hurdled_objects.append(collider)
		hurdle_cast.add_exception(collider)
		hurdle_cast.force_raycast_update()

	for hurdled_object in _hurdled_objects:
		_hurdled_object()


func _hurdled_object() -> void:
	_add_ammo()


func _clean_raycast() -> void:
	# Clean up exceptions so the raycast functions normally next frame
	for obj in _hurdled_objects:
		if not is_instance_valid(obj):
			break
		hurdle_cast.remove_exception(obj)

	_hurdled_objects = []


func _handle_jump() -> void:
	velocity.y = _get_jump_velocity()
	_has_landed_since_jump = false
	juice_box.feedback.on_jump_takeoff()


func _handle_landing() -> void:
	_has_landed_since_jump = true
	_is_hurdling = false
	_clean_raycast()
	juice_box.feedback.on_landed()


func _handle_movement() -> void:
	velocity.x = move_toward(velocity.x, _movement_direction * speed, juice_box.kinetics.get_acceleration(_is_in_air))

	if not _is_in_air:
		_last_ground_direction = velocity.x


func _handle_shooting() -> void:
	_shoot_hand(Vector2.RIGHT, true)


func _shoot_hand(vector: Vector2, track_ammo: bool) -> void:
	if not _is_shooting:
		return

	var direction_data = gun.launch_direction_data as LauncherDirectionStatsFixed
	if direction_data:
		# Overwrite, we're just always going to shoot from hand
		var angle_degrees = juice_box.kinetics.get_shoot_angle(hand.global_rotation_degrees)
		direction_data.vector = vector.rotated(deg_to_rad(angle_degrees))

	var old_ammo = gun.remaining_projectiles
	var fired = gun.fire()
	if not fired:
		return

	juice_box.feedback.on_shot(gun)
	juice_box.kinetics.apply_knockback(gun)

	if track_ammo:
		Game.events.player.ammo_changed.emit(old_ammo, gun.remaining_projectiles)


func _add_ammo() -> void:
	# We just need to track 1 gun's ammo
	_reload_gun(true)
	# Hurdling a bat is what reloads us, so voice the reload here.
	juice_box.feedback.on_reloaded()


func _reload_gun(track_ammo: bool) -> void:
	var old_ammo = gun.remaining_projectiles
	gun.restock_projectiles(reload_amount)
	if track_ammo:
		var new_ammo = gun.remaining_projectiles
		Game.events.player.ammo_changed.emit(old_ammo, new_ammo)


func apply_knockback(source_position: Vector2, amount: float) -> void:
	var direction = source_position.direction_to(global_position)
	_knockback_velocity = direction * amount


func _get_danger_closeness() -> float:
	if _dangerous_bats.is_empty():
		return 0.0

	var closest_distance = INF
	for bat in _dangerous_bats:
		closest_distance = minf(closest_distance, global_position.distance_to(bat.global_position))

	return 1.0 - clampf(closest_distance / danger_falloff_distance, 0.0, 1.0)


func _async_on_hit() -> void:
	# Impact feedback (hurt sound + shake) has to land at the moment of the hit.
	# If it waits behind the 0.75s hitstun freeze it reads as late or missing, and
	# the death flash beats it. on_hit() is synchronous, so it is called, not awaited.
	juice_box.feedback.on_hit()
	await juice_box.kinetics.async_hitstun()


func _async_die() -> void:
	# The slow motion was ours to set, so it is ours to clean up.
	Game.services.time.clear_sustained_time(Game.messages.time.danger_zone)
	await juice_box.feedback.async_on_died()
	queue_free()


func _on_hurt_area_area_entered(area: Area2D) -> void:
	if not area.is_in_group(Game.groups.hit_area.bat):
		return

	var old_health = _health
	_health -= 1
	await _async_on_hit()
	Game.events.player.updated_health.emit(old_health, _health)
	
	# Process a frame so we give the event a chance to land
	await get_tree().process_frame

	if _health <= 0:
		set_deferred("process_mode", PROCESS_MODE_DISABLED)
		await _async_die()


func _on_interaction_area_area_entered(area: Area2D) -> void:
	pass


func _on_danger_area_body_entered(body: Node2D) -> void:
	if body.is_in_group(Game.groups.roots.bat):
		_dangerous_bats.append(body)


func _on_danger_area_body_exited(body: Node2D) -> void:
	if body.is_in_group(Game.groups.roots.bat):
		_dangerous_bats = _dangerous_bats.filter(func(bat): return bat.name != body.name)


func _get_jump_velocity() -> float:
	return -2.0 * jump_height / time_to_apex


func _get_gravity() -> float:
	var rise_gravity = 2.0 * jump_height / (time_to_apex * time_to_apex)
	return rise_gravity * juice_box.kinetics.get_gravity_scale(velocity.y)

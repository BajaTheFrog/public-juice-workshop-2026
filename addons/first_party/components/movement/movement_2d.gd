extends Component
class_name Movement2D

# Movment math inspired by
# https://github.com/ShatReal/Game-Jam-Template-4/blob/master/scenes/players/player_top_down.gd

enum CollisionType { COLLIDE, SLIDE }

signal velocity_changed(velocity)

@export var target: CharacterBody2D
@export var collision_type: CollisionType = CollisionType.COLLIDE
@export_range(0.0, Tools.EXPORT_RANGE_FLOAT_MAX) var gravity: float = 0.0
# TODO: Make a simpler version that has the speed and direction built in
@export var speed_calculator: SpeedCalculator
@export var direction_calculator: DirectionCalculator2D

@onready var velocity = Vector2.ZERO

var assigned_target: CharacterBody2D = null

func reset():
	hard_stop()


func _component_physics_process(delta):
	if not target:
		return

	var top_speed = speed_calculator.top_speed
	var next_direction = direction_calculator.get_current_direction()
	var direction_responsiveness = direction_calculator.direction_change_responsiveness

	if speed_calculator.has_acceleration:
		if next_direction.length() == 0.0:
			velocity = velocity.move_toward(Vector2.ZERO, speed_calculator.deacceleration * delta)
		else:
			velocity = velocity.move_toward(next_direction * top_speed, speed_calculator.acceleration * delta)
			# Adjust the actual velocity heading based on responsiveness
			# even if length stays the same
			var current_speed = velocity.length()
			var current_heading = velocity.normalized()
			var adjusted_heading = lerp(current_heading, next_direction, direction_responsiveness)
			velocity = adjusted_heading.normalized() * current_speed
		
	else:
		velocity = next_direction * top_speed
	
	velocity.y += gravity * delta
	
	match collision_type:
		CollisionType.COLLIDE:
			var collision_info = target.move_and_collide(velocity * delta)
		CollisionType.SLIDE:
			target.set_velocity(velocity)
			target.set_up_direction(Vector2(0, -1))
			target.move_and_slide()
			velocity = target.velocity
	
	_set_velocity(velocity)


func hard_stop():
	_set_velocity(Vector2.ZERO)


func _set_velocity(vector: Vector2):
	velocity = vector
	velocity_changed.emit(velocity)

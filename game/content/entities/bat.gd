extends CharacterBody2D
class_name Bat

@export var juice_box: BatJuiceBox

@export var speed = 0.0
@export var level_speed_mult = 1.0
@export var direction = Vector2.ZERO

@export var hurt_area: Area2D
@export var hit_area: Area2D
@export var interaction_area: Area2D

@export var level = 1

@export var left_wing_anchor: Node2D
@export var right_wing_anchor: Node2D
@export var wing_sequencer: WaveSequencer

var starting_level = 1
var was_on_screen = false
var through_first_zone = false

func _ready() -> void:
	self.add_to_group(Game.groups.roots.bat)
	hurt_area.add_to_group(Game.groups.hurt_area.bat)
	hit_area.add_to_group(Game.groups.hit_area.bat)
	interaction_area.add_to_group(Game.groups.interaction_area.bat)
	# speed up wing flapping with level
	wing_sequencer.min_to_max_time /= float(level)
	starting_level = level


func set_speed_and_direction(p_speed: float, p_direction: Vector2) -> void:
	speed = p_speed * level_speed_mult
	direction = p_direction
	

func _physics_process(delta: float) -> void:
	velocity = speed * direction
	move_and_slide()


func _on_hurt_area_area_entered(area: Area2D) -> void:
	if not area.is_in_group(Game.groups.hit_area.player_bullet):
		return

	# Using level _also_ as a health proxy
	level -= 1
	
	await _async_on_hit()

	if level <= 0:
		await _async_die()


func _async_die() -> void:
	await juice_box.feedback.async_on_died()
	queue_free()


func _async_on_hit() -> void:
	await juice_box.kinetics.async_hitstop()
	await juice_box.feedback.async_on_hit()


func _on_hit_area_area_entered(area: Area2D) -> void:
	pass


func _on_visibility_changed() -> void:
	if not was_on_screen:
		was_on_screen = is_visible_in_tree()


func _on_wing_sequencer_new_value(value: Variant) -> void:
	left_wing_anchor.rotation_degrees = value
	right_wing_anchor.rotation_degrees = value * -1

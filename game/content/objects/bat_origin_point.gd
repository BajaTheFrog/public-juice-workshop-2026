extends Node2D
class_name BatSpawn

@export var level_1_bat_scene: PackedScene
@export var level_2_bat_scene: PackedScene
@export var level_3_bat_scene: PackedScene

@export var speed = 500.0
@export var direction = Vector2.ZERO
@export var spawner: Spawner2D

var last_spawn_level = 1

func _ready() -> void:
	pass
	

func spawn_bat_at_level(level: int) -> void:
	if level == 1:
		spawner.scene_to_spawn = level_1_bat_scene
	elif level == 2:
		spawner.scene_to_spawn = level_2_bat_scene
	elif level == 3:
		spawner.scene_to_spawn = level_3_bat_scene
	else:
		spawner.scene_to_spawn = level_1_bat_scene
		
	last_spawn_level = level
	_spawn_bat()
	
	speed *= 1.01
	

func _spawn_bat() -> void:
	spawner.spawn_position.y = Random.randf_range(-10.0, 10.0)
	spawner.spawn()


func _on_spawner_node_spawned(spawned_node: Variant) -> void:
	var bat = spawned_node as Bat
	if not bat:
		return
	
	var randomized_speed = speed + Random.randf_range(-20.0, 20.0)
	bat.level = last_spawn_level
	bat.set_speed_and_direction(randomized_speed, direction)

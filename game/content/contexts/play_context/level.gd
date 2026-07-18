extends Node2D
class_name Level

@export var timer: Timer
@export var spawn_points: Array[BatSpawn]
@export var score_label: Label

@export var juice_box: LevelJuiceBox

var track_time = true
var time_score = 0.0
var bat_score = 0.0
var queued_levels = [1, 1, 1]
var elapsed_time = 0.0

func _ready() -> void:
	Game.events.gameplay.bat_crossed_screen.connect(_on_bat_crossed_screen)
	Game.events.gameplay.bat_killed.connect(_on_bat_killed)
	Game.events.player.updated_health.connect(_on_updated_player_health)
	
	
func _process(delta: float) -> void:
	if not track_time:
		return
		
	elapsed_time += delta
	_update_score_with_time(elapsed_time)
	
	
func _get_total_score() -> float:
	return time_score + bat_score


func _on_spawn_timer_timeout() -> void:
	_spawn_bat()
	timer.wait_time *= 0.99
	timer.wait_time = max(timer.wait_time, 0.5)
	

func _spawn_bat() -> void:
	var spawner = _get_available_spawners().pick_random() as BatSpawn
	if not spawner:
		return
	
	var next_level_to_spawn = 1
	if not queued_levels.is_empty():
		next_level_to_spawn = queued_levels.pop_front()
	
	spawner.spawn_bat_at_level(next_level_to_spawn)
	

func _get_available_spawners() -> Array[BatSpawn]:
	var available_spawners: Array[BatSpawn] = spawn_points
	return available_spawners


func _update_score_with_time(time: float) -> void:
	time_score = time
	_set_score_to(_get_total_score())
	

func _update_score_with_bat(level: int) -> void:
	bat_score += float(level)
	_set_score_to(_get_total_score())
	
	
func _set_score_to(value: float) -> void:
	score_label.text = str(int(value))


func _on_bat_crossed_screen(level: int) -> void:
	var level_to_append = 1
	if level == 1:
		level_to_append = 2
	elif level == 2:
		level_to_append = 3
	elif level == 3:
		# rather than bump a bat, we spawn a new one right away
		_spawn_bat()
		
	queued_levels.reverse()
	queued_levels.append(level_to_append)
	queued_levels.reverse()


func _on_bat_killed(level: int) -> void:
	_update_score_with_bat(level)
	
	
func _on_updated_player_health(old: int, new: int) -> void:
	if new <= 0:
		track_time = false
		juice_box.feedback.async_on_player_died()


func _on_bat_zone_area_exited(area: Area2D) -> void:
	pass

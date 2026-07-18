extends Area2D
class_name AdvancedArea2D
# AdvancedArea2D
# A subclass of Area2D with more functionality and convenience functions

signal invincibility_started
signal invincibility_ended
signal area_recieved_message(message, sending_object)

@export var key_owner: Node

var collision_shape: CollisionShape2D = null
var invincibility_timer: Timer = null
var invincible = false: 
	set(value):
		set_invincible(value)


static func get_owner_from(area: Area2D) -> Node:
	var advanced_area = area as AdvancedArea2D
	if not advanced_area:
		return null
		
	var aa_owner = advanced_area.key_owner
	if not aa_owner:
		return null
		
	return aa_owner


func _ready():
	collision_shape = _get_collision_shape()
	
	var new_timer = Timer.new()
	new_timer.one_shot = true
	add_child(new_timer)
	invincibility_timer = new_timer
	invincibility_timer.timeout.connect(_on_invincibility_timeout)


func set_invincible(value: bool):
	invincible = value
	if invincible:
		_on_invincibility_started()
	else:
		_on_invincibility_ended()
		
		
func start_invincibility(duration: float):
	invincible = true
	invincibility_timer.start(duration)
	
	
func stop_invincibility():
	invincible = false
	invincibility_timer.stop()
	
	
func _on_invincibility_started():
	collision_shape.set_deferred("disabled", true)
	invincibility_started.emit()
	
	
func _on_invincibility_ended():
	collision_shape.set_deferred("disabled", false)
	invincibility_ended.emit()


func _on_invincibility_timeout():
	invincible = false
	

func send_message(message: String, sender: Object):
	area_recieved_message.emit(message, sender)


func _get_collision_shape() -> CollisionShape2D:
	for child in get_children():
		if child is CollisionShape2D:
			return child
			
	return null

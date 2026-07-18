extends CharacterBody2D
class_name PlayerBullet

@export var juice_box: PlayerBulletJuiceBox

@export var hit_area: Area2D
@export var hurt_area: Area2D

func _ready() -> void:
	self.add_to_group(Game.groups.roots.player_bullet)
	hit_area.add_to_group(Game.groups.hit_area.player_bullet)
	hurt_area.add_to_group(Game.groups.hurt_area.player_bullet)

	await juice_box.feedback.async_on_fired()


func _physics_process(delta: float) -> void:
	move_and_slide()


func _on_hit_area_area_entered(area: Area2D) -> void:
	pass


func _on_hurt_area_area_entered(area: Area2D) -> void:
	pass 


func _on_hurt_area_body_entered(body: Node2D) -> void:
	await juice_box.feedback.async_on_impact()
	queue_free()

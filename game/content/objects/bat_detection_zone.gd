extends Area2D
class_name BatDetectionZone

func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group(Game.groups.interaction_area.bat):
		var bat = area.owner as Bat
		if not bat:
			return
			
		if not bat.through_first_zone:
			bat.through_first_zone = true
		else:
			await Wait.on(self, 1.0).timeout
			bat.queue_free()
			Game.events.gameplay.bat_crossed_screen.emit(bat.level)

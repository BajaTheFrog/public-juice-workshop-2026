extends Node2D

func _on_go_to_game_pressed():
	Game.change.go_to(Content.Contexts.PLAY)


func _on_start_button_pressed() -> void:
	_on_go_to_game_pressed()

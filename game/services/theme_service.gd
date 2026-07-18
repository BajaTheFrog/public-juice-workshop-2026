extends GameService
class_name ThemeService

signal game_theme_changed(new_theme: GameTheme)

@onready var current_theme: GameTheme

func on_game_initialize():
	set_current_theme(ExampleTheme.get_theme())
	

func set_current_theme(new_theme: GameTheme) -> void:
	current_theme = new_theme
	game_theme_changed.emit(current_theme)

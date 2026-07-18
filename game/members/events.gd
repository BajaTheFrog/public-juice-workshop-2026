extends Node
class_name Events
# Events
# This is the recommended hub for broad events to pass through
# Some examples are included to demonstrate the pattern
# Create a class that contains the events for _types_ events or _categories_
# we might care about.

@onready var application: ApplicationEvents = ApplicationEvents.new()
@onready var game_theme: GameThemeEvents = GameThemeEvents.new()
@onready var gameplay: GameplayEvents = GameplayEvents.new()
@onready var player: PlayerEvents = PlayerEvents.new()

class ApplicationEvents:
	# These are events that are outside the context of 
	# the specific game rules or gameplay loop
	signal game_is_ready()
	signal pause_changed(is_paused)

	
class GameThemeEvents:
	# These are events to communicate changes in the
	# GameTheme (colors, assets and presentation of the game)
	signal theme_changed(new_theme)


class GameplayEvents:
	signal updated_time(old, new)
	signal bat_killed(level)
	signal bat_crossed_screen(level)
	
	
class PlayerEvents:
	signal ammo_changed(old, new)
	signal updated_health(old, new)

extends Resource
class_name ExampleTheme
# Demonstrates how to set up arbitrary colors
# that you can select in editor
# and then assigne them to a specific set of properties 
# for your game's theme

@export var dark_purple: Color
@export var medium_purple: Color
@export var purple: Color

@export var dark_blue: Color
@export var medium_blue: Color 
@export var blue: Color 

@export var dark_green: Color 
@export var medium_green: Color 
@export var green: Color 

@export var red: Color


static func get_theme() -> GameTheme:
	var new_theme = GameTheme.new()
	var instance = ExampleTheme.new()
	new_theme.background_color = instance.dark_purple
	new_theme.primary_color = instance.blue
	new_theme.accent_color = instance.red
	return new_theme

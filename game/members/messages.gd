extends Node
class_name Messages
# Messages
# Const strings for situations where a collision
# or area interaction needs to send a message

@onready var time: TimeMessages = TimeMessages.new()

class TimeMessages:
	const danger_zone = "messages.time.danger_zone"

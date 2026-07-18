extends Area2D
class_name ClickableArea2D
# An Area2D with a built-in signal
# for handling click events

signal area_clicked()


func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		on_click()


func on_click():
	emit_signal("area_clicked")

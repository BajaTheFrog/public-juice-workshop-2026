extends RefCounted
class_name Wait
# Turns out the yield(get_tree... method can cause problems if you queue_free
# so instead we're going to quietly add a timer child

const END = "timeout"

static func on(calling_node: Node, time: float) -> Timer:
	var timer = Timer.new()
	timer.autostart = false
	timer.one_shot = true

	calling_node.add_child(timer)

	timer.start(time)
	return timer


static func zero(calling_node: Node) -> SceneTreeTimer:
	return calling_node.get_tree().create_timer(0.0)

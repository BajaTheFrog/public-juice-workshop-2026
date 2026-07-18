extends CanvasLayer
class_name Transition

@export var fade_time: float
@export var color_rect: ColorRect

var nodes_in_wait: Array[Node] = []

func _ready():
	fade_in()


func fade_out_then_fade_in(wait_time: float) -> void:
	await fade_out()
	await get_tree().create_timer(0.3).timeout
	await fade_in()


func fade_out() -> void:
	if color_rect.modulate.a == 1.0:
		return
	
	var tween = create_tween()
	tween.tween_property(color_rect, "modulate:a", 1.0, fade_time)
	await tween.finished
	

func fade_in_when_ready(waiting_node: Node) -> void:
	nodes_in_wait.append(waiting_node)
		
	
func fade_in() -> void:
	if color_rect.modulate.a == 0.0:
		return
	
	var tween = create_tween()
	tween.tween_property(color_rect, "modulate:a", 0.0, fade_time)
	await tween.finished
	

func _process(delta: float) -> void:
	if nodes_in_wait.is_empty():
		return
	
	var still_waiting_nodes: Array[Node] = []
	for node in nodes_in_wait:
		if not is_instance_valid(node):
			continue
		if not node.is_node_ready():
			still_waiting_nodes.append(node)
			
	nodes_in_wait = still_waiting_nodes
	if nodes_in_wait.is_empty():
		await fade_in()

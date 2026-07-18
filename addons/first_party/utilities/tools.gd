extends RefCounted
class_name Tools

const EXPORT_RANGE_INT_MAX = 1_000_000
const EXPORT_RANGE_FLOAT_MAX = 1_000_000.0

static var tree: TreeTools = TreeTools.new()
static var string: StringTools = StringTools.new()
static var array: ArrayTools = ArrayTools.new()
static var area: AreaTools = AreaTools.new()

class TreeTools:
	
	func get_all_descendents(node: Node) -> Array:
		var all_nodes: Array = []
		for child_node in node.get_children():
			if child_node.get_child_count() > 0:
				var grand_children = child_node.get_children()
				all_nodes.append_array(grand_children)
			else:
				all_nodes.append(child_node)
			
		return all_nodes


class StringTools:
	
	func punctuated_number(value: int, separator: String = ",") -> String:
		var string_value = str(value)
		var length = string_value.length()
		var return_string = ""
	
		for index in range(length):
				if((length - index) % 3 == 0 and index > 0):
					return_string = str(return_string, separator, string_value[index])
				else:
					return_string = str(return_string, string_value[index])
			
		return return_string
		

	func two_decimal_number(value: float) -> String:
		return str("%0.2f" % value)


class ArrayTools:
	
	func push_with_limit(array: Array, element, element_limit: int) -> Array:
		array.push_front(element)
		var trimmed_array = array.slice(0, element_limit - 1)
		return trimmed_array
		
		
class AreaTools:

	func start_colliding(area: Area2D) -> void:
		_change_is_ready_to_collide(area, true)
	

	func stop_colliding(area: Area2D) -> void:
		_change_is_ready_to_collide(area, false)
	
	
	func is_ready_to_collide(area: Area2D) -> bool:
		return area.monitoring and area.monitorable
	
	
	func _change_is_ready_to_collide(area: Area2D, is_ready: bool) -> void:
		set_monitoring(area, is_ready)
		set_monitorable(area, is_ready)
	
	
	func start_monitoring(area: Area2D) -> void:
		set_monitoring(area, true)
	

	func stop_monitoring(area: Area2D) -> void:
		set_monitoring(area, false)
	

	func set_monitoring(area: Area2D, is_monitoring: bool) -> void:
		area.set_deferred("monitoring", is_monitoring)
	
	
	func start_monitorable(area: Area2D) -> void:
		set_monitorable(area, true)
	
	
	func stop_monitorable(area: Area2D) -> void:
		set_monitorable(area, false)


	func set_monitorable(area: Area2D, is_monitorable: bool) -> void:
		area.set_deferred("monitorable", is_monitorable)

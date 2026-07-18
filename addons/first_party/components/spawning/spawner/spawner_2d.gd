extends Component2D
class_name Spawner2D

static var world_spawn_root: Node2D = null

static func get_world_spawn_root(from_tree: SceneTree):
	if world_spawn_root:
		return world_spawn_root
	else:
		return from_tree.root
		

static func global_spawn(scene: PackedScene, parent: Node, pos: Vector2 = Vector2.ZERO, scale: Vector2 = Vector2.ONE, rotation_degrees: float = 0.0, is_top_level: bool = true) -> Node:
	var scene_instance = scene.instantiate()
	scene_instance.global_position = pos
	scene_instance.global_scale = scale
	scene_instance.global_rotation_degrees = rotation_degrees
	
	parent.call_deferred("add_child", scene_instance)
	scene_instance.call_deferred("set_as_top_level", is_top_level)
	
	return scene_instance
	
signal node_spawned(spawned_node)

enum PositionMode {ABSOLUTE, RELATIVE_TO_SPAWNER, RELATIVE_TO_PARENT}
enum ScaleMode {ABSOLUTE, RELATIVE_TO_SPAWNER, RELATIVE_TO_PARENT}
enum RotationMode {ABSOLUTE, RELATIVE_TO_SPAWNER, RELATIVE_TO_PARENT}
enum ParentMode {SPAWNER, ASSIGNED_PARENT, WORLD_SPAWN_POINT}
# The spawner id that can be signaled remotely to trigger a spawn
@export var spawner_id: String = "" #TODO: Add global event for triggering spawn

# Scene to spawn
@export var scene_to_spawn: PackedScene
# Position
@export var position_mode: PositionMode
@export var spawn_position: Vector2 = Vector2.ZERO
# Scale
@export var scale_mode: ScaleMode
@export var spawn_scale: Vector2 = Vector2.ONE
# Rotation
@export var rotation_mode: RotationMode
@export_range(-360.0, 360.0) var spawn_rotation_degrees: float = 0.0
# Parent
@export var parent_mode: ParentMode
@export var mark_as_top_level: bool = true
# Misc
@export var defer_call_when_spawning: bool = false
@onready var parent_for_spawn: Node2D = self

func spawn():
	spawn_with_defer_call(defer_call_when_spawning)
	
	
func spawn_with_defer_call(should_defer_call: bool):
	if should_defer_call:
		call_deferred("_private_spawn")
	else:
		_private_spawn()
	

func _private_spawn():	
	# TODO: Make these transform functions exposed to delegate for custom
	# calculations such as randomness. Include calculated values in case
	# delegate just wants to use those
	var spawn_position = _get_spawn_position()
	var spawn_scale = _get_spawn_scale()
	var spawn_rotation_degrees = _get_spawn_rotation()
	var spawn_parent = _get_spawn_parent()
	
	if not spawn_parent:
		printerr(self.name + ": CANNOT SPAWN WITHOUT A PARENT")
		return
	
	var scene_instance = global_spawn(
		scene_to_spawn, 
		spawn_parent, 
		spawn_position, 
		spawn_scale, 
		spawn_rotation_degrees,
		mark_as_top_level
	)
	
	node_spawned.emit(scene_instance)


func _get_spawn_position() -> Vector2:
	match position_mode:
		PositionMode.ABSOLUTE:
			return spawn_position
		PositionMode.RELATIVE_TO_SPAWNER:
			return global_position + spawn_position
		PositionMode.RELATIVE_TO_PARENT:
			return parent_for_spawn.global_position + spawn_position
			
	return Vector2.ZERO
	
	
func _get_spawn_scale() -> Vector2:
	match scale_mode:
		ScaleMode.ABSOLUTE:
			return spawn_scale
		ScaleMode.RELATIVE_TO_SPAWNER:
			return global_scale * spawn_scale
		ScaleMode.RELATIVE_TO_PARENT:
			return parent_for_spawn.global_scale * spawn_scale
			
	return Vector2.ONE
	

func _get_spawn_rotation() -> float:
	match rotation_mode:
		RotationMode.ABSOLUTE:
			return spawn_rotation_degrees
		PositionMode.RELATIVE_TO_SPAWNER:
			return self.global_rotation_degrees + spawn_rotation_degrees
		PositionMode.RELATIVE_TO_PARENT:
			return parent_for_spawn.global_rotation_degrees + spawn_rotation_degrees
			
	return 0.0
	
	
func _get_spawn_parent() -> Node2D:
	match parent_mode:
		ParentMode.SPAWNER:
			return self
		ParentMode.ASSIGNED_PARENT:
			return parent_for_spawn
		ParentMode.WORLD_SPAWN_POINT:
			return get_world_spawn_root(get_tree())
			
	return null
	

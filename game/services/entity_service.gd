extends GameService
class_name EntityService
# EntityService
# A service for finding speicifc entities in the scene tree

func get_player_location() -> Vector2:
	var player_root = get_tree().get_first_node_in_group(Game.groups.roots.player) as Node2D
	if not player_root:
		return Vector2.INF
		
	return player_root.global_position

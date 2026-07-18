extends Node
class_name Groups
# Groups
# This is the recommended hub for accessing group identifiers
# so that nodes, areas and more are added to the appropriate groups

var roots = Roots.new()
var hit_area = HitArea.new()
var hurt_area = HurtArea.new()
var interaction_area = InteractionArea.new()

class Roots:
	const player = "root.player"
	const bat = "root.bat"
	const player_bullet = "root.player.bullet"
	const bat_bullet = "root.bat.bullet"
	
	
class HitArea:
	const bat = "hit_area.bat"
	const player_bullet = "hit_area.player.bullet"
	

class HurtArea:
	const bat = "hurt_area.bat"
	const player = "hurt_area.player"
	const player_bullet = "hurt_area.player.bullet"
	
	
class InteractionArea:
	const player = "interaction_area.player"
	const bat = "interaction_area.bat"

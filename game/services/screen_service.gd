extends GameService
class_name ScreenService

func get_screen_size() -> Vector2:
	return get_viewport().get_visible_rect().size
	
	
func get_screen_center() -> Vector2:
	return get_screen_size() / 2


func get_random_position_on_screen() -> Vector2:
	return get_random_position_on_screen_inset()
	

func get_random_position_on_screen_inset(inset: float = 0.0) -> Vector2:
	return get_random_position_on_screen_inset_edges(inset, inset, inset, inset)
	
	
func get_random_position_on_screen_inset_edges(left_inset: float, right_inset: float, top_inset: float, bottom_inset: float) -> Vector2:
	var top_left_corner = get_viewport().get_visible_rect().position
	var bottom_right_corner = get_viewport().get_visible_rect().end
	
	var random_x = Random.randf_range(top_left_corner.x + left_inset, bottom_right_corner.x - right_inset)
	var random_y = Random.randf_range(top_left_corner.y + top_inset, bottom_right_corner.y - bottom_inset)
	
	return Vector2(random_x, random_y)


func get_random_position_off_screen(outer_buffer: float) -> Vector2:
	var direction_off_screen = Random.randi_capped(4)
	match direction_off_screen:
		0:
			return get_random_position_above_screen(outer_buffer)
		1:
			return get_random_position_right_of_screen(outer_buffer)
		2:
			return get_random_position_below_screen(outer_buffer)
		3: 
			return get_random_position_left_of_screen(outer_buffer)
			
	return get_random_position_above_screen(outer_buffer)
	
	
func get_random_position_above_screen(outer_buffer: float) -> Vector2:
	var top_left_corner = get_viewport().get_visible_rect().position
	var bottom_right_corner = get_viewport().get_visible_rect().end
	
	var random_x = Random.randf_range(top_left_corner.x - outer_buffer, bottom_right_corner.x + outer_buffer)
	var random_y = Random.randf_range(top_left_corner.y - outer_buffer, top_left_corner.y)
	
	return Vector2(random_x, random_y)
	
	
func get_random_position_below_screen(outer_buffer: float) -> Vector2:
	var top_left_corner = get_viewport().get_visible_rect().position
	var bottom_right_corner = get_viewport().get_visible_rect().end
	
	var random_x = Random.randf_range(top_left_corner.x - outer_buffer, bottom_right_corner.x + outer_buffer)
	var random_y = Random.randf_range(bottom_right_corner.y, bottom_right_corner.y + outer_buffer)
	
	return Vector2(random_x, random_y)
	
	
func get_random_position_left_of_screen(outer_buffer: float) -> Vector2:
	var top_left_corner = get_viewport().get_visible_rect().position
	var bottom_right_corner = get_viewport().get_visible_rect().end
	
	var random_x = Random.randf_range(top_left_corner.x - outer_buffer, top_left_corner.x)
	var random_y = Random.randf_range(top_left_corner.y - outer_buffer, bottom_right_corner.y + outer_buffer)
	
	return Vector2(random_x, random_y)
	
	
func get_random_position_right_of_screen(outer_buffer: float) -> Vector2:
	var top_left_corner = get_viewport().get_visible_rect().position
	var bottom_right_corner = get_viewport().get_visible_rect().end
	
	var random_x = Random.randf_range(bottom_right_corner.x, bottom_right_corner.x + outer_buffer)
	var random_y = Random.randf_range(top_left_corner.y - outer_buffer, bottom_right_corner.y + outer_buffer)
	
	return Vector2(random_x, random_y)

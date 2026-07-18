class_name Random
# This does nothing to preserve a seed across 
	
static func randf() -> float:
	var rand = _get_fresh_random_generator()
	return rand.randf()
	
	
static func randf_range(lower_limit, upper_limit) -> float:
	var rand = _get_fresh_random_generator()
	return rand.randf_range(lower_limit, upper_limit)
	
	
static func randi() -> int:
	var rand = _get_fresh_random_generator()
	return rand.randi()
	
	
static func randi_capped(upper_limit) -> int:
	if upper_limit <= 0:
		return 0
		
	return randi() % upper_limit
	
	
static func randi_range(lower_limit, upper_limit):
	var rand = _get_fresh_random_generator()
	return rand.randi_range(lower_limit, upper_limit)
	
	
static func _get_fresh_random_generator() -> RandomNumberGenerator:
	var rand = RandomNumberGenerator.new()
	rand.randomize()
	return rand
	

static func random_unit_vector() -> Vector2:
	var random_x = randf_range(-1, 1)
	var random_y = randf_range(-1, 1)
	return Vector2(random_x, random_y).normalized()
	
	
static func flip_a_coin() -> bool:
	return roll_chance_out_of_100(50.0)
	

# Give a number between 0.0-100.0 and "roll" to see
# if you hit based on that chance out of 100%
# So passing in 14 evaluates if you hit on a 14% chance
static func roll_chance_out_of_100(chance_out_of_100: float) -> bool:
	return roll_chance_with_percent(chance_out_of_100 / 100.0)
	
	
# Give a number between 0.0-1.0 and "roll" to see
# if you hit based on that chance out of 100%
# So passing in 0.36 evaluates if you hit on a 36% chance
static func roll_chance_with_percent(percent: float) -> bool:
	var roll = randf_range(0.0, 1.0)
	return roll <= percent
	

# For calculating probabilties like a "2 in 7" chance
# Both parameters must be >= 0
# If the second parameter is <= 0 it will always return false
static func evaluate_in_chance(numerator: int, denominator: int) -> bool:
	if denominator <= 0:
		return false
		
	var threshold = float(numerator) / float(denominator)
	var random_value = randf()
		
	return random_value >= threshold
	
	
static func color(saturation: float = 1, value: float = 1, alpha: float = 1) -> Color:
	var random_hue = randf_range(0, 1)
	return Color.from_hsv(random_hue, saturation, value, alpha)
	
	
static func random_color_array(number_of_colors: int, saturation: float = 1, value: float = 1, alpha: float = 1) -> Array:
	var hue_value_separation = 1.0 / float(number_of_colors)
	var next_color = Random.color(saturation, value, alpha)
	var color_array = []
	for index in number_of_colors:
		color_array.append(next_color)
		var next_hue = next_color.h + hue_value_separation
		if next_hue > 1.0:
			next_hue -= 1.0
				
		next_color = Color.from_hsv(next_hue, next_color.s, next_color.v)
	
	return color_array

shader_type canvas_item;

uniform bool active = true;
uniform vec4 color: source_color;

void fragment() {
	vec4 previous_color = texture(TEXTURE, UV);
	vec4 flash_color = vec4(color.r, color.g, color.b, previous_color.a);
	vec4 new_color = previous_color;
	if (active == true)
	{
		new_color = flash_color;
	}
	COLOR = new_color;
}
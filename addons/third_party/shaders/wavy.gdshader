shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture;

void fragment() {
    // Calculate UV coordinates
	vec2 uv = SCREEN_UV;
    // Offset the UV coordinates based on a sine wave
    uv.x += sin(SCREEN_UV.y * 0.1 + TIME) * 0.01; // Adjust the frequency and amplitude as needed
    uv.y += sin(SCREEN_UV.x * 0.1 + TIME) * 0.01;

    // Sample the texture using the modified UV coordinates
    COLOR = texture(screen_texture, uv);
}
shader_type canvas_item;

uniform bool outline_enabled = false; // 🆕 toggle for outline
uniform vec4 line_color : source_color = vec4(1.0);
uniform float line_thickness : hint_range(0, 100) = 1.0;

const vec2 OFFSETS[8] = {
	vec2(-1, -1), vec2(-1, 0), vec2(-1, 1),
	vec2(0, -1),              vec2(0, 1),
	vec2(1, -1), vec2(1, 0), vec2(1, 1)
};

void fragment() {
	vec4 color = texture(TEXTURE, UV);

	if (outline_enabled) {
		vec2 size = TEXTURE_PIXEL_SIZE * line_thickness*vec2(0.1, 0.1);
		float outline = 0.0;

		for (int i = 0; i < OFFSETS.length(); i++) {
			outline += texture(TEXTURE, UV + size * OFFSETS[i]).a;
		}
		outline = min(outline, 1.0);

		color = mix(color, line_color, outline - color.a);
	}

	COLOR = color;
}



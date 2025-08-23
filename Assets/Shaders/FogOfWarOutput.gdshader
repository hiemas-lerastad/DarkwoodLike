shader_type canvas_item;

uniform sampler2D MASK_TEXTURE;
uniform sampler2D ALBEDO_TEXTURE;
uniform vec2 scale = vec2(1.0);

void fragment() {
	vec4 mask_colour = texture(MASK_TEXTURE, SCREEN_UV);

	if (COLOR != vec4(0.0, 0.0, 0.0, 1.0)) {
		discard;
	} else {
		vec4 albedo_colour = texture(ALBEDO_TEXTURE, UV);
		COLOR = albedo_colour;
	}
}
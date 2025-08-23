shader_type canvas_item;

uniform sampler2D ALBEDO_TEXTURE;
uniform bool enabled = false;

void fragment() {
	if (enabled) {
		float alpha = 1.0 - COLOR.r;
		vec4 albedo_colour = texture(ALBEDO_TEXTURE, UV);
		COLOR.rgb = albedo_colour.rgb;
		COLOR.a = alpha;
	}
}
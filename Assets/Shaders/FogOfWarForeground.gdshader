shader_type canvas_item;

uniform sampler2D MASK_TEXTURE;
uniform bool enabled = false;
uniform float min_alpha = 0.2;

void fragment() {
	if (enabled) {
		vec4 mask_colour = texture(MASK_TEXTURE, SCREEN_UV);
		float alpha = 1.0 - mask_colour.r;
		//COLOR.rgb = albedo_colour.rgb;
		if (COLOR.a != 0.0) {
			if (alpha > min_alpha) {
				COLOR.a = alpha;
				//COLOR.rgb = (mix(vec3((COLOR.r + COLOR.g + COLOR.b) / 3.0),  vec3(0.299 * COLOR.r + 0.587 * COLOR.g + 0.114 * COLOR.b), 1.0)) * 1.1;
			} else {
				COLOR.a = min_alpha;
			}
		}
	}
}
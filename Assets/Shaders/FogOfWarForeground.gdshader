shader_type canvas_item;

uniform sampler2D MASK_TEXTURE;
uniform bool enabled = false;

void fragment() {
	if (enabled) {
		vec4 mask_colour = texture(MASK_TEXTURE, UV);
		float alpha = 1.0 - mask_colour.r;
		//COLOR.rgb = albedo_colour.rgb;
		if (COLOR.a != 0.0) {
			if (alpha > 0.1) {
				COLOR.a = alpha;
			} else {
				COLOR.a = 0.1;
			}
		}
	}
}
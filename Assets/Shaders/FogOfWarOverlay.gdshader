shader_type canvas_item;
render_mode unshaded;

uniform sampler2D MASK_TEXTURE;
uniform sampler2D SCREEN_TEXTURE: hint_screen_texture;
uniform bool enabled = false;
uniform float min_alpha = 0.2;
uniform float weight: hint_range(0.0, 1.0, 0.1) = 0.2;
uniform float ambient_light_value: hint_range(0.0, 1.0, 0.1) = 0.2;

void fragment() {
	if (enabled) {
		vec4 mask_colour = texture(MASK_TEXTURE, UV);
		float alpha = 1.0 - mask_colour.r;

		COLOR = texture(SCREEN_TEXTURE, SCREEN_UV);

		if (COLOR.a != 0.0) {
			if (alpha > min_alpha) {
				vec3 greyscale = (mix(vec3((COLOR.r + COLOR.g + COLOR.b) / 3.0),  vec3(0.299 * COLOR.r + 0.587 * COLOR.g + 0.114 * COLOR.b), 1.0)) * 1.1;

				alpha *= weight;
				//}
				COLOR.rgb = mix(COLOR.rgb, greyscale, alpha);
			} else {
				COLOR.a = alpha;
			}
		}
	}
}

//void fragment() {
	//COLOR.r = SCREEN_UV.x * 3.0;
	//COLOR.g = SCREEN_UV.y * 3.0;
	//COLOR.a = 0.5;
//}
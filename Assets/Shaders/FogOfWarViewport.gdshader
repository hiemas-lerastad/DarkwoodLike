shader_type canvas_item;

void light() {
    if (LIGHT.r >= 0.0 && LIGHT_COLOR == vec4(1.0)) {
		LIGHT = vec4(1.0);
	}
}
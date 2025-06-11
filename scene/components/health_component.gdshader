shader_type canvas_item;

uniform float percent: hint_range(0.0, 1.0,0.1);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 spriteColor = texture(TEXTURE, UV);
	vec4 flash_color = mix(spriteColor, vec4(1.0, 1.0, 1.0, spriteColor.a), percent );
	COLOR = flash_color;
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}

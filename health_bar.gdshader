shader_type canvas_item;

uniform vec4 flashColor : source_color;
uniform float flashAmmount : hint_range(0.0, 1.0, 0.1);

void fragment() {
	if (!(COLOR.a <= 0.0)){
		vec4 texture_color = texture(TEXTURE, UV);
		COLOR = mix(texture_color, flashColor, flashAmmount);

	}


}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}

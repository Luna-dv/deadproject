shader_type canvas_item;

//uniform vec4 outline_color : hint_color;
uniform float width : hint_range(1.0, 8.0);
uniform vec4 color_1 : hint_color;
uniform vec4 color_2 : hint_color;
uniform vec4 color_3 : hint_color;
uniform vec4 color_4 : hint_color;

float average_color(vec3 _c){
	return (_c.r + _c.g + _c.b)/3.0;
}

void fragment() {
	vec2 size = SCREEN_PIXEL_SIZE * width;
	vec4 screen_color = textureLod(SCREEN_TEXTURE, SCREEN_UV, 0.0);
	float average = round(average_color(screen_color.rgb) * 6.0);
	
	if(distance(vec3(average), vec3(0.0)) == 0.0){
		float _temp = average/6.0;
		float _max_cell = 0.0;
		for(float _r = 0.0; _r < 4.0; _r += 1.0){
			float _angle = (_r/4.0) * (2.0 * 3.141592654);
			vec2 _p = SCREEN_UV + vec2(sin(_angle) * size.x, cos(_angle) * size.y);
			_temp += average_color(texture(SCREEN_TEXTURE, _p).rgb);
			float _temp_max = round(average_color(texture(SCREEN_TEXTURE, _p).rgb) * 6.0);
			if(_temp_max > _max_cell) _max_cell = _temp_max;
			
		}
		_temp = ceil(_temp);
		if(_temp > 0.0){
			average = _max_cell + 1.0;
		}
	}
	if(average == 0.0){
		screen_color = color_1;
	}else if(average == 1.0){
		screen_color = mix(color_1, color_2, .5);
	}else if(average == 2.0){
		screen_color = color_2;
	}else if(average == 3.0){
		screen_color = mix(color_2, color_3, .5);
	}else if(average == 4.0){
		screen_color = color_3;
	}else if(average == 5.0){
		screen_color = mix(color_3, color_4, .5);
	}else{
		screen_color = color_4;
	}
	
	
	COLOR = screen_color;
}





















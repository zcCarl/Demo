shader_type canvas_item;

uniform sampler2D emission_texture;
uniform float speed = 0.0;

void fragment(){
    vec2 newuv = UV;
	
	if(newuv.y>1.0f){
		newuv.y=0.0f;
	}
	if(newuv.x<0.0f){
		newuv.x=1.0f;
	}
    newuv.x += TIME * speed;
    newuv.y -= TIME * speed;
    vec4 c = texture(emission_texture, newuv);
    COLOR = c;
}
shader_type canvas_item;
uniform float strength = 1.;
uniform float speed = 2.;
void vertex() {
	VERTEX += vec2(cos(TIME * speed),cos(TIME*speed*1.3))*strength*step(1.,1.-VERTEX.y);
}

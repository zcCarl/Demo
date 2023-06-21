
shader_type canvas_item;

uniform sampler2D emission_texture;
uniform vec4 glow_color : source_color = vec4(1.0);

void fragment()
{
	vec4 current_color = texture(TEXTURE,UV); // what's our current sprite pixel
	vec4 emission_color = texture(emission_texture,UV); // what's our current emission pixel
	
	if(emission_color.r > 0.0f) // check if we're not black in the emission color.
	{
		COLOR = (emission_color + glow_color); // add brightness corrosponding with the emission pixel
	}
	else
	{
		COLOR = current_color; // we arent over an emission pixel leave alone
	}
}
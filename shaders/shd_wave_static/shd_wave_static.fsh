//
// Simple passthrough fragment shader
//

varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float frequency;
uniform float intensity;

void main()
{
	//Wave
	vec2 Coord = v_vTexcoord + vec2(cos((v_vTexcoord.y)*frequency)/intensity,
									cos((v_vTexcoord.x)*frequency)/intensity);
	
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, Coord );
}

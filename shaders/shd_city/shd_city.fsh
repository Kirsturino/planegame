varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float depth;

void main()
{
	vec2 offset;
	offset.x = depth;
	
	//Drop shadow alpha
	float side = texture2D( gm_BaseTexture, v_vTexcoord).a;
	side += ceil(texture2D( gm_BaseTexture, v_vTexcoord - offset).a);
	
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	gl_FragColor.a += side;
}

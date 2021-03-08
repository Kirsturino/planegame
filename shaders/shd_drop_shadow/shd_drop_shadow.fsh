varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float pixelH;
uniform float pixelW;

void main()
{
	vec2 offsetX;
	offsetX.x = pixelW;
	
	vec2 offsetY;
	offsetY.y = pixelH;
	
	//Utilize outline offset for placing drop shadow
	offsetX /= 1.5;
	offsetY /= 1.5;
	offsetX *= 2.5;
	offsetY *= 2.5;
	
	//Drop shadow alpha
	float shadow = texture2D( gm_BaseTexture, v_vTexcoord - offsetX).a;
	shadow += 0.5;
	
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	gl_FragColor.a += shadow;
}

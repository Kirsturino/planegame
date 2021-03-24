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
	
	float alpha = texture2D( gm_BaseTexture, v_vTexcoord ).a;
	
	//Cardinal
	alpha += ceil(texture2D( gm_BaseTexture, v_vTexcoord + offsetX).a);
	alpha += ceil(texture2D( gm_BaseTexture, v_vTexcoord - offsetX).a);
	alpha += ceil(texture2D( gm_BaseTexture, v_vTexcoord + offsetY).a);
	alpha += ceil(texture2D( gm_BaseTexture, v_vTexcoord - offsetY).a);
	
	//Diagonal
	offsetX /= 1.5;
	offsetY /= 1.5;
	
	alpha += ceil(texture2D( gm_BaseTexture, v_vTexcoord + offsetX + offsetY).a);
	alpha += ceil(texture2D( gm_BaseTexture, v_vTexcoord - offsetX + offsetY).a);
	alpha += ceil(texture2D( gm_BaseTexture, v_vTexcoord - offsetY - offsetX).a);
	alpha += ceil(texture2D( gm_BaseTexture, v_vTexcoord - offsetY + offsetX).a);
	
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	gl_FragColor.a = alpha;
}

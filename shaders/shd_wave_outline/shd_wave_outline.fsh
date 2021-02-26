//
// Simple passthrough fragment shader
//

varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float time;
uniform float frequency;
uniform float intensity;
uniform float pixelH;
uniform float pixelW;
uniform float xOffset;
uniform float yOffset;

void main()
{
	//Wave
	vec2 Coord = v_vTexcoord + vec2(cos((v_vTexcoord.y + yOffset)*frequency + time)/intensity,
									cos((v_vTexcoord.x + xOffset)*frequency + time)/intensity);
	
	//Outline
	vec2 offsetX;
	offsetX.x = pixelW;
	
	vec2 offsetY;
	offsetY.y = pixelH;
	
	float alpha = texture2D( gm_BaseTexture, Coord ).a;
	
	//Cardinal
	alpha += ceil(texture2D( gm_BaseTexture, Coord + offsetX).a);
	alpha += ceil(texture2D( gm_BaseTexture, Coord - offsetX).a);
	alpha += ceil(texture2D( gm_BaseTexture, Coord + offsetY).a);
	alpha += ceil(texture2D( gm_BaseTexture, Coord - offsetY).a);
	
	//Diagonal
	offsetX /= 1.5;
	offsetY /= 1.5;
	
	alpha += ceil(texture2D( gm_BaseTexture, Coord + offsetX + offsetY).a);
	alpha += ceil(texture2D( gm_BaseTexture, Coord - offsetX + offsetY).a);
	alpha += ceil(texture2D( gm_BaseTexture, Coord - offsetY - offsetX).a);
	alpha += ceil(texture2D( gm_BaseTexture, Coord - offsetY + offsetX).a);
	
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, Coord );
	gl_FragColor.a = alpha;
}

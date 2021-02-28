//Create surface and draw white lines
if (!surface_exists(lineSurf))
{
	lineSurf = surface_create(surfWidth, surfHeight);
	
	surface_set_target(lineSurf);
	draw_clear_alpha(col_black, 0);
	
	var xOffset = -surfX + surfMargin/2;
	var yOffset = -surfY + surfMargin/2;

	for (var i = 0; i < pointArrayLength; ++i)
	{
	    var point = pointArray[i];
		var pointTo = pointArray[min(i + 1, pointArrayLength - 1)];
	
		var _x = point[0] + xOffset;
		var _y = point[1] + yOffset;
		var _x2 = pointTo[0] + xOffset;
		var _y2 = pointTo[1] + yOffset;
	
		draw_line_width_color(_x, _y, _x2, _y2, lineThickness*2, col_white, col_white);
		draw_circle_color(_x, _y, lineThickness, col_white, col_white, false);
	}

	surface_reset_target();
	
	//Outline shader stuff
	uPixelH = shader_get_uniform(shd_outline, "pixelH");
	uPixelW = shader_get_uniform(shd_outline, "pixelW");

	uTexelW = outlineThiccness * texture_get_texel_width(surface_get_texture(lineSurf));
	uTexelH = outlineThiccness * texture_get_texel_height(surface_get_texture(lineSurf));
}

var drawX = progressX - surfX + surfMargin/2;
var drawY = progressY - surfY + surfMargin/2;

//Draw on top of white lines when completing. When destroying, erase from surface
surface_set_target(lineSurf);
if (!completed)
{
	draw_circle_color(drawX, drawY, lineThickness*1.1, col_black, col_black, false);
} else
{
	gpu_set_blendmode(bm_subtract);
	draw_circle_color(drawX, drawY, lineThickness*2, col_white, col_white, false);
	gpu_set_blendmode(bm_normal);
}
surface_reset_target();

//Draw surface
shader_set(shd_outline);
shader_set_uniform_f(uPixelW, uTexelW);
shader_set_uniform_f(uPixelH, uTexelH);
draw_surface(lineSurf, surfX, surfY);
shader_reset();

//Draw rotating triangle thing on tracks
var drawX = progressX + surfMargin/2;
var drawY = progressY + surfMargin/2;

drawTriangle(drawX, drawY, 18*triangleScale, rot, col_black, false);
drawTriangle(drawX, drawY, 12*triangleScale, rot, col_white, false);
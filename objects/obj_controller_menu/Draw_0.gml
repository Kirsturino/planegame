if (!surface_exists(levelSurf))
{
	levelSurf = surface_create(viewWidth, viewHeight);
	levelSurfTexelW = global.outlineThiccness * texture_get_texel_width(surface_get_texture(levelSurf));
	levelSurfTexelH = global.outlineThiccness * texture_get_texel_height(surface_get_texture(levelSurf));
	uPixelW = shader_get_uniform(shd_outline, "pixelW");
	uPixelH = shader_get_uniform(shd_outline, "pixelH");
}

var iteration = 1;
var camX = camera_get_view_x(view);
var camY = camera_get_view_y(view);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

surface_set_target(levelSurf);
draw_clear_alpha(col_black, 0);

for (var i = 0; i < lengthX; i++)
{
	var length = array_length(targArray[i]);
	for (var j = 0; j < length; j++)
	{
		var _x = originX + i*spaceX - camX;
		var _y = originY + j*spaceY - camY;
		var c = col_white;
		if (i == arrayX && j == arrayY) { c = col_black; }
		draw_roundrect_color(_x-size, _y-size, _x+size, _y+size, c, c, false);

		if (i == arrayX && j == arrayY) { c = col_white; }
		else { c = col_black; }
		draw_text_color(_x+2, _y+1, iteration, c, c, c, c, 1);
		
		iteration++;
	}
	
	//iteration = 1;
}

surface_reset_target();

draw_set_halign(fa_left);
draw_set_valign(fa_top);

shader_set(shd_outline);
shader_set_uniform_f(uPixelW, levelSurfTexelW);
shader_set_uniform_f(uPixelH, levelSurfTexelH);
draw_surface(levelSurf, camX, camY);
shader_reset();
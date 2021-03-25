if (!surface_exists(levelSurf))
{
	levelSurf = surface_create(viewWidth, viewHeight);
	levelSurfTexelW = global.outlineThickness * texture_get_texel_width(surface_get_texture(levelSurf));
	levelSurfTexelH = global.outlineThickness * texture_get_texel_height(surface_get_texture(levelSurf));
	uPixelW = shader_get_uniform(shd_outline_drop_shadow, "pixelW");
	uPixelH = shader_get_uniform(shd_outline_drop_shadow, "pixelH");
}

var camX = camera_get_view_x(view);
var camY = camera_get_view_y(view);

//Offset background based on camera position for parallax
draw_sprite_tiled_ext(spr_bg, 0, camX/2, camY/2, 1, 1, c_white, 1);

surface_set_target(levelSurf);
draw_clear_alpha(col_black, 0);

var iteration = 1;
for (var i = 0; i < levelSets; i++)
{
	var length = array_length(levelArray[i]);
	for (var j = 0; j < length; j++)
	{
		var _x = originX + j*spaceX - camX;
		var _y = originY + i*spaceY - camY;
		var c = col_white;
		var sine = wave(0, 4, 2, iteration/4, true);
		
		if (i == selectedLevelSet && j == selectedLevel)
		{
			_x += pushX;
			_y += pushY;
			c = col_black;
		}
		
		draw_roundrect_color(_x-size, _y-size+sine, _x+size, _y+size+sine, c, c, false);

		if (i == selectedLevelSet && j == selectedLevel) { c = col_white; }
		else { c = col_black; }
		
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		draw_text_color(_x+2, _y+1+sine, iteration, c, c, c, c, 1);
		
		iteration++;
	}
	
	draw_set_halign(fa_left);
	c = col_white;
	_x = originX - size;
	_y = originY + i*spaceY - camY - size*2;
	
	draw_text_color(_x, _y, levelSetNames[i], c, c, c, c, 1);
}

draw_set_halign(fa_right);

//Draw "back" prompt
var marginX = 16;
var marginY = 24;
var _x = viewWidth - marginX;
var _y = marginY;
var c = col_white;
draw_set_font(fnt_small);

draw_text_color(_x, _y, "Back", c, c, c, c, 1);
var spriteOffset = string_width("Back");
_x -= spriteOffset + 20;
draw_sprite(spr_button_faces, 1, _x, _y);

draw_set_valign(fa_top);
draw_set_halign(fa_left);
draw_set_font(fnt_default);

surface_reset_target();

shader_set(shd_outline_drop_shadow);
shader_set_uniform_f(uPixelW, levelSurfTexelW);
shader_set_uniform_f(uPixelH, levelSurfTexelH);
draw_surface(levelSurf, camX, camY);
shader_reset();
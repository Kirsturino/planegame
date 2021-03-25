//Init surf
if (!surface_exists(menuSurf))
{
	menuSurf = surface_create(viewWidth, viewHeight);
	menuSurfTexelW = global.outlineThickness * texture_get_texel_width(surface_get_texture(menuSurf));
	menuSurfTexelH = global.outlineThickness * texture_get_texel_height(surface_get_texture(menuSurf));
	uPixelW = shader_get_uniform(shd_outline_drop_shadow, "pixelW");
	uPixelH = shader_get_uniform(shd_outline_drop_shadow, "pixelH");
}

var originX = 32;
var originY = viewHeight/2;
var spaceY = 32;

//Draw current menu
draw_set_valign(fa_middle);
surface_set_target(menuSurf);
draw_clear_alpha(col_black, 0);

for (var i = 0; i < pageLength; ++i)
{
	//Center text to origin
	var _x = originX;
	var _y = originY + spaceY*i - spaceY*(pageLength - 1)/2;
	var curPage = menuPages[page];
	var txt = curPage[i][0];
	var c = col_white;
	
	//Indicate current line
	if (selected == i)
		{ txt = "> " + txt; }
	
    draw_text_color(_x, _y, txt, c, c, c, c, 1);
}

draw_set_valign(fa_top);
surface_reset_target();

shader_set(shd_outline_drop_shadow);
shader_set_uniform_f(uPixelW, menuSurfTexelW);
shader_set_uniform_f(uPixelH, menuSurfTexelH);
draw_surface(menuSurf, 0, 0);
shader_reset();
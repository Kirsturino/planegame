//Init surf
if (!surface_exists(menuSurf))
{
	menuSurf = surface_create(viewWidth, viewHeight);
	menuSurfTexelW = global.outlineThickness * texture_get_texel_width(surface_get_texture(menuSurf));
	menuSurfTexelH = global.outlineThickness * texture_get_texel_height(surface_get_texture(menuSurf));
	uPixelW = shader_get_uniform(shd_outline_drop_shadow, "pixelW");
	uPixelH = shader_get_uniform(shd_outline_drop_shadow, "pixelH");
}

//Draw current menu
draw_set_valign(fa_middle);
surface_set_target(menuSurf);
draw_clear_alpha(col_black, 0);

var originX = 32;
var originY = viewHeight/2;
var spaceY = 32;
var curPage = menuPages[page];

for (var i = 0; i < pageLength; ++i)
{
	//Left column
	originX = 32;
	var _x = originX;
	var _y = originY + spaceY*i - spaceY*(pageLength - 1)/2;
	var line = curPage[i];
	var txt = line[0];
	var c = col_white;
	
	//Indicate current line
	if (selected == i)
	{
		txt = "> " + txt;
		c = col_yellow;
	}
	
    draw_text_color(_x, _y, txt, c, c, c, c, 1);
	
	//Right column
	//This is used for mostly settings and stuff
	originX = 192;
	_x = originX;
	var setting = line[2];
	
	if (variable_global_exists(setting[0]))
	{
		var value = variable_global_get(setting[0]);
		
		switch (setting[4])
		{
			case display.shift:
				txt = string(value);
			break;
			
			case display.shift_string:
				txt = setting[5][value - setting[1]];
			break;
			
			case display.toggle:
				txt = value ? "Yes" : "No";
			break;
		}
		
		if (value > setting[1])
			{ txt = "< " + txt; }
		else
			{ _x += string_width("< "); }
				
		if (value < setting[2])
			{ txt = txt + " >"; }
		
		draw_text_color(_x, _y, txt, c, c, c, c, 1);
	}
}


draw_set_valign(fa_top);
surface_reset_target();

shader_set(shd_outline_drop_shadow);
shader_set_uniform_f(uPixelW, menuSurfTexelW);
shader_set_uniform_f(uPixelH, menuSurfTexelH);
draw_surface(menuSurf, 0, 0);
shader_reset();
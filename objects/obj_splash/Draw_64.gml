//Init surf
if (!surface_exists(menuSurf))
{
	menuSurf = surface_create(viewWidth, viewHeight);
	menuSurfTexelW = global.outlineThickness * texture_get_texel_width(surface_get_texture(menuSurf));
	menuSurfTexelH = global.outlineThickness * texture_get_texel_height(surface_get_texture(menuSurf));
	uPixelW = shader_get_uniform(shd_outline_drop_shadow, "pixelW");
	uPixelH = shader_get_uniform(shd_outline_drop_shadow, "pixelH");
}

//Draw stuff
surface_set_target(menuSurf);
draw_clear_alpha(col_black, 0);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var c = col_white;
var txt = "Super";
var _x = viewWidth/2 - 64;
var _y = viewHeight/2 - 40;
draw_set_font(fnt_logo_1);
draw_text_color(_x, _y, txt, c, c, c, c, 1);

var txt = "Aerobatics";
_y += 40;
_x += 64;
draw_set_font(fnt_logo_2);
draw_text_color(_x, _y, txt, c, c, c, c, 1);

var txt = "Turbo";
_y += 48;
_x += 64;
draw_set_font(fnt_logo_1);
draw_text_color(_x, _y, txt, c, c, c, c, 1);

//txt = "by Kirstu";
//draw_set_font(fnt_default);
//_y += 64 + wave(-6, 6, 2, 0, true);
//_x -= 64;
//draw_text_color(_x, _y, txt, c, c, c, c, 1);

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(fnt_default);
surface_reset_target();

//Draw surface
shader_set(shd_outline_drop_shadow);
shader_set_uniform_f(uPixelW, menuSurfTexelW);
shader_set_uniform_f(uPixelH, menuSurfTexelH);
draw_surface(menuSurf, 0, 0);
shader_reset();
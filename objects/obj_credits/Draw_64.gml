//Init surf
if (!surface_exists(creditsSurf))
{
	creditsSurf = surface_create(viewWidth, viewHeight);
	creditsSurfTexelW = global.outlineThickness * texture_get_texel_width(surface_get_texture(creditsSurf));
	creditsSurfTexelH = global.outlineThickness * texture_get_texel_height(surface_get_texture(creditsSurf));
	uPixelW = shader_get_uniform(shd_outline_drop_shadow, "pixelW");
	uPixelH = shader_get_uniform(shd_outline_drop_shadow, "pixelH");
}

var originX = viewWidth/2;
var originY = viewHeight/2;
var spaceY = 32;
var spaceX = originX - 32;
var c = col_white;

//Draw current menu
draw_set_valign(fa_middle);
surface_set_target(creditsSurf);
draw_clear_alpha(col_black, 0);

draw_text_ext_color(originX, originY, "Everything made by Kirstu. No, wait, the music is from Chip-Con's REBOOT1 event", spaceY, spaceX, c, c, c, c, 1);

draw_set_valign(fa_top);
surface_reset_target();

shader_set(shd_outline_drop_shadow);
shader_set_uniform_f(uPixelW, creditsSurfTexelW);
shader_set_uniform_f(uPixelH, creditsSurfTexelH);
draw_surface(creditsSurf, 0, 0);
shader_reset();
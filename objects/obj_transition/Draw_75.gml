//Init surf
if (!surface_exists(transSurf))
{
	transSurf = surface_create(viewWidth, viewHeight);
	transSurfTexelW = global.outlineThickness * texture_get_texel_width(surface_get_texture(transSurf));
	transSurfTexelH = global.outlineThickness * texture_get_texel_height(surface_get_texture(transSurf));
	uPixelW = shader_get_uniform(shd_outline_drop_shadow, "pixelW");
	uPixelH = shader_get_uniform(shd_outline_drop_shadow, "pixelH");
	
	surface_set_target(transSurf);
	draw_clear_alpha(col_black, 0);
	surface_reset_target();
}

surface_set_target(transSurf);
drawFunction();
surface_reset_target();

shader_set(shd_outline_drop_shadow);
shader_set_uniform_f(uPixelW, transSurfTexelW);
shader_set_uniform_f(uPixelH, transSurfTexelH);
draw_surface(transSurf, 0, 0);
shader_reset();
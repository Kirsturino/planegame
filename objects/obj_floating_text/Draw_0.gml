if (!surface_exists(textSurf))
{
	textSurf = surface_create(width+margin*2, height+margin*2);
	
	surface_set_target(textSurf);
	var c = col_white;
	draw_text_ext_color(margin, margin, txt, lineHeight, maxWidth, c, c, c, c, 1);
	surface_reset_target();
	
	textTexelW = global.outlineThickness * texture_get_texel_width(	surface_get_texture(textSurf));
	textTexelH = global.outlineThickness * texture_get_texel_height(surface_get_texture(textSurf));
	uPixelW = shader_get_uniform(shd_outline_drop_shadow, "pixelW");
	uPixelH = shader_get_uniform(shd_outline_drop_shadow, "pixelH");
}


shader_set(shd_outline_drop_shadow);
shader_set_uniform_f(uPixelW, textTexelW);
shader_set_uniform_f(uPixelH, textTexelH);

draw_surface(textSurf, x, y);

shader_reset();
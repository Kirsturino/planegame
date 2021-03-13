if (!surface_exists(textSurf))
{
	textSurf = surface_create(width+margin*2, height+margin*2);
	
	surface_set_target(textSurf);
	draw_text_ext(margin, margin, txt, font_get_size(fnt_default), maxWidth);
	surface_reset_target();
	
	textTexelW = global.outlineThiccness * texture_get_texel_width(	surface_get_texture(textSurf));
	textTexelH = global.outlineThiccness * texture_get_texel_height(surface_get_texture(textSurf));
	uPixelW = shader_get_uniform(shd_outline, "pixelW");
	uPixelH = shader_get_uniform(shd_outline, "pixelH");
}


shader_set(shd_outline);
shader_set_uniform_f(uPixelW, textTexelW);
shader_set_uniform_f(uPixelH, textTexelH);

draw_surface(textSurf, x, y);

shader_reset();
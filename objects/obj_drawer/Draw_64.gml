if (global.paused)
{

	if (!surface_exists(guiSurf))
	{
		guiSurf = surface_create(viewWidth, viewHeight);
		guiTexelW = outlineThiccness * texture_get_texel_width(surface_get_texture(guiSurf));
		guiTexelH = outlineThiccness * texture_get_texel_height(surface_get_texture(guiSurf));
	}

	surface_set_target(guiSurf);
	draw_clear_alpha(col_black, 0);

	draw_set_halign(fa_center);
	draw_set_valign(fa_center);
	draw_text(viewWidth/2, viewHeight/4, "PAUSED");
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);

	surface_reset_target();
	
	//Draw surface with transparent background
	draw_sprite_ext(spr_pixel, 0, 0, 0, viewWidth, viewHeight, 0, col_black, 0.8);

	shader_set(shd_outline);
	shader_set_uniform_f(upixelW, guiTexelW);
	shader_set_uniform_f(upixelH, guiTexelH);
	draw_surface(guiSurf, 0, 0);
	shader_reset();
}
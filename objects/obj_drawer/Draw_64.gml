if (global.paused)
{

	if (!surface_exists(guiSurf))
	{
		guiSurf = surface_create(viewWidth, viewHeight);
		guiTexelW = outlineThickness * texture_get_texel_width(surface_get_texture(guiSurf));
		guiTexelH = outlineThickness * texture_get_texel_height(surface_get_texture(guiSurf));
	}

	surface_set_target(guiSurf);
	draw_clear_alpha(col_black, 0);

	draw_set_halign(fa_center);
	draw_set_valign(fa_center);
	
	var anchorX = viewWidth/2;
	var anchorY = viewHeight/2;
	var spriteOffset = 16;
	var textHeight = font_get_size(fnt_default);
	
	draw_text(anchorX, viewHeight/5 + wave_pure(-8, 8, 4, 0, true), "PAUSED");
	
	draw_text(anchorX+spriteOffset, anchorY+textHeight, "Level Select");
	var offset = string_width("Level Select")/2;
	draw_sprite(spr_button_face_2, 0, anchorX-spriteOffset-offset, anchorY+textHeight);
	
	offset = string_width("Resume")/2;
	draw_text(anchorX+spriteOffset, anchorY-textHeight, "Resume");
	draw_sprite(spr_button_face_1, 0, anchorX-spriteOffset-offset, anchorY-textHeight);
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);

	surface_reset_target();
	
	
	
	//Draw surface with transparent background
	draw_sprite_ext(spr_pixel, 0, 0, 0, viewWidth, viewHeight, 0, col_black, 0.5);

	shader_set(shd_outline);
	shader_set_uniform_f(upixelW, guiTexelW);
	shader_set_uniform_f(upixelH, guiTexelH);
	draw_surface(guiSurf, 0, 0);
	shader_reset();
}
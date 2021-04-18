if (!surface_exists(cubeSurf))
{
	cubeSurf = surface_create(drawSize*4 + surfMargin, drawSize*4 + surfMargin);
	
	//Shader
	upixelH = shader_get_uniform(shd_outline_drop_shadow, "pixelH");
	upixelW = shader_get_uniform(shd_outline_drop_shadow, "pixelW");

	cubeTexelW = outlineThickness * texture_get_texel_width(surface_get_texture(cubeSurf));
	cubeTexelH = outlineThickness * texture_get_texel_height(surface_get_texture(cubeSurf));
}

surface_set_target(cubeSurf);
draw_clear_alpha(col_black, 0);
draw_cube_width(drawSize*2, drawSize*2, drawSize, wave(-1, 1, 8, 0, true), wave(-1, 1, 8, 0.2, true), col_white, 12);
surface_reset_target();

shader_set(shd_outline_drop_shadow);
shader_set_uniform_f(upixelW, cubeTexelW);
shader_set_uniform_f(upixelH, cubeTexelH);

draw_surface(cubeSurf, x - drawSize*2, y - drawSize*2);

shader_reset();
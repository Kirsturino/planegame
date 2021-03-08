if (!surface_exists(citySurf))
{
	generateCityScape();
	
	//City surf stuff
	buildingSide = 10 * texture_get_texel_width(surface_get_texture(citySurf));
	
	uDepth = shader_get_uniform(shd_city, "depth");
} else
{
	var zoom = obj_camera.zoomMultiplier;
	var camX = camera_get_view_x(view) + viewWidth*frac(zoom)/2;
	var camY = camera_get_view_y(view) + viewHeight*frac(zoom)/2;
	
	var drawX = -surfWidth/4 + camX*cityParallaxMultiplier;
	var drawY = min(room_height - surfHeight + camY*cityParallaxMultiplier, room_height - surfHeight);
	
	shader_set(shd_city);
	shader_set_uniform_f(uDepth, buildingSide);
	
	draw_surface(citySurf, drawX, drawY);
	
	shader_reset();
}
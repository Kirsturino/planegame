if (!surface_exists(citySurf))
{
	generateCityScape();
} else
{
	var camX = camera_get_view_x(view);
	var camY = camera_get_view_y(view);
	var zoom = obj_camera.zoomMultiplier;
	var parallax = 0.5;
	var drawX = (-surfWidth/4 + camX*parallax*zoom);
	var drawY = min(room_height-viewHeight + camY*parallax*zoom, room_height-surfHeight);
	draw_surface(citySurf, drawX, drawY);
}
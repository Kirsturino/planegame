if (!surface_exists(backgroundCloudSurface))
{	
	backgroundCloudSurface = surface_create(width, height);
				
	//Draw cloud
	drawCloud();
} else 
{
	if (instance_exists(obj_camera)) { var zoom = obj_camera.zoomMultiplier; }
	else { var zoom = 1; }

	var camX = camera_get_view_x(view) - viewWidth*(1 - zoom)/2;
	var camY = camera_get_view_y(view) - viewHeight*(1 - zoom)/2;
	
	var drawX = x - width/2 + camX*parallaxMultiplier;
	var drawY = y - height/2 + camY*parallaxMultiplier;
	
	draw_surface(backgroundCloudSurface, drawX, drawY);
}
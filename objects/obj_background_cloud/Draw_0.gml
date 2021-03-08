if (!surface_exists(backgroundCloudSurface))
{	
	backgroundCloudSurface = surface_create(width, height);
				
	//Draw cloud
	drawCloud();
} else 
{
	var zoom = obj_camera.zoomMultiplier;
	var camX = camera_get_view_x(view) + viewWidth*frac(zoom)/2;
	var camY = camera_get_view_y(view) + viewHeight*frac(zoom)/2;
	
	var drawX = x - width/2 + camX*parallaxMultiplier;
	var drawY = y - height/2 + camY*parallaxMultiplier;
	
	draw_surface(backgroundCloudSurface, drawX, drawY);
}
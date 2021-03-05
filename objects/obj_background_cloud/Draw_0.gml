if (!surface_exists(backgroundCloudSurface))
{	
	backgroundCloudSurface = surface_create(width, height);
				
	//Draw cloud
	drawCloud();
} else 
{
	var camY = camera_get_view_y(view);
	var camX = camera_get_view_x(view);
	
	var drawX = x-width/2 + camX*parallaxMultiplier;
	var drawY = y-height/2 + camY*parallaxMultiplier;
	
	draw_surface(backgroundCloudSurface, drawX, drawY);
}
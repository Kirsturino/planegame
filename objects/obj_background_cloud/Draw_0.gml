if (!surface_exists(backgroundCloudSurface))
{	
	backgroundCloudSurface = surface_create(width, height);
				
	//Draw cloud
	drawCloud();
} else 
{
	var camY = camera_get_view_y(view);
	
	var drawX = x-width/2;
	var drawY = y-height/2 - camY*parallaxMultiplier;
	
	draw_surface(backgroundCloudSurface, drawX, drawY);
}
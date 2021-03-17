var zoom = obj_camera.zoomMultiplier;
var camX = camera_get_view_x(view) + viewWidth*frac(zoom)/2;
var camY = camera_get_view_y(view) + viewHeight*frac(zoom)/2;
	
var drawX = x + camX*parallaxMultiplier;
var drawY = y + camY*parallaxMultiplier;


draw_circle_color(drawX, drawY, 32, col_yellow, col_yellow, false);
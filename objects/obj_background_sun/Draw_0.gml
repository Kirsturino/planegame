if (instance_exists(obj_camera)) { var zoom = obj_camera.zoomMultiplier; }
else { var zoom = 1; }

var camX = camera_get_view_x(view) - viewWidth*(1 - zoom)/2;
var camY = camera_get_view_y(view) - viewHeight*(1 - zoom)/2;
	
var drawX = x + camX*parallaxMultiplier;
var drawY = y + camY*parallaxMultiplier;


draw_circle_color(drawX, drawY, 32, col_yellow, col_yellow, false);
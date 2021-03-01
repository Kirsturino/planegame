window_center();

//Set camera coordinates to player location
var _x = obj_player.x - viewWidth/2;
var _y = obj_player.y - viewHeight/2;

xx = _x;
xTo = _x;
yy = _y;
yTo = _y;

camera_set_view_pos(view, _x, _y);
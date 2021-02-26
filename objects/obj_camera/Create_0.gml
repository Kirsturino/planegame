//Center window
alarm[0] = 1;

//Setup camera variables
camera_set_view_pos(view, 0, 0);
window_set_size(viewWidth * global.windowScale, viewHeight * global.windowScale);

//Apply camera
camera_set_view_size(view, viewWidth, viewHeight);

//Limit GUI draw resolution
surface_resize(application_surface, viewWidth, viewHeight);
display_set_gui_size(viewWidth, viewHeight);

//Camera variables
xTo = 0;
yTo = 0;

//Camera shake variables
shakeDuration = 0;
shakeAmount = 0;
shakeX = 0;
shakeY = 0;

//Directional shake variables
dirShakeAmount = 0;
dirShakeDirection = 0;
dirShakeDuration = 0;
dirShakeFrequency = 0;
dirShakeX = 0;
dirShakeY = 0;

//Camera push variables
pushX = 0;
pushY = 0;
pushReturn = 4;

//Camera zoom stuff
zoomMultiplier = 1;
zoomLerpSpeed = 0.02;
zoomTarget = 1;

//Camera rotation
rot = 0;
rotTo = 0;

function cameraShake()
{
	if (shakeDuration > 0)
	{
		var amount = irandom_range(-shakeAmount, shakeAmount);
		shakeX = amount;
		amount = irandom_range(-shakeAmount, shakeAmount);
		shakeY = amount;
	} else
	{
		shakeX = 0;
		shakeY = 0;
		shakeAmount = 0;
	}
	
	shakeAmount = approach(shakeAmount, 0, 0.1);
	shakeDuration = approach(shakeDuration, 0, 1);
}

function cameraShakeDirectional()
{
	if (dirShakeDuration > 0)
	{
		var amount = lengthdir_x(wave(-dirShakeAmount, dirShakeAmount, dirShakeFrequency, 0, true), dirShakeDirection);
		dirShakeX = amount;
		
		var amount = lengthdir_y(wave(-dirShakeAmount, dirShakeAmount, dirShakeFrequency, 0, true), dirShakeDirection);
		dirShakeY = amount;
	} else
	{
		dirShakeX = 0;
		dirShakeY = 0;
		dirShakeAmount = 0;
	}
	
	dirShakeAmount = approach(dirShakeAmount, 0, 0.1);
	dirShakeDuration = approach(dirShakeDuration, 0, 1);
}

function cameraPush()
{
	//Smoothly reset camera push
	pushX = approach(pushX, 0, pushReturn);
	pushY = approach(pushY, 0, pushReturn);
}

function cameraRotation()
{
	rot = lerp(rot, rotTo, 0.1);
	rotTo = approach(rotTo, 0, 1);
}

function cameraZoom()
{
	zoomMultiplier = lerp(zoomMultiplier, zoomTarget, zoomLerpSpeed);
}

function cameraLogic()
{
	var spd = .05;
	var finalWidth = viewWidth * zoomMultiplier;
	var finalHeight = viewHeight * zoomMultiplier;
	var lookAheadMultiplierX = 50;
	var lookAheadMultiplierY = 20;
	var xDir = obj_player.image_angle;
	var yDir = point_direction(0, 0, obj_player.hsp, obj_player.vsp);
	
	xx = obj_player.x + lengthdir_x(abs(obj_player.hsp) * lookAheadMultiplierX, xDir)
		- viewWidth/2 + viewWidth/2 * (1 - zoomMultiplier);
	yy = obj_player.y + lengthdir_y(abs(obj_player.vsp) * lookAheadMultiplierY, yDir) 
		- viewHeight/2 + viewHeight/2 * (1 - zoomMultiplier);
	
	xx = clamp(xx, 0, room_width - finalWidth);
	yy = clamp(yy, 0, room_height - finalHeight);
	
	applyCameraPos(spd, finalWidth, finalHeight);
}

function staticCameraLogic(_x, _y)
{
	var spd = .05;

	xx = _x - viewWidth;
	yy = _y - viewHeight;
	
	xx = clamp(xx, 0, room_width - viewWidth*2);
	yy = clamp(yy, 0, room_height - viewHeight*2);
	
	applyCameraPos(spd, viewWidth*2, viewHeight*2);
}

function applyCameraPos(spd, width, height)
{
	cameraShake();
	cameraShakeDirectional();
	cameraPush();
	cameraRotation();
	cameraZoom();
	
	curX = camera_get_view_x(view);
	curY = camera_get_view_y(view);
	
	xTo = lerp(curX, xx + shakeX + pushX + dirShakeX, spd);
	yTo = lerp(curY, yy + shakeY + pushY + dirShakeY, spd);

	camera_set_view_pos(view, xTo, yTo);
	camera_set_view_angle(view, rot);
	camera_set_view_size(view, width, height);
}
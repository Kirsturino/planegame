//Camera variables
curX = 0;
curY = 0;

//Set camera coordinates to player location
var _x = obj_player.x - viewWidth/2;
var _y = obj_player.y - viewHeight/2;

xx = _x;
xTo = _x;
yy = _y;
yTo = _y;

camera_set_view_pos(view, _x, _y);

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
zoomLerpSpeed = 0.05;
zoomTarget = 1;

//Camera rotation
rot = 0;
rotTo = 0;

//Array of things the camera should find interesting
focusArray = [];

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
	rot = lerp(rot, rotTo, 0.05*delta);
	rotTo = approach(rotTo, 0, 0.01);
}

function cameraZoom()
{
	zoomMultiplier = lerp(zoomMultiplier, zoomTarget, zoomLerpSpeed*delta);
}

function checkCameraFocus()
{
	var length = array_length(focusArray);
	if (length > 0)
	{
		var dist = point_distance(curX + viewWidth/2, curY + viewHeight/2, obj_player.x, obj_player.y);
		var cutOffPoint = 140;
		if (dist > cutOffPoint)
		{
			array_resize(focusArray, 0);
		
			//Reset object focus states
			with (par_object_of_interest) { inFocus = false; }
		}
	}
}

function cameraLogic()
{
	var spd = 0.05;
	var finalWidth = viewWidth * zoomMultiplier;
	var finalHeight = viewHeight * zoomMultiplier;
	var lookAheadMultiplierX = 50;
	var lookAheadMultiplierY = 20;
	var xDir = obj_player.image_angle;
	var yDir = point_direction(0, 0, obj_player.hsp, obj_player.vsp);
	
	//Get player's coordinates with some doctoring added
	var playerX = obj_player.x + lengthdir_x(abs(obj_player.hsp) * lookAheadMultiplierX, xDir);
	var playerY = obj_player.y + lengthdir_y(abs(obj_player.vsp) * lookAheadMultiplierY, yDir);
	
	//Check if player is too far away from camera center
	//If player is too far, clear the focus array
	checkCameraFocus();
	
	//Get any objects of interest and add them together
	var xAverage = playerX;
	var yAverage = playerY;
	
	var length = array_length(focusArray);
	for (var i = 0; i < length; ++i)
	{
	    xAverage += focusArray[i].x;
		yAverage += focusArray[i].y;
	}
	
	//Calculate the wanted focal point of the camera
	var finalX = xAverage / (length+1);
	var finalY = yAverage / (length+1);
	
	//Change offset of camera depending on zoom to keep it centered on player smoothly
	var xZoomOffset = viewWidth/2 * frac(zoomTarget);
	var yZoomOffset = viewHeight/2 * frac(zoomTarget);
	
	xx = finalX - viewWidth/2 - xZoomOffset;
	yy = finalY - viewHeight/2 - yZoomOffset;
	
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
	
	xTo = lerp(curX, xx + shakeX + pushX + dirShakeX, spd*delta);
	yTo = lerp(curY, yy + shakeY + pushY + dirShakeY, spd*delta);

	camera_set_view_pos(view, xTo, yTo);
	camera_set_view_angle(view, rot);
	camera_set_view_size(view, width, height);
}
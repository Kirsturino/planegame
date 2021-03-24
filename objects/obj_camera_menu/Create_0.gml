//Camera variables
curX =	0;
curY =	0;
xx =	0;
xTo =	0;
yy =	0;
yTo =	0;
targX = 0;
targY = 0;
spd = 0.1;

camera_set_view_pos(view, 0, 0);

#region FX

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

#endregion

function cameraLogic()
{
	curX = camera_get_view_x(view);
	curY = camera_get_view_y(view);

	var finalWidth = viewWidth * zoomMultiplier;
	var finalHeight = viewHeight * zoomMultiplier;
	
	//Change offset of camera depending on zoom to keep it centered on player smoothly
	var xZoomOffset = viewWidth/2 * (zoomTarget-1);
	var yZoomOffset = viewHeight/2 * (zoomTarget-1);
	
	xx = targX - viewWidth/2 - xZoomOffset;
	yy = targY - viewHeight/2 - yZoomOffset;
	
	xx = clamp(xx, 0, room_width - finalWidth);
	yy = clamp(yy, 0, room_height - finalHeight);
	
	applyCameraPos(spd, finalWidth, finalHeight);
}

function applyCameraPos(spd, width, height)
{
	cameraShake();
	cameraShakeDirectional();
	cameraPush();
	cameraRotation();
	cameraZoom();
	
	xTo = lerp(curX, xx + shakeX + pushX + dirShakeX, spd*delta);
	yTo = lerp(curY, yy + shakeY + pushY + dirShakeY, spd*delta);

	camera_set_view_pos(view, xTo, yTo);
	camera_set_view_angle(view, rot);
	camera_set_view_size(view, width, height);
}
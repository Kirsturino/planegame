#macro view view_camera[0]
#macro viewWidth 480
#macro viewHeight 270
global.windowScale = 3;

function shakeCamera(panAmount, rotAmount, duration)
{
	if (panAmount > obj_camera.shakeAmount)
	{
		obj_camera.shakeAmount = panAmount;
		obj_camera.shakeDuration = duration;
	}
	
	if (rotAmount != 0)
		{ obj_camera.rotTo = choose(rotAmount, -rotAmount); }
}

function directionShakeCamera(amount, duration, direction, frequency)
{
	if (amount > obj_camera.dirShakeAmount)
	{
		obj_camera.dirShakeFrequency = frequency;
		obj_camera.dirShakeAmount = amount;
		obj_camera.dirShakeDuration = duration;
		obj_camera.dirShakeDirection = direction;
	}
}

function rotateCamera(amount, rng)
{
	if (rng)	{obj_camera.rotTo = choose(amount, -amount);}
	else		{obj_camera.rotTo = amount;}
}
 
function pushCamera(amount, direction)
{
	obj_camera.pushX = lengthdir_x(amount, direction);
	obj_camera.pushY = lengthdir_y(amount, direction);
}

function zoomCamera(amount)
{
	obj_camera.zoomMultiplier = 1 - amount;
}

function setCameraZoom(amount)
{
	obj_camera.zoomTarget = amount;
}

function addCameraFocus(object_id)
{
	array_push(obj_camera.focusArray, object_id);
}

function removeCameraFocus(object_id)
{
	removeFromArray(obj_camera.focusArray, object_id);
}
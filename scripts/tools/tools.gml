function approach(value, to, amount) {
	if (value < to)
	{
	    value += amount * delta;
	    if (value > to) return to;
	} else
	{
	    value -= amount * delta;
	    if (value < to) return to;
	}
	return value;
}

function approach_pure(value, to, amount) {
	if (value < to)
	{
	    value += amount;
	    if (value > to) return to;
	} else
	{
	    value -= amount;
	    if (value < to) return to;
	}
	return value;
}

function wave(from, to, duration, offset, sine) {
	var a4 = (to - from) * 0.5;

	//Ternary operator stuff
	var waveType = sine		?	sin(((((current_time - global.pausedTime) * 0.001) + duration + offset) / duration) * (pi*2))
							:	cos(((((current_time - global.pausedTime) * 0.001) + duration + offset) / duration) * (pi*2));
	
	return from + a4 + waveType * a4;
}

function wave_pure(from, to, duration, offset, sine) {
	var a4 = (to - from) * 0.5;

	//Ternary operator stuff
	var waveType = sine		?	sin(((((current_time) * 0.001) + duration + offset) / duration) * (pi*2))
							:	cos(((((current_time) * 0.001) + duration + offset) / duration) * (pi*2));
	
	return from + a4 + waveType * a4;
}

function isOutsideRoom(x, y, marginX, marginY)
{
	if (x < -marginX || x > room_width + marginX)		{ return true; }
	else if (y < -marginY || y > room_height + marginY) { return true; }
	else												{ return false; }
}

function isInView(objectID, margin) {
	
	var viewX = camera_get_view_x(view);
	var viewY = camera_get_view_y(view);
	with (objectID) {	
		if (bbox_right + margin < viewX || bbox_left - margin > viewX + viewWidth*obj_camera.zoomMultiplier)		{ return false; }
		else if (bbox_bottom + margin < viewY || bbox_top - margin > viewY + viewHeight*obj_camera.zoomMultiplier)	{ return false; }
		else																										{ return true; }
	}
}

function debug()
{
	show_debug_message("This code is being run.");
}

function executeFunctionArray(array)
{
	//Run through functions in an array
	var length = array_length(array);
	for (var i = 0; i < length; ++i) { array[i](); }
}

function pushArrayToArray(arrayFrom, arrayTo)
{
	var length = array_length(arrayFrom);
	for (var i = 0; i < length; ++i)
		{ array_push(arrayTo, arrayFrom[i]); }
}

function removeFromArray(array, value)
{
	var foundValue = false;
	var length = array_length(array);
	for (var i = 0; i < length; ++i)
	{
		if (array[i] == value)
		{
			var index = i;
			foundValue = true;
		}
	}
	
	if (foundValue) array_delete(array, index, 1);
}

function arrayContains(array, value)
{
	var foundValue = false;
	var length = array_length(array);
	for (var i = 0; i < length; ++i)
	{
		if (array[i] == value) {foundValue = true;}
	}
	
	return foundValue;
}
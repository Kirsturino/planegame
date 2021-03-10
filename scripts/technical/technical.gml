//Some flags TBA

//Delta time
globalvar delta;
delta = 0;

//This doesn't really matter what it is, but will affect rate of everything. 
//Just needs some constant to measure against, I think.
#macro defaultFramesPerSecond 60
globalvar framesPerSecond;
framesPerSecond = 144;
game_set_speed(framesPerSecond, gamespeed_fps);

//Time that a single frame should last by default
global.targetDelta = 1 / defaultFramesPerSecond;

//Actual time that includes lag etc.
global.actualDelta = delta_time / 1000000;

//This is going to be used EVERYWHERE, so having a shorter name is convenient
//Don't use this way of creating global variables otherwise
globalvar delta;
delta = global.actualDelta / global.targetDelta;

global.timeScale = 1;

global.controller = 0;
global.gp_num = gamepad_get_device_count();
global.deadzone = 0.3;

function getController()
{
	//Cycle through USB ports
	for (var i = 0; i < global.gp_num; i++;)
	{
		//Select first available controller (prefers XInput devices)
		if (gamepad_is_connected(i))
		{
			global.controller = i;
			break;
		} else
		{
			global.controller = -1;
		}
	}

	gamepad_set_axis_deadzone(global.controller, global.deadzone);
}
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
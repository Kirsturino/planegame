//Delta time
globalvar delta;
delta = 0;

//This doesn't really matter what it is, but will affect rate of everything. 
//Just needs some constant to measure against
#macro defaultFramesPerSecond 60
global.framesPerSecond = 1;
global.speeds = [30, 60, 144, 240];

function applyFrameRate()
{
	game_set_speed(global.speeds[global.framesPerSecond], gamespeed_fps);
	
	initParticles();
}

//Time that a single frame should last by default
global.targetDelta = 1 / defaultFramesPerSecond;

//Actual time that includes lag etc.
global.actualDelta = delta_time / 1000000;

//This is going to be used EVERYWHERE, so having a shorter name is convenient
//Don't use this way of creating global variables otherwise
globalvar delta;
delta = global.actualDelta / global.targetDelta;

global.timeScale = 1;
global.paused = false;
global.pausedTime = 0;

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

function togglePause()
{
	global.paused = !global.paused;
	global.timeScale = !global.paused;
	part_system_automatic_update(global.ps,		!global.paused);
	part_system_automatic_update(global.psTop,	!global.paused);
}

function saveJSON(fileName, struct)
{
	//JSONify data
	var str = json_stringify(struct);
	var hash = sha1_string_utf8_hmac(HMAC_KEY, str);
	
	//Append hash
	str += "#" +  hash + "#";
	
	//Delete old file
	if (file_exists(fileName)) { file_delete(fileName); }
	
	var file = file_text_open_write(fileName);
	file_text_write_string(file, str);
	file_text_close(file);
}

function loadJSON(fileName)
{
	if (file_exists(fileName))
	{
		var file = file_text_open_read(fileName)
		var str = file_text_read_string(file);
		file_text_close(file);
		
		//Find hash, it's always the same length
		var expectedHash = string_copy(str, string_length(str)-40, 40);
		
		//Get rid of hash
		var hashlessString = string_copy(str, 1, string_length(str)-42);
		
		//Make hash of trimmed text
		var newHash = sha1_string_utf8_hmac(HMAC_KEY, hashlessString);
		
		//Compare hashes
		//Check if the two hashes match
		if (expectedHash == newHash)
		{
		    //Savefile is valid! Let's load the savedata
		    return json_parse(hashlessString);
		}
		else
		{
		    show_message("Don't do that");
		}
	} else
	{
		return -1;
	}
}
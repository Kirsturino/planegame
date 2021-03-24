//Game state things
checkForPlayer();

if (gamepad_button_check_pressed(global.controller, gp_face1) && !global.paused)
{
	startRoomTransition(restartLevel);
}

if (global.paused)
{
	if (gamepad_button_check_pressed(global.controller, gp_face2))
	{
		togglePause();
		audio_group_stop_all(ag_sfx);
		room_goto(rm_level_select);
	}
	
	if (gamepad_button_check_pressed(global.controller, gp_face1))
		{ togglePause(); }
}

if (gamepad_button_check_pressed(global.controller, gp_start) && !transitioningIn && !transitioningOut)
{
	with (obj_player) { resetInput(); }
	togglePause();
}

//Level transitions
if (transitioningOut)
{
	transitionTimer = approach(transitionTimer, 0, 1);
	if (transitionTimer == 0)
	{ transitionFunction(); }
}
else if (transitioningIn)
{
	transitionTimer = approach(transitionTimer, transitionTimerMax, 1);
	if (transitionTimer == transitionTimerMax)
		{ transitioningIn = false; }
}

//Music
checkMusic();
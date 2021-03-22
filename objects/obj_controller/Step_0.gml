//Game state things
checkForPlayer();

if (gamepad_button_check_pressed(global.controller, gp_face1))
{
	startRoomTransition(restartLevel);
}

if (gamepad_button_check(global.controller, gp_shoulderl) && gamepad_button_check_pressed(global.controller, gp_face2))
{
	game_end();
}

if (gamepad_button_check_pressed(global.controller, gp_face4))
{
	room_goto_next();
}

if (gamepad_button_check_pressed(global.controller, gp_face3))
{
	room_goto_previous();
}

if (keyboard_check_pressed(ord("M")))
{
	global.musicToggle = !global.musicToggle;
}

if (keyboard_check_pressed(ord("F")))
{
	window_set_fullscreen(!window_get_fullscreen());
}

if (gamepad_button_check_pressed(global.controller, gp_start) && !transitioningIn && !transitioningOut)
{
	with (obj_player) { resetInput(); }
	global.paused = !global.paused;
	global.timeScale = !global.paused;
	part_system_automatic_update(global.ps,		!global.paused);
	part_system_automatic_update(global.psTop,	!global.paused);
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
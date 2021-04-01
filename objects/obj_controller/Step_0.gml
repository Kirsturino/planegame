if (gamepad_button_check_pressed(global.controller, gp_face1) && !global.paused)
{
	startRoomTransition(transition.level_restart, obj_player.x, obj_player.y, room);
}

if (global.paused)
{
	if (gamepad_button_check_pressed(global.controller, gp_face2))
	{
		togglePause();
		startRoomTransition(transition.out, obj_player.x, obj_player.y, rm_level_select);
	}
	
	if (gamepad_button_check_pressed(global.controller, gp_face1))
		{ togglePause(); }
}

if (gamepad_button_check_pressed(global.controller, gp_start) && !global.transitioning)
{
	with (obj_player) { resetInput(); }
	togglePause();
}
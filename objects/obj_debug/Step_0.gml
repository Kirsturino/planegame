if (gamepad_button_check(global.controller, gp_shoulderl) && gamepad_button_check_pressed(global.controller, gp_face2))
{
	game_end();
}

if (gamepad_button_check_pressed(global.controller, gp_face4) && findLevelFromArray(room) != -1)
{
	audio_group_stop_all(ag_sfx);
	markLevelAsCleared(room);
	startRoomTransition(nextLevel);
}
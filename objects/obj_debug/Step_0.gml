if (gamepad_button_check(global.controller, gp_shoulderl) && gamepad_button_check_pressed(global.controller, gp_face2))
{
	game_end();
}

if (gamepad_button_check_pressed(global.controller, gp_face4))
{
	audio_group_stop_all(ag_sfx);
	room_goto_next();
}

if (gamepad_button_check_pressed(global.controller, gp_face3))
{
	audio_group_stop_all(ag_sfx);
	room_goto_previous();
}

if (keyboard_check_pressed(ord("M")))
{
	obj_music_controller.musicToggle = !obj_music_controller.musicToggle;
}

if (keyboard_check_pressed(ord("F")))
{
	window_set_fullscreen(!window_get_fullscreen());
}
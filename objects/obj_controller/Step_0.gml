if (gamepad_button_check_pressed(0, gp_face1))
{
	room_restart();
	audio_stop_all();
}

if (gamepad_button_check_pressed(0, gp_face2))
{
	game_end();
}
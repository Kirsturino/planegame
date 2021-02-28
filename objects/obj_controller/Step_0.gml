//Game state things
checkForPlayer();

if (gamepad_button_check_pressed(0, gp_face1))
{
	transitionFunction = restartLevel;
	startRoomTransition();
}

if (gamepad_button_check_pressed(0, gp_face2))
{
	game_end();
}

//Level transitions
if (transitioningOut)
{
	transitionTimer = approach(transitionTimer, 0, 1);
	
	if (transitionTimer == 0)
	{ transitionFunction(); }
} else if (transitioningIn)
{
	transitionTimer = approach(transitionTimer, transitionTimerMax, 1);
	
	if (transitionTimer == transitionTimerMax)
		{ transitioningIn = false; }
}

//Music
checkMusic();
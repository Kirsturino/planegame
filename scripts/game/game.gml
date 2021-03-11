global.objectiveCount = 0;

function startRoomTransition(func)
{
	obj_controller.transitioningOut = true;
	obj_controller.transitionFunction = func;
}

//Level transition
function nextLevel()
{
	audio_group_stop_all(ag_sfx);
	room_goto_next();
}

function restartLevel()
{
	audio_group_stop_all(ag_sfx);
	room_restart();
}
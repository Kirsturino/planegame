event_inherited();

function checkLevelCompletion()
{
	if (global.objectiveCount == 0)
	{
		markLevelAsCleared(room);
		startRoomTransition(30, transition.level_next, obj_player.x, obj_player.y);
	}
}

//Count up all completables in level
global.objectiveCount++;
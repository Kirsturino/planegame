event_inherited();

function checkLevelCompletion()
{
	if (global.objectiveCount == 0)
	{
		markLevelAsCleared(room);
		startRoomTransition(nextLevel);
	}
}

//Count up all completables in level
global.objectiveCount++;
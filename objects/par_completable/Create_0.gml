function checkLevelCompletion()
{
	if (global.objectiveCount == 0)
		{ startRoomTransition(); }
}

//Count up all completables in level
global.objectiveCount++;
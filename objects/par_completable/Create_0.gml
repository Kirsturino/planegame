event_inherited();

function checkLevelCompletion()
{
	if (global.objectiveCount == 0)
		{ startRoomTransition(nextLevel); }
}

//Count up all completables in level
global.objectiveCount++;
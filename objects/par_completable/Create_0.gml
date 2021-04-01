event_inherited();

function checkLevelCompletion()
{
	if (global.objectiveCount == 0)
	{
		markLevelAsCleared(room);
		startRoomTransition(transition.level_next, obj_player.x, obj_player.y, room);
		
		with (obj_player) { toDummy(); blockPlayerInput(60);}
	}
}

//Count up all completables in level
global.objectiveCount++;
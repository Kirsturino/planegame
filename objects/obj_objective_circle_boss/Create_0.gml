event_inherited();

function checkLevelCompletion()
{
	obj_boss.circleCount++;
	
	if (obj_boss.circleCount == obj_boss.transitionAmount)
	{
		obj_boss.phase++;
		obj_boss.circleCount = 0;
	}
	
	if (global.objectiveCount == 0)
	{
		markLevelAsCleared(room);
		startRoomTransition(transition.level_next, obj_player.x, obj_player.y, room);
		
		with (obj_player) { toDummy(); blockPlayerInput(60);}
	}
}

hsp = 0;
vsp = 0;

destroyTimer = 480;
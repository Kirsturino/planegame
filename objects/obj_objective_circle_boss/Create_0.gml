event_inherited();

function checkLevelCompletion()
{
	obj_boss.circleCount++;
	
	if (obj_boss.circleCount == obj_boss.transitionAmount)
	{
		obj_boss.incrementPhase();
		
		switch (obj_boss.phase)
		{
			case 3:
				obj_boss.spawnLine();
			break;
		}
	}
}

hsp = 0;
vsp = 0;

destroyTimer = 480;
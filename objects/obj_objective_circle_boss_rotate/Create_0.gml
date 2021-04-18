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
		
		with (obj_objective_circle_boss)
		{
			if (!completed)
			{
				removeCameraFocus(id);
				instance_destroy();
			}
		}
		
		with (obj_bullet)
		{
			instance_destroy();
		}
	}
}

hsp = 0;
vsp = 0;

destroyTimer = 480;
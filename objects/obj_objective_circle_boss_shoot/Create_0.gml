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

objective = function ()
{
	//Track bullets
	var list = ds_list_create();
	collision_circle_list(x, y, radius, obj_bullet, false, false, list, false);
	var size = ds_list_size(list);
	
	for (var i = 0; i < size; ++i)
	{
	   var blt = list[| i];
	
		if (blt != noone && blt.target != obj_player)
		{
			if (!playerEnter)
				{ playerEnter = true; }
					
			if (!inFocus)
			{
				resetCameraFocus();
				addCameraFocus(id);
				inFocus = true;
			}
				
			completion = approach_pure(completion, completionMax, blt.dmg);
			completionDecayDelay = completionDecayDelayMax;
			radius *= 1.1;
				
				
			//SFX
			progressAudio();
			freeze(20);
			if (!audio_is_playing(shootHitSound)) audio_play_sound(shootHitSound, 0, false);
			part_particles_create(global.ps, blt.x, blt.y, global.electricityPart, 4);
			part_particles_create(global.psTop, blt.x, blt.y, global.bulletHitPart, 1);
				
			instance_destroy(blt);
		} else if (blt != noone)
		{
			completionDecayLogic();
		}
	}
	
	ds_list_destroy(list);
}
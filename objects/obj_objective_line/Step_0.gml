if (!completed)
{
	var _x = pointArray[progressPoint][0];
	var _y = pointArray[progressPoint][1];
	var _x2 = pointArray[progressPoint+1][0];
	var _y2 = pointArray[progressPoint+1][1];

	if (collision_circle(progressX+surfMargin/2, progressY+surfMargin/2, radius, obj_player, false, false) != noone)
	{
		var speedModifier = (abs(obj_player.hsp) + abs(obj_player.vsp)) * 0.2;
		curProgressSpeed = approach(curProgressSpeed, progressSpeed, progressAxl * speedModifier);
	} else
	{
		curProgressSpeed = approach(curProgressSpeed, 0, progressFrc);
	}

	progressX = lerp(_x, _x2, progressLerp);
	progressY = lerp(_y, _y2, progressLerp);

	var dist = point_distance(_x, _y, _x2, _y2);
	progressLerp = approach(progressLerp, 1, curProgressSpeed / dist);

	if (progressLerp == 1 && progressPoint < pointArrayLength)
	{
		progressPoint++;
		progressLerp = 0;
		
		if (progressPoint == pointArrayLength-1)
		{
			completed = true;
			curProgressSpeed = 0;
			
			destroyLerp = 2;
			//FX
			var i = 0;
			var seg = 8;
			repeat (seg)
			{
				var dir = 360/seg*i;
				var spawnX = progressX+surfMargin/2 + lengthdir_x(lineThickness*8*destroyLerp, dir);
				var spawnY = progressY+surfMargin/2 + lengthdir_y(lineThickness*8*destroyLerp, dir);
				
				part_type_direction(global.linePart, dir, dir, -2, 0);
				part_particles_create(global.ps, spawnX, spawnY, global.linePart, 1);
				
				i++;
			}
			
			audio_sound_pitch(completionSound, 1);
			audio_play_sound(completionSound, 0, false);
		}
	}
} else if (completed)
{
	//Go backwards in the set line
	var _x = pointArray[progressPoint][0];
	var _y = pointArray[progressPoint][1];
	var _x2 = pointArray[progressPoint-1][0];
	var _y2 = pointArray[progressPoint-1][1];

	curProgressSpeed = approach(curProgressSpeed, progressSpeed*2, progressAxl);

	destroyX = lerp(_x, _x2, progressLerp);
	destroyY = lerp(_y, _y2, progressLerp);

	var dist = point_distance(_x, _y, _x2, _y2);
	progressLerp = approach(progressLerp, 1, curProgressSpeed / dist);

	if (progressLerp == 1 && progressPoint > 1)
	{
		progressPoint--;
		progressLerp = 0;
		
		
	} else if (progressPoint == 1 && progressLerp == 1 && !destroy)
	{
		destroy = true;
		destroyFade = 2;
		
		//FX
		radialParticle(global.linePart, 8, lineThickness*8*destroyLerp, destroyX+surfMargin/2, destroyY+surfMargin/2);
		
		audio_sound_pitch(completionSound, 2);
		audio_play_sound(completionSound, 0, false);
	}
	
	if (destroy)
	{
		destroyFade = approach(destroyFade, 0, 0.1)
		
		if (destroyFade == 0)
		{
			radialParticle(global.linePart, 8, 16, destroyX+surfMargin/2, destroyY+surfMargin/2);
			audio_play_sound(disappearSound, 0, false);
			surface_free(lineSurf);
			instance_destroy();
		}
	}
	
	//FX
	part_particles_create(global.ps, destroyX+surfMargin/2, destroyY+surfMargin/2, global.smokePart, 1);
}

//This is used for scaling the spinny thing (and also as a timer, clean this whole object into states later)
destroyLerp = lerp(destroyLerp, destroyFade, 0.2);
rot -= curProgressSpeed*3;

//SFX
if (curProgressSpeed > 0 && sfxTimer == 0 && !destroy)
{
	audio_sound_pitch(progressSound, 1 + curProgressSpeed/10);
	audio_play_sound(progressSound, 0, false);
	sfxTimer = sfxTimerMax / (1 + curProgressSpeed);
} else
{
	sfxTimer = approach(sfxTimer, 0, 1);
}
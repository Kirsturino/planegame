event_inherited();

completed = false;
radius = 8;

curProgressSpeed = 0;
progressSpeed = 4;
progressAxl = 0.2;
progressFrc = 0.05;

progressLerp = 0;
progressPoint = 0;

destroyTimer = 30;
destroy = false;

//Graphics
rot = irandom(45);
triangleScale = 1;
triangleScaleTarget = 1;

//SFX
sfxTimer = 0;
sfxTimerMax = 20;
progressSound = snd_tick;
completionSound = snd_line_completion;
disappearSound = snd_pop;

//This is horrible instance creation order jank
alarm[0] = 1;

function completionLogic()
{
	//Get two points we're moving between
	var _x = pointArray[progressPoint][0];
	var _y = pointArray[progressPoint][1];
	var _x2 = pointArray[progressPoint+1][0];
	var _y2 = pointArray[progressPoint+1][1];
	
	var progX = progressX+surfMargin/2;
	var progY = progressY+surfMargin/2;

	//If player touches triangle, it accelerates, else it slows down
	var plr = collision_circle(progX, progY, radius, obj_player, false, false);
	if (plr != noone)
	{
		//Move triangle depending on player speed
		var speedModifier = (abs(obj_player.hsp) + abs(obj_player.vsp)) * 0.2;
		curProgressSpeed = approach(curProgressSpeed, progressSpeed, progressAxl * speedModifier);
	} else
	{
		curProgressSpeed = approach(curProgressSpeed, 0, progressFrc);
	}
	
	//Actuallly increment completion value based on the triangle's current speed
	progressLerp = approach(progressLerp, 1, curProgressSpeed / pointLength);

	//Move triangle between two points
	progressX = lerp(_x, _x2, progressLerp);
	progressY = lerp(_y, _y2, progressLerp);

	//This is where we go once we reach the point
	if (progressLerp == 1 && progressPoint < pointArrayLength)
	{
		//Increment next point details
		progressPoint++;
		progressLerp = 0;
		
		//If at last point, do stuff and change state
		if (progressPoint == pointArrayLength-1)
		{
			completed = true;
			curProgressSpeed = 0;
			
			global.objectiveCount--;
			//Check if this is the last completable, if so, mark level as cleared
			checkLevelCompletion();
			
			state = destroyLogic;
			
			//FX
			radialParticle(global.linePart, 8, 32, progX, progY);
			audio_sound_pitch(completionSound, 1);
			audio_play_sound(completionSound, 0, false);
		} else
		{
			//Calculate length of next segment
			var _x = pointArray[progressPoint][0];
			var _y = pointArray[progressPoint][1];
			var _x2 = pointArray[progressPoint+1][0];
			var _y2 = pointArray[progressPoint+1][1];
			pointLength = point_distance(_x, _y, _x2, _y2);
		}
	}
}

function destroyLogic()
{
	//Go backwards in the set line
	var _x = pointArray[progressPoint][0];
	var _y = pointArray[progressPoint][1];
	var _x2 = pointArray[progressPoint-1][0];
	var _y2 = pointArray[progressPoint-1][1];
	
	var progX = progressX+surfMargin/2;
	var progY = progressY+surfMargin/2;

	//Triangle accelerates to twice of full speed
	curProgressSpeed = approach(curProgressSpeed, progressSpeed*2, progressAxl);
	progressLerp = approach(progressLerp, 1, curProgressSpeed / pointLength);
	
	progressX = lerp(_x, _x2, progressLerp);
	progressY = lerp(_y, _y2, progressLerp);

	//If at target point, increment target
	if (progressLerp == 1 && progressPoint > 1)
	{
		progressPoint--;
		progressLerp = 0;
		
		//Calculate length of next segment
		var _x = pointArray[progressPoint][0];
		var _y = pointArray[progressPoint][1];
		var _x2 = pointArray[progressPoint-1][0];
		var _y2 = pointArray[progressPoint-1][1];
		
		pointLength = point_distance(_x, _y, _x2, _y2);
		
	} else if (progressPoint == 1 && progressLerp == 1 && !destroy)
	{
		//If at end of the line, start destruction sequence
		destroy = true;
		
		//FX
		radialParticle(global.linePart, 8, 32, progX, progY);
		audio_sound_pitch(completionSound, 2);
		audio_play_sound(completionSound, 0, false);
	}
	
	//Destruction sequence
	if (destroy)
	{
		destroyTimer = approach(destroyTimer, 0, 1);
		triangleScaleTarget = 0;
		
		if (destroyTimer == 0)
		{
			radialParticle(global.linePart, 8, 16, progX, progY);
			audio_play_sound(disappearSound, 0, false);
			surface_free(lineSurf);
			instance_destroy();
		}
	}
}

state = completionLogic;
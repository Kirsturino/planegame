col = make_color_rgb(26, 17, 46);
col2 = make_color_rgb(41, 25, 69);

solidSurf = -1;
tempSurf = -1;

onScreen = true;

frequency = 8;
radius = 7;
positionVariance = 0;
fillPositionVariance = 0;
radiusVariance = 0;
surfMargin = 32;
margin = 4;

function createSolidSurface(surf, freq, posVar, fillPosVar, rad, radVar, marg, surfMarg, col, col2, fill)
{
	var surfWidth = sprite_width+surfMarg;
	var surfHeight = sprite_height+surfMarg;
	tempSurf = surface_create(surfWidth, surfHeight);
	
	surface_set_target(tempSurf);
	
	var totalMarg = marg/2 + surfMarg/2;
	var xLimit = surfWidth - totalMarg;
	var yLimit = surfHeight - totalMarg;
	
	//Fill
	if (fill)
	{ draw_rectangle_color(totalMarg, totalMarg, surfWidth-totalMarg, surfHeight-totalMarg, col, col, col, col, false); }
	
	//Make surface edges
	if (totalMarg < xLimit && totalMarg < yLimit)
	{
		for (var i = totalMarg; i <= xLimit; i += freq;)
		{
		    for (var j = totalMarg; j <= yLimit; j += freq;)
			{
				var _x = i + irandom_range(-posVar, posVar);
				var _y = j + irandom_range(-posVar, posVar);
			    draw_circle_color(_x, _y, max(0, rad + irandom_range(-radVar, radVar)), col2, col2, false);
			}
		}
	}
	
	//Make surface inside
	var insideMarg = 12;
	if (totalMarg < xLimit && totalMarg < yLimit)
	{
		for (var i = totalMarg+insideMarg; i <= xLimit-insideMarg; i += freq;)
		{
		    for (var j = totalMarg+insideMarg; j <= yLimit-insideMarg; j += freq;)
			{
				var _x = i + irandom_range(-fillPosVar, fillPosVar);
				var _y = j + irandom_range(-fillPosVar, fillPosVar);
			    draw_circle_color(_x, _y, rad, col, col, false);
			}
		}
	}
	
	surface_reset_target();
	
	surface_copy(surf, 0, 0, tempSurf);
	surface_free(tempSurf);
}

function hitFunction()
{
	with (obj_player)
	{
		if (state != outOfEnergy)
		{
			energyCooldown = energyCooldownMax;
			energy = approach_pure(energy, 0, max((abs(hsp) + abs(vsp))*20, 10));
		} else
		{
			startRoomTransition(restartLevel);
		}
		
		if (!inDanger)
		{
			//FX
			inDanger = true;
			var dir = point_direction(0, 0, hsp, vsp);
			directionShakeCamera(30, 40, dir, 0.2);
			pushCamera(60, dir);
			audio_play_sound(bonkSound, 0, false);
			freeze(50);
			setControllerVibration(0.8, 0.8);
			zoomCamera(0.05);
		}
		
		//Bounceback
		var margin = 16;
		var bounceFactor = -0.2;
		if (x+hsp < other.bbox_left + margin || x+hsp > other.bbox_right - margin)
			{ hsp *= bounceFactor; }
		else 
			{ vsp *= bounceFactor; }
				
		blockPlayerInput(60);
		resetInput();
		resetTurbo();
	}
}
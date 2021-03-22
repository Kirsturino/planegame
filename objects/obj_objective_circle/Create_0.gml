event_inherited();

//Graphics variables
rot = 0;
rotSpd = 1;
thiccness = lineThickness;
col = col_white;
radius = 0;
radiusTo = sprite_width/2;
segments = radiusTo/2;
drawRad = 0;

//Objective time
completion = 0;
completed = false;

//Misc
surfSize = radiusTo*4;
surfCenter = surfSize/2;
circleSurf = -1;

//Tracks when player first enters circle
playerEnter = false;

//SFX
completionSoundAsset = snd_circle_progress_inside;
completionSound = audio_play_sound(completionSoundAsset, 0, true);
audio_stop_sound(completionSound);
objectiveCompleteSound = snd_circle_complete;

function progressAudio()
{
	if (!audio_is_playing(completionSound))
	{
		completionSound = audio_play_sound(completionSoundAsset, 0, true);
	}
	audio_sound_pitch(completionSound, 1 + completion/completionMax);
}

function completionDecayLogic()
{
	if (completionDecayDelay == 0)
	{
		completion = approach(completion, 0, completionDecay);
		audio_stop_sound(completionSound);
	} else
	{
		completionDecayDelay = approach(completionDecayDelay, 0, 1);
	}
}

switch (type)
{
	case "inside":
		objective = function ()
		{
			//Track player
			var plr = collision_circle(x, y, radius, obj_player, false, false);
			if (plr != noone)
			{
				if (!playerEnter)
					{ playerEnter = true; }
					
				completion = approach(completion, completionMax, 1);
				completionDecayDelay = completionDecayDelayMax;
				
				progressAudio();
			} else
			{
				completionDecayLogic();
			}
		}
		
		drawFunction = function()
		{
			var i = 0;
			var seg = segments/2;
			repeat(seg)
			{
				//Draw every other segment for dotted look
				if (i mod 2 == 0)
				{
					var rad = drawRad/2+wave(-4, 4, 2, 0, true);
					var size = 8;
					
					var _x = surfCenter + lengthdir_x(rad, 360/seg*i+rot-size);
					var _y = surfCenter + lengthdir_y(rad, 360/seg*i+rot-size);
	
					var _x2 = surfCenter + lengthdir_x(rad, 360/seg*i+rot+size);
					var _y2 = surfCenter + lengthdir_y(rad, 360/seg*i+rot+size);
					
					var _x3 = surfCenter + lengthdir_x(rad-size, 360/seg*i+rot);
					var _y3 = surfCenter + lengthdir_y(rad-size, 360/seg*i+rot);
					
					draw_triangle_color(_x, _y, _x2, _y2, _x3, _y3, col, col, col, false);
				} 
	
				i++;
			}
			
			draw_circle_color(surfCenter, surfCenter, (drawRad+thiccness)*completion/completionMax, col_black, col_black, false);
		}
	break;
	
	case "insideRotation":
		enterRotation = -1;
		
		objective = function ()
		{
			//Track player
			var plr = collision_circle(x, y, radius, obj_player, false, false);
			if (plr != noone)
			{
				if (!playerEnter)
				{
					playerEnter = true;
					enterRotation = plr.image_angle;
				}
				
				//Player can UNDO progress if rotating wrong direction
				var progress = plr.rotSpd[0] - plr.rotSpd[1];
				completion = clamp(completion + progress*delta, min(0, completionMax), max(0, completionMax));
				completionDecayDelay = completionDecayDelayMax;
				
				//SFX
				progressAudio();
			} else
			{
				completionDecayLogic();
			}
		} 

		drawFunction = function()
		{
			var i = 0;
			var seg = segments/2;
			repeat(seg)
			{
				//Draw every other segment for dotted look
				if (i mod 2 == 0)
				{
					var rad = drawRad/2+wave(-4, 4, 2, 0, true);
					var _x = surfCenter + lengthdir_x(rad, 360/seg*i+rot);
					var _y = surfCenter + lengthdir_y(rad, 360/seg*i+rot);
	
					var _x2 = surfCenter + lengthdir_x(rad, 360/seg*(i+1)+rot);
					var _y2 = surfCenter + lengthdir_y(rad, 360/seg*(i+1)+rot);
	
					draw_line_width_color(_x, _y, _x2, _y2, thiccness, col, col);
					
					var size = 6;
					var dir = max(sign(completionMax), 0);
					
					var _x = surfCenter + lengthdir_x(rad-size, 360/seg*(i+dir)+rot);
					var _y = surfCenter + lengthdir_y(rad-size, 360/seg*(i+dir)+rot);
	
					var _x2 = surfCenter + lengthdir_x(rad+size, 360/seg*(i+dir)+rot);
					var _y2 = surfCenter + lengthdir_y(rad+size, 360/seg*(i+dir)+rot);
					
					var _x3 = surfCenter + lengthdir_x(rad, 360/seg*(i+dir)+rot) + lengthdir_x(size, 360/seg*(i+dir)+rot+90*sign(completionMax));
					var _y3 = surfCenter + lengthdir_y(rad, 360/seg*(i+dir)+rot) + lengthdir_y(size, 360/seg*(i+dir)+rot+90*sign(completionMax));
					
					draw_triangle_color(_x, _y, _x2, _y2, _x3, _y3, col, col, col, false);
				} 
	
				i++;
			}
			
			if (completion != 0)
			{
				var i = 0;
				var rad = drawRad + thiccness;
				repeat(segments)
				{
					//Draw unfolding circle
					var seg = 360*completion/completionMax/segments*sign(completionMax);
					
					var _x = surfCenter;
					var _y = surfCenter;
	
					var _x2 = surfCenter + lengthdir_x(rad, seg*i+enterRotation);
					var _y2 = surfCenter + lengthdir_y(rad, seg*i+enterRotation);
					
					var _x3 = surfCenter + lengthdir_x(rad, seg*(i+1)+enterRotation);
					var _y3 = surfCenter + lengthdir_y(rad, seg*(i+1)+enterRotation);
					
					draw_triangle_color(_x, _y, _x2, _y2, _x3, _y3, col_black, col_black, col_black, false);
	
					i++;
				}
			}
		}
	break;
	
	case "shoot":
		shootHitSound = snd_circle_shoot_hit;
		objective = function ()
		{
			//Track bullets
			var blt = collision_circle(x, y, radius, obj_bullet, false, false);
			if (blt != noone)
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
				instance_destroy(blt);
				
				//SFX
				progressAudio();
				freeze(10);
				if (!audio_is_playing(shootHitSound)) audio_play_sound(shootHitSound, 0, false);
				
			} else
			{
				completionDecayLogic();
			}
		}
		
		drawFunction = function()
		{
			var i = 0;
			var dir = 1;
			var seg = segments;
			repeat(seg)
			{
				var size = radius/6;
				var rad = drawRad/2+wave(-radius/16, radius/16, 2, 0, true);
				var _x = surfCenter + lengthdir_x(rad + (size*dir), 360/seg*i+rot);
				var _y = surfCenter + lengthdir_y(rad + (size*dir), 360/seg*i+rot);
	
				var _x2 = surfCenter + lengthdir_x(rad - (size*dir), 360/seg*(i+1)+rot);
				var _y2 = surfCenter + lengthdir_y(rad - (size*dir), 360/seg*(i+1)+rot);
	
				draw_line_width_color(_x, _y, _x2, _y2, thiccness, col, col);
	
				i++;
				dir *= -1;
			}
			
			draw_circle_color(surfCenter, surfCenter, drawRad*completion/completionMax, col_black, col_black, false);
		}
	break;
	
	case "turbo":
		objective = function()
		{
			//Track player
			var plr = collision_circle(x, y, radius, obj_player, false, false);
			if (plr != noone && plr.turbo)
			{
				if (!playerEnter)
					{ playerEnter = true; }
					
				completion = approach(completion, completionMax, 1);
				completionDecayDelay = completionDecayDelayMax;
				
				progressAudio();
			} else
			{
				completionDecayLogic();
			}
		}
		
		drawFunction = function()
		{
			var i = 0;
			var dir = 1;
			var starSegments = 10;
			repeat(starSegments)
			{
				var size = radius/8;
				var rad = drawRad/2+wave(-radius/14, radius/14, 2, 0, true);
				var _x = surfCenter + lengthdir_x(rad + (size*dir), 360/starSegments*i+rot);
				var _y = surfCenter + lengthdir_y(rad + (size*dir), 360/starSegments*i+rot);
	
				var _x2 = surfCenter + lengthdir_x(rad - (size*dir), 360/starSegments*(i+1)+rot);
				var _y2 = surfCenter + lengthdir_y(rad - (size*dir), 360/starSegments*(i+1)+rot);
	
				draw_line_width_color(_x, _y, _x2, _y2, thiccness, col, col);
	
				i++;
				dir *= -1;
			}
			
			draw_circle_color(surfCenter, surfCenter, drawRad*completion/completionMax, col_black, col_black, false);
		}
	break;
	
	default:
		objective = function()
			{ show_debug_message("Invalid objective type"); }
	break;
}

function checkCompletion()
{
	if (completion == completionMax && !completed)
		{
			//Remove the object from the camera's focus list
			if (type == "shoot")
				{ removeCameraFocus(id); }
				
			completed = true;
			radiusTo *= 1.5;
			audio_stop_sound(completionSound);
			audio_play_sound(objectiveCompleteSound, 0, false);
			
			//FX
			var i = 0;
			repeat (segments)
			{
				var dir = 360/segments*i;
				var spawnX = x + lengthdir_x(radiusTo, dir);
				var spawnY = y + lengthdir_y(radiusTo, dir);
				
				part_type_direction(global.linePart, dir, dir, 2*sign(completionMax)*delta, 0);
				part_particles_create(global.ps, spawnX, spawnY, global.linePart, 1);
				
				i++;
			}
			
			global.objectiveCount--;
			//Check if this is the last completable, if so, mark level as cleared
			checkLevelCompletion();
		}
}
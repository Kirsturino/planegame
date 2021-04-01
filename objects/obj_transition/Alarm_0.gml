switch (transitionType)
{
	case transition.out:
		transitionFunction = function()
		{
			audio_group_stop_all(ag_sfx);
			room_goto(destination);
		}
		
		drawFunction = function()
		{
			draw_clear_alpha(col_black, 1);
			
			gpu_set_blendmode(bm_subtract);
			var rad = transitionTimer/transitionTimerMax * viewWidth;
			draw_circle(targX, targY, rad, false);
			gpu_set_blendmode(bm_normal);
		}
		
		transitionSound = snd_transition_out;
	break;
	
	case transition.in:
		transitionFunction = function()
		{
			
		}
		
		drawFunction = function()
		{
			draw_clear_alpha(col_black, 1);
			
			gpu_set_blendmode(bm_subtract);
			var rad = (1 - transitionTimer/transitionTimerMax) * viewWidth;
			draw_circle(targX, targY, rad, false);
			gpu_set_blendmode(bm_normal);
		}
		
		transitionSound = snd_transition_in;
	break;
	
	case transition.level_next:
		transitionFunction = function()
		{
			audio_group_stop_all(ag_sfx);
			nextLevel();
		}
		
		drawFunction = function()
		{
			draw_clear_alpha(col_black, 1);
			
			gpu_set_blendmode(bm_subtract);
			var rad = transitionTimer/transitionTimerMax * viewWidth;
			draw_circle(targX, targY, rad, false);
			gpu_set_blendmode(bm_normal);
		}
		
		transitionSound = snd_transition_out;
	break;
	
	case transition.level_restart:
		transitionFunction = function()
		{
			audio_group_stop_all(ag_sfx);
			restartLevel();
		}
		
		drawFunction = function()
		{
			draw_clear_alpha(col_black, 1);
			
			gpu_set_blendmode(bm_subtract);
			var rad = transitionTimer/transitionTimerMax * viewWidth;
			draw_circle(targX, targY, rad, false);
			gpu_set_blendmode(bm_normal);
		}
		
		transitionSound = snd_transition_out;
	break;
}

targX -= camera_get_view_x(view);
targY -= camera_get_view_y(view);
audio_play_sound(transitionSound, 0, false);

//If we finish a thing and go to level select, make extra noise
var level = findLevelFromArray(room);
if (level != -1 && transitionType == transition.level_next)
	{
	var levelSetLength = array_length(levelArray[level[0]]) - 1;
	if (level[1] == levelSetLength && (level[0] + 1 > global.unlockedLevelSets || level[0] == array_length(levelArray)))
	{
		transitionTimer *= 3;
		audio_play_sound(snd_end_of_level_set, 0, false);
	}
}
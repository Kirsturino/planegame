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
	break;
}

targX -= camera_get_view_x(view);
targY -= camera_get_view_y(view);
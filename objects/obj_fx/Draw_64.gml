//Implementation of full screen flash
draw_sprite_ext(spr_pixel, 0, 0, 0, viewWidth, viewHeight, 0, c_white, alpha);

//Extra danger indication
if (!surface_exists(dangerSurf))
	{ dangerSurf = surface_create(viewWidth, viewHeight); }

surface_set_target(dangerSurf);

//Draw red rectangle over whole screen
var c = merge_color(col_red, col_orange, wave(0, 1, 0.5, 0, true));
draw_sprite_ext(spr_pixel, 0, 0, 0, viewWidth, viewHeight, 0, c, 1);

//Chunk out the middle for a clean border
gpu_set_blendmode(bm_subtract);
var blend = 0.5 - obj_player.energy/obj_player.energyMax;
var borderSize = rectThickness * blend;
if (obj_player.state == obj_player.outOfEnergy) borderSize = rectThickness;
border = lerp(border, borderSize, 0.1);

draw_sprite_ext(spr_pixel_centered, 0, viewWidth/2, viewHeight/2, viewWidth/2-border, viewHeight/2-border, 0, c_white, 1);

gpu_set_blendmode(bm_normal);

surface_reset_target();

shader_set(shd_wave);
shader_set_uniform_f(uIntensity, intensity);
shader_set_uniform_f(uTime, (current_time-global.pausedTime)/1000*spd);
shader_set_uniform_f(uFrequency, frequency);
draw_surface(dangerSurf, 0, 0);
shader_reset();
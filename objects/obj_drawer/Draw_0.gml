var camX = camera_get_view_x(view);
var camY = camera_get_view_y(view);

draw_clear(backgroundColor);

#region Background cloud drawing

with (obj_background_cloud) { event_perform(ev_draw, 0); }

#endregion

with (obj_background) { event_perform(ev_draw, 0); }

#region Completables

with (par_completable) { event_perform(ev_draw, 0); }

#endregion

#region Danger zone bottom layer drawing

//Make sure surface hasn't exploded
if (!surface_exists(masterCloudSurf))
{
	masterCloudSurf = surface_create(viewWidth*2, viewHeight*2);
	cloudTexelW = outlineThiccness * texture_get_texel_width(surface_get_texture(masterCloudSurf));
	cloudTexelH = outlineThiccness * texture_get_texel_height(surface_get_texture(masterCloudSurf));
}
			
with (obj_danger_zone)
{
	if (!surface_exists(cloudSurf))
		{
			cloudSurf = surface_create(sprite_width+surfMargin, sprite_height+surfMargin);
			createCloudSurface(cloudSurf, frequency, positionVariance, radius, radiusVariance, margin, surfMargin, col, true);
		}
}

surface_set_target(other.masterCloudSurf);
draw_clear_alpha(col_black, 0);
with (obj_danger_zone)
{
	if (onScreen)
	{
		draw_surface(cloudSurf, bbox_left - surfMargin/2 - camX + viewWidth/2,
								bbox_top - surfMargin/2 - camY + viewHeight/2);
	}
}
surface_reset_target();

//Animate bottom cloud layer with wave shader and outline
shader_set(shd_wave_outline);
shader_set_uniform_f(uTimeOL, current_time/1000 * spdOL);
shader_set_uniform_f(uFrequencyOL, frequencyOL);
shader_set_uniform_f(uIntensityOL, intensityOL);
shader_set_uniform_f(uWavePixelW, cloudTexelW);
shader_set_uniform_f(uWavePixelH, cloudTexelH);
shader_set_uniform_f(uXOffsetOL, camX/masterWidth); //This surface moves, so we have to offset texcoord for the shader
shader_set_uniform_f(uYOffsetOL, camY/masterHeight);

draw_surface(masterCloudSurf, camX-viewWidth/2, camY-viewHeight/2);
shader_reset();
			
#endregion

part_system_drawit(global.ps);

#region Player drawing

if (!surface_exists(playerSurf))
{
	playerSurf = surface_create(64, 64);
	playerTexelW = outlineThiccness * texture_get_texel_width(surface_get_texture(playerSurf));
	playerTexelH = outlineThiccness * texture_get_texel_height(surface_get_texture(playerSurf));
}

surface_set_target(playerSurf);

//This is both outline and shape fill color
if (obj_player.energy / obj_player.energyMax < .3)	{ dangerBlend = approach(dangerBlend, 1, 0.1); }
else												{ dangerBlend = approach(dangerBlend, 0, 0.1); }
var c = merge_color(col_black, col_red, wave(0, 1, 1, 0, true) * dangerBlend);

draw_clear_alpha(c, 0);

var drawOffset = 32;

with (obj_player)
{
	//Set to only draw on alpha channel
	gpu_set_blendenable(false)
	gpu_set_colorwriteenable(false,false,false,true);
	//Clear alpha channel
	draw_set_alpha(0);
	draw_rectangle(0,0, 64, 64, false);
	draw_set_alpha(1);
	
	//Draw mask
	//Yes, the entire player is the mask, thanks for asking

	//Draw wings
	var drawX = drawOffset + lengthdir_x(-2*xScale, image_angle);
	var drawY = drawOffset + lengthdir_y(-2*xScale, image_angle);
	var diff = angle_difference(image_angle, 0);
	var diff2 = angle_difference(image_angle, 180);
	var finalDiff = min(abs(diff), abs(diff2));
	wingSpan = finalDiff/90;
	var finalSpan = wingSpan;
	if (image_angle > 180 && image_angle < 360) { finalSpan *= -1; }
	draw_sprite_ext(spr_wings_small, 0, drawX, drawY, xScale, finalSpan*yScale, image_angle, c, 1);

	//Rudder
	var offset = -12;
	var drawX = drawOffset + lengthdir_x(offset*xScale, image_angle);
	var drawY = drawOffset + lengthdir_y(offset*xScale, image_angle);
	draw_sprite_ext(spr_rudder_small, 0, drawX, drawY, yScale, finalSpan*yScale, image_angle, c, 1);
	
	//Other perspective
	var diff = angle_difference(image_angle, 90);
	var diff2 = angle_difference(image_angle, 270);
	var finalDiff = min(abs(diff), abs(diff2));
	horWingSpan = finalDiff/90;
	var finalSpan = horWingSpan;
	//Keep top rudder thing always on top of plane
	if (image_angle > 90 && image_angle < 270) { finalSpan *= -1; }
	var offset = -8;
	var drawX = drawOffset + lengthdir_x(offset*xScale, image_angle);
	var drawY = drawOffset + lengthdir_y(offset*xScale, image_angle);
	draw_sprite_ext(spr_rudder_top_small, 0, drawX, drawY, xScale, finalSpan*yScale, image_angle, c, 1);
	
	//Draw body
	//This is centered to surface
	draw_sprite_ext(spr_player_small, 0, drawOffset, drawOffset, xScale, yScale, image_angle, c, 1);
	
	//Reset drawing to normal
	gpu_set_blendenable(true);
	gpu_set_colorwriteenable(true,true,true,true);
	
	//Draw our sprite in mask
	var offset = -20;
	var drawX = drawOffset + lengthdir_x(offset*xScale, image_angle);
	var drawY = drawOffset + lengthdir_y(offset*xScale, image_angle);
	
	gpu_set_blendmode_ext(bm_dest_alpha,bm_inv_dest_alpha);
	gpu_set_alphatestenable(true);
	draw_sprite_ext(spr_pixel_centered, 0, drawX, drawY, 30*yScale, 18*energy/energyMax*xScale, image_angle-90+wave(-10, 10, 2, 0, true), col_white, 1);
	gpu_set_alphatestenable(false);
	gpu_set_blendmode(bm_normal);
}

surface_reset_target();

shader_set(shd_outline);
shader_set_uniform_f(upixelW, playerTexelW);
shader_set_uniform_f(upixelH, playerTexelH);
draw_surface(playerSurf, obj_player.x - drawOffset, obj_player.y - drawOffset);

shader_reset();

#endregion

#region Danger zone top layer drawing

with (obj_danger_zone)
{
	if (!surface_exists(topCloudSurf))
	{
		topCloudSurf = surface_create(sprite_width+topSurfMargin, sprite_height+topSurfMargin);
		createCloudSurface(topCloudSurf, topFrequency, topPositionVariance, topRadius, topRadiusVariance, topMargin, topSurfMargin, col, false);
	}
}

//Animate clouds with wave shader
shader_set(shd_wave);
shader_set_uniform_f(other.uTime, current_time/1000 * other.spd);
shader_set_uniform_f(other.uFrequency, other.frequency);
shader_set_uniform_f(other.uIntensity, other.intensity);

with (obj_danger_zone)
{
	if (onScreen)
		{ draw_surface(topCloudSurf, bbox_left - topSurfMargin/2, bbox_top - topSurfMargin/2); }
}

shader_reset();

#endregion

part_system_drawit(global.psTop);

#region Draw bullets and things that should always be on top of everything

//Draw dropshadows for bullets (they don't use surfaces)
draw_set_alpha(0.5);
with (obj_bullet)
	{ draw_circle_color(x + 2, y + 2, 2, col_black, col_black, false); }
draw_set_alpha(1);
with (obj_bullet) { event_perform(ev_draw, 0); }

#endregion
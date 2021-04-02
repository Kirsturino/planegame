var camX = camera_get_view_x(view);
var camY = camera_get_view_y(view);
var time = (current_time - global.pausedTime) / 1000;

draw_clear(backgroundColor);
with (obj_background_sun) { event_perform(ev_draw, 0); }

#region Background cloud drawing

with (obj_background_cloud) { event_perform(ev_draw, 0); }

#endregion

with (obj_background) { event_perform(ev_draw, 0); }

part_system_drawit(global.ps);

#region Visual cloud drawing

//Make sure surface hasn't exploded
if (!surface_exists(masterCloudSurf))
{
	masterCloudSurf = surface_create(viewWidth*2, viewHeight*2);
	cloudTexelW = outlineThickness * texture_get_texel_width(surface_get_texture(masterCloudSurf));
	cloudTexelH = outlineThickness * texture_get_texel_height(surface_get_texture(masterCloudSurf));
}
			
with (obj_danger_zone_visual)
{
	if (!surface_exists(cloudSurf))
		{
			cloudSurf = surface_create(sprite_width+surfMargin, sprite_height+surfMargin);
			createCloudSurface(cloudSurf, frequency, positionVariance, radius, radiusVariance, margin, surfMargin, col, true);
		}
}

surface_set_target(masterCloudSurf);
draw_clear_alpha(col_black, 0);

with (obj_danger_zone_visual)
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
shader_set_uniform_f(uTimeOL, time * spdOL);
shader_set_uniform_f(uFrequencyOL, frequencyOL);
shader_set_uniform_f(uIntensityOL, intensityOL);
shader_set_uniform_f(uWavePixelW, cloudTexelW);
shader_set_uniform_f(uWavePixelH, cloudTexelH);
shader_set_uniform_f(uXOffsetOL, camX/masterWidth); //This surface moves, so we have to offset texcoord for the shader
shader_set_uniform_f(uYOffsetOL, camY/masterHeight);

draw_surface(masterCloudSurf, camX-viewWidth/2, camY-viewHeight/2);
shader_reset();
			
#endregion

//Make sure surface hasn't exploded
if (!surface_exists(cloudSurf))
{
	cloudSurf = surface_create(sprite_width+surfMargin, sprite_height+surfMargin);
	createCloudSurface(cloudSurf, frequency, positionVariance, radius, radiusVariance, margin, surfMargin, col, true);
	
	cloudTexelW = outlineThickness * texture_get_texel_width(surface_get_texture(cloudSurf));
	cloudTexelH = outlineThickness * texture_get_texel_height(surface_get_texture(cloudSurf));
}

shader_set(shd_wave_outline);
var time = (current_time - global.pausedTime) / 1000;
shader_set_uniform_f(uTimeOL, time * spdOL);
shader_set_uniform_f(uFrequencyOL, frequencyOL);
shader_set_uniform_f(uIntensityOL, intensityOL);
shader_set_uniform_f(uWavePixelW, cloudTexelW);
shader_set_uniform_f(uWavePixelH, cloudTexelH);

draw_surface(cloudSurf, x, y);
shader_reset();
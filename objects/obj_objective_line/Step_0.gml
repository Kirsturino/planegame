state();

//This is used for rotating the triangle
rot -= curProgressSpeed*3*delta;

//FX
triangleScale = lerp(triangleScale, triangleScaleTarget, 0.2*delta);

//This is to trigger the sound effect in relation to progress speed
if (curProgressSpeed != 0 && sfxTimer == 0 && !destroy)
{
	audio_sound_pitch(progressSound, 1 + abs(curProgressSpeed)/10);
	audio_play_sound(progressSound, 0, false);
	sfxTimer = sfxTimerMax / (1 + abs(curProgressSpeed));
	
	part_particles_create(global.ps, progressX+surfMargin/2, progressY+surfMargin/2, global.smokePartShort, 1);
	part_particles_create(global.ps, progressX+surfMargin/2, progressY+surfMargin/2, global.electricityPart, 4);
	triangleScale = triangleScaleTarget + 0.2;
} else
{
	sfxTimer = approach(sfxTimer, 0, 1);
}
//Ro ro rotate your owl
rot += rotSpd*sign(completionMax)*delta;
radius = lerp(radius, radiusTo, 0.1*delta);
drawRad = radius - radius*0.2*completion/completionMax;

//Simple sine movement
if (!completed)
{
	x = xstart + wave(-moveX, moveX, moveXDuration, moveXOffset, true);
	y = ystart + wave(-moveY, moveY, moveYDuration, moveYOffset, true);
}

if (completed)
{
	radiusTo = approach(radiusTo, 0, 2);
	if (radius < 1)
	{
		audio_play_sound(snd_pop, 0, false);
		radialParticle(global.linePart, 8, 16, x, y);
		surface_free(circleSurf);
		instance_destroy(); 
	}
} else
	{ objective(); }
	
checkCompletion();
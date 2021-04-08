//Ro ro rotate your owl
rot += rotSpd*sign(completionMax)*delta;
radius = lerp(radius, radiusTo, 0.1*delta);
drawRad = radius - radius*0.2*completion/completionMax;

//Simple sine movement
if (!completed && moveY != 0)
{
	y = ystart + wave(-moveY, moveY, moveYDuration, moveYOffset, true);
}

if (!completed && moveX != 0)
{
	x = xstart + wave(-moveX, moveX, moveXDuration, moveXOffset, true);
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
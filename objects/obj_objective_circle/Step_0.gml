//Ro ro rotate your owl
rot += rotSpd*sign(completionMax)*delta;
radius = lerp(radius, radiusTo, 0.1*delta);
drawRad = radius - radius*0.2*completion/completionMax;

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
} else if (!completed) 
	{ objective(); }
	
checkCompletion();
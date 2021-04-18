event_inherited();

destroyTimer = approach(destroyTimer, 0, 1);

if (!completed)
{
	x += hsp*delta;
	y += vsp*delta;
	
	if (destroyTimer == 0) 
	{
		removeCameraFocus(id);
		instance_destroy();
	}
}
event_inherited();

if (!completed)
{
	x += hsp*delta;
	y += vsp*delta;
}

destroyTimer = approach(destroyTimer, 0, 1);
	if (destroyTimer == 0) { instance_destroy(); global.objectiveCount--;}
//Level transitions
transitionTimer = approach(transitionTimer, 0, 1);

if (transitionType == transition.level_next)
{
	setCameraZoom(0.6);
}

if (transitionTimer == 0)
{
	global.transitioning = false;
	transitionFunction();
	audio_stop_sound(transitionSound);
	instance_destroy();
}
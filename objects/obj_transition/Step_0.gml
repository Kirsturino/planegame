//Level transitions
transitionTimer = approach(transitionTimer, 0, 1);

if (transitionTimer == 0)
{
	global.transitioning = false;
	transitionFunction();
	instance_destroy();
}
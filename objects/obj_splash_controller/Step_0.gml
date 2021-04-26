if (timer == 0)
	{ startRoomTransition(transition.out, viewWidth/2, viewHeight/2, rm_splash); }
else
	{ timer = approach(timer, 0, 1); }
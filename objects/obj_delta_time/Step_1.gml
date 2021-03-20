//Keep track of frame delta
global.actualDelta = delta_time / 1000000;

if (global.paused)
	{ global.pausedTime += delta_time * 0.001; }

//Calculate multiplier based on frame time, affected by manual timescale A.K.A. slowmotion
//When game is running smoothly and without slow motion effects, with default framerate, this will equal 1
delta = global.actualDelta / global.targetDelta * global.timeScale;

//Limit delta time, so intentional lagging won't break things
delta = min(delta, maxDelta);
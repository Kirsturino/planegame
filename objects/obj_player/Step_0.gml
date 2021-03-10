state();

//Persistent effects/things
if (turbo)
{
	setCameraZoom(1.3);
} else
{
	setCameraZoom(1);
}

//rotateCamera((rotSpd[0] - rotSpd[1]) * 0.5, false);
energyRecovery();

//Squash
xScale = lerp(xScale, xScaleTarget, squashSpeed * delta);
yScale = lerp(yScale, yScaleTarget, squashSpeed * delta);

//Controller vibration
vibL = approach(vibL, 0, vibDecay);
vibR = approach(vibR, 0, vibDecay);
gamepad_set_vibration(global.controller, vibL, vibR);
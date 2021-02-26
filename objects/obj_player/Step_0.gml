state();

//Persistent effects/things
if (turbo)
{
	setCameraZoom(1.4);
} else
{
	setCameraZoom(1);
}

//rotateCamera((rotSpd[0] - rotSpd[1]) * 0.5, false);
energyRecovery();

//Squash
xScale = lerp(xScale, xScaleTarget, squashSpeed);
yScale = lerp(yScale, yScaleTarget, squashSpeed);